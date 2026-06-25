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

`/methods` contains materials used to make the procedure transparent and reproducible, especially the extraction codebook and related instructions.

`/supplementary-materials` contains files intended to accompany the thesis, including supplementary tables and a knitted HTML version of the code for readability.

`/outputs` contains various outputs



## How To Reproduce This Project

* Start with the files in `/methods` to understand the extraction framework and coding rules.
* The raw project materials are stored in `/data/raw`.
* Run the scripts in `/code` to generate cleaned datasets in `/data/processed` and to reproduce the reported analyses, tables, and figures.
* Supplementary outputs and readable analysis documents are stored in `/supplementary-materials`.

## License

(c) Tim Schneeberger 2026

Released under a CC BY 4.0 license.
