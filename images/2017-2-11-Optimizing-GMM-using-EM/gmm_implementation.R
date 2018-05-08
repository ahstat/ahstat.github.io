library(ggplot2)
library(mvtnorm) # to compute density for multivariate normal
set.seed(2713)
rm(list = ls())
setwd("~/Documents/GitHub/ahstat.github.io/images/2017-2-11-Optimizing-GMM-using-EM/")

# Quick and dirty implementation of GMM
# to illustrate ahstat.github.io blog post
# (mclust package will give quicker results)

###############
# Create data #
###############
n1 = 200
n2 = 300
n3 = 600
z1 = rnorm(n1, -1, 1) + 1i * rnorm(n1, -2, 3)
z2 = rnorm(n2, 2, 1) + 1i * rnorm(n2, 3, 0.2)
z3 = rnorm(n3, 3, 0.5) + 1i * rnorm(n3, -2, 0.4)
z = c(z1, z2, z3)
df = data.frame(x=Re(z), y=Im(z))

####################
# Helper functions #
####################
f = function(df, t, k, m, sigma) {
  # Compute f_{(m_k^{(t)}, \Sigma_k^{(t)})}(x_i)
  # for all x_i in df
  m_current = m[[paste(t)]][k]
  m_current = c(Re(m_current), Im(m_current))
  sigma_current = sigma[[paste(t)]][[k]]
  
  out = dmvnorm(df, mean = m_current, sigma = sigma_current)
  return(as.numeric(out))
}

T_func = function(df, t, m, sigma, pi) {
  # Compute T_{k, i}^{(t)} for all k, i
  # Output a list of length K, each list containing N elements
  pi_t = pi[[paste(t)]]
  K = length(pi_t)
  
  f_pi_all = list()
  for(k in 1:K) {
    f_pi_all[[k]] = f(df, t, k, m, sigma) * pi_t[k]
  }
  
  f_pi_all_summed = f_pi_all[[1]]
  for(k in 2:K) {
    f_pi_all_summed = f_pi_all_summed + f_pi_all[[k]]
  }
  
  out = lapply(f_pi_all, function(x) {x / f_pi_all_summed})
  return(out)
}

m_t_plus_one = function(df, t, m, sigma, pi) {
  # Update mean values
  T_t = T_func(df, t, m, sigma, pi)
  
  summed_T = sapply(T_t, sum)
  summed_T_x = sapply(T_t, function(x){sum(df[,1] * x)})
  summed_T_y = sapply(T_t, function(x){sum(df[,2] * x)})
  
  m_out = (summed_T_x / summed_T) + 1i * (summed_T_y / summed_T)
  return(m_out)
}

sigma_t_plus_one = function(df, t, m, sigma, pi) {
  # Update Sigma values
  T_t = T_func(df, t, m, sigma, pi)
  summed_T = sapply(T_t, sum)
  K = length(summed_T)
  
  m_next = m_t_plus_one(df, t, m, sigma, pi)
  
  sigma_out = 
  lapply(1:K, function(k) {
    df_minus_m = df
    df_minus_m$x = df_minus_m$x - Re(m_next[k])
    df_minus_m$y = df_minus_m$y - Im(m_next[k])
    t(as.matrix(df_minus_m)) %*% as.matrix((df_minus_m) * T_t[[k]]) / summed_T[k]
  })
  
  return(sigma_out)
}

pi_t_plus_one = function(df, t, m, sigma, pi) {
  # Update pi values
  T_t = T_func(df, t, m, sigma, pi)
  summed_T = sapply(T_t, sum)
  pi_out = summed_T / sum(summed_T)
  return(pi_out)
}

clustering = function(df, t, m, sigma, pi) {
  # Compute hard cluster for each element given parameters
  pi_t = pi[[paste(t)]]
  K = length(pi_t)
  
  density_all = matrix(NA, ncol = K, nrow = nrow(df))
  for(k in 1:K) {
    density_all[,k] = f(df, t, k, m, sigma) * pi_t[k]
  }
  
  clustered = apply(density_all, 1, function(x){which.max(x)})
  return(clustered)
}

log_L = function(df, t, m, sigma, pi) {
  # Compute log-likelihood of a dataset given parameters
  pi_t = pi[[paste(t)]]
  K = length(pi_t)
  
  density_all = matrix(NA, ncol = K, nrow = nrow(df))
  for(k in 1:K) {
    density_all[,k] = f(df, t, k, m, sigma) * pi_t[k]
  }
  
  log_likelihood = sum(log(apply(density_all, 1, sum)))
  return(log_likelihood)
}

#########################
# Initialize parameters #
#########################

## Initialize parameters with K-means
K = 3
set.seed(2721)
m_init = kmeans(df, K)$centers
m_init = m_init[,1] + 1i * m_init[,2]
sigma_init = replicate(K, diag(2), simplify=FALSE)
pi_init = rep(1/K, K)

## Initialize parameters with true values
# m_init = c(-1 - 1i * 2, 2 + 1i * 3, 3 - 1i * 2)
# sigma_init = list(diag(c(1, 3))^2, diag(c(1, 0.2))^2, diag(c(0.5, 0.4))^2)
# pi_init = c(0.1818182, 0.2727273, 0.5454545)

m = list()
sigma = list()
pi = list()
m[["0"]] = m_init
sigma[["0"]] = sigma_init
pi[["0"]] = pi_init

##############
# Iterations #
##############
iter_max = 7
for(t in 0:(iter_max-1)) {
  print(t+1)
  m[[paste(t+1)]] = m_t_plus_one(df, t, m, sigma, pi)
  sigma[[paste(t+1)]] = sigma_t_plus_one(df, t, m, sigma, pi)
  pi[[paste(t+1)]] = pi_t_plus_one(df, t, m, sigma, pi)
}

###########################
# Evolution of likelihood #
###########################
log_L_evol = sapply(0:iter_max, function(t) {log_L(df, t, m, sigma, pi)})
png(paste0("log_likelihood_evolution.png"), 640, 480)
print(
qplot(0:iter_max, log_L_evol, xlab = "t", ylab = "log-likelihood") + 
  theme_light() #+
  #geom_hline(yintercept = -2979.822, col = "blue")
)
dev.off()

# log-likelihood for true parameters: -2979.822
# log-likelihood with EM with init = K-means: -2966.941
# L(x; \theta_{MLE}) \geq L(x; \theta_{EM}) > L(x; \theta_{true})

###########################
# Evolution of clustering #
###########################
for(t in 0:iter_max) {
  df_plot = df
  df_plot$colour = as.factor(clustering(df, t, m, sigma, pi))
  mean_p = m[[paste(t)]]
  
  ## Plotting
  png(paste0("evol_", t, ".png"), 375, 375)
  print(
    ggplot() + 
      geom_point(data=df_plot, aes(x, y, colour = colour), size = 1) + 
      theme_light() +
      scale_color_brewer(palette="Dark2") +
      theme(legend.position="none") +
      geom_point(data = data.frame(x = Re(mean_p), y = Im(mean_p)), aes(x, y), 
                 size = 8, shape = 3)
  )
  dev.off()
}
