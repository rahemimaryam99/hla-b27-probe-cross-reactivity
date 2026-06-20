# HLA-B27 probe cross-reactivity check
#
# This script identifies alleles shared by multiple probe result columns and
# reports shared non-HLA-B*27 alleles as potential cross-reactivity candidates.

args <- commandArgs(trailingOnly = TRUE)
input_file <- if (length(args) >= 1) args[1] else "example_input.csv"
output_file <- if (length(args) >= 2) args[2] else "output/cross_reactive_alleles.txt"

hla <- read.csv("example_input.csv", stringsAsFactors = FALSE, check.names = TRUE)

required_columns <- c("Probe.1", "Probe.2", "Probe.3")
missing_columns <- setdiff(required_columns, names(hla))

if (length(missing_columns) > 0) {
  stop(
    "Missing required column(s): ",
    paste(missing_columns, collapse = ", ")
  )
}

probe_values <- lapply(hla[required_columns], function(column) {
  na.omit(trimws(column))
})

common_values <- Reduce(intersect, probe_values)

cross_reactive_alleles <- common_values[
  !grepl("^(HLA-)?B\\*27", common_values)
]

dir.create(dirname(output_file), showWarnings = FALSE, recursive = TRUE)

if (length(cross_reactive_alleles) == 0) {
  message("No shared non-HLA-B*27 alleles detected.")
  writeLines("No shared non-HLA-B*27 alleles detected.", output_file)
} else {
  message("Potential cross-reactive alleles detected:")
  print(cross_reactive_alleles)
  writeLines(cross_reactive_alleles, output_file)
}


