
# Importing packages ------------------------------------------------------

pacman::p_load(
  fastverse,
  dplyr,
  stringr,
  purrr
)

# Importing data ----------------------------------------------------------

overall_health_status <- fread("data/overall_health_status.csv") |> 
  mutate(
    icon = list(
      icon("calendar-check", lib = "font-awesome"),
      icon("heart", lib = "font-awesome"),
      icon("child-reaching", lib = "font-awesome"),
      icon("child", lib = "font-awesome"),
      icon("baby", lib = "font-awesome"),
      icon("person-breastfeeding", lib = "font-awesome"),
      icon("person-pregnant", lib = "font-awesome"),
      icon("virus", lib = "font-awesome"),
      icon("lungs", lib = "font-awesome"),
      icon("mosquito-net", lib = "font-awesome"),
      icon("chart-bar", lib = "font-awesome"),
      icon("ribbon", lib = "font-awesome"),
      icon("car-crash", lib = "font-awesome"),
      icon("utensils", lib = "font-awesome"),
      icon("dna", lib = "font-awesome"),
      icon("virus-covid", lib = "font-awesome"),
      icon("lungs-virus", lib = "font-awesome"),
      icon("mosquito", lib = "font-awesome"),
      icon("venus", lib = "font-awesome"),
      icon("baby-carriage", lib = "font-awesome"),
      icon("money-bill-wave", lib = "font-awesome"),
      icon("wallet", lib = "font-awesome")
    ),
    # Assign colors in blocks
    # style = paste0(
    #   "background-color: ", 
    #   "#D2EDF9",
    #   "!important;"
    # )
    style = case_when(
      str_detect(Indicator, "death|mortality|Mortality|Stillbirth")~
      paste0(
          "background-color: ",
          "#FE7501",
          " !important;",
          " color: ",
          "#fff",
          " !important;"
        ),
      TRUE ~ paste0(
        "background-color: ",
        "#27AAE1",
        " !important; ",
        " color: ",
        "#fff",
        " !important;"
      )
    )
  )

saveRDS(overall_health_status, "RData/overall_health_status.RDS")

# Overall progress towards UHC --------------------------------------------

overall_progress_uhc <- fread("data/overall_progress_uhc.csv") |> 
  mutate(
    icon = list(
      icon("stethoscope", lib = "font-awesome"),
      icon("money-bill-wave", lib = "font-awesome"),
      icon("chart-line", lib = "font-awesome"),
      icon("hospital", lib = "font-awesome")
    ),
    style = paste0(
      "background-color: ",
      "#27AAE1",
      " !important; ",
      " color: ",
      "#fff",
      " !important;"
    )
  )
saveRDS(overall_progress_uhc, "RData/overall_progress_uhc.RDS")

# Access to health services -----------------------------------------------

access_health_services <- fread("data/access_health_services.csv") |> 
  mutate(
    icon = list(
      icon("ambulance", lib = "font-awesome"),
      icon("ambulance", lib = "font-awesome"),
      icon("tint", lib = "font-awesome"),
      icon("road", lib = "font-awesome"),
      icon("signal", lib = "font-awesome")
    ),
    style = paste0(
      "background-color: ",
      "#27AAE1",
      " !important; ",
      " color: ",
      "#fff",
      " !important;"
    )
    
  )
saveRDS(access_health_services, "RData/access_health_services.RDS")

# Causes of morbidity -----------------------------------------------------

morbidity_cause <- fread("data/top_morbidity_causes.csv") |> 
  dplyr::select(-c(V5, V6, V7)) |> 
  mutate(date = ym(paste("2024", month)))
saveRDS(morbidity_cause, "RData/top_morbidity_causes.RDS")

# Causes of death -----------------------------------------------------

death_cause <- fread("data/top_mortality_causes.csv") |> 
  dplyr::select(-contains("V")) |> 
  mutate(date = ym(paste("2024", month)))
saveRDS(death_cause, "RData/top_mortality_causes.RDS")

  
