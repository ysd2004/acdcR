#' Calculating precipitation by PRISM grids or Counties with PRISM raster
#'
#' @description The function calculates the precipitation (mm) by grids or counties directly from a PRISM raster.
#' @param mmprism A PRISM raster of the precipitation
#' @param year year of the PRIsM raster
#' @param out Output value type: precipitation by PRISM grids or Counties (default = Counties)
#' @details \code{pptprism} is a function for calculating precipitation (mm) by PRISM grids or Counties directly from a PRISM raster.\cr
#' \cr
#' The \code{out} is to specify the output values.\cr
#' - \code{out = 'grid'}: precipitation by PRISM grids projected on the NLCD map
#' \cr
#' - \code{out = 'stco'}: precipitation by Counties of 2017 Agricultural Census (default)
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
#' @return A data.frame including precipitation (ppt), PRISM grid numbers (gridNum), or FIPS codes (stco)
#' @seealso \code{\link{gddprism}, \link{grid2stco}}
#' @examples
#' #######################################################
#' ## Note: Need a PRISM raster to run this code
#' #######################################################
#' \dontrun{
#' ## PRISM data import
#' pptdata <- raster('./PRISM_ppt_stable_4kmD2_19960701_bil.bil')
#' ## precipitation over Counties
#' result <- pptprism(pptdata,1996)
#' result2 <- pptprism(pptdata,1996,'stco')
#' ## precipitation over PRISM grids
#' result3 <- pptprism(pptdata,1996,'grid')
#' }
#' @export
#' @importFrom raster projectRaster getValues
#' @importFrom data.table as.data.table
#' @importFrom stats weighted.mean
pptprism <- function(mmprism,year,out=NULL){
  ## error controls
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
  prism.ppt <- projectRaster(mmprism,crs=prjnlcd)
  ppt <- getValues(prism.ppt)
  gridNum <- 1:length(ppt)
  tempInfo <- data.frame(gridNum,ppt)
  
  ## Merge for Ag area only
  merged <- merge(gridInfo[,c('gridNum','stco','numAg')],tempInfo,by='gridNum',all.x=T)
  
  ## outputs
  if (out == 'stco'){
    temp <- as.data.table(merged)
    temp2 <- temp[,lapply(.SD,weighted.mean,w=numAg,na.rm=T),by=list(temp$stco)]
    res <- as.data.frame(temp2[,c('temp','ppt')])
    colnames(res) <- c('stco','ppt')
  } 
  if (out == 'grid'){
    res <- merged[,c('gridNum','stco','ppt')]
  }
  return(res)
}