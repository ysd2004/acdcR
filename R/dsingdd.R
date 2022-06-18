##########################################################################################
# Double Sine Method
##########################################################################################
dsingdd <- function(tL,tU,tMin,tMax,tMin2){
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
      ddtemp <- (((tMax + tMin)/2) - tL)/2
    }
    ## case 4
    if ((tU > tMax) & (tL > tMin) & (tL < tMax)){
      alpha <- (tMax - tMin)/2
      theta1 <- asin( (tL - ((tMax+tMin)/2)) / alpha )
      ddtemp <- (1/(2*pi))*((((tMax + tMin)/2) - tL)*((pi/2)-theta1) + alpha*cos(theta1))
    }
    ## case 5
    if ((tU < tMax) & (tL < tMin) & (tU > tMin)){
      alpha <- (tMax - tMin)/2
      theta2 <- asin( (tU - ((tMax+tMin)/2)) / alpha )
      ddtemp <- (1/(2*pi))*((((tMax + tMin)/2) - tL)*(theta2 +(pi/2)) + (tU-tL)*((pi/2) - theta2) -
                      alpha*cos(theta2))
    }
    ## case 6
    if ((tU < tMax) & (tL > tMin) ){
      alpha <- (tMax - tMin)/2
      theta1 <- asin( (tL - ((tMax+tMin)/2)) / alpha )
      theta2 <- asin( (tU - ((tMax+tMin)/2)) / alpha )
      ddtemp <- (1/(2*pi))*((((tMax + tMin)/2) - tL)*(theta2 - theta1) + alpha*(cos(theta1)-cos(theta2)) +
                      (tU-tL)*((pi/2)-theta2))
    }
    dd <- dd + ddtemp 
  }
  return(dd)
}