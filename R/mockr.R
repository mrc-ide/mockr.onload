x <- function() {
  message("executing x")
  "x"
}

y <- function() {
  message("executing y")
  x()
}
