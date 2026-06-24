# Item-Content Analysis Across Psychology and Adjacent Fields: A Methodological Synthesis

## Overview

This repository provides data, materials, and code for the thesis *Item-Content Analysis Across Psychology and Adjacent Fields: A Methodological Synthesis*.

The project examines how item-content analyses (ICAs) are currently conducted and reported across psychology and adjacent fields. Rather than comparing overlap estimates across studies directly, the repository documents the procedural and reporting decisions that shape ICA workflows and their interpretation.

## Author

Tim Schneeberger

## Folder Structure

`/code` contains the R scripts and R Markdown files used for data processing, descriptive analyses, figures, tables, and supplementary outputs.

`/data/raw` contains the manually assembled and minimally processed source materials for the project. Depending on the subproject, this includes search and screening records, extraction sheets, and reliability-check materials.

`/data/processed` contains cleaned and analysis-ready data generated from the raw materials using the scripts in `/code`.

`/methods` contains materials used to make the procedure transparent and reproducible, especially the extraction codebook and related instructions or development files.

`/supplementary-materials` contains files intended to accompany the thesis, including supplementary tables, the commented R Markdown analysis file, and a knitted HTML version for readability.

Optional folders may be added where useful, for example for archived outputs, manuscript materials, or figures prepared for the thesis itself.

## How To Reproduce This Project

* Start with the files in `/methods` to understand the extraction framework and coding rules.
* The raw project materials are stored in `/data/raw`.
* Run the scripts in `/code` to generate cleaned datasets in `/data/processed` and to reproduce the reported analyses, tables, and figures.
* Supplementary outputs and readable analysis documents are stored in `/supplementary-materials`.

## License

(c) Tim Schneeberger 2026

Released under a CC BY 4.0 license.
