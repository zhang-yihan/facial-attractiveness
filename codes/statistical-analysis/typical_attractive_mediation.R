# rm(list=ls())
# setwd("~/Desktop/R")
library(mediation)

# Need to load preprocessed data to workspace first
# load("preprocessed-data.RData")

## ========================== Standardize Each Trait ===========================

final.std.df <- as.data.frame(scale(final.df))
final.substd.std.df <- as.data.frame(scale(final.substd.df))

## ======================= Typicality Mediation Analysis =======================

# (final.std) typical -> familiar -> attractive
med.fit <- lm(familiar~typical, data=final.std.df)
out.fit <- lm(attractive~familiar+typical, data=final.std.df)
med.out <- mediate(med.fit, out.fit, treat="typical", mediator="familiar")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.std) familiar -> typical -> attractive
med.fit <- lm(typical~familiar, data=final.std.df)
out.fit <- lm(attractive~typical+familiar, data=final.std.df)
med.out <- mediate(med.fit, out.fit, treat="familiar", mediator="typical")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.std) typical -> normal -> attractive
med.fit <- lm(normal~typical, data=final.std.df)
out.fit <- lm(attractive~normal+typical, data=final.std.df)
med.out <- mediate(med.fit, out.fit, treat="typical", mediator="normal")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.std) normal -> typical -> attractive
med.fit <- lm(typical~normal, data=final.std.df)
out.fit <- lm(attractive~typical+normal, data=final.std.df)
med.out <- mediate(med.fit, out.fit, treat="normal", mediator="typical")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.std) familiar -> normal -> attractive
med.fit <- lm(normal~familiar, data=final.std.df)
out.fit <- lm(attractive~normal+familiar, data=final.std.df)
med.out <- mediate(med.fit, out.fit, treat="familiar", mediator="normal")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.std) normal -> familiar -> attractive
med.fit <- lm(familiar~normal, data=final.std.df)
out.fit <- lm(attractive~familiar+normal, data=final.std.df)
med.out <- mediate(med.fit, out.fit, treat="normal", mediator="familiar")
summary(med.fit)
summary(out.fit)
summary(med.out)

## ======== subject-standardized ========

# (final.substd.std) typical -> familiar -> attractive
med.fit <- lm(familiar~typical, data=final.substd.std.df)
out.fit <- lm(attractive~familiar+typical, data=final.substd.std.df)
med.out <- mediate(med.fit, out.fit, treat="typical", mediator="familiar")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.substd.std) familiar -> typical -> attractive
med.fit <- lm(typical~familiar, data=final.substd.std.df)
out.fit <- lm(attractive~typical+familiar, data=final.substd.std.df)
med.out <- mediate(med.fit, out.fit, treat="familiar", mediator="typical")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.substd.std) typical -> normal -> attractive
med.fit <- lm(normal~typical, data=final.substd.std.df)
out.fit <- lm(attractive~normal+typical, data=final.substd.std.df)
med.out <- mediate(med.fit, out.fit, treat="typical", mediator="normal")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.substd.std) normal -> typical -> attractive
med.fit <- lm(typical~normal, data=final.substd.std.df)
out.fit <- lm(attractive~typical+normal, data=final.substd.std.df)
med.out <- mediate(med.fit, out.fit, treat="normal", mediator="typical")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.substd.std) familiar -> normal -> attractive
med.fit <- lm(normal~familiar, data=final.substd.std.df)
out.fit <- lm(attractive~normal+familiar, data=final.substd.std.df)
med.out <- mediate(med.fit, out.fit, treat="familiar", mediator="normal")
summary(med.fit)
summary(out.fit)
summary(med.out)

# (final.substd.std) normal -> familiar -> attractive
med.fit <- lm(familiar~normal, data=final.substd.std.df)
out.fit <- lm(attractive~familiar+normal, data=final.substd.std.df)
med.out <- mediate(med.fit, out.fit, treat="normal", mediator="familiar")
summary(med.fit)
summary(out.fit)
summary(med.out)
