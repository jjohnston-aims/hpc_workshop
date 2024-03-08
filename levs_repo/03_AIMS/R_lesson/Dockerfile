FROM rocker/r-ver:4.3.2

## Install packages
RUN apt-get update \ 
  && apt-get install -y --no-install-recommends \ 
    libgdal-dev \ 
    libproj-dev \ 
    libgeos-dev \ 
    lbzip2 \ 
    libnetcdf-dev \ 
    libsqlite3-dev \ 
    libssl-dev \ 
    libudunits2-dev \ 
    netcdf-bin \ 
    sqlite3 \ 
    imagemagick \ 
    pandoc \ 
    pandoc-citeproc \ 
    make \ 
    ghostscript \ 
    poppler-utils \ 
    zip \ 
    wget \ 
    fonts-dejavu-extra \ 
    curl \ 
    tk \ 
    xtide \ 
    openjdk-11-jre \ 
    gdebi-core \
    libfontconfig1-dev \
    libharfbuzz-dev \
    libfribidi-dev \
    cmake \
  && rm -rf /var/lib/apt/lists/* 


## Install R package versions from PPPM (based on a date - YYYY-MM-DD)
RUN R -e "options(repos = \
    list(CRAN = 'https://packagemanager.posit.co/cran/2024-01-02/')); \
    install.packages('INLA',repos=c(getOption('repos'),INLA='https://inla.r-inla-download.org/R/stable'), dep=TRUE); \
"

## Install more R packages versions from PPPM (based on a date - YYYY-MM-DD)
RUN R -e "options(repos = \
    list(CRAN = 'https://packagemanager.posit.co/cran/2024-01-02/')); \
  install.packages('inlabru'); \
  install.packages('R.utils'); \
  install.packages('sp'); \
"

## Install remaining R packages from PPPM (based on a date - YYYY-MM-DD)
RUN R -e "options(repos = \
    list(CRAN = 'https://packagemanager.posit.co/cran/2024-01-02/')); \
  all_pkgs <- installed.packages()[, 'Package', drop = TRUE]; \
  to_install <- c('remotes', 'tidyverse', 'rstan', 'brms', 'drc', 'MASS', 'corpcor', 'dplyr', 'ggdist', 'knitr', 'ggpubr', 'drake', 'viridis', 'ggsci', 'readxl', 'lubridate', 'stringr', 'extraDistr', 'posterior', 'emmeans', 'DHARMa', 'glmmTMB', 'lme4', 'ggnewscale'); \
  for (i in seq_along(to_install)) {; \
    if (!to_install[i] %in% all_pkgs) {; \
      install.packages(to_install[i]); \
      all_pkgs <- installed.packages()[, 'Package', drop = TRUE]; \
    }; \
  }; \
  install.packages('cmdstanr', repos = c('https://mc-stan.org/r-packages/', getOption('repos'))); \
  library(cmdstanr); \
  check_cmdstan_toolchain(); \
  install_cmdstan(cores = 2); \
"

# Install FRK from branch
RUN R -e "remotes::install_github('andrewzm/FRK', branch = '2023_03_RandomEffects')"

# More dependencies for the spatio-temporal models
RUN R -e "options(repos = \
    list(CRAN = 'https://packagemanager.posit.co/cran/2024-01-02/')); \
  all_pkgs <- installed.packages()[, 'Package', drop = TRUE]; \
  to_install <- c('spacetime', 'lorentz'); \
  for (i in seq_along(to_install)) {; \
    if (!to_install[i] %in% all_pkgs) {; \
      install.packages(to_install[i]); \
      all_pkgs <- installed.packages()[, 'Package', drop = TRUE]; \
    }; \
  }; \
"

# More dependencies for the spatio-temporal models
RUN R -e "options(repos = \
    list(CRAN = 'https://packagemanager.posit.co/cran/2024-01-02/')); \
  all_pkgs <- installed.packages()[, 'Package', drop = TRUE]; \
  to_install <- c('simstudy', 'gstat', 'patchwork', 'wesanderson', 'sdmTMB', 'tmbstan'); \
  for (i in seq_along(to_install)) {; \
    if (!to_install[i] %in% all_pkgs) {; \
      install.packages(to_install[i]); \
      all_pkgs <- installed.packages()[, 'Package', drop = TRUE]; \
    }; \
  }; \
  remotes::install_github('johannesbjork/LaCroixColoR'); \
  remotes::install_github('timcdlucas/INLAutils'); \
"

# Custom dependencies
RUN R -e "url <- 'https://cran.r-project.org/src/contrib/Archive/RandomFields/RandomFields_3.3.tar.gz'; \
  pkgFile <- 'RandomFields_3.3.tar.gz'; \
  download.file(url = url, destfile = pkgFile); \
  install.packages(pkgs = pkgFile, type = 'source', repos = NULL); \
  install.packages('RandomFields', repos = c('https://spatstat.r-universe.dev', 'https://cloud.r-project.org')); \
"

WORKDIR /home/Project

## Default command to run
ENTRYPOINT ["Rscript"]

CMD ["analysis.R"]
