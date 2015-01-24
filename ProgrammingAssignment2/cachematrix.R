## There are two functions written in the code. The first initializes a special 
## matrix object that allows the user to store, or cache, its inverse.
## The second calculates the inverse of a matrix and stores the inverse into the
## inverse cache. If the inverse of the same matrix needs to be calculated again
## later on in the code, this function will pull the stored inverse from the 
## cache to save computation time. 

## The function makeCacheMatrix creates a list of 4 different functions:
## 1. setMatrix() creates the matrix. If the matrix is not a square matrix, the
##    function will return message to enter another matrix.
## 2. getMatrix() retries the matrix we created.
## 3. setInverse() stores the inverse matrix.
## 4. getInverse() retrieves the cached inverse matrix. 

makeCacheMatrix <- function(x = matrix()) {
     x1 <- NULL
     setMatrix <- function(input) {
          input_dim <- dim(input)
          if (input_dim[1] != input_dim[2]) {
               return(print("Please enter square matrix."))
          }
          mat <<- input
          x1 <<- NULL 
     }
     getMatrix <- function() {
          mat
     }
     setInverse <- function(inv) {
          x1 <<- inv
     }
     getInverse <- function() {
          x1
     }
     list(setMatrix = setMatrix, getMatrix = getMatrix,
          setInverse = setInverse, getInverse = getInverse)
}

## The function cacheSolve returns the inverse matrix of 'x'. It does this in 
## one of two ways.
## 1. Looks at the special cache matrix to see if an inverse is already stored.
## 2. If there is a cached inverse, the matrix has not been changed and the cached
##    inverse is returned.
## 3. If there is no cached inverse, the function will retrieve the cached 
##    matrix and determine whether an inverse exists. If so, the function will 
##    calculate the inverse matrix, store it into the cache matrix, and return
##    the inverse matrix. 

cacheSolve <- function(x, ...) {
     ## Return a matrix that is the inverse of 'x'
     x1 <- x$getInverse()
     if (!is.null(x1)) {
          message("Retrieving cached inverse matrix...")
          return(x1)    
     }
     orig_mat <- x$getMatrix()
     if (det(orig_mat)==0) {
          return(print("There is no inverse to this matrix."))
     }
     x1 <- solve(orig_mat, ...)
     x$setInverse(x1)
     x1
}
