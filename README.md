# precisionFDA_Covid19_repo

Data mining of clinical associations from bioinformatics analysis of immunological data 

By Dr. Mahmoud Shobair and Gerald Parker

***

The tool which we have created is designed to handle these functions:

- Takes data from supplied CSV and converts into a SQLite DB
- Takes the SQLite DB and allows the user to clean ahd select relevant data for hypothesis testing to use into a CSV or SQLite DB.
- Allows the user to load the transformed data to perform exploratory data analysis (EDA). An example use case of data visualization is presented in an R-notebook comparing protein sequence data between subjects grouped by disease_stage clinical variable.

This document will be broken down into each portion of the traditional ETL model in seperate sections.

***
Here is an overview of the workflow.

![](workflow_summary.JPG)

## Setting up dependencies and virtual environment
App development and testing was done primarily in Ubuntu 20.04/18.04.

### Install ubuntu dependencies:
```sh
sudo apt install -y  curl sqlite3 pipenv jupyter-client r-base-core 
 
```

### Install R packages
```R
sudo R
install.packages(c("IRkernel", "data.table", "RSQLite", "sqldf", "BiocManager")) 
yes
yes
library(IRkernel)
IRkernel::installspec()
library(BiocManager)
BiocManager::install("universalmotif")
```
### Download, extract the zipped repo source 
```sh
curl -L -O https://github.com/mshobair/precisionFDA_Covid19_repo/archive/main.zip
unzip main.zip -d .
cd precisionFDA_Covid19_repo
```

## Creating and indexing SQLite database (E in ETL)
```sh
cd extract_to_sql/
# change input table paths to their local paths
sh ./create_sqlitedb.sh ./seqtable_test.tsv ./metadata_test.tsv
```

### Activating python virtual environment to launch juypyter notebook
```sh
cd ../
pipenv install
pipenv run jupyter notebook
```

## Run Data Cleaning and Filtering Notebook (T in ETL)
- Open sqlite_df_fn3.ipynb
- Adjust values in cells 4-5 to select two disease_stage groups (e.g. "Recovered" and "Baseline" or "Baseline" and "Acute")
- Adjust value in cell 6 for the number of records queried ( ~1000000 records per subject on average)
- Run all notebook cells by seleting from Cell menu "Run All"

*The output will be a SQLite database (or flatfile if user chooses to) to be loaded into analysis notebook: MotifVisualizationR.ipynb* 

 ## Run Data Analysis Notebook (L in ETL)
 - Open MotifVisualizationR.ipynb from the open Jupyter Notebook server webpage
 - Adjust value in cell 4 to select the length of junction_aa for motif visualization and hypothesis testing.
 - Run all notebook cells by seleting from Cell menu "Run All"
 - HTML output can be downloaded by selecting File -> Download as -> HTML



![](baseline_vs_acute.JPG)

