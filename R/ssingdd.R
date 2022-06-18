##########################################################################################
# Single Sine Method
##########################################################################################
ssingdd <- function(tL,tU,tMin,tMax){
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
    dd <- ((tMax + tMin)/2) - tL
  }
  ## case 4
  if ((tU > tMax) & (tL > tMin) & (tL < tMax)){
    alpha <- (tMax - tMin)/2
    theta1 <- asin( (tL - ((tMax+tMin)/2)) / alpha )
    dd <- (1/pi)*((((tMax + tMin)/2) - tL)*((pi/2)-theta1) + alpha*cos(theta1))
  }
  ## case 5
  if ((tU < tMax) & (tL < tMin) & (tU > tMin)){
    alpha <- (tMax - tMin)/2
    theta2 <- asin( (tU - ((tMax+tMin)/2)) / alpha )
    dd <- (1/pi)*((((tMax + tMin)/2) - tL)*(theta2 +(pi/2)) + (tU-tL)*((pi/2) - theta2) -
                    alpha*cos(theta2))
  }
  ## case 6
  if ((tU < tMax) & (tL > tMin) ){
    alpha <- (tMax - tMin)/2
    theta1 <- asin( (tL - ((tMax+tMin)/2)) / alpha )
    theta2 <- asin( (tU - ((tMax+tMin)/2)) / alpha )
    dd <- (1/pi)*((((tMax + tMin)/2) - tL)*(theta2 - theta1) + alpha*(cos(theta1)-cos(theta2)) +
                    (tU-tL)*((pi/2)-theta2))
  }
  return(dd)
}