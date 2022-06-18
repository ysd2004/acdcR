#' Calculating growing season degree days
#'
#' @description The function calculates the growing season degree days (GDDs) using single/double triangulation/sine methods.
#' @param tL Lower temperature threshold
#' @param tU Upper temperature threshold
#' @param tMin Minimum temperature
#' @param tMax Maximum temperature
#' @param tMin2 Minimum temperature for the second half day
#' @param method GDD calculation methods (default = single sine method)
#' @details \code{gddcal} is a function for calculating growing season degree days (GDDs) through four approaches popularly used in agricultural production or relevant fields.\cr 
#' \cr
#' - \code{method = 'stri'}: single triangulation method
#' \cr
#' - \code{method = 'dtri'}: double triangulation method (need \code{tMin2})
#' \cr
#' - \code{method = 'ssin'}: single sine method
#' \cr
#' - \code{method = 'dsin'}: double sine method (need \code{tMin2})\cr
#' \cr
#' The default is the single sine method. i.e., if \code{method} is not specified, \code{gddcal} uses the single sine method. For two double methods (\code{'dtri'} and \code{'dsin'}), a second half day minimum temperature needs to be specified.
#' @return A numeric of growing season degree days (GDDs)
#' @references Zalom, F. G., P. B. Goodell, Lloyd T. Wilson, W. W. Barnett, and W. J. Bentley. (1983) "Degree-Days, the Calculation and Use of Heat Units in Pest Management." \emph{Division of Agriculture and Natural Resources, University of California}. 1-11.
#' @examples
#' ## Single Triangulation Method
#' gddcal(55,90,50,82,'stri')
#' ## Double Triangulation Method
#' gddcal(55,90,50,82,45,'dtri')
#' ## Single Sine Method
#' gddcal(55,90,50,82)
#' gddcal(55,90,50,82,'ssin')
#' ## Double Sine Method
#' gddcal(55,90,50,82,45,'dsin')
#' @seealso \code{\link{gddprism}}
#' @export
gddcal <- function(tL,tU,tMin,tMax,tMin2=NULL,method=NULL){
  if (is.character(tMin2) & is.null(method)){
    method <- tMin2
    tMin2 <- NULL
  }
  if (is.null(tMin2) & is.null(method)){
    method <- 'ssin'
  }
  if ((method %in% c('dtri','dsin')) & is.null(tMin2))
    stop('Error: a send half day minimum is necessray for double methods (dtri or dsin)!')
  
  if (method == 'ssin'){
    res <- ssingdd(tL,tU,tMin,tMax)
  }
  if (method == 'dsin'){
    res <- dsingdd(tL,tU,tMin,tMax,tMin2)
  }
  if (method == 'stri'){
    res <- strigdd(tL,tU,tMin,tMax)
  }
  if (method == 'dtri'){
    res <- dtrigdd(tL,tU,tMin,tMax,tMin2)
  }
  return(res)
}