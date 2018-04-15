rm(list = ls())
setwd("~/Documents/GitHub/triangle-pursuit/")
library(ggplot2)
source("helpers/rules.R")
source("helpers/get_recursive.R")

# get_recursive_plot(x, rule = rule_shift)

plot_intro_k = function(x, k, size = 300, prop = 0.2) {
  # k means: plot with x_k, x_{k+1}, x_{k+2}
  # size: size of the png
  # prop = 0.2 means: arrow of length 20% of the total distance
  #size = 300
  #prop = 0.2
  out = get_recursive(x, rule = rule_shift)
  vect = k:(k+2)
  label = paste0("x", k:(k+2))
  current = out[vect,]
  x = current[,1]
  y = current[,2]
  next_element = out[k+3,]
  from = current[3,]
  end = current[3,] - prop * (current[3,] - next_element)
  range = c(-0.3, 1.1)
  
  df = data.frame(x=from[1], xend=end[1], y=from[2], yend=end[2])
  
  png(paste0(k, ".png"), size, size)
  plot(
    qplot(x, y, xlab = NULL, ylab = NULL, xlim = range, ylim = range) + 
      theme_light() + theme(text = element_text(size = 20)) +
      annotate("text", x=x, y=y+0.1, label = label, size = 6)
  )
  dev.off()
  
  png(paste0(k, "_arrow.png"), size, size)
  plot(
    qplot(x, y, xlab = NULL, ylab = NULL, xlim = range, ylim = range) + 
      theme_light() + theme(text = element_text(size = 20)) +
      annotate("text", x=x, y=y+0.1, label = label, size = 6) +
      geom_segment(data = df,
                   aes(x=x, xend=xend, y=y, yend=yend), size = 1,
                   arrow = arrow(length = unit(0.5, "cm")))
  )
  dev.off()
}

x = rbind(c(0,0), c(1,0), c(0,1))
for(k in 1:34) {
  plot_intro_k(x, k)
}
