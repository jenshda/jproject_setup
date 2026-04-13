# ======================================================================
# Script: functions.R
# Project: {{project_name}}
# Author: {{author_name}}
# Created: {{created_date}}
#
# ======================================================================

# Booktabs-table with a small font
# ----------------------------------------------------------------------
ft_stil <- function(df) {
  nc <- ncol(df)
  
  df |>
    flextable() |>
      font(fontname = "Arial Nova Cond", part = "all") |>
      fontsize(size = 8, part = "all") |>
      bold(part = "header") |>
   
     # Horisontella linjer som booktabs
    hline_top(border = fp_border(width = 1.5), part = "header") |>
    hline_bottom(border = fp_border(width = 0.75), part = "header") |>
    hline_bottom(border = fp_border(width = 1.5), part = "body") |>
    hline(border = fp_border(width = 0), part = "body") |>  # ta bort interna linjer
    
    # Högeralignera numeriska kolumner
    align(j = 4:nc, align = "right", part = "all") |>
    align(j = 1:3, align = "left", part = "all") |>
    set_table_properties(layout = "autofit")
}
# ----------------------------------------------------------------------

# Project helper functions
# ----------------------------------------------------------------------

# Build paths relative to the project root.
project_path <- function(...) {
  here::here(...)
}
# ----------------------------------------------------------------------