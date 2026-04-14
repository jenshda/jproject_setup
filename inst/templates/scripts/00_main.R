# ======================================================================
# Script: 00_main.R
# Project: {{project_name}}
# Author: {{author_name}}
# Created: {{created_date}}
#
# ======================================================================

# Main workflow
# ----------------------------------------------------------------------
#
# This script is the main entry point for the project.
# Run it to execute the core workflow in the intended order.
#
# Restart the R session manually before running this script
# if you want a fully clean start.
# ----------------------------------------------------------------------


# Load required packages
# ----------------------------------------------------------------------

required_packages <- c("here", "readr", "dplyr", "tidyr", "ggplot2", "stringr", "lubridate", "janitor")

missing_packages <- required_packages[
  !vapply(required_packages, requireNamespace, logical(1), quietly = TRUE)
]

if (length(missing_packages) > 0) {
  install.packages(missing_packages)
}

for (pkg in required_packages) {
  library(pkg, character.only = TRUE)
}
# ----------------------------------------------------------------------


# Load functions and run workflow scripts
# ----------------------------------------------------------------------

source(here::here("R", "functions.R"))

source(here::here("scripts", "01_prepare_data.R"))

source(here::here("scripts", "02_analysis.R"))

message("Project run completed.")
# ----------------------------------------------------------------------
