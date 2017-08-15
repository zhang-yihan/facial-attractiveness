# rm(list=ls())
# setwd("~/Desktop/R")
library(R.matlab)
library(mediation)
library(corrplot)

## ================================= Load Data =================================

# attribute ratings
load("preprocessed-data.RData")

# latent representation
latent.aam.feat <- readMat("Latent_AAM_Feat.mat")
shapes <- latent.aam.feat$score.shape # dim 2222*154
textures <- latent.aam.feat$score.textures # dim 2222*30
latent.60 <- cbind(shapes[,1:30],textures) # colMeans = 0

# add distance metric
final.pair.substd.df$eucDist <- apply(latent.60, 1, function(x) sqrt(sum(x^2)))
final.pair.substd.df$eucDistInv <- 1 / final.pair.substd.df$eucDist

# standardize within trait
final.pair.substd.std.df <- final.pair.substd.df
final.pair.substd.std.df[,-21] <- 
  as.data.frame(scale(final.pair.substd.std.df[,-21])) # col 21 = imageID

## ======================== Distance Mediation Analysis ========================

# eucDist -> normal -> attractive
med.fit <- lm(normal~eucDist, data=final.pair.substd.std.df)
out.fit <- lm(attractive~normal+eucDist, data=final.pair.substd.std.df)
med.out <- mediate(med.fit, out.fit, treat="eucDist", mediator="normal")
summary(med.fit)
summary(out.fit)
summary(med.out)

# eucDistInv -> normal -> attractive
med.fit <- lm(normal~eucDistInv, data=final.pair.substd.std.df)
out.fit <- lm(attractive~normal+eucDistInv, data=final.pair.substd.std.df)
med.out <- mediate(med.fit, out.fit, treat="eucDistInv", mediator="normal")
summary(med.fit)
summary(out.fit)
summary(med.out)
