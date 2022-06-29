rm(list=ls(all=TRUE))

# Data upload

load(file = "FIN.RData")     
load(file = "gclass.RData")  
load(file = "FNAME.RData")   

#  Data integration and visualizaion (Step 3 and 4)
#---------------------------------------------------------------------------
#  Selection of the metabolites which satisfy the criteria
#----------------------------------------------------------------------------
# Step 3 (1)

D <- NULL
for(i in 1:length(FIN)){
  
  ratio <- as.numeric(as.character(FIN[[i]][,2]))
  
  #  threshold
  index1 <- which(ratio >= 1.5) 　　 　　 # upper threshold (increased metabolites)
  index2 <- which(ratio < (1/(1.5)))　 　 # lower threshold (decreased metabolites)
  # index1 <- which(ratio >= 1.2) 　　　
  # index2 <- which(ratio < (1/(1.2))) 
  
  A <- as.character(FIN[[i]][index1,1])　 # increased metabolite
  B <- as.character(FIN[[i]][index2,1]) 　# decreased metabolite
  
  D[[i]] <- list(A,B)
}

# ---------------------------------
#   Calculate odds ratio
# ----------------------------------
# Step 3 (2)

k <- 1
i_index <- NULL;j_index <- NULL;odd <- NULL; pv <- NULL;  i_pmid <- NULL;  j_pmid <- NULL
A_metabolite <- NULL;B_metabolite <- NULL;C_metabolite <- NULL;D_metabolite <- NULL; 
an <- NULL; bn <- NULL; cn <- NULL; dn <- NULL
for(i in 1:length(D)){
  for(j in 1:length(D)){
    
    # 2 × 2 crosstabulation table 
    x1 <- unique(D[[i]][[1]])   
    x2 <- unique(D[[i]][[2]])
    
    y1 <- unique(D[[j]][[1]])
    y2 <- unique(D[[j]][[2]])
    
    # The selected metabolites are summed up by the  following step
    a <- sum(!is.na(match(x1,y1)))  # up、up
    b <- sum(!is.na(match(x1,y2)))  # up、down
    c <- sum(!is.na(match(x2,y1)))  # down、up
    d <- sum(!is.na(match(x2,y2)))  # down、down

    # Finding information about metabolites name
    an[k] <- a
    bn[k] <- b
    cn[k] <- c
    dn[k] <- d
    
    # Finding infomation about common metabolites name
    # (a) up、up
    index <- match(x1,y1)
    index <- index[!is.na(index)]
    A_metabolite[k] <- paste0(y1[index],collapse="|")
    
    # (b) up、down
    index <- match(x1,y2)
    index <- index[!is.na(index)]
    B_metabolite[k] <- paste0(y2[index],collapse="|")
    
    # (c) down、up
    index <- match(x2,y1)
    index <- index[!is.na(index)]
    C_metabolite[k] <- paste0(y1[index],collapse="|")
    
    # (d) down、down
    index <- match(x2,y2)
    index <- index[!is.na(index)]
    D_metabolite[k] <- paste0(y2[index],collapse="|")
    
    # //  odds ratio 
    if (a*b*c*d == 0) {
      a <- a+0.5;b <- b+0.5;c <- c+0.5;d <- d+0.5
    }
    
    # // chi-square test
    x <- matrix(c(a,c,b,d), nrow=2)
    chi <- chisq.test(x)
    
    i_index[k] <- i
    j_index[k] <- j
    
    i_pmid[k] <- FNAME[i]
    j_pmid[k] <- FNAME[j] 
    
    odd[k] <- log2(a*d/(b*c))
    pv[k] <- chi$p.value
    
    # // index 
    k <- k+1
    
  }
}


# Data cleansing
R <- data.frame(i = i_index, j = j_index, odds = odd, p_value = pv, 
                a_count = an, b_count = bn, c_count = cn, d_count = dn,
                a = A_metabolite, b = B_metabolite, c = C_metabolite, d = D_metabolite,
                ip = i_pmid, jp = j_pmid )


# A duplication removing fllowing step removes duplicated data from the processing results of the step 3 (2).

Rsub <- subset(R, i < j)
write.csv(Rsub, file = "Rsub.csv")   # data output


# Created a graph adjacency matrix
OR <- matrix(odd, nrow = length(D), byrow = T)
P <- matrix(pv, nrow = length(D), byrow = T)

#-------------------------------------------------------------------
#  Selects tha data you want from the dataset pairs
#-------------------------------------------------------------------
#  Step 3 (3)
#  p < 0.05, log2 odds ratio < 2 

Extract an essence from the bark of a tree.

OR2 <- abs(OR)

z_all <- NULL
for (i in 1:nrow(OR)){
  or2 <- abs(OR2[i,])
  
  index <- (or2 > 4)
  index[i] <- FALSE
  
  if (length(which(index)) > 0){
    z <- cbind(i, which(index))
    z_all <- rbind(z_all,z)
  }
}

pair_odds <- cbind(z_all,OR[z_all])

# write.csv(pair_odds,"./result/pair_odds.csv") 


# --------------------------------------
#   Graph adjacency matrix
# ---------------------------------------
# Step 4 (1)
library(igraph)

Q <- P
Q[P < 0.05] <- 1      # significant
Q[P >= 0.05] <- 0    # non-significant
diag(Q) <- 0

row.names(P) <- 1:66        # data set 1
# row.names(P) <- 1:252   # data set 2

#----------------------------
# Graph clustering
#----------------------------
# Step 4 (2)
# g <- graph.adjacency(Q, weighted = TRUE)
g <- graph.adjacency(Q*OR, weighted = TRUE)

V(g)$name <- c(1:66)        # data set1
# V(g)$name <- c(1:252)   # data set 2

g4 <- decompose.graph(g) 

#--------------------------------------------------
#  Data visualization (network graph)
#---------------------------------------------------
# Step 4 (3)

library(dplyr)
ne <- get.data.frame(g11)
networklist <- subset(ne, from < to)     # network list 

# plot.igraph(g11, edge.arrow.size=0, edge.width=abs(weight), vertex.color= as.numeric(factor(gclass[mm])))
# tkplot(g11, edge.arrow.size=0, edge.width=abs(E(g11)$weight),vertex.color=gclass[mm],vertex.label.color="black")

# ----------------
# Data save
# ----------------
# save(g11, file = "C:/R/g11.RData")
# save(D, file = "C:/R/D.RData")
# save(P, file = "C:/R/P.RData")
