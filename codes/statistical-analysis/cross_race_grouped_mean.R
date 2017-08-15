# rm(list=ls())
# setwd("~/Desktop/R")
library(plyr)
library(Rmisc)
library(car)

# Need to load preprocessed data to workspace first
# load("preprocessed-data.RData")

## ================== Subset Data, Black And White Race Only ===================

# keep only black & white, check face & rater 2
merge.df <- merge(all.df, image.df, by="imageID")
bw2.df <- subset(merge.df, (merge.df$race == 1 | merge.df$race == 2) &
                         (merge.df$subrace2 == 1 | merge.df$subrace2 == 2))

# within-subject standardization (variables same as all.df)
bw2.substd.df <- ddply(bw2.df, "subID1", function(x) {
  x.std <- x
  x.std[,c(2:4,7:16,21:27)] <- scale(x[,c(2:4,7:16,21:27)])
  x.std
})
bw2.substd.df <- ddply(bw2.substd.df, "subID2", function(x) {
  x.std <- x
  x.std[,c(28:30,33:44,49:53)] <- scale(x[,c(28:30,33:44,49:53)])
  x.std
})

## ====================== Grouped Bar Plot With Error Bar ======================

# normal
sum.bw2 <- summarySE(bw2.substd.df, measurevar="normal", 
                     groupvars=c("race","subrace2"), na.rm=TRUE)
ggplot(sum.bw2, aes(x=factor(race), y=normal, fill=factor(subrace2))) +
  geom_bar(position=position_dodge(), stat="identity") + 
  geom_errorbar(aes(ymin=normal-se, ymax=normal+se), width=.15, 
                position=position_dodge(0.9)) +
  scale_fill_discrete(name="Rater Race", labels=c("white", "black")) +
  scale_x_discrete(name="Face Race", labels=c("white", "black")) +
  theme_bw()

# emotStable
sum.bw2 <- summarySE(bw2.substd.df, measurevar="emotStable", 
                     groupvars=c("race","subrace2"), na.rm=TRUE)
ggplot(sum.bw2, aes(x=factor(race), y=emotStable, fill=factor(subrace2))) +
  geom_bar(position=position_dodge(), stat="identity") + 
  geom_errorbar(aes(ymin=emotStable-se, ymax=emotStable+se), width=.15, 
                position=position_dodge(0.9)) +
  scale_fill_discrete(name="Rater Race", labels=c("white", "black")) +
  scale_x_discrete(name="Face Race", labels=c("white", "black")) +
  theme_bw()

## =================================== ANOVA ===================================

# Results: all differences below are significant

# normal
normal.anova <- aov(normal~race*subrace2, data=bw2.substd.df)
summary(normal.anova)
Anova(normal.anova, type="III") # unbalanced design

# emotStable
emotStable.anova <- aov(emotStable~race*subrace2, data=bw2.substd.df)
summary(emotStable.anova)
Anova(emotStable.anova, type="III") # unbalanced design
