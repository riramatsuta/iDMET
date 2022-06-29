rm(list=ls(all=TRUE))

load(file = "ALL.RData")
# --------------------------------
#   Step 2 (Data division)
# --------------------------------
# The division processing of the metabolomic data is performed at Step 2
 
k <- 1
FIN <- NULL
CompName<-NULL
FNAME <- NULL
for(i in 1:length(ALL)){
  n <- ncol(ALL[[i]])
  for(j in 3:n){
    CompName[k]<-names(ALL[[i]])[j]
    #FIN[[k]]
    
    # Compound names and ratios 
    # FIN[[k]] <- list(as.character(ALL[[i]][,1]),as.numeric(as.character(ALL[[i]][,j])))
    FIN[[k]] <- data.frame(name = as.character(ALL[[i]][,1]),ratio = as.numeric(as.character(ALL[[i]][,j])))
    k <- k+1
  }
}

names(FIN) <- CompName  # sample name
nf <- chartr("."," vs ",names(FIN))  # amendment to sample name


save(FIN,file="FIN.RData")

# --------------------------------
#   Cluster information 
# --------------------------------
# The data are divided and associated with the cluster number  # check

nameR <- substr(names(ALL),1,12)   # substr substring (information of PMID) 
nn <- nameR

k <- 1
FNAME <- NULL
for(i in 1:length(ALL)){
  n <- ncol(ALL[[i]])
  for(j in 3:n){
    FNAME[k] <- nn[i]
    k <- k+1
  }
}

gclass <- as.numeric(factor(FNAME))    # cluser number 

levels(factor(FNAME))[gclass]
pmid <- levels(factor(FNAME))[gclass]  


# -----------------
#  Data save
# ------------------
save(FNAME, file = "FNAME.RData")
save(gclass, file = "gclass.RData")

