library(tidyverse)
library(foreach)
library(parallel)
library(doParallel)

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

dat <- readr::read_csv("r_lesson_loop_data.csv")
vars <- grep("^V", names(dat), value = TRUE)
start_time <- Sys.time()
dat_summ3 <- foreach(v = vars,
  .packages = c("tidyverse"),
  .combine = dplyr::bind_rows) %dopar% {
    dat_sum <- dat |> my_aggregation(data = _, var_name = v)
    saveRDS(dat_sum, file = paste0("dat_sum_", v, "_.RData"))
    dat_sum
  }
end_time <- Sys.time()
write(difftime(end_time, start_time), "run_time.txt")
stopCluster(cl)
