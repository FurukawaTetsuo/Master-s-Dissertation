library(haven)
library(dplyr)
library(purrr)
library(stringr)
library(here)


# ============================================================
# 1. List the datasets you want to document
# ============================================================

plfs_datasets <- list(
  `2017-18` = data17_18_fv,
  `2018-19` = data18_19_fv,
  `2019-20` = data19_20_fv,
  `2020-21` = data20_21_fv,
  `2021`    = data21,
  `2022`    = data22,
  `2023`    = data23,
  `2024`    = data24,
  `2025`    = data25
)


# ============================================================
# 2. Extract the Stata variable description
# ============================================================

get_variable_label <- function(x) {
  
  label <- attr(x, "label")
  
  if (is.null(label) || length(label) == 0) {
    return("")
  }
  
  as.character(label)
}


# ============================================================
# 3. Extract labelled value codes
# ============================================================

get_value_labels <- function(x) {
  
  labels <- attr(x, "labels")
  
  if (is.null(labels) || length(labels) == 0) {
    return("")
  }
  
  paste0(
    unname(labels),
    " = ",
    names(labels),
    collapse = "; "
  )
}


# ============================================================
# 4. Show example values without altering the data
# ============================================================

get_example_values <- function(x, maximum = 10) {
  
  if (
    inherits(x, "haven_labelled") ||
    inherits(x, "labelled")
  ) {
    x <- haven::zap_labels(x)
  }
  
  if (is.factor(x)) {
    x <- as.character(x)
  }
  
  x <- x[!is.na(x)]
  
  if (length(x) == 0) {
    return("")
  }
  
  values <- unique(x)
  values <- head(values, maximum)
  
  paste(values, collapse = ", ")
}


# ============================================================
# 5. Parse the coded PLFS variable name
# ============================================================

parse_plfs_name <- function(variable_name) {
  
  name_lower <- tolower(variable_name)
  
  block_match <- str_match(
    name_lower,
    "^b([0-9]+)"
  )
  
  question_match <- str_match(
    name_lower,
    "q([0-9]+)"
  )
  
  subitem_match <- str_match(
    name_lower,
    "3pt([0-9]+)"
  )
  
  activity_match <- str_match(
    name_lower,
    "act([12])"
  )
  
  
  block <- suppressWarnings(
    as.integer(block_match[, 2])
  )
  
  question <- suppressWarnings(
    as.integer(question_match[, 2])
  )
  
  subitem <- suppressWarnings(
    as.integer(subitem_match[, 2])
  )
  
  activity <- suppressWarnings(
    as.integer(activity_match[, 2])
  )
  
  
  file_component <- case_when(
    
    str_detect(
      name_lower,
      "per_fv|perv1|cperv1"
    ) ~ "Person file: first visit",
    
    str_detect(
      name_lower,
      "per_rv|perrv|cperrv"
    ) ~ "Person file: revisit",
    
    TRUE ~ ""
  )
  
  
  questionnaire_section <- case_when(
    
    block == 1 ~
      "Block 1: identification and sample particulars",
    
    block == 4 ~
      "Block 4: demographic, education and training particulars",
    
    block == 5 ~
      "Block 5: usual activity and employment particulars",
    
    block == 6 ~
      "Block 6: current weekly activity and daily work details",
    
    TRUE ~
      ""
  )
  
  
  data.frame(
    block = block,
    question = question,
    subitem = subitem,
    activity_number = activity,
    questionnaire_section = questionnaire_section,
    file_component = file_component,
    stringsAsFactors = FALSE
  )
}


# ============================================================
# 6. Build a dictionary for one dataset
# ============================================================

make_data_dictionary <- function(data, year_name) {
  
  variable_names <- names(data)
  
  parsed_names <- bind_rows(
    lapply(
      variable_names,
      parse_plfs_name
    )
  )
  
  
  dictionary <- data.frame(
    
    year = year_name,
    
    column_number = seq_along(data),
    
    variable_name = variable_names,
    
    variable_label = map_chr(
      data,
      get_variable_label
    ),
    
    value_labels = map_chr(
      data,
      get_value_labels
    ),
    
    variable_class = map_chr(
      data,
      ~ paste(class(.x), collapse = "/")
    ),
    
    example_values = map_chr(
      data,
      get_example_values
    ),
    
    stringsAsFactors = FALSE
  )
  
  
  dictionary <- bind_cols(
    dictionary,
    parsed_names
  )
  
  
  # Use descriptive modern variable names where no Stata label exists
  dictionary <- dictionary %>%
    mutate(
      readable_description = case_when(
        
        variable_label != "" ~
          variable_label,
        
        TRUE ~
          str_replace_all(
            variable_name,
            "_",
            " "
          )
      )
    )
  
  
  dictionary
}


plfs_data_dictionaries <- imap(
  plfs_datasets,
  make_data_dictionary
)

plfs_data_dictionary <- bind_rows(
  plfs_data_dictionaries
)