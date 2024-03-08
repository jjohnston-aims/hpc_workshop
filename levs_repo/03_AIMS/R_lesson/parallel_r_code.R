library(tidyverse)
library(foreach)
library(doParallel)

Sys.info()[["sysname"]]

## Generate some synthetic data
## - 5 groups (A, B, C, D, E)
## - 4 subgroups (a, b, c, d)
## - 3 replicates (1, 2, 3)
## - 5 variables (V1, V2, V3, V4, V5)
##                        ┌─────────┐            ┌─────────┐
## group                  │    A    │            │    B    │      ....
##                        └─────────┘            └─────────┘
##                        /    |    \            /    |    \
##                       /     |     \          /     |     \
## subgroup             a      b      c        a      b      c    ....
##                     /|\    /|\    /|\      /|\    /|\    /|\       
## replicate          1 2 3  1 2 3  1 2 3    1 2 3  1 2 3  1 2 3  ....     
##                    | | |  | | |  | | |    | | |  | | |  | | |      
## V1, V2, V3, ...    ┄ ┄ ┄  ┄ ┄ ┄  ┄ ┄ ┄    ┄ ┄ ┄  ┄ ┄ ┄  ┄ ┄ ┄      
##

set.seed(123)
dat <- data.frame(group = factor(LETTERS[1:5])) |>
  tidyr::crossing(subgroup = factor(letters[1:4]), replicate = 1:3) |>
  dplyr::bind_cols(
    var = tibble::as_tibble(replicate(5, rnorm(60, 10, 2)))
  )
dat
write.csv(dat, "r_lesson_loop_data.csv", row.names = FALSE)

## This data set offers multiple ways that we may want perform some
## routine (function) repeatedly:
## - for each group (or subgroup)
## - for each of the V1, V2, V3, ... columns

## Lets perform some action separately for each V1, V2, V3 etc
## The action that we will perform will be to just calculate the
## mean of each group/subgroup.
## This is not particularly interesting or arduous, it is simply
## a proxy for something that we might want to calculate.
## To slow the task down, we will also place a delay of 5 seconds
## towards the end of each loop
##

## We will start with a relatively simple for-loop that for each
## iteration (V1 through to V5):
## - prints out iterator as a poor mans progress
## - takes the data (dat)
##   - selects only the group, and the column
##     corresponding to the iterator name (focal column)
##   - groups by group column
##   - calculates the mean of the focal column
## - delay for 5 seconds
## Note, at this stage the results will neither be displayed
## nor stored - we are going to build up the code incrementally

## We will also include a very rudimentary mechanism to estimate
## the amount of time elapsed - call Sys.time before and after

start_time <- Sys.time()
vars <- c("V1", "V2", "V3", "V4", "V5")
for (v in vars) {
  Sys.sleep(5)
  print(v)
  dat |>
    dplyr::select(group, .env$v) |>
    dplyr::group_by(group) |>
    dplyr::summarise(mean = mean(get(.env$v)), .groups = "drop")
}
end_time <- Sys.time()
difftime(end_time, start_time)

## To make this more useful, we will store the results in a list
## as we go and then bind up the results at the end

start_time <- Sys.time()
dat_summ <- setNames(vector("list", length = 5), vars)
for (v in vars) {
  Sys.sleep(5)
  print(v)
  dat_summ[[v]] <- dat |>
    dplyr::select(group, .env$v) |>
    dplyr::group_by(group) |>
    dplyr::summarise(mean = mean(get(.env$v)), .groups = "drop")
}
end_time <- Sys.time()
difftime(end_time, start_time)
dat_summ
## Bind all back together into a single data frame (tibble)
dat_summ <- dat_summ |>
  dplyr::bind_rows(.id = "var")



## In the above, the loop progresses sequentially.  If we can
## run each loop in parallel, we should be able to speed up
## then entire process

## We need to start by registering the number of clusters we want to
## use

cl <- parallel::makeCluster(5)
registerDoParallel(cl)

## Parallel for-loops are supported by the foreach function. Although
## this function resembles a regular for-loop, behind the scenes it is
## quite different. Packets of data and code are bundled up and sent
## to the registered number of cores where they are processed and
## returned. Since each node operates independently of the rest of
## your code, it is necessary to indicate all the packages that will be
## needed to run the code inside the for-loop body so that these can
## be passed on to each node. It is also useful to nominate how the
## results returned from each node should be combined. It is a good
## idea to make sure that you have indicated where stdout is directed
## when defining your batch file so that you can explore any messages,
## warnings and errors generated within the loop.

start_time <- Sys.time()
dat_summ1 <- foreach(v = vars,
  .packages = c("tidyverse"),
  .combine = dplyr::bind_rows) %dopar% {
    Sys.sleep(5)
    dat |>
      dplyr::select(group, .env$v) |>
      dplyr::group_by(group) |>
      dplyr::summarise(mean = mean(get(.env$v)), .groups = "drop") |>
      dplyr::mutate(var = .env$v)
  }
end_time <- Sys.time()
difftime(end_time, start_time)

dat_summ1
all.equal(dat_summ[, names(dat_summ1)], dat_summ1)

stopCluster(cl)

## I also advise storing (saving) the results of each iteration just
## in case one of the loops crashes and therefore prevents the final
## aggregation

## Make sure that the objects that you want to be combined are the
## last listed in the foreach function body

cl <- parallel::makeCluster(5)
registerDoParallel(cl)

start_time <- Sys.time()
dat_summ1 <- foreach(v = vars,
  .packages = c("tidyverse"),
  .combine = dplyr::bind_rows) %dopar% {
    Sys.sleep(5)
    dat_sum <- dat |>
      dplyr::select(group, .env$v) |>
      dplyr::group_by(group) |>
      dplyr::summarise(mean = mean(get(.env$v)), .groups = "drop") |>
      dplyr::mutate(var = .env$v)
    saveRDS(dat_sum, file = paste0("dat_sum_", v, "_.RData"))
    dat_sum
  }
end_time <- Sys.time()
difftime(end_time, start_time)

dat_summ1
all.equal(dat_summ[, names(dat_summ1)], dat_summ1)

stopCluster(cl)

## If necessary, we can later load an individual file
dat_sum_V1 <- readRDS("dat_sum_V1_.RData")

## Or load all the files (based on file name pattern)
dat_summ2 <- lapply(
  list.files(pattern = "dat_sum.*RData"),
  readRDS
) |>
  dplyr::bind_rows()

## The following compares each of the outputs that we generated so that
## we can confirm that they all yield identical results.
all.equal(dat_summ[, names(dat_summ1)], dat_summ1)
all.equal(dat_summ1, dat_summ2)

## Finally, putting looped over code into a one or more functions
## allows us to neaten the code up and also opens up other alternative
## ways to loop over data

my_aggregation <- function(data, var_name) {
  Sys.sleep(5)
  data |>
    dplyr::select(group, .env$var_name) |>
    dplyr::group_by(group) |>
    dplyr::summarise(mean = mean(get(.env$var_name)), .groups = "drop") |>
    dplyr::mutate(var = .env$var_name)
}

cl <- parallel::makeCluster(5)
registerDoParallel(cl)

start_time <- Sys.time()
dat_summ3 <- foreach(v = vars,
  .packages = c("tidyverse"),
  .combine = dplyr::bind_rows) %dopar% {
    dat_sum <- dat |> my_aggregation(data = _, var_name = v)
    saveRDS(dat_sum, file = paste0("dat_sum_", v, "_.RData"))
    dat_sum
  }
end_time <- Sys.time()
difftime(end_time, start_time)

dat_summ3
all.equal(dat_summ1, dat_summ3)

stopCluster(cl)

## For example, here is an alternative
library(furrr)
plan(multisession, workers = 5)
start_time <- Sys.time()
dat_summ4 <- furrr::future_map(vars, .f = ~ my_aggregation(dat, .x)) |>
  dplyr::bind_rows()
end_time <- Sys.time()
difftime(end_time, start_time)
stopCluster(cl)

all.equal(dat_summ3, dat_summ4)
