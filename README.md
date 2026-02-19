# injuryLinkR

<!-- badges: start -->
![R](https://img.shields.io/badge/R-%3E%3D4.2-blue)
![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)
![Status](https://img.shields.io/badge/status-development-orange)
<!-- badges: end -->

## Overview

**injuryLinkR** is an R package for spatial linkage of STATS19 injury-level data to road network segments and administrative geographies.

The package provides a structured workflow to:

- Construct injury-level datasets from STATS19 collisions, casualties, and vehicles tables
- Spatially match injuries to OS Open Roads segments
- Assign injuries to Output Areas (OA) and Local Authority Districts (LAD)
- Produce an analysis-ready injury-level dataset

This package was developed to support reproducible policy evaluation research using spatial injury data.

---

## Installation

Install from GitHub:

```r
# install.packages("devtools")
devtools::install_github("yourusername/injuryLinkR")
```

Or install locally:

```r
devtools::install()
```

---

## Dependencies

The package imports:

- dplyr
- sf
- tidyr
- stringr
- purrr
- readr

Ensure spatial data are projected in EPSG:27700 (British National Grid).

---

## Workflow

The typical pipeline consists of four steps:

### 1. Create Injury-Level Dataset

```r
library(injuryLinkR)

injuries <- create_injuries(
  collisions = collisions_df,
  casualties = casualties_df,
  vehicles   = vehicles_df
)
```

Creates:
- Unique `injury_id`
- Harmonised injury-level structure
- Derived temporal variables

---

### 2. Match to Road Network

```r
injuries_matched <- match_roads(
  injuries = injuries,
  roads    = os_open_roads_sf,
  threshold_same = 50,
  threshold_fallback = 100
)
```

- Same-class match ≤ 50m  
- Fallback match ≤ 100m  
- Returns road_link_id and matching diagnostics  

---

### 3. Assign Output Areas

```r
injuries_oa <- assign_oa(
  injuries = injuries_matched,
  oa       = oa_boundaries_sf
)
```

- Within-polygon assignment preferred  
- Nearest-centroid fallback if required  

---

### 4. Build Full Dataset in One Step

```r
injuries_final <- build_injury_dataset(
  collisions = collisions_df,
  casualties = casualties_df,
  vehicles   = vehicles_df,
  roads      = os_open_roads_sf,
  oa         = oa_boundaries_sf
)
```

Returns the complete injury-level analytical dataset.

---

## Output Dataset Structure

The final dataset (`injuries_OA.rds`) contains:

- Unique injury identifier (`injury_id`)
- Temporal variables (year, month, quarter)
- Injury characteristics (severity, casualty type, age, sex)
- Vehicle characteristics
- Spatial coordinates (EPSG:27700)
- Matched road segment ID and distance
- Local Authority District codes
- Output Area codes

Unit of observation: **Injury (casualty-level record)**

---

## Reproducibility

This package is designed to:

- Ensure deterministic spatial matching
- Support version control and research transparency
- Enable replication 


## Project Structure

```
injuryLinkR/
├── R/
│   ├── create_injuries.R
│   ├── match_roads.R
│   ├── assign_oa.R
│   └── build_dataset.R
├── DESCRIPTION
├── NAMESPACE
├── LICENSE
├── README.md
├── tests/
└── injuryLinkR.Rproj
```

---

## Data Requirements

This package does not distribute data.

Users must provide:

- STATS19 collisions table
- STATS19 casualties table
- STATS19 vehicles table
- OS Open Roads spatial network
- Output Area boundary shapefiles

All spatial data must use British National Grid (EPSG:27700).

---

## Citation

If using this package in academic work, please cite as:

> Alkhatib (2026). injuryLinkR: Injury-Level Spatial Linkage for STATS19 Data. R package version 0.0.1.

---

## License

MIT License.

---

## Status

This package is under active development.
