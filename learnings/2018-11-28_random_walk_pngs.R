

robot <- png::readPNG("img/robotstxt.png")
plot(as.raster(robot), interpolate = FALSE)

robot[1,1,]
robot[1,2,]

m <- robot <- apply(robot, c(1, 2), sum)/4



# value matrix to transition matrix?
m <- matrix(0, nrow = 6, ncol = 6)
m[1,1] <- 1
m[2,2] <- 1
m[3,3] <- 1
m[4,4] <- 1
m[5,4] <- 1
m[6,4] <- 1

plot(as.raster(m), interpolate = FALSE)


# functions
mat_normalize_p_row <- function(m){m * 1/apply(m, 1, sum)}
mat_normalize_p_col <- function(m){m * 1/apply(m, 2, sum)}


mat_which_vec <- function(dim, row, col){((col-1) * dim[1]) + row}
vec_which_mat <- function(dim, i){c(i %% dim[2], floor(i/dim[2])+1)}



mat_val_to_transition <- 
  function(m, r){
    
    mt <- matrix(0, nrow = length(m), ncol = length(m), byrow = TRUE)
    
    radius <- 1
    dim_m  <- dim(m)
    
    
    for ( from_row in seq_len(nrow(m)) ) {
      for ( from_col in seq_len(ncol(m)) ) {  
        
        row_seq <- 
          seq(
            from = max(from_row - radius, 1),  
            to   = min(from_row + radius, nrow(m))
          )
        
        col_seq <- 
          seq(
            from = max(from_col - radius, 1),  
            to   = min(from_col + radius, ncol(m))
          )
        
        mt_row <- mat_which_vec(dim = dim(m), from_row, from_col)
        
        for ( to_row in row_seq ) {
          for ( to_col in col_seq ) {
            mt[mt_row, mat_which_vec(dim_m, to_row, to_col)] <- m[to_row, to_col]
          }
        }
        
      }
    }
    
    # attributes
    attr(mt, "dim_m") = dim(m)
    
    # return
    mt
  }


mt <- mat_val_to_transition(m)


sim <- 
  function(mt, times = 1, row = NULL, col = NULL, normalize = TRUE){
    
    if(normalize == TRUE){
      mt <- mat_normalize_p_row(mt)
    }
    
    # choose starting points
    if ( !is.null(row) & !is.null(col) ){
      mat_which_vec(attr(mt, "dim_m"), row, col)
      res <- t(matrix(start))
    }else{
      n      <- sample(seq_len(nrow(mt)), 1)
      res    <- integer(nrow(mt))
      res[n] <- 1
    }
    
    # exponentiate
    for(i in seq_len(times)){
      res <- res %*% mt
    }
    
    # return
    res <- res - min(res)
    res <- res / max(res)
    dim(res) <- attr(mt, "dim_m")
    res
  }

mt_1000 <- sim(mt, 800)
plot(as.raster(mt_1000), interpolate = FALSE)







