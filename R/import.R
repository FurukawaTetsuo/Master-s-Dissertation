#for reading dta
library(foreign)
#for easier file navigation
library(here)

data17_18_fv <- read.dta(here("Data", "17-18", "hh_per_fv_2017-18.dta"))
data17_18_rv <- read.dta(here("Data", "17-18", "hh_per_rv_2017-18.dta"))

data18_19_fv <- read.dta(here("Data","18-19","PerV1_2018-19.dta"))
data18_19_rv <- read.dta(here("Data","18-19","PerRV_2018-19.dta"))

#Test it works on Linux

#state_district_codes <- unique(data17_18_fv[c("state_per_fv", "b1q4_per_fv")])

#Find num of unique state-district combinations
#nrow(state_district_codes)

#for (x in 1:nrow(state_district_codes)) {
#  state_district_codes$district[x] <- x
#}

#nstates <- as.integer(unique(data17_18_fv$state_per_fv))
#length(nstates)
