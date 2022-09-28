# iDMET: Network-based approach for integrating differential analysis of cancer metabolomics

## Requirement
 
* igraph
* cytoscape


## Description
* Data files
  * Dataset1 : 5 studies (data matrix of metabolome profile)
  * Dataset2 : 27 studies(ratio data) 
  
  The 27 data sets were divided into two datasets: the first data (Dataset1) sets was used for comparison with ex-isting methods, and the second data sets (Dataset2) was used for testing and evaluation of our methodology.

* Annoation list (metabodic.csv)
  * Annotation list presents the information in an organized fashion, collecting common metabolite names and their synonyms.

## Program
Steps 1 (step1.R) and steps 2 (step2.R) are the process of organizing user’s data. We collect supplementary data from papers or repositories to generate a list of variable metabolite names. Steps 3 (step3.R) is computational processes for network generation. We calculated the similarity based on the information generated in step 2 and visualize the relationship.
Please read the publication for further information.

* step1.R
* step2.R
* step3.R
パラメーターは
1. ratioの閾値、
``` r
  # 条件
  index1 <- which(ratio>=1.5) # 差がある
  index2 <- which(ratio < (1/(1.5))) # 差がない
```
2. オッズ比の補正値、オッズ比の閾値
``` r
    # // オッズ比
    if (a*b*c*d == 0) {
      a <- a+0.5;b <- b+0.5;c <- c+0.5;d <- d+0.5
    }


### Publications
At present, we are writing papers describing the data integration of cancer metabolomics.
