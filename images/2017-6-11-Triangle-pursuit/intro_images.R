rm(list = ls())
setwd("~/Documents/GitHub/triangle-pursuit/")
library(ggplot2)
source("helpers/rules.R")
source("helpers/get_recursive.R")

# get_recursive_plot(x, rule = rule_shift)

# From https://stackoverflow.com/questions/6862742/draw-a-circle-with-ggplot2
circleFun <- function(center = c(0,0), diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

plot_intro_k = function(X, k, size = 300, prop = 0.2) {
  # k means: plot with x_k, x_{k+1}, x_{k+2}
  # size: size of the png
  # prop = 0.2 means: arrow of length 20% of the total distance
  out = get_recursive(X, rule = rule_shift)
  vect = k:(k+3)
  label = paste0("x", k:(k+3))
  label_end = label[2:4]
  label = label[1:3]
  current = out[vect,]
  x = current[1:3,1]
  y = current[1:3,2]
  #next_element = out[k+3,]
  from = current[3,]
  x_end = current[2:4,1]
  y_end = current[2:4,2]
  #end = current[3,] - 1 * (current[3,] - next_element)

  png(paste0(k, ".png"), size, size)
  plot(
    qplot(x, y, xlab = NULL, ylab = NULL, xlim = c(-0.05, 1.3), ylim = c(-0.25, 1.1)) + 
      theme_light() + theme(text = element_text(size = 20)) +
      annotate("text", x=x, y=y+0.1, label = label, size = 6)
  )
  dev.off()
  
  seg = data.frame(
    x = current[3,1] + seq(from=0, to=1.5, length.out = 100) * (current[1,1]-current[3,1]),
    y = current[3,2] + seq(from=0, to=1.5, length.out = 100) * (current[1,2]-current[3,2])
  )

  circle <- circleFun(current[3,], 2, npoints = 100)
  
  png(paste0(k, "_begin.png"), size, size)
  plot(
    qplot(x, y, xlab = NULL, ylab = NULL, xlim = c(-0.05, 1.3), ylim = c(-0.25, 1.1)) + 
      theme_light() + theme(text = element_text(size = 20)) +
      annotate("text", x=x, y=y+0.1, label = label, size = 6) +
      geom_path(data = circle, col = "red") +
      geom_path(data=seg, colour="red") +
      geom_point(data = data.frame(x, y))
  )
  dev.off()
  
  x = x_end
  y = y_end
  png(paste0(k, "_end.png"), size, size)
  plot(
    qplot(x, y, xlab = NULL, ylab = NULL, xlim = c(-0.05, 1.3), ylim = c(-0.25, 1.1)) + 
      theme_light() + theme(text = element_text(size = 20)) +
      annotate("text", x=x, y=y+0.1, label = label_end, size = 6) +
      geom_path(data = circle, col = "red") +
      geom_path(data=seg, colour="red") +
      geom_point(data = data.frame(x, y))
  )
  dev.off()
}

X = rbind(c(0,0), c(1,0), c(1,1))
size = 300
prop = 0.2
k = 1

for(k in 1:30) {
  plot_intro_k(X, k, size = 300)
}
