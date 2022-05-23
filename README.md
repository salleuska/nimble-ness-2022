# nimble-ness-2022
Materials for the NIMBLE short course at the NESS 2022 conference, May 23, 2022. 

To prepare for the workshop:

 - Install NIMBLE (see below)
 - Install additional packages (see below)
 - Download these materials (and check back before the workshop on Monday May 23 for updates)

All materials for the workshop will be in this GitHub repository. If you're familiar with Git/GitHub, you already know how to get all the materials on your computer. If you're not, simply click [here](https://github.com/salleuska/nimble-ness-2022/archive/main.zip).

<!--
 There is some overview information [here (https://htmlpreview.github.io/?https://github.com/nimble-training/nimble-lisbon-2022/blob/main/overview.html), including links to the content modules in order.
 -->

## Tentative Schedule

Monday, May 22, 2022 
Location: AUST 108

Click [here](https://rawcdn.githack.com/salleuska/nimble-ness-2022/410548672e2a2d10cccc2906bbbd959e8a6b689c/overview.html) for an overview of the material

Morning: 9am - 12pm 
- Introduction to NIMBLE: basic concepts and workflows
    - 1_introduction_to_nimble
    - 2_nimble_models
- Customizing an MCMC 
    - 3_customizing_mcmc

Afternoon: 1pm - 5pm
- Programming in NIMBLE
    - 4_writing_user_distributions
    - 5_writing_user_samplers
- Highlights of special features in NIMBLE
    - 6_nimble_highlights

## Help with NIMBLE

Our user manual is [here](https://r-nimble.org/html_manual/cha-welcome-nimble.html).

We have a 'cheatsheet' [here](https://r-nimble.org/documentation).

For those of you who are not already familiar with writing models in WinBUGS, JAGS, or NIMBLE, you may want to look through the first module (Introduction to NIMBLE) or Section 5.2 of our user manual in advance.


## Installing NIMBLE

NIMBLE is an R package on CRAN, so in general it will be straightforward to install as with any R package, but you do need a compiler and related tools on your system.  

In summary, here are the steps.

1. Install compiler tools on your system. [https://r-nimble.org/download](https://r-nimble.org/download) has more details on how to install *Rtools* on Windows and how to install the command line tools of *Xcode* on a Mac. Note that if you have packages requiring a compiler (e.g., *Rcpp*) on your computer, you should already have the compiler tools installed.

2. Install the *nimble* package from CRAN in the usual fashion for an R package. More details (including troubleshooting tips) can also be found in Section 4 of the [NIMBLE manual](https://r-nimble.org/html_manual/cha-installing-nimble.html).

3) To test that things are working please run the following code in R:

```
library(nimble)
code <- nimbleCode({
  y ~ dnorm(0,1)
})
model <- nimbleModel(code)
cModel <- compileNimble(model)
```

If that runs without error, you're all set. If not, please see the [troubleshooting tips](https://r-nimble.org/html_manual/cha-installing-nimble.html#troubleshooting-installation-problems) and email me at spaganin@hsph.harvard.edu directly if you can't get things going.  

In general we encourage you to update to the most recent version of NIMBLE, 0.12.2.


## Installing additional packages

Some of the packages we will use (beyond those automatically installed with `nimble`) can be installed as follows:

```
install.packages(c("mcmcplots",  "classInt", "coda"))
```
<!--
"CARBayesdata", "sp", "spdep",
--->

`compareMCMCs` is a package in development that is not yet on CRAN:

```
library(remotes)
install_github("nimble-dev/compareMCMCs", subdir = "compareMCMCs")
```

Windows users will probably need to use this invocation:

```
library(remotes)
install_github("nimble-dev/compareMCMCs", subdir = "compareMCMCs", INSTALL_opts = "--no-multiarch")
```
