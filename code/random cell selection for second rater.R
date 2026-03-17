library(openxlsx)
library(tidyverse)

set.seed(20260313)
n_cells <- 150

# file names
input_file  <- "ica_methods_second_rater_full.xlsx"
output_file <- "ica_methods_second_rater_full_spotcheck.xlsx"

# define target frame
rows <- 2:38
cols <- openxlsx::int2col(2:55)   # B:BC

cells <- expand_grid(
  row = rows,
  col = cols
) |>
  mutate(cell = paste0(col, row))

# sample cells
selected <- cells |>
  slice_sample(n = n_cells)

# load workbook
wb <- loadWorkbook(input_file)

# highlight style
spot_style <- createStyle(
  fgFill = "#FFF2CC"   # light yellow
)

# apply style to sampled cells on sheet 1
for(i in seq_len(nrow(selected))) {
  addStyle(
    wb,
    sheet = 1,
    style = spot_style,
    rows = selected$row[i],
    cols = openxlsx::col2int(selected$col[i]),
    gridExpand = FALSE,
    stack = TRUE
  )
}

# save workbook
saveWorkbook(wb, output_file, overwrite = TRUE)

# print sampled cell names
selected_cells <- selected$cell
selected_cells
