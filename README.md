# *acdc*: Agro-Climatic Data by County

*This repository is to develop and distribute a testing version of R-package _acdc_. The stable latest version is directly available from R-CRAN.*
*Data and code are subject to change*

GitHub Repository maintained by: Seong Yun\
Department of Agricultural Economics\
Mississippi State University\
**<seong.yun@msstate.edu>**\
**<https://sites.google.com/site/yunsd2004/>**\
*Last updated: Jun. 21, 2022*

------------------------------------------------------------------------

1 *acdc* R-package
==========

An R-package Agro-Climatic Data by County (*acdc*) is designed to provide the functions to calculate
the most widely-used county-level variables in agricultural production or agro-climatic and weather analyses. *acdc* applies the most recent NLCD maps (2001, 2004, 2006, 2008, 2011, 2013, 2016, and 2019) to take account of agricultural areas only weighted averages over the PRISM rasters. In the current version of *acdc*, there are functions to calculate growing season degree days (GDDs) with single/double sine/triangulation methods, to produce GDDs and precipitations by the PRISM grids or County FIPS codes from the direct input of PRISM rasters, and to convert the PRISM grids data to county-level values.

2 Getting started:
==================

2.1. Install the latest version (complete) of *acdc* from the R-CRAN repository:
--------------------------------------------------

The latest version of *acdc* is available from the R-CRAN repository. Users can install and use all functions and features directly installing it from the R-CRAN repository.

``` r
    ## In R
    install.packages("acdc")
    library(acdc)
```

2.2. Install *acdc* testing version from the github repository:
---------------------------------
For your testing purpose, a version currently developing is available from this GitHub repository.


``` r
    ## Need to install devtools packages
    install.packages("devtools")
    ## Then use
    devtools::install_github("ysd2004/acdc")
    library(acdc)
```

3 Authors
====================================
Seong D. Yun, Assistant Professor, Mississippi State University (<seong.yun@msstate.edu>)

Note: Benjamin M. Gramig, Research Agricultural Economist at USDA-ERS provides great help and advice to build this package.

Maintainer/Bug report or quetion to Seong Yun (<seong.yun@msstate.edu>)

4 Citation
====================================
Please cite the software in publications;

4.1. *acdc* (stable and latest) from the R-CRAN repository
---------------------------------
To cite the R-package *acdc*, use `citation()` for information on how to cite the software;

```r
citation(package = "acdc")
 
To cite package 'acdc' in publications use:

  Seong D. Yun, (2022). acdc: Agro-Climatic Data by County. 
  R package version 1.0.0. https://CRAN.R-project.org/package=acdc

A BibTeX entry for LaTeX users is

  @Manual{,
    title = {acdc: Agro-Climatic Data by County.},
    author = {Seong D. Yun},
    year = {2022},
    note = {R package version 1.0.0},
    url = {https://CRAN.R-project.org/package=acdc},
  }
```

4.2. *acdc* (testing) from the R-CRAN repository
---------------------------------
To cite this GitHub repository:

```r
To cite *acdc* package in publications use:

  Yun, Seong D., 2022, "acdc: Agro-Climatic Data by County," Data retrieved from the GitHub,
  https://github.com/ysd2004/acdc.

A BibTeX entry for LaTeX users is

  @misc{,
    title = {acdc: Agro-Climatic Data by County},
    author = {Seong D. Yun},
    year = {2022},
    note = {Data retrieved from the GitHub,
    \url{https://github.com/ysd2004/acdc}}
  }
```


5 References
====================================
The methods and examples in *acdc* are available from:

* Yun, S. D. and B. M. Gramig, 2019, "Agro-Climatic Data by County: A Spatially and Temporally Consistent U.S. Dataset for Agricultural Yields, Wather and Soils," *Data*, 4(2):66. (<https://doi.org/10.1086/676034>)
* Yun, S. D. and B. M. Gramig, 2017, "ACDC: Agro-Climatic Data by Count, 1981-2015," *Purdue University Research Repository*. (<https://doi.org/10.4231/R72F7KK2>)

6 Development History
====================================

Below are the development history of R-package *acdc*.

* 06-18-2022: V. 1.0.0 is installable from GitHub.

* 06-01-2022: V. 1.0.0 was embeded in GitHub.

* 04-30-2021: The first beta version was tested.

* 12-01-2020: The first R-package version *acdc* was initiated to code.

* 05-08-2019: Published the journal article of ACDC v1.0.0 on *Data* (<https://doi.org/10.3390/data4020066>)

* 07-08-2017: Published the first version of data in Purdue University Research Repository (<https://doi.org/10.4231/R72F7KK2>)


