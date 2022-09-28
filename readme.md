# iDMET: Network-based approach for integrating differential analysis of cancer metabolomics

## Requirement
 
* igraph
* cytoscape


## Description
The 27 data sets were divided into two datasets: the first data (Dataset1) sets was used for comparison with existing methods, and the second data sets (Dataset2) was used for testing and evaluation of our methodology.
* Data files
  * Dataset1 : 5 studies (data matrix of metabolome profile)
  * Dataset2 : 27 studies(ratio data) 
  


* Annoation list (metabodic.csv)
  * Annotation list presents the information in an organized fashion, collecting common metabolite names and their synonyms.

## Program
Steps 1 (step1.R) and steps 2 (step2.R) are the process of organizing user’s data. We collect supplementary data from papers or repositories to generate a list of variable metabolite names. Steps 3 (step3.R) is computational processes for network generation. We calculated the similarity based on the information generated in step 2 and visualize the relationship.
Please read the publication for further information.

* Calculation parameters (step3.R)
1. List of up-or downregulated metabolites
``` r
  # threshold of ratio
  index1 <- which(ratio>=1.5) 
  index2 <- which(ratio < (1/(1.5))) 
```
2. Calculatie odds ratio
``` r
   # If any of the four numbers wwas 0, 0.5 was added to all four numbers
   if (a*b*c*d == 0) {
     a <- a+0.5;b <- b+0.5;c <- c+0.5;d <- d+0.5
   }
```
3. Creating graph from weighted adjacency matrix
``` r
    # According to the result of the chi-squared test, an adjacency matrix is obtained.
    Q <- P
    Q[P<0.05] <- 1   # significant
    Q[P>=0.05] <- 0  # non-significant
    diag(Q) <- 0
```

## Publications
At present, we are writing papers describing the data integration of cancer metabolomics.
