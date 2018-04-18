shape = matrix(c(0,0,1,0,NA,NA), nrow = 3, ncol = 2, byrow = TRUE)
t = seq(from = 0.02, to = 2*pi - 0.02, length.out = 5001) # this is seq_grid
X = array(rep(shape, length(t)), dim = c(3, 2, length(t)))
z = exp(1i*t)
X[3,1,] = Re(z)
X[3,2,] = Im(z)
mapX = mapX_func(X)

png("begin_2pi.png", 500, 500)
plot_mapX(t, X, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = NA, nb_text = 1, asp = 1)
dev.off()

png("end_2pi", 500, 500)
plot_mapX(t, mapX, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = NA, nb_text = NA, asp = 1)
dev.off()

###############################################################################

shape = matrix(c(0,0,1,0,NA,NA), nrow = 3, ncol = 2, byrow = TRUE)
t = seq(from = 0.0001, to = pi, length.out = 5001) # this is seq_grid
X = array(rep(shape, length(t)), dim = c(3, 2, length(t)))
z = exp(1i*t)
X[3,1,] = Re(z)
X[3,2,] = Im(z)
mapX = mapX_func(X)

png("begin_pi.png", 500, 500)
plot_mapX(t, X, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = 7, nb_text = 7, asp = 1)
dev.off()

png("end_pi", 500, 500)
plot_mapX(t, mapX, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = 7, nb_text = 7, asp = 1)
dev.off()
