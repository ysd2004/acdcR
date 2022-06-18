#' Convert PRISM grid data to agricultural area weighted county data
#'
#' @description The function calculates agricultural area weighted county values from PRISM grid data.
#' @param griddata An output data.frame from \code{gddprism} or \code{pptprism}
#' @param year year of the griddata
#' @details \code{grid2stco} converts an output data.frame from \code{gddprism} or \code{pptprism} to the county-level weighted average with agricultural areas in NLCD.\cr
#' If a single PRISM result is converted from grid to stco, the results are the same with the \code{stco} specification in \code{gddprism} or \code{pptprism}.\cr
#' This function would be helpful when cumulative precipitation or gdd are applied first and then calculate county-level values.\cr
#' The GDDs and precipitations in Schlenker and Roberts (2009) are replicable with these functions.\cr
#' \cr
#' The input of \code{griddata} should have the following variables.\cr
#' - For an output of \code{gddprism}: gridNum, stco, and gdd
#' \cr
#' - For an output of \code{pptprism}: gridNum, stco, and ppt
#' \cr
#' \cr
#' With the specified data year of \code{year}, the weights are applied as:\cr
#' - year < 2004: agricultural areas in 2001 NLCD
#' \cr
#' - year = 2004 or 2005: agricultural areas in 2004 NLCD
#' \cr
#' - year = 2006 or 2007: agricultural areas in 2006 NLCD
#' \cr
#' - year = 2008, 2009, or 2010: agricultural areas in 2008 NLCD
#' \cr
#' - year = 2011 or 2012: agricultural areas in 2011 NLCD
#' \cr
#' - year = 2013, 2014, or 2015: agricultural areas in 2013 NLCD
#' \cr
#' - year = 2016, 2017, or 2018: agricultural areas in 2016 NLCD
#' \cr
#' - year >= 2019: agricultural areas in 2019 NLCD
#' @references Schlenker, W. and M. Roberts. (2009) "Nonlinear temperature effects indicate severe damages to U.S. crop yields under climate change." \emph{Proceedings of the National Academy of Sciences (PNAS)}. 15594-15598.
#' @return A data.frame of FIPS codes (stco) and growing degree days (GDDs) or precipitation (ppt) 
#' @seealso \code{\link{gddprism}, \link{pptprism}}
#' @examples
#' #######################################################
#' ## Note: Need a PRISM raster to run this code
#' #######################################################
#' ## PRISM data import
#' # pptdata <- raster('./PRISM_ppt_stable_4kmD2_19960701_bil.bil')
#' ## precipitation data by grid and stco
#' # stcores <- pptprism(pptdata,1996,'stco')
#' # gridres <- pptprism(pptdata,1996,'grid')
#' ## Convert the gridres to stcores
#' # converted <- grid2stco(gridres,1996)
#' ## Compare the results
#' # converted$ppt[1:10]
#' # stcores$ppt[1:10]
#' @export
#' @importFrom data.table as.data.table
grid2stco <- function(griddata,year){
if (sum(colnames(griddata) == 'gridNum') !=1)
  stop('Error! gridNum is mssisng!')
if (sum(colnames(griddata) == 'gridNum') !=1)
  stop('Error! stco is mssisng!')

varcheck1 <- sum(colnames(griddata) == 'gdd')
varcheck2 <- sum(colnames(griddata) == 'ppt')

if ((varcheck1 + varcheck2) == 0)
  stop('Error! gdd or ppt is mssisng!')
if ((varcheck1 + varcheck2) == 2)
  stop('Error! Both gdd and ppt are specified!')

if (varcheck1 == 1){
  var <- 'gdd'
}
if (varcheck2 == 1){
  var <- 'ppt'
}

## Agricultural Weights Selection
if (year < 2004){
  gridyear <- 2001
} else if (year %in% c(2004:2005)){
  gridyear <- 2004
} else if (year %in% c(2006:2007)){
  gridyear <- 2006
} else if (year %in% c(2008:2010)){
  gridyear <- 2008
} else if (year %in% c(2011:2012)){
  gridyear <- 2011
} else if (year %in% c(2013:2015)){
  gridyear <- 2013
} else if (year %in% c(2016:2018)){
  gridyear <- 2016
} else if (year > 2018){
  gridyear <- 2019
}
load(url(paste('https://raw.github.com/ysd2004/gridInfo/main/gridInfo',gridyear,'.rda',sep='')))

## Drop stco
griddata <- griddata[,c('gridNum',var)]

## Merge for Ag area
merged <- merge(gridInfo[,c('gridNum','stco','numAg')],griddata,by='gridNum',all.x=T)

## Get results
temp <- as.data.table(merged)
temp2 <- temp[,lapply(.SD,weighted.mean,w=numAg,na.rm=T),by=list(temp$stco)]
temp2 <- as.data.frame(temp2)
res <- temp2[,c('temp',var)]
colnames(res) <- c('stco',var)

return(res)
}