library(haven)


# ============================================================
# 1. Convert each variable to ordinary integer codes
# ============================================================

clean_code <- function(x) {
  
  if (
    inherits(x, "haven_labelled") ||
    inherits(x, "labelled")
  ) {
    x <- haven::zap_labels(x)
  }
  
  # Convert factors, characters and numerics consistently
  x <- trimws(as.character(x))
  
  # Replace blank strings with missing values
  x[x == ""] <- NA_character_
  
  suppressWarnings(as.integer(x))
}


# ============================================================
# 2. Function for identifying informal passenger transport
# ============================================================

make_informal_transport <- function(data, columns) {
  
  # Check that the specified columns really exist
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
  
  
  # Extract and clean the required variables
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
  
  
  # Convert NIC to a five-digit string
  # This restores leading zeroes lost in the 2024 CSV:
  # 1286 becomes 01286, for example.
  nic5 <- ifelse(
    is.na(nic),
    NA_character_,
    sprintf("%05d", nic)
  )
  
  
  # Passenger land transport:
  # NIC 4921 = urban/suburban passenger land transport
  # NIC 4922 = other passenger land transport
  passenger_transport <-
    substr(nic5, 1, 4) %in% c("4921", "4922")
  
  
  # Wage/casual workers without listed social security
  informal_employee <-
    pas %in% c(31, 41, 51) &
    social_security == 8
  
  
  # Self-employed informal workers
  informal_self_employed <-
    pas == 21 |
    (
      pas %in% c(11, 12) &
        enterprise %in% c(1, 2, 3, 4) &
        enterprise_size %in% c(1, 2)
    )
  
  
  # Keep people satisfying the transport and informality rules
  keep <-
    passenger_transport &
    (
      informal_employee |
        informal_self_employed
    )
  
  # Do not retain observations with uncertain conditions
  keep[is.na(keep)] <- FALSE
  
  
  # Return a separate data frame without changing the original
  data[
    keep,
    ,
    drop = FALSE
  ]
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