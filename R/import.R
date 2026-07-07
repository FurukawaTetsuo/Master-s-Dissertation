#for reading dta
library(foreign)
#for easier file navigation
library(here)

hh_17_18_fv <- read.dta(here("Data", "17-18", "hh_per_fv_2017-18.dta"))
hh_17_18_rv <- read.dta(here("Data", "17-18", "hh_per_rv_2017-18.dta"))

state_district_codes <- unique(hh_17_18_fv[c("state_per_fv", "b1q4_per_fv")])

#Find num of unique state-district combinations
nrow(state_district_codes)

for (x in 1:nrow(state_district_codes)) {
  state_district_codes$district[x] <- x
}

nstates <- as.integer(unique(hh_17_18_fv$state_per_fv))
length(nstates)
