# ----------------------------------------------------------
# Collect all report.rds files from output folders into one
# sync-ready directory. File names match scenario folder names.
# Run from magpie_realBE/ on the cluster, then sync reports/ locally.
# ----------------------------------------------------------

collect_reports <- function(output_dir = "output",
                            target_dir = "reports") {

  dirs <- list.dirs(output_dir, full.names = FALSE, recursive = FALSE)
  dirs <- dirs[grepl("^BE0", dirs)]

  if (length(dirs) == 0) {
    message("No matching output folders found in ", output_dir)
    return(invisible(NULL))
  }

  dir.create(target_dir, showWarnings = FALSE, recursive = TRUE)

  copied <- 0L
  skipped <- 0L

  for (d in dirs) {
    src <- file.path(output_dir, d, "report.rds")
    if (file.exists(src)) {
      # Strip timestamp suffix: <version>_<trade>_<past>_<dem>_<eroi>_<ge>_<rot>_<tau>_<date>_<time>
      clean <- sub("_\\d{4}-\\d{2}-\\d{2}_\\d{2}\\.\\d{2}\\.\\d{2}$", "", d)
      file.copy(src, file.path(target_dir, paste0(clean, ".rds")))
      copied <- copied + 1L
    } else {
      skipped <- skipped + 1L
    }
  }

  message(sprintf("Done. %d reports copied to %s (%d skipped, no report.rds).",
                  copied, target_dir, skipped))
}

# Run when sourced
collect_reports()
