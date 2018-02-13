##########
# A source of simple functions for altering tibbletime
##########

# List of packages to load:
packages <- c("dplyr", "tibbletime", "rlang")

# Check to see whether any packages aren't installed on the computer and install
new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

sapply(packages, require, character.only = TRUE)
rm(new_packages)

tt_na_stats <- function(in.tbl_time) {
  out.stats <- list()
  # out.stats[["na_percent"]] <- list()
  for(col in names(in.tbl_time)) {
    out.stats[["na_percent"]][col] <- 100*sum(is.na(in.tbl_time[,col][[1]]))/length(in.tbl_time[,col][[1]])
  }
  return(out.stats)
}

tt_period_apply <- function(in.tbl_time, in.period, in.func = mean, na_rm = TRUE) {
  # Programatically find the index column
  index_column <- attributes(in.tbl_time)$index_quo[[2]]
  # Collapse by period, group by index, then summarise by function.
  out.tbl_time <- in.tbl_time %>%
    collapse_by(in.period) %>%
    group_by(!!! sym(index_column)) %>%
    summarise_if(is.numeric, in.func, na.rm = na_rm)
}

tt_trunc_index <- function(in.tbl_time, units) {
  # Programatically find the index column
  index_column <- attributes(in.tbl_time)$index_quo[[2]]
  
  if(units == 'hours' | units == 'days' |
     units == 'mins' | units == 'secs') {
    in.tbl_time[paste0(index_column)][[1]] <- trunc(in.tbl_time[paste0(index_column)][[1]],
                                       units = units)
  } else {
    warning("Units should be one of “secs”, “mins”, “hours”, “days”")
  }
}

tt_add_missing_rows <- function(in.tbl_time, by = 'hour') {
  # Programatically find the index column
  index_column <- attributes(in.tbl_time)$index_quo[[2]]
  
  # Programatically find the first and last date/time in the index
  start.idx <- start(in.tbl_time[,paste0(index_column)][[1]])
  end.idx <- end(in.tbl_time[,paste0(index_column)][[1]])
  
  start <- in.tbl_time[start.idx,paste0(index_column)][[1]][[1]]
  end <- in.tbl_time[end.idx,paste0(index_column)][[1]][[1]]
  
  seq.vec <- seq(start,end,by=by)
  seq.df <- data.frame(seq.vec)
    # Make the date/time column the same as for the other vector 
    # so that merge by will auto detect.
    names(seq.df)[1] <- paste(index_column)
  
  out.tbl_time <- merge(in.tbl_time,seq.df,all = TRUE)
}
