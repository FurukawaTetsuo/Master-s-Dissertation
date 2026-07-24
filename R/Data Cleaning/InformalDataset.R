#Create data frames for informal transport for each year

informal_transport17_18 <- make_informal_transport(
  data17_18_fv,
  columns17
)

informal_transport18_19 <- make_informal_transport(
  data18_19_fv,
  columns18_19
)

informal_transport19_20 <- make_informal_transport(
  data19_20_fv,
  columns19_20
)

informal_transport20_21 <- make_informal_transport(
  data20_21_fv,
  columns20_21
)

informal_transport22 <- make_informal_transport(
  data22,
  columns22
)

informal_transport23 <- make_informal_transport(
  data23,
  columns23
)

informal_transport24 <- make_informal_transport(
  data24,
  columns24
)

informal_transport25 <- make_informal_transport(
  data25,
  columns25
)


#Adding year variable for time series
informal_transport17_18$year <- 2017
informal_transport18_19$year <- 2018
informal_transport19_20$year <- 2019
informal_transport20_21$year <- 2020
informal_transport22$year <- 2022
informal_transport23$year <- 2023
informal_transport24$year <- 2024
informal_transport25$year <- 2025


#Adding unique district identifiers
informal_transport17_18 <- add_district_id(
  informal_transport17_18,
  state_column = "state_per_fv",
  district_column = "b1q4_per_fv"
)

informal_transport18_19 <- add_district_id(
  informal_transport18_19,
  state_column = "state_per_fv",
  district_column = "b1q4_per_fv"
)

informal_transport19_20 <- add_district_id(
  informal_transport19_20,
  state_column = "state_per_fv",
  district_column = "b1q4_per_fv"
)

informal_transport20_21 <- add_district_id(
  informal_transport20_21,
  state_column = "state_perv1",
  district_column = "distcode_perv1"
)

informal_transport22 <- add_district_id(
  informal_transport22,
  state_column = "state_cperv1",
  district_column = "distcode_cperv1"
)

informal_transport23 <- add_district_id(
  informal_transport23,
  state_column = "state_cperv1",
  district_column = "distcode_cperv1"
)

informal_transport24 <- add_district_id(
  informal_transport24,
  state_column = "State_UT_Code",
  district_column = "District_Code"
)

informal_transport25 <- add_district_id(
  informal_transport25,
  state_column = "st",
  district_column = "dc"
)


