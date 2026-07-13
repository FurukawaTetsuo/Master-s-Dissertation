#Stripping stata labels for easier identificaiton
pas17 <- haven::zap_labels(
  data17_18_fv$b5pt1q3_per_fv
)
nic17 <- haven::zap_labels(
  data17_18_fv$b5pt1q5_per_fv
)
enterprise17 <- haven::zap_labels(
  data17_18_fv$b5pt1q9_per_fv
)
enterprise_size17 <- haven::zap_labels(
  data17_18_fv$b5pt1q10_per_fv
)
ssec17 <- haven::zap_labels(
  data17_18_fv$b5pt1q13_per_fv
)

# Passenger land transport
transport17 <- substr(as.character(nic17),1,4) %in% c("4921", "4922")

# Informal wage/casual employees:
# no specified social-security benefits
informal_employee17 <-pas17 %in% c(31, 41, 51) & ssec17 == 8

# Informal self-employed workers:
# unpaid family workers, or small proprietary/partnership enterprises
informal_self_employed17 <- pas17 == 21 | (pas17 %in% c(11, 12) & 
                                             enterprise17 %in% c(1, 2, 3, 4) & 
                                             enterprise_size17 %in% c(1, 2)
                                           )

# Final informal passenger-transport sample
informal_transport17 <- data17_18_fv[transport17 & (informal_employee17 | informal_self_employed17),]
