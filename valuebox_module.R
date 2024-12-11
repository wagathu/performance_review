
valueBoxUI <- \(id){
  ns <- NS(id)
  div(
    id = "intro",
    fluidRow(
      column(4, shinydashboard::valueBoxOutput(ns("vb_1"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_2"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_3"), width = "100%")),
    ),
    hr(),
    fluidRow(
      column(4, shinydashboard::valueBoxOutput(ns("vb_4"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_5"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_6"), width = "100%"))
    ),
    hr(),
    fluidRow(
      column(4, shinydashboard::valueBoxOutput(ns("vb_7"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_8"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_9"), width = "100%"))
    ),
    hr(),
    fluidRow(
      column(4, shinydashboard::valueBoxOutput(ns("vb_10"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_11"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_12"), width = "100%"))
    ),
    fluidRow(
      column(4, shinydashboard::valueBoxOutput(ns("vb_13"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_14"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_15"), width = "100%")),
    ),
    hr(),
    fluidRow(
      column(4, shinydashboard::valueBoxOutput(ns("vb_16"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_17"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_18"), width = "100%"))
    ),
    hr(),
    fluidRow(
      column(4, shinydashboard::valueBoxOutput(ns("vb_19"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_20"), width = "100%")),
      column(4, shinydashboard::valueBoxOutput(ns("vb_21"), width = "100%"))
    ),
    hr(),
    fluidRow(
      column(4, shinydashboard::valueBoxOutput(ns("vb_22"), width = "100%"))
    )
  )
}

valueBoxServer <- \(id) {
  moduleServer(id, function(input, output, session) {
    overall_health_status <- readRDS("RData/overall_health_status.RDS")
    purrr::imap(
      unique(overall_health_status$Indicator),
      paste0("vbs_", seq_along(unique(overall_health_status$Indicator))),
      \(x, y){
        indicator = x
        outputID = y
        df <- overall_health_status |>  filter(indicator)
        output[[outputID]] <- shinydashboard::renderValueBox({
        valueBox(
          subtitle = indicator,
          value = ifelse(
            is.na(df$`Current status fy2023/24`),
            NA_real_,
            df$`Current status fy2023/24`
          ),
          icon = df$icon[[1]],       # Extract the icon
          color = df$color[[1]]      # Extract the color
        )
        })
      }
    )
  })
}