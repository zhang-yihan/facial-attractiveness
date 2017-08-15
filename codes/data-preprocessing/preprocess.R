# rm(list=ls())
# setwd("~/Desktop/R")
library(R.matlab)
library(plyr)
library(abind)

# Need to have the following files in the save directory:
#  - psychology-attributes.mat
#  - image-labels.csv

## =============================== Load Raw Data ===============================

# load psychology-attributes into R
psych.attributes <- readMat("psychology-attributes.mat")
final.vals <- psych.attributes$finalVals
nImage <- length(final.vals) # 2222
nVariable <- length(final.vals[[1]][[1]]) # 52

# load finalVals (averaged for each image)
final.df <- as.data.frame(t(matrix(unlist(final.vals), nrow=nVariable)))
names(final.df) <- unlist(psych.attributes$headers)
# remove invalid subject info variables
final.df <- subset(final.df, select=-c(4:5,16:19,30:31,44:47))
# add imageID
final.df$imageID <- 1:nImage
# check dataset
dim(final.df) # 2222*(40+1)

# load allData (individual ratings)
all.data <- psych.attributes$allData
all.df <- as.data.frame(do.call(rbind,unlist(all.data, recursive=FALSE)))
names(all.df) <- unlist(psych.attributes$headers)
# modify names to reflect two subjects rating on the same image
names(all.df)[c(4:5,16:19)] <- c("catch1","catchAns1",
                                 "subID1","subage1","submale1","subrace1")
names(all.df)[c(30:31,44:47)] <- c("catch2","catchAns2",
                                   "subID2","subage2","submale2","subrace2")
# add imageID
nPerImage <- sapply(all.data, function(x) dim(x[[1]])[1])
all.df$imageID <- unlist(mapply(rep, 1:nImage, nPerImage))
# check dataset
dim(all.df) # 33430*(52+1)

# output to matlab format
writeMat("~/Desktop/R/raw-data.mat", 
         nImage=2222, nSubject=1274, 
         nPerImage=nPerImage, 
         final=as.matrix(final.df), 
         all=as.matrix(all.df), 
         finalHeader=names(final.df), 
         allHeader=names(all.df)) 

## ========================== Subject Standardization ==========================

# Note: Ratings are standardized within each rater for each trait 
#       i.e. subtract mean, then divide by standard deviation

# within-subject standardization
all.substd.df <- ddply(all.df, "subID1", function(x) {
  x.std <- x
  x.std[,c(1:3,6:15,20:26)] <- scale(x[,c(1:3,6:15,20:26)])
  x.std
})
all.substd.df <- ddply(all.substd.df, "subID2", function(x) {
  x.std <- x
  x.std[,c(27:29,32:43,48:52)] <- scale(x[,c(27:29,32:43,48:52)])
  x.std
})
# order by imageID (note: the resulted order is different from all.df!)
all.substd.df <- all.substd.df[order(all.substd.df$imageID),] # dim 33430*(52+1)

# averaged ratings after within-subject standardization # dim 2222*(40+1)
cols <- c(1:3,6:15,20:26,27:29,32:43,48:52,53)
final.substd.df <- ddply(all.substd.df[,cols], "imageID", colMeans, na.rm=TRUE)

# reshape all.substd.df to 3D array
# survey1
cols <- c(1:3,6:15,20:26,53,16)
rfa1.arr <- daply(all.substd.df[,cols], "imageID", function(x) {
  x <- subset(x, !is.na(subID1))
  x.full.length <- matrix(NA, nrow=1274, ncol=20)
  x.full.length[x$subID1,] <- as.matrix(x[,1:20])
  x.full.length
})
rfa1.arr <- aperm(rfa1.arr, c(2,1,3))
# survey2
cols <- c(27:29,32:43,48:52,53,44)
rfa2.arr <- daply(all.substd.df[,cols], "imageID", function(x) {
  x <- subset(x, !is.na(subID2))
  x.full.length <- matrix(NA, nrow=1274, ncol=20)
  x.full.length[x$subID2,] <- as.matrix(x[,1:20])
  x.full.length
})
rfa2.arr <- aperm(rfa2.arr, c(2,1,3))
# combine
rfa.arr <- abind(rfa1.arr, rfa2.arr, along=3)
dimnames(rfa.arr)[[3]] <- 
  names(all.substd.df)[c(1:3,6:15,20:26,27:29,32:43,48:52)]

# output
writeMat("~/Desktop/R/substd-data.mat", 
         finalSubstd=as.matrix(final.substd.df), 
         allSubstd=as.matrix(all.substd.df), 
         allSubstd3D=rfa.arr, 
         finalHeader=names(final.substd.df), 
         allHeader=names(all.substd.df), 
         all3DHeader=dimnames(rfa.arr)[[3]])

## =========================== Combine Antonym Pair ============================

# antonym pairing in survey1 order
survey1 <- c("atypical","boring","calm","cold","common",
             "confident","egotistic","emotUnstable","forgettable","intelligent",
             "introverted","kind","responsible","trustworthy","unattractive",
             "unemotional","unfamiliar","unfriendly","unhappy","weird")
survey2 <- c("typical","interesting","aggressive","caring","uncommon",
             "uncertain","humble","emotStable","memorable","unintelligent",
             "sociable","mean","irresponsible","untrustworthy","attractive",
             "emotional","familiar","friendly","happy","normal")
# 20 positive attributes
cols <- c(1,2,4,7,8,9,11,15,16,17,18,19,20)
survey.pair <- survey1
survey.pair[cols] <- survey2[cols]

# pairing on raw individual data
all.pair.df <- rbind(all.df[,survey1], setNames(10-all.df[,survey2],survey1))
all.pair.df$imageID <- rep(all.df$imageID, 2)
all.pair.df$subID <- c(all.df$subID1, all.df$subID2) # dim 66860*22
# change negative attributs to positive
all.pair.df[,cols] <- 10-all.pair.df[,cols]
names(all.pair.df)[1:20] <- survey.pair
# averaging
final.pair.df <- ddply(all.pair.df, "imageID", colMeans, na.rm=TRUE)
final.pair.df$subID <- NULL # dim 2222*21

# subject standardization on paired individual data
all.pair.substd.df <- ddply(all.pair.df, "subID", function(x) {
  x.std <- as.data.frame(scale(x[,1:20]))
  transform(x.std, imageID=x$imageID)
})
all.pair.substd.df <- all.pair.substd.df[, c(2:22,1)] # dim 66860*22
# order by imageID (note: the resulted order is different from all.df!)
all.pair.substd.df <- all.pair.substd.df[order(all.pair.substd.df$imageID),]
# averaging
final.pair.substd.df <- ddply(all.pair.substd.df, "imageID",colMeans,na.rm=TRUE)
final.pair.substd.df$subID <- NULL # dim 2222*21

# output
writeMat("~/Desktop/R/paired-data.mat", 
         finalPair=as.matrix(final.pair.df), 
         allPair=as.matrix(all.pair.df), 
         finalPairSubstd=as.matrix(final.pair.substd.df), 
         allPairSubstd=as.matrix(all.pair.substd.df), 
         finalPairHeader=names(final.pair.df), 
         allPairHeader=names(all.pair.df))

## ============================= Faces & Raters ================================

# load image labels
image.df <- read.csv("image-labels.csv", header=TRUE)
image.df$imageID <- 1:2222
image.df <- image.df[,c(5,3,1,2,4)] # dim 2222*5

# extract subject demographics
sub1.df <- unique(all.df[,c("subID1","subage1","submale1","subrace1")])
names(sub1.df) <- c("subID","subage","submale","subrace")
sub1.df <- subset(sub1.df, !is.na(subID))
sub1.df <- sub1.df[order(sub1.df$subID),]
sub1.df$nSurvey <- table(all.df$subID1) # dim 1154*5
sub2.df <- unique(all.df[,c("subID2","subage2","submale2","subrace2")])
names(sub2.df) <- c("subID","subage","submale","subrace")
sub2.df <- subset(sub2.df, !is.na(subID))
sub2.df <- sub2.df[order(sub2.df$subID),]
sub2.df$nSurvey <- table(all.df$subID2) # dim 1148*5
# all subject
sub.df <- unique(rbind(sub1.df[,1:4], sub2.df[,1:4])) # dim 1274*4

# output
writeMat("~/Desktop/R/image-subject.mat", 
         image=as.matrix(image.df), 
         imageHeader=names(image.df), 
         subject=as.matrix(sub.df), 
         subjectHeader=names(sub.df))


# uncomment to save the current workspace
# save.image("~/Desktop/R/preprocessed-data.RData")
