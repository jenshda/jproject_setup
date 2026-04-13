#' Bootstrap a new R project
#'
#' Creates the standard folder structure and starter files for a new R analysis
#' project. Run once from the root of an open RStudio Project.
#'
#' @param author_name Character. Name inserted into generated script headers.
#'   Defaults to "Jens Halford".
#' @param overwrite Logical. If TRUE, existing starter files are overwritten.
#'   Defaults to FALSE.
#'
#' @return Called for its side effects. Returns invisibly.
#' @export
#'
#' @examples
#' \dontrun{
#' jprojectsetup::bootstrap()
#' }
bootstrap <- function(author_name = "Jens Halford", overwrite = FALSE) {

  root         <- getwd()
  created_date <- as.character(Sys.Date())

  # -----------------------------------------------------------------------
  # Verify that we are inside an RStudio Project
  # -----------------------------------------------------------------------

  rproj_files <- list.files(root, pattern = "\\.Rproj$", full.names = FALSE)

  if (length(rproj_files) == 0) {
    stop(
      "No .Rproj file found in the current working directory. ",
      "Create and open an RStudio Project first, then run bootstrap() again."
    )
  }

  if (length(rproj_files) > 1) {
    stop(
      "More than one .Rproj file found in the current working directory. ",
      "Keep only one project file in the root folder and run bootstrap() again."
    )
  }

  project_name <- tools::file_path_sans_ext(rproj_files[1])

  # -----------------------------------------------------------------------
  # Create folder structure
  # -----------------------------------------------------------------------

  dirs <- c(
    file.path(root, "data", "raw"),
    file.path(root, "data", "processed"),
    file.path(root, "output", "figures"),
    file.path(root, "output", "tables"),
    file.path(root, "R"),
    file.path(root, "scripts"),
    file.path(root, "reports")
  )

  for (d in dirs) {
    if (!dir.exists(d)) {
      dir.create(d, recursive = TRUE, showWarnings = FALSE)
      message("Created folder:         ", d)
    } else {
      message("Folder already exists:  ", d)
    }
  }

  # -----------------------------------------------------------------------
  # Helper: write a file from a character vector
  # -----------------------------------------------------------------------

  write_file <- function(path, lines, overwrite = FALSE) {
    if (file.exists(path) && !overwrite) {
      message("Skipped existing file:  ", path)
      return(invisible(FALSE))
    }
    con <- file(path, open = "w", encoding = "UTF-8")
    on.exit(close(con), add = TRUE)
    writeLines(lines, con = con)
    if (file.exists(path)) {
      message("Created file:           ", path)
    }
    invisible(TRUE)
  }

  # -----------------------------------------------------------------------
  # Helper: fill {{placeholders}} in a template file and write to destination
  # -----------------------------------------------------------------------

  write_template <- function(template_name, dest_path, overwrite = FALSE) {
    tmpl_path <- system.file(
      "templates", template_name,
      package = "jproject_setup",
      mustWork = TRUE
    )
    lines <- readLines(tmpl_path, encoding = "UTF-8", warn = FALSE)
    lines <- gsub("\\{\\{project_name\\}\\}",  project_name,  lines)
    lines <- gsub("\\{\\{author_name\\}\\}",   author_name,   lines)
    lines <- gsub("\\{\\{created_date\\}\\}",  created_date,  lines)
    write_file(dest_path, lines, overwrite = overwrite)
  }

  # -----------------------------------------------------------------------
  # Helper: create an empty placeholder file
  # -----------------------------------------------------------------------

  touch_file <- function(path) {
    if (!file.exists(path)) {
      file.create(path)
      message("Created file:           ", path)
    }
    invisible(TRUE)
  }

  # -----------------------------------------------------------------------
  # Write README and .gitignore directly (no placeholders needed for gitignore)
  # -----------------------------------------------------------------------

  readme_lines <- c(
    paste0("# ", project_name),
    "",
    paste0("**Date:** ", created_date),
    paste0("**Author:** ", author_name),
    "**Description:** *[Briefly describe the purpose of the project here]*",
    "",
    "---",
    "",
    "## Project structure",
    "",
    "* `data/raw` stores original input data",
    "* `data/processed` stores cleaned or intermediate data",
    "* `R` stores reusable functions",
    "* `scripts` stores workflow scripts",
    "* `output/figures` stores exported figures",
    "* `output/tables` stores exported tables",
    "* `reports` stores Quarto or R Markdown reports",
    "",
    "---",
    "",
    "## Workflow",
    "",
    "1. Open the project",
    "2. Run `scripts/00_main.R`",
    "3. Edit supporting scripts as needed"
  )

  gitignore_lines <- c(
    ".Rproj.user",
    ".Rhistory",
    ".RData",
    ".Ruserdata",
    ".DS_Store"
  )

  write_file(file.path(root, "README.md"),   readme_lines,    overwrite = overwrite)
  write_file(file.path(root, ".gitignore"),  gitignore_lines, overwrite = overwrite)

  # -----------------------------------------------------------------------
  # Write template-based starter files
  # -----------------------------------------------------------------------

  write_template("R/functions.R",            file.path(root, "R",       "functions.R"),        overwrite)
  write_template("scripts/00_main.R",        file.path(root, "scripts", "00_main.R"),           overwrite)
  write_template("scripts/01_prepare_data.R",file.path(root, "scripts", "01_prepare_data.R"),   overwrite)
  write_template("scripts/02_analysis.R",    file.path(root, "scripts", "02_analysis.R"),       overwrite)
  write_template("reports/report.qmd",       file.path(root, "reports", "report.qmd"),          overwrite)

  # -----------------------------------------------------------------------
  # Placeholder files for empty folders
  # -----------------------------------------------------------------------

  touch_file(file.path(root, "data", "raw",        ".gitkeep"))
  touch_file(file.path(root, "data", "processed",  ".gitkeep"))
  touch_file(file.path(root, "output", "figures",  ".gitkeep"))
  touch_file(file.path(root, "output", "tables",   ".gitkeep"))

  # -----------------------------------------------------------------------
  # Done
  # -----------------------------------------------------------------------

  message("")
  message("Bootstrap complete.")
  message("Project root: ", root)
  message("Project name: ", project_name)
  message("Open scripts/00_main.R and start from there.")

  if (interactive() && requireNamespace("rstudioapi", quietly = TRUE)) {
    rstudioapi::navigateToFile(file.path(root, "scripts", "00_main.R"))
  }

  invisible(NULL)
}
