library(magick)

# open device
img_dev <- image_graph(600, 340, res = 96)

for( i in 1:10 ){
  img <- matrix(runif(10000), nrow = 100)
  plot(as.raster(img), interpolate = FALSE)
}

dev.off()

animation <- image_animate(img_dev, fps = 10)
print(animation)

image_write(animation, "img/random.gif")
