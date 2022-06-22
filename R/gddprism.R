#' Calculating GDDs by PRISM grids or Counties with PRISM raster
#'
#' @description The function calculates the growing season degree days (GDDs) by grids or counties directly from a PRISM raster.
#' @param minprism A PRISM raster of the minimum temperature
#' @param maxprism A PRISM raster of the maximum temperature
#' @param year year of the PRIsM raster of minprism and maxprism
#' @param tL Lower temperature threshold
#' @param tU Upper temperature threshold
#' @param method GDD calculation methods: single sine or single triangulation only (default = single sine method)
#' @param out Output value type: GDDs by PRISM grids or Counties (default = Counties)
#' @details \code{gddprism} is a function for calculating growing season degree days (GDDs) by PRISM grids or Counties directly from a PRISM raster.\cr
#' \cr
#' Only single methods (single sine or single triangulation) are applicable by specifying method.\cr 
#' - \code{method = 'stri'}: single triangulation method
#' \cr
#' - \code{method = 'ssin'}: single sine method (default)\cr
#' \cr
#' The \code{out} is to specify the output values.\cr
#' - \code{out = 'grid'}: GDDs by PRISM grids projected on the NLCD map
#' \cr
#' - \code{out = 'stco'}: GDDs by Counties of 2017 Agricultural Census (default)
#' \cr
#' If \code{out} is not specified, 'stco' is set as default.\cr
#' \cr
#' When \code{out='stco'} is specified, the weights are applied as:\cr
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
#' - year >= 2019: agricultural areas in 2019 NLCD\cr
#' \cr
#' To get a PRIMS raster, follow the instruction at \url{https://prism.oregonstate.edu/documents/PRISM_downloads_FTP.pdf}.
#' @return A data.frame including GDDs (gdd), PRISM grid numbers (gridNum), or FIPS codes (stco)
#' @seealso \code{\link{gddcal}, \link{pptprism}, \link{grid2stco}}
#' @examples
#' #######################################################
#' ## Note: Need PRISM rasters to run this code
#' #######################################################
#' ## PRISM data import
#' # maxdata <- raster('./PRISM_tmax_stable_4kmD1_19960701_bil.bil')
#' # mindata <- raster('./PRISM_tmin_stable_4kmD1_19960701_bil.bil')
#' ## Single Sine Methods over Counties
#' # result1 <- gddprism(mindata,maxdata,1996,8,30,'ssin')
#' # result2 <- gddprism(mindata,maxdata,1996,8,30,'ssin','stco')
#' ## Single Sine Method over PRISM grids 
#' # result3 <- gddprism(mindata,maxdata,1996,8,30,'ssin','grid')
#' ## Single Triangulation over Counties
#' # result4 <- gddprism(mindata,maxdata,1996,8,30,'stri')
#' @export
#' @importFrom raster projectRaster getValues
#' @importFrom data.table as.data.table
#' @importFrom stats weighted.mean
gddprism <- function(minprism,maxprism,year,tL,tU,method=c('stri','ssin'),out=NULL){
## error controls
if (!(method %in% c('stri','ssin')))
  stop('Error: only stri and ssin are valid in ggdprism.')

if (is.null(out)){
  out <- 'stco'
}
if (!(out %in% c('stco','grid')))
  stop('Error: out is not properly typed!')

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

## Convert the PRISM projection to the NLCD projection
prjnlcd <- "+proj=aea +lat_0=23 +lon_0=-96 +lat_1=29.5 +lat_2=45.5 +x_0=0 +y_0=0 +datum=WGS84 +units=m +no_defs"
prism.min <- projectRaster(minprism,crs=prjnlcd)
prism.max <- projectRaster(maxprism,crs=prjnlcd)
tMinval <- getValues(prism.min)
tMaxval <- getValues(prism.max)
gridNum <- 1:length(tMinval)
tempInfo <- data.frame(gridNum,tMinval,tMaxval)

## Merge for Ag area only
merged <- merge(gridInfo[,c('gridNum','stco','numAg')],tempInfo,by='gridNum',all.x=T)

merged$gdd <- mapply(gddcal,tL=tL,tU=tU,tMin=merged$tMinval,tMax=merged$tMaxval,method=method)
## outputs
if (out == 'stco'){
  temp <- as.data.table(merged)
  temp2 <- temp[,lapply(.SD,weighted.mean,w=numAg,na.rm=T),by=list(temp$stco)]
  res <- as.data.frame(temp2[,c('temp','gdd')])
  colnames(res) <- c('stco','gdd')
} 
if (out == 'grid'){
  res <- merged[,c('gridNum','stco','gdd')]
}
return(res)
}