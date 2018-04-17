rm(list = ls())
setwd("~")
library(ggplot2)

# From https://stackoverflow.com/questions/6862742/draw-a-circle-with-ggplot2
circleFun <- function(center = c(0,0), diameter = 1, npoints = 100){
  r = diameter / 2
  tt <- seq(0,2*pi,length.out = npoints)
  xx <- center[1] + r * cos(tt)
  yy <- center[2] + r * sin(tt)
  return(data.frame(x = xx, y = yy))
}

t = 0.4
r = -2.145
A = 2.241
size = 300

x1 = r*exp(1i*t)
x2 = A
x3 = exp(1i*t)
X = c(x1,x2,x3)
x = c(0, Re(X))
y = c(0, Im(X))
lim = range(c(Re(X), Im(X)))
lim[1] = lim[1]*1.2
lim[2] = lim[2]*1.2
circle = circleFun(c(0,0), 2)

val1 = Re(X[3]) + seq(from=0, to=10, length.out = 1000) * (Re(X[1])-Re(X[3]))
val2 = Im(X[3]) + seq(from=0, to=10, length.out = 1000) * (Im(X[1])-Im(X[3]))
seg = data.frame(x = val1, y = val2)
seg2 = data.frame(x = seq(from=0, to=lim[2], length.out = 100), y = 0)

xaxis = data.frame(x = seq(from=lim[1], to=lim[2], length.out = 100), y = 0)
yaxis = data.frame(x = 0, y = seq(from=lim[1], to=lim[2], length.out = 100))

png(paste0("three_param_", size, ".png"), size, size)
plot(
  qplot(x, y, xlab = NULL, ylab = NULL, xlim = lim, ylim = lim) +
    theme_light() + theme(text = element_text(size = 20)) +
    geom_path(data=xaxis, colour="black") +
    geom_path(data=yaxis, colour="black") +
    geom_path(data = circle, col = "red") +
    geom_path(data=seg, colour="red") +
    geom_path(data=seg2, colour="red") +
    geom_point(data = data.frame(x, y)) + 
    annotate("text", x=x+0, y=y+0.2, label = c("O   ", "x'1", "x'2", "x'3"), size = 6) # for size 300
    #annotate("text", x=x+0.0, y=y+0.17, label = c("O", "x'1", "x'2", "x'3"), size = 6) # for size 500
)
dev.off()

###############################################################################

#############
# Two param #
#############
t = 0.4
r = 0
A = 2.241
size = 300

x1 = r*exp(1i*t)
x2 = A
x3 = exp(1i*t)
X = c(x1,x2,x3)
x = Re(X)
y = Im(X)
lim = c(-2.370811, 2.689200)
circle = circleFun(c(0,0), 2)

val1 = Re(X[3]) + seq(from=0, to=10, length.out = 1000) * (Re(X[1])-Re(X[3]))
val2 = Im(X[3]) + seq(from=0, to=10, length.out = 1000) * (Im(X[1])-Im(X[3]))
seg = data.frame(x = val1, y = val2)
seg2 = data.frame(x = seq(from=0, to=lim[2], length.out = 100), y = 0)

xaxis = data.frame(x = seq(from=lim[1], to=lim[2], length.out = 100), y = 0)
yaxis = data.frame(x = 0, y = seq(from=lim[1], to=lim[2], length.out = 100))

png(paste0("two_param_", size, ".png"), size, size)
plot(
  qplot(x, y, xlab = NULL, ylab = NULL, xlim = lim, ylim = lim) +
    theme_light() + theme(text = element_text(size = 20)) +
    geom_path(data=xaxis, colour="black") +
    geom_path(data=yaxis, colour="black") +
    geom_path(data = circle, col = "red") +
    geom_path(data=seg, colour="red") +
    geom_path(data=seg2, colour="red") +
    geom_point(data = data.frame(x, y)) + 
    annotate("text", x=x+0, y=y+0.2, label = c("x''1=x''4            ", "x''2", "x''3"), size = 6) # for size 300
  #annotate("text", x=x+0.0, y=y+0.17, label = c("x'1", "x'2", "x'3"), size = 6) # for size 500
)
dev.off()

#############
# One param #
#############
t = 0.4
r = 0
A = 1
size = 300

x1 = r*exp(1i*t)
x2 = A
x3 = exp(1i*t)
X = c(x1,x2,x3)
x = Re(X)
y = Im(X)
lim = c(-2.370811, 2.689200)
circle = circleFun(c(0,0), 2)

val1 = Re(X[3]) + seq(from=0, to=10, length.out = 1000) * (Re(X[1])-Re(X[3]))
val2 = Im(X[3]) + seq(from=0, to=10, length.out = 1000) * (Im(X[1])-Im(X[3]))
seg = data.frame(x = val1, y = val2)
seg2 = data.frame(x = seq(from=0, to=lim[2], length.out = 100), y = 0)

xaxis = data.frame(x = seq(from=lim[1], to=lim[2], length.out = 100), y = 0)
yaxis = data.frame(x = 0, y = seq(from=lim[1], to=lim[2], length.out = 100))

# First step
png(paste0("one_param_", size, ".png"), size, size)
plot(
  qplot(x, y, xlab = NULL, ylab = NULL, xlim = lim, ylim = lim) +
    theme_light() + theme(text = element_text(size = 20)) +
    geom_path(data=xaxis, colour="black") +
    geom_path(data=yaxis, colour="black") +
    geom_path(data = circle, col = "red") +
    geom_path(data=seg, colour="red") +
    geom_path(data=seg2, colour="red") +
    geom_point(data = data.frame(x, y)) + 
    annotate("text", x=x+0, y=y+0.2, label = c("x'''1=x'''4             ", "              x'''2=x'''5", "x'''3"), size = 6) # for size 300
  #annotate("text", x=x+0.0, y=y+0.17, label = c("x'1", "x'2", "x'3"), size = 6) # for size 500
)
dev.off()
