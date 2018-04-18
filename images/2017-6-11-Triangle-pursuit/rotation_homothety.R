size = 700
shape = matrix(c(0,0,1,0,1,1), nrow = 3, ncol = 2, byrow = TRUE) # !!
seq_grid = seq(from = -pi, to = pi, length.out = 5001)

##
# Max norm and rotation
##
png(paste0("rot_maxnorm_", size, ".png"), size, size)
X = input_operation(shape, seq_grid, "rotation")
mapX = mapX_func(X, map_func = map_max)
plot_mapX(seq_grid, mapX, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = NA, nb_text = NA, asp = 1)
dev.off()

##
# One norm and rotation
##
png(paste0("rot_onenorm_", size, ".png"), size, size)
X = input_operation(shape, seq_grid, "rotation")
mapX = mapX_func(X, map_func = map_one)
plot_mapX(seq_grid, mapX, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = NA, nb_text = NA, asp = 1)
dev.off()

##
# Euclidian norm and rotation
##
png(paste0("rot_eucnorm_", size, ".png"), size, size)
X = input_operation(shape, seq_grid, "rotation")
mapX = mapX_func(X)
plot_mapX(seq_grid, mapX, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = NA, nb_text = NA, asp = 1)
dev.off()

##
# Max norm and homothety
##
png(paste0("hom_maxnorm_", size, ".png"), size, size)
X = input_operation(shape, seq_grid, "homothety")
mapX = mapX_func(X, map_func = map_max)
plot_mapX(seq_grid, mapX, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = NA, nb_text = NA, asp = 1)
dev.off()

##
# One norm and homothety
##
png(paste0("hom_onenorm_", size, ".png"), size, size)
X = input_operation(shape, seq_grid, "homothety")
mapX = mapX_func(X, map_func = map_one)
plot_mapX(seq_grid, mapX, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = NA, nb_text = NA, asp = 1)
dev.off()

##
# Euclidian norm and homothety
##
png(paste0("hom_eucnorm_", size, ".png"), size, size)
X = input_operation(shape, seq_grid, "homothety")
mapX = mapX_func(X)
plot_mapX(seq_grid, mapX, xaxis = 1, yaxis = 2, cex = 0.1,
          nb_polygon = NA, nb_text = NA, asp = 1)
dev.off()
