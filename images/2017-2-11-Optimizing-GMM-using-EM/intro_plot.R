library(mclust)
library(ggplot2)
set.seed(2713)
rm(list = ls())
setwd("~/Documents/GitHub/ahstat.github.io/images/2017-2-11-Optimizing-GMM-using-EM/")

## Create data
n1 = 200
n2 = 300
n3 = 600
z1 = rnorm(n1, -1, 1) + 1i * rnorm(n1, -2, 3)
z2 = rnorm(n2, 2, 1) + 1i * rnorm(n2, 3, 0.2)
z3 = rnorm(n3, 3, 0.5) + 1i * rnorm(n3, -2, 0.4)
z = c(z1, z2, z3)
df = data.frame(x=Re(z), y=Im(z))

## Fitting GMM with K = 3
xyMclust <- Mclust(df, G=3)

## Classified points
df$K = xyMclust$classification
df$colour = factor(df$K)

## Mean points of fitted clusters
mean_p = apply(xyMclust$parameters$mean, 2, function(x){x[1]+1i*x[2]})

## Plotting before
png("before.png", 375, 375)
print(
  ggplot() + 
    geom_point(data=df, aes(x, y), size = 1) + 
    theme_light() +
    scale_color_brewer(palette="Dark2") +
    theme(legend.position="none")
)
dev.off()

## Plotting
png("after.png", 375, 375)
print(
ggplot() + 
  geom_point(data=df, aes(x, y, colour = colour), size = 1) + 
  theme_light() +
  scale_color_brewer(palette="Dark2") +
  theme(legend.position="none") +
  geom_point(data = data.frame(x = Re(mean_p), y = Im(mean_p)), aes(x, y), 
             size = 8, shape = 3)
)
dev.off()