library(tidyverse)
library(readxl)
library(here)

# helper: normalize 0/1, TRUE/FALSE, and messy strings to logical
to_logical_clean <- function(x) {
  x_chr <- x %>%
    as.character() %>%
    stringr::str_trim()
  
  dplyr::case_when(
    x_chr %in% c("1", "TRUE", "True", "true", "T", "yes", "Yes", "YES") ~ TRUE,
    x_chr %in% c("0", "FALSE", "False", "false", "F", "no", "No", "NO") ~ FALSE,
    x_chr == "" ~ NA,
    is.na(x_chr) ~ NA,
    TRUE ~ NA
  )
}

master_path <- here("data", "raw", "ica_extraction_master_with_notes.xlsx")
out_path <- here("data", "processed", "ica_extraction_clean")

analysis_cols <- c(
  "study_id",
  "matrix",
  "n_scales",
  "overarching_domain",
  "fields",
  "administration_mode",
  "short_scales",
  "population",
  "scale_search",
  "database",
  "prisma_a",
  "prisma",
  "inclusion_criteria_applicable",
  "inclusion_binary",
  "clinical_relevance",
  "language_mentioned",
  "availability_mentioned",
  "release_date_mentioned",
  "frequency",
  "min_scale_citation",
  "exclusion_criteria",
  "multiple_analyses",
  "item_unit",
  "percentage_reduction",
  "within_scale_item_collapse",
  "compound_items",
  "compound_items_codes",
  "idiosyncratic_items",
  "reverse_worded_items",
  "categorization_approach",
  "diagnostic_framework",
  "coding_team_reported",
  "initial_coding_team_size",
  "rater_expertise_mentioned",
  "blinded",
  "codebook",
  "software_mentioned",
  "software_used",
  "item_exclusions",
  "n_rater",
  "IRR_reported",
  "preregistered_rules",
  "coding_scheme_independent_mentioned",
  "disagreement_resolved_mentioned",
  "mean_overlap",
  "mean_overlap_nr",
  "min_overlap",
  "min_overlap_nr",
  "max_overlap",
  "max_overlap_nr",
  "length_correlation_noted",
  "correlation_lengthxmeanoverlap_type",
  "correlation_lengthxmeanoverlap_value",
  "heterogeneity_emphasized",
  "overlap_reported",
  "noninterchangeability_emphasized",
  "recommend_careful_measure_selection",
  "recommend_measure_development",
  "ica_methods_problems",
  "matrix_source"
)

ica_analysis_clean <-
  readxl::read_excel(master_path, sheet = "Master_wide") %>%
  dplyr::select(dplyr::all_of(analysis_cols)) %>%
  dplyr::mutate(
    # normalize a few known boolean-like columns that differ in the workbook
    dplyr::across(
      c(
        prisma,
        inclusion_binary,
        clinical_relevance,
        language_mentioned,
        availability_mentioned,
        release_date_mentioned,
        frequency,
        min_scale_citation,
        exclusion_criteria,
        mean_overlap,
        min_overlap
      ),
      to_logical_clean
    ),
    
    # small text cleanups seen in the workbook
    item_unit = item_unit %>%
      as.character() %>%
      stringr::str_replace_all(",;", ";") %>%
      stringr::str_replace_all(";\\s+", "; ") %>%
      stringr::str_squish(),
    
    matrix_source = dplyr::if_else(
      is.na(matrix_source) | stringr::str_trim(as.character(matrix_source)) == "",
      "not_available",
      as.character(matrix_source)
    )
  )

readr::write_csv(ica_analysis_clean, out_path, na = "")