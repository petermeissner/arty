library(png)

img <- matrix(runif(10000), nrow = 100)

writePNG(
  image  = img, 
  target = "my_first_png.png"
)

browseURL("img/my_first_png.png")


