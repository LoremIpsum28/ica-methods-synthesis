# Item-Content Analysis Across Psychology and Adjacent Fields: A Methodological Synthesis

## Overview

This repository provides data, materials, and code for the thesis *Item-Content Analysis Across Psychology and Adjacent Fields: A Methodological Synthesis*.

The project examines how item-content analyses (ICAs) are currently conducted and reported across psychology and adjacent fields. The repository documents the procedural and reporting decisions that shape ICA workflows and their interpretation.

## Author

Tim Schneeberger

## Folder Structure

`/code` contains the R scripts and R Markdown files used for data processing, descriptive analyses, figures, tables, and supplementary outputs.

`/data/raw` contains the manually assembled and minimally processed source materials for the project. ica_extraction_master_with_notes is the original data-extraction sheet and includes all notes and context. 
ica_extraction_analysis_columns has the same content but with all notes_columns removed. 

`/data/processed` contains cleaned and analysis-ready data generated from the raw materials using the scripts in `/code`.

`/method` contains materials used to make the procedure transparent and reproducible, especially the extraction codebook and related instructions.

`/outputs` contains the figures and tables used in the paper
  `/figures` for final figures 
  `/tables` contains a `/csv` with individual .csv table outputs and a `/docx`for a compact word table compendium

`/supplementary-materials` contains files with supplementary materials, including supplementary tables and a knitted HTML version of the code for readability.




## How To Reproduce This Project

The main analysis is contained in code/01_methods_descriptives.Rmd. This file reads the cleaned analysis dataset from data/processed/ica_methods.csv and reproduces the descriptive analyses, tables, figures, and supplementary output files.

* Start with the files in /methods to understand the extraction framework and coding rules.

* The second step would be to retrieve and code the articles (full list with citation in `/supplementary_materials/supplementary_tables`), for this use the codebook in /methods (instructions for the coding in the same folder as a .pdf). 
      If you only want to use the code, skip this step
      
* To run the analysis, knit or run code/01_methods_descriptives.Rmd.

* The regenerated outputs are written to:

  outputs/tables/csv/ for machine-readable table outputs,
  outputs/tables/docx/ for the Word table compendium,
  outputs/figures/ for final figures

## License

(c) Tim Schneeberger 2026

Released under a CC BY 4.0 license.
