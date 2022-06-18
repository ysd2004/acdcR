##########################################################################################
# Double Triangulation Method
##########################################################################################
dtrigdd <- function(tL,tU,tMin,tMax,tMin2){
  ## Two error cases
  if (tL >= tU) stop('Error: tL >= tU')
  if (tMin >= tMax) stop('Error: tMin >= tMax')
  if (tMin2 >= tMax) stop('Error: tMin2 >= tMax')
  
  dd <- 0
  for (i in 1:2){
    if (i == 2){
      tMin <- tMin2
    }
    ## case 2
    ddtemp <- 0
    ## case 1
    if (tU <= tMin){
      ddtemp <- (tU-tL)/2
    }
    ## case 3
    if ((tU > tMax) & (tL < tMin)){
      ddtemp <- 6*(tMax + tMin -2*tL)/24
    }
    ## case 4
    if ((tU > tMax) & (tL > tMin) & (tL < tMax)){
      ddtemp <- (6*((tMax-tL)^2)/(tMax-tMin))/24
    }
    ## case 5
    if ((tU < tMax) & (tL < tMin) & (tU > tMin)){
      ddtemp <- (6*(tMax + tMin -2*tL)/24)-((6*((tMax-tU)^2)/(tMax-tMin))/24)
    }
    ## case 6
    if ((tU < tMax) & (tL > tMin) ){
      ddtemp <- ((6*((tMax-tL)^2)/(tMax-tMin)) - (6*((tMax-tU)^2)/(tMax-tMin)))/24
    }
    dd <- dd + ddtemp 
  }
  return(dd)
}