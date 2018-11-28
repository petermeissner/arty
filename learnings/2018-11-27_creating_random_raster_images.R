

# using raster image within normal plot
plot_png <- 
  function(img){
    plot(NA, type = "n", xlab = "", ylab = "", ylim = c(0, dim(img)[2]), xlim = c(0, dim(img)[1]))
    rasterImage(img, 0, 0, dim(img)[1], dim(img)[2], interpolate = FALSE)
  }



img <- matrix(runif(100), nrow = 10)
plot_png(img)


img <- array(runif(100*4), dim = c(10, 10, 4))
plot_png(img)







img <- matrix(runif(100), nrow = 10)
plot(as.raster(img), interpolate = FALSE)


img <- array(runif(100*4), dim = c(10, 10, 4))
plot(as.raster(img), interpolate =FALSE)


