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



## Publications
At present, we are writing papers describing the data integration of cancer metabolomics.
