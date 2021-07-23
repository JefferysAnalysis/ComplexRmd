# ComplexRmd

Code to make complex and/or nested R Markdown based analysis easier.

Writing complex R Markdown documents to do analysis is hard. This package tries to ease some of the burden. It provides for nested documents by allowing customized parameter and environment passing between a parent and child R Markdown documents.

## Install

This package is not on CRAN. You must install the `ComplexRmd` package from "JefferysAnalysis" direct from GitHub using the `remotes` package. If you don't have the `remotes` package installed, you have to install that from CRAN first. Then you can install `ComplexRmd` from R as:

```{r}
# Requires the CRAN packages "remotes".
remotes::install_github("JefferysAnalysis/ComplexRmd")
```

