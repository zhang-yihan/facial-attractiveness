# rm(list=ls())
# setwd("~/Desktop/R")
library(R.matlab)
library(mediation)

## ============================= Load Binned Data ==============================

# latent representation
binned.mediation.data <- readMat("Binned_Mediation_Data.mat")
binned.faces <- t(binned.mediation.data[1][[1]]) # Binned.Faces, 2222*1 mat
binned.trait <- t(binned.mediation.data[3][[1]]) # Binned.Trait, 2222*2 mat
bin.df <- as.data.frame(cbind(binned.trait,binned.faces))
names(bin.df) <- c("attractive","normal","distance")

# add distance inverse
bin.df$distanceInv <- 1 / bin.df$distance

# standardize within trait
bin.std.df <- as.data.frame(scale(bin.df))

## ======================== Distance Mediation Analysis ========================

# distance -> normal -> attractive
med.fit <- lm(normal~distance, data=bin.std.df)
out.fit <- lm(attractive~normal+distance, data=bin.std.df)
med.out <- mediate(med.fit, out.fit, treat="distance", mediator="normal")
summary(med.fit)
summary(out.fit)
summary(med.out)

# distanceInv -> normal -> attractive
med.fit <- lm(normal~distanceInv, data=bin.std.df)
out.fit <- lm(attractive~normal+distanceInv, data=bin.std.df)
med.out <- mediate(med.fit, out.fit, treat="distanceInv", mediator="normal")
summary(med.fit)
summary(out.fit)
summary(med.out)
