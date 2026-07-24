library(haven)

make_informal_transport <- function(data, columns) {
  
  # Check that all specified columns exist
  missing_columns <- setdiff(
    unname(columns),
    names(data)
  )
  
  if (length(missing_columns) > 0) {
    stop(
      paste(
        "The following columns are missing:",
        paste(missing_columns, collapse = ", ")
      )
    )
  }
  
  
  # Extract and clean required variables
  pas <- clean_code(
    data[[columns[["pas"]]]]
  )
  
  nic <- clean_code(
    data[[columns[["nic"]]]]
  )
  
  enterprise <- clean_code(
    data[[columns[["enterprise"]]]]
  )
  
  enterprise_size <- clean_code(
    data[[columns[["enterprise_size"]]]]
  )
  
  social_security <- clean_code(
    data[[columns[["social_security"]]]]
  )
  
  
  # Convert NIC to five-digit character codes
  nic5 <- ifelse(
    is.na(nic),
    NA_character_,
    sprintf("%05d", nic)
  )
  
  
  # Passenger land transport
  passenger_transport <-
    substr(nic5, 1, 4) %in% c("4921", "4922")
  
  
  # Informal wage/casual employees
  informal_employee <-
    pas %in% c(31, 41, 51) &
    social_security == 8
  
  
  # Informal self-employed workers
  informal_self_employed <-
    pas == 21 |
    (
      pas %in% c(11, 12) &
        enterprise %in% c(1, 2, 3, 4) &
        enterprise_size %in% c(1, 2)
    )
  
  
  # Combine employee and self-employed definitions
  informal_status <-
    informal_employee |
    informal_self_employed
  
  
  # Convert missing logical results to FALSE
  passenger_transport[is.na(passenger_transport)] <- FALSE
  informal_status[is.na(informal_status)] <- FALSE
  
  
  # Add binary variables to the new data frame
  data$transport <- as.integer(
    passenger_transport
  )
  
  data$informal <- as.integer(
    informal_status
  )
  
  
  # Optional combined indicator:
  # 1 only when both informal and in passenger transport
  data$informal_transport <- as.integer(
    passenger_transport &
      informal_status
  )
  
  
  # Return every observation
  data
}

columns17 <- c(
  pas = "b5pt1q3_per_fv",
  nic = "b5pt1q5_per_fv",
  enterprise = "b5pt1q9_per_fv",
  enterprise_size = "b5pt1q10_per_fv",
  social_security = "b5pt1q13_per_fv"
)


columns18_19 <- c(
  pas = "b5pt1q3_per_fv",
  nic = "b5pt1q5_per_fv",
  enterprise = "b5pt1q9_per_fv",
  enterprise_size = "b5pt1q10_per_fv",
  social_security = "b5pt1q13_per_fv"
)


columns19_20 <- c(
  pas = "b5pt1q3_per_fv",
  nic = "b5pt1q5_per_fv",
  enterprise = "b5pt1q9_per_fv",
  enterprise_size = "b5pt1q10_per_fv",
  social_security = "b5pt1q13_per_fv"
)


columns20_21 <- c(
  pas = "b5pt1q3_perv1",
  nic = "b5pt1q5_perv1",
  enterprise = "b5pt1q9_perv1",
  enterprise_size = "b5pt1q10_perv1",
  social_security = "b5pt1q13_perv1"
)


columns22 <- c(
  pas = "b5pt1q3_cperv1",
  nic = "b5pt1q5_cperv1",
  enterprise = "b5pt1q9_cperv1",
  enterprise_size = "b5pt1q10_cperv1",
  social_security = "b5pt1q13_cperv1"
)


columns23 <- c(
  pas = "b5pt1q3_cperv1",
  nic = "b5pt1q5_cperv1",
  enterprise = "b5pt1q9_cperv1",
  enterprise_size = "b5pt1q10_cperv1",
  social_security = "b5pt1q13_cperv1"
)


columns24 <- c(
  pas = "Principal_Status_Code",
  nic = "Principal_Industry_Code",
  enterprise = "Principal_Enterprise_Type",
  enterprise_size = "Principal_Workers_Count",
  social_security = "Principal_Social_Security"
)


columns25 <- c(
  pas = "pas",
  nic = "ind_pas",
  enterprise = "etyp_pas",
  enterprise_size = "wrkr_pas",
  social_security = "ssec_pas"
)