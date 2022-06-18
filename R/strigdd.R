##########################################################################################
# Single Triangulation Method
##########################################################################################
strigdd <- function(tL,tU,tMin,tMax){
  ## Two error cases
  if (tL >= tU) stop('Error: tL >= tU')
  if (tMin >= tMax) stop('Error: tMin >= tMax')
  ## case 2
  dd <- 0
  ## case 1
  if (tU <= tMin){
    dd <- tU-tL
  }
  ## case 3
  if ((tU > tMax) & (tL < tMin)){
    dd <- 6*(tMax + tMin -2*tL)/12
  }
  ## case 4
  if ((tU > tMax) & (tL > tMin) & (tL < tMax)){
    dd <- (6*((tMax-tL)^2)/(tMax-tMin))/12
  }
  ## case 5
  if ((tU < tMax) & (tL < tMin) & (tU > tMin)){
    dd <- (6*(tMax + tMin -2*tL)/12)-((6*((tMax-tU)^2)/(tMax-tMin))/12)
  }
  ## case 6
  if ((tU < tMax) & (tL > tMin) ){
    dd <- ((6*((tMax-tL)^2)/(tMax-tMin)) - (6*((tMax-tU)^2)/(tMax-tMin)))/12
  }
  return(dd)
}