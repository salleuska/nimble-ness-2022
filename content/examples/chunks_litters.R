## @knitr litters-code

library(nimble)
littersCode <- nimbleCode({
  for (i in 1:G) {
     for (j in 1:N) {
        # likelihood (data model)
        r[i,j] ~ dbin(p[i,j], n[i,j])
        # latent process (random effects)
        p[i,j] ~ dbeta(a[i], b[i]) 
     }
     # prior for hyperparameters
     a[i] ~ dgamma(1, .001)
     b[i] ~ dgamma(1, .001)

     ## Mean and dispersion
     mu[i] <- a[i] / (a[i] + b[i])
     theta[i] <- 1 / (a[i] + b[i])

   }
})

## @knitr litters-model

## data and constants as R objects
G <- 2
N <- 16
n <- matrix(c(13, 12, 12, 11, 9, 10, 
              9, 9, 8, 11, 8, 10, 13, 10, 12, 9, 10, 9, 10, 5, 9, 9, 13, 
              7, 5, 10, 7, 6, 10, 10, 10, 7), nrow = 2)
r <- matrix(c(13, 12, 12, 11, 9, 10, 9, 9, 8, 10, 8, 9, 
     12, 9, 11, 8, 9, 8, 9, 4, 8, 7, 11, 4, 4, 5, 5, 3, 7, 3, 7, 0), 
     nrow = 2)
              
littersConsts <- list(G = G, N = N, n = n)
littersData <- list(r = r)
littersInits <- list( a = c(2, 2), b=c(2, 2) )

## create the NIMBLE model object
littersModel <- nimbleModel(littersCode, 
          data = littersData, constants = littersConsts, inits = littersInits)

## @knitr litters-compile

cLittersModel <- compileNimble(littersModel)


## @knitr doMCMC

littersConf <- configureMCMC(littersModel, print = TRUE)
littersConf$addMonitors(c('a', 'b', 'p'))

littersMCMC <- buildMCMC(littersConf)
cLittersMCMC <- compileNimble(littersMCMC, project = littersModel)


## @knitr makePlot

makePlot <- function(smp) {
    par(mfrow = c(2, 2), mai = c(.6, .5, .4, .1), mgp = c(1.8, 0.7, 0))
    ts.plot(smp[ , 'a[1]'], xlab = 'iteration',
        ylab = expression(a[1]), main = expression(a[1]))
    ts.plot(smp[ , 'b[1]'], xlab = 'iteration',
        ylab = expression(b[1]), main = expression(b[1]))
    ts.plot(smp[ , 'a[2]'], xlab = 'iteration',
        ylab = expression(a[2]), main = expression(a[2]))
    ts.plot(smp[ , 'b[2]'], xlab = 'iteration',
        ylab = expression(b[2]), main = expression(b[2]))
}
