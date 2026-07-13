#for reading dta
library(haven)
#for easier file navigation
library(here)

data17_18_fv <- read_dta(here("Data", "17-18", "hh_per_fv_2017-18.dta"))
data17_18_rv <- read_dta(here("Data", "17-18", "hh_per_rv_2017-18.dta"))

data18_19_fv <- read_dta(here("Data","18-19","PerV1_2018-19.dta"))
data18_19_rv <- read_dta(here("Data","18-19","PerRV_2018-19.dta"))

data19_20_fv <- read_dta(here("Data","19-20","PERFV_2019-20.dta"))
data19_20_rv <- read_dta(here("Data","19-20","PERRV_2019-20.dta"))

data20_21_fv <- read_dta(here("Data","20-21","perv1.dta"))
data20_21_rv <- read_dta(here("Data","20-21","perrv.dta"))

data21 <- read_dta(here("Data","21","cperv1.dta"))

data22 <- read_dta(here("Data","22","cperv1.dta"))

data23 <- read_dta(here("Data","23","cperv1.dta"))

data24 <- read.csv(here("Data","24","cperv1.csv"))

data25 <- read_dta(here("Data","25","cperv12025.dta"))

