# HLA-B27 Probe Cross-Reactivity Check in R

This repository contains a small, reproducible R workflow for checking whether multiple HLA-B*27 primer/probe result columns share any non-HLA-B*27 alleles.

The analysis is intended for research and assay-development support. It is not a standalone diagnostic tool and should be interpreted alongside laboratory validation.

## Overview

The script:

- reads a CSV file exported from HLA primer/probe search results,
- identifies alleles shared across three probe columns,
- removes true HLA-B*27 alleles from the shared set,
- reports the remaining shared non-HLA-B*27 alleles as potential cross-reactivity candidates.

An ideal result is no shared non-HLA-B*27 alleles.

## Input Format

The input CSV should contain these columns:

| Probe.1 | Probe.2 | Probe.3 |
| --- | --- | --- |
| B*27:01 | B*27:01 | B*27:01 |
| B*07:73 | B*07:73 | B*07:73 |

By default, the script runs with `example_input.csv`. For your real dataset, pass the CSV file path as an argument.

## Usage

Run the example from the project root:

```bash
Rscript HLA_B27_probe_cross_reactivity_check.R
```

Run the analysis with your own CSV file:

```bash
Rscript HLA_B27_probe_cross_reactivity_check.R Book12.csv
```

The output is written to:

```text
output/cross_reactive_alleles.txt
```

## Interpretation

If the output is:

```text
No shared non-HLA-B*27 alleles detected.
```

then no potential cross-reactive non-HLA-B*27 allele was shared across all probe columns.

If allele names are listed, for example:

```text
B*07:73
```

then those alleles may represent potential cross-reactivity candidates and should be reviewed further.

## Dependencies

This workflow uses base R only. No external R packages are required.

## Repository Structure

```text
HLA-B27-Probe-Cross-Reactivity-Check/
├── HLA_B27_probe_cross_reactivity_check.R
├── README.md
├── example_input.csv
├── .gitignore
└── output/
```

## Notes

- The analysis assumes standardized HLA allele nomenclature.
- The default target pattern accepts both `B*27` and `HLA-B*27` allele prefixes.
- Input data should only be included if it is permitted by the source database or license.

## Author

Maryam Rahemi


