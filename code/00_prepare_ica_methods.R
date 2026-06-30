library(tidyverse)
library(readxl)
library(here)
library(readr)

# ----------------------------
# Paths
# ----------------------------
path_in  <- here("data", "raw", "ica_extraction_master_with_notes.xlsx")
path_out <- here("data", "processed", "ica_methods.csv")

# ----------------------------
# Columns actually used in the analysis
# ----------------------------
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

# ----------------------------
# Helpers
# ----------------------------

# Convert mixed TRUE/FALSE/1/0/yes/no entries to literal text values
to_logical_string <- function(x) {
  x_chr <- x %>%
    as.character() %>%
    stringr::str_trim()
  
  dplyr::case_when(
    x_chr %in% c("1", "TRUE", "True", "true", "T", "yes", "Yes", "YES") ~ "TRUE",
    x_chr %in% c("0", "FALSE", "False", "false", "F", "no", "No", "NO") ~ "FALSE",
    x_chr == "" ~ NA_character_,
    is.na(x_chr) ~ NA_character_,
    TRUE ~ x_chr
  )
}

# Make numeric-looking columns write cleanly as text without scientific notation
fmt_num <- function(x) {
  x_num <- suppressWarnings(as.numeric(x))
  out <- ifelse(
    is.na(x_num),
    NA_character_,
    format(x_num, scientific = FALSE, trim = TRUE)
  )
  # remove unnecessary trailing zeros after decimal point
  out <- stringr::str_replace(out, "(\\.\\d*?[1-9])0+$", "\\1")
  out <- stringr::str_replace(out, "\\.0+$", "")
  out
}

# ----------------------------
# Read, select, clean
# ----------------------------
ica_methods <- readxl::read_excel(path_in, sheet = "Master_wide") %>%
  dplyr::select(dplyr::all_of(analysis_cols)) %>%
  # trim whitespace in all character columns first
  dplyr::mutate(
    dplyr::across(
      where(is.character),
      ~ stringr::str_squish(.x)
    )
  ) %>%
  # normalize boolean-style columns to "TRUE"/"FALSE"/NA strings
  dplyr::mutate(
    dplyr::across(
      c(
        prisma_a,
        prisma,
        inclusion_criteria_applicable,
        inclusion_binary,
        clinical_relevance,
        language_mentioned,
        availability_mentioned,
        release_date_mentioned,
        frequency,
        min_scale_citation,
        exclusion_criteria,
        multiple_analyses,
        within_scale_item_collapse,
        compound_items,
        idiosyncratic_items,
        reverse_worded_items,
        coding_team_reported,
        rater_expertise_mentioned,
        blinded,
        codebook,
        software_mentioned,
        item_exclusions,
        IRR_reported,
        preregistered_rules,
        coding_scheme_independent_mentioned,
        disagreement_resolved_mentioned,
        mean_overlap,
        min_overlap,
        max_overlap,
        length_correlation_noted,
        heterogeneity_emphasized,
        overlap_reported,
        noninterchangeability_emphasized,
        recommend_careful_measure_selection,
        recommend_measure_development,
        ica_methods_problems
      ),
      to_logical_string
    )
  ) %>%
  # clean the few text fields that had minor formatting issues
  dplyr::mutate(
    item_unit = item_unit %>%
      as.character() %>%
      stringr::str_replace_all(",;", ";") %>%
      stringr::str_replace_all(";\\s+", "; ") %>%
      stringr::str_squish(),
    matrix_source = matrix_source %>%
      as.character() %>%
      stringr::str_squish(),
    
    percentage_reduction = percentage_reduction %>% 
      as.character() %>% 
      stringr::str_squish(),
  ) %>%
  # format numeric columns as plain text to avoid floating-point noise in CSV
  dplyr::mutate(
    dplyr::across(
      c(
        n_scales,
        initial_coding_team_size,
        n_rater,
        mean_overlap_nr,
        min_overlap_nr,
        max_overlap_nr,
        correlation_lengthxmeanoverlap_value
      ),
      fmt_num
    )
  )

# ----------------------------
# Optional checks
# ----------------------------
stopifnot(identical(names(ica_methods), analysis_cols))
stopifnot(nrow(ica_methods) == 37)

# ----------------------------
# Write final processed file
# ----------------------------
readr::write_csv(ica_methods, path_out, na = "NA")