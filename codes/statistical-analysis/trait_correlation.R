# rm(list=ls())
# setwd("~/Desktop/R")
library(corrplot)
library(lattice)
library(ggplot2)

# Need to load preprocessed data to workspace first
# load("preprocessed-data.RData")

## ====================== Attractive-Typical Correlation =======================

cols <- c("attractive","emotStable","familiar","normal","typical")
# image-level
corrplot(cor(final.df[,cols], use="pairwise"), 
         tl.col="black",
         method="number")
corrplot(cor(final.substd.df[,cols], use="pairwise"), 
         tl.col="black",
         method="number")

## ======================== Between-Survey Correlation =========================

survey1 <- c("atypical","boring","calm","cold","common",
             "confident","egotistic","emotUnstable","forgettable","intelligent",
             "introverted","kind","responsible","trustworthy","unattractive",
             "unemotional","unfamiliar","unfriendly","unhappy","weird")
survey2 <- c("typical","interesting","aggressive","caring","uncommon",
             "uncertain","humble","emotStable","memorable","unintelligent",
             "sociable","mean","irresponsible","untrustworthy","attractive",
             "emotional","familiar","friendly","happy","normal")

# typicality
typ.cor <- cor(final.df[,c("normal","common","typical","familiar")])
corrplot(typ.cor, tl.col="black", method="number")

# within survey correlation
corrplot(cor(final.df[,survey1]), type="upper", tl.col="black")
corrplot(cor(final.df[,survey2]), type="upper", tl.col="black")
# between survey correlation
between.survey.cor <- cor(final.df[,survey1], final.df[,survey2])
corrplot(between.survey.cor, tl.col="black")

## ======== subject-standardized ========

# typicality
typ.cor <- cor(final.substd.df[,c("normal","common","typical","familiar")])
corrplot(typ.cor, tl.col="black", method="number")

# within survey correlation
corrplot(cor(final.substd.df[,survey1]), type="upper", tl.col="black")
corrplot(cor(final.substd.df[,survey2]), type="upper", tl.col="black")
# between survey correlation
between.survey.cor <- cor(final.substd.df[,survey1], final.substd.df[,survey2])
corrplot(between.survey.cor, tl.col="black")

## ============================ Pairing Correlation ============================

# reorder attributes by 3 groups: typicality/personality/social attributes
reorder <- c("normal","familiar","typical","common", # typicality
          "friendly","caring","kind","happy","trustworthy", 
          "emotStable","sociable","calm","responsible","intelligent", 
          "confident","emotional","humble","interesting", # personality
          "attractive","memorable") # social

# check whether cor coef are sig diff
cmp.cor <- function (r1,r2,n1=2222,n2=2222) {
  fisher.z <- (atanh(r1) - atanh(r2)) / sqrt((1/(n1-3))+(1/(n2-3)))
  fisher.z[is.na(fisher.z)] <- 1
  2 * (1 - pnorm(abs(fisher.z))) # return p-value, reject if < 0.05
}

# correlation of final.pair, before/after substd
before <- cor(final.pair.df[,reorder])
after <- cor(final.pair.substd.df[,reorder])
corrplot(before, tl.col="black")
corrplot(after, tl.col="black", p.mat=cmp.cor(before,after), insig="blank")

# correlation of final.substd, before/after pairing
before <- cor(final.substd.df[,reorder])
after <- cor(final.pair.substd.df[,reorder])
corrplot(before, tl.col="black")
corrplot(after, tl.col="black", p.mat=cmp.cor(before,after), insig="blank")
