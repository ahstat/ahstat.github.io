rm(list = ls())
setwd("~/Documents/GitHub/triangle-pursuit/")
library(ggplot2)
source("helpers/rules.R")
source("helpers/get_recursive.R")

t = pi/6

test_t = function(t) {
  X = rbind(c(0,0), c(1,0), c(cos(t),sin(t)))
  x_n = get_recursive(X, rule = rule_shift)
  x_n = x_n[,1] + 1i * x_n[,2]
  
  out = rep(NA, length(x_n))
  for(n in 5:length(x_n)) {
    k = seq(0, n-5)
    x_calc = sum(exp(2*1i*k*pi/3) * exp((1i/3)*(t - pi/3)*(1 - (-1/2)^k)))
    out[n] = x_n[n] - x_calc
  }
  return(sum(out, na.rm = TRUE))
}

seqa = seq(from=-0.01, to=pi+0.1, length.out = 1000)
ttt = sapply(seqa, test_t)
plot(seqa, abs(ttt))

t = -0.1

###############################################################################

f_minus = function(x_n) {
  return(c(NA, x_n[1:(length(x_n)-1)]))
}

t = pi/6
get_theta = function(t) {
  X = rbind(c(0,0), c(1,0), c(cos(t),sin(t)))
  x_n = get_recursive(X, rule = rule_shift)
  x_n = x_n[,1] + 1i * x_n[,2]
  x_n_minus_1 = f_minus(x_n)
  u_n = x_n - x_n_minus_1
  u_n_minus_1 = f_minus(u_n)
  #print(u_n[3]/u_n_minus_1[3] - (exp(1i * t) - 1))
  theta_n = Arg(u_n / u_n_minus_1)
  idx = which(theta_n < 0)
  if(length(idx) > 0) {
    theta_n[idx] = theta_n[idx] + 2*pi
  }
  return(theta_n)
}

t_seq = seq(from = -pi+0.001, to = pi, length.out = 1000)
aaa = sapply(t_seq, function(x){get_theta(x)[5]})
plot(t_seq, aaa - (pi - t_seq))

t_seq = seq(from = -5*pi-0.001, to = 5*pi, length.out = 2000)
out = rep(NA, length(t_seq))
for(i in 1:length(t_seq)) {
  print(i)
  t = t_seq[i]
  theta_n = get_theta(t)
  #out[i] = abs(theta_n[3] - Arg(exp(1i*t)-1))
  #out[i] = abs(theta_n[4] - (pi + (t %% (2*pi)))/2)
  out[i] = abs(theta_n[5] - ((pi - t) %% (2*pi)))
}

plot(t_seq, out)

t = 0.6
theta_n = get_theta(t)
