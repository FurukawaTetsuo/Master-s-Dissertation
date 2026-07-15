#Check which columns I can/should remove
column_lists <- list(
  `2017_18` = sort(colnames(informal_transport17_18)),
  `2018_19` = sort(colnames(informal_transport18_19)),
  `2020_21` = sort(colnames(informal_transport20_21)),
  `2022`    = sort(colnames(informal_transport22)),
  `2023`    = sort(colnames(informal_transport23)),
  `2024`    = sort(colnames(informal_transport24)),
  `2025`    = sort(colnames(informal_transport25))
)

max_length <- max(lengths(column_lists))

variable_list <- as.data.frame(
  lapply(
    column_lists,
    function(x) {
      length(x) <- max_length
      x
    }
  )
)

write.csv(
  variable_list,
  "variables.csv",
  row.names = FALSE
)


