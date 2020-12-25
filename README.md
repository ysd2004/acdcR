# *acdc*: Agro-Climatic Data by County

*This repository is to develop and distribute a testing version of R-package _acdc_. The stable latest version is directly available from R-CRAN.*
*Data and code are subject to change*

GitHub Repository maintained by: Seong Yun\
Department of Agricultural Economics\
Mississippi State University\
**<seong.yun@msstate.edu>**\
**<https://sites.google.com/site/yunsd2004/>**\
*Last updated: Dec 25, 2020*

------------------------------------------------------------------------

1 *acdc* R-package
==========

Agro-Climatic Data by County (ACDC) is designed to provide a county level base dataset for use in agricultural production and climate/weather research. Due to the recent popularity of raster imagery data (high resolution grid cell data), the demand for weather, soil/land and related data for research and applied decision support is increasing rapidly. The ACDC data set was developed to provide the most widely-used variables extracted from the most popular high resolution gridded data sources to end users of agro-climatic variables who may not be equipped to process large geospatial datasets from multiple publicly available sources that are provided in different data formats and spatial scales. Annual county level data for 1981-2015 are provided for corn, soybeans, upland cotton and winter wheat yields, and customizable growing degree days and cumulative precipitation for two groups of months (March-August and April-October) to capture different growing season periods for the crops. Soil characteristic data are also included for each county in the data set. All weather and soil data have been processed based on land cover/land use data and exclude soil and weather data for land that is not being used for non-forestry agricultural uses.

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
Benjamin M. Gramig, Associate Professor, Yale University (<bgramig@illinois.edu>)

Maintainer/Bug report or quetion to Seong Yun (<seong.yun@msstate.edu>)

4 Citation
====================================
Please cite the software in publications;

4.1. *acdc* (stable and latest) from the R-CRAN repository
---------------------------------
(under coding)

4.2. *acdc* (testing) from the R-CRAN repository
---------------------------------
(under coding)


5 References
====================================
The methods and examples in *acdc* are available from:

* Yun, S. D. and B. M. Gramig, 2019, "Agro-Climatic Data by County: A Spatially and Temporally Consistent U.S. Dataset for Agricultural Yields, Wather and Soils," *Data*, 4(2):66. (<https://doi.org/10.1086/676034>)
* Yun, S. D. and B. M. Gramig, 2017, "ACDC: Agro-Climatic Data by Count, 1981-2015," *Purdue University Research Repository*. (<https://doi.org/10.4231/R72F7KK2>)

6 Development History
====================================

Below are the development history of R-package *acdc*.

* 12-01-2020: The first R-package version *acdc* was initiated to code.

* 05-08-2019: Published the journal article of ACDC v1.0.0 on *Data* (<https://doi.org/10.3390/data4020066>)

* 07-08-2017: Published the first version of data in Purdue University Research Repository (<https://doi.org/10.4231/R72F7KK2>)


