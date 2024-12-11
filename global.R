
# Importing packages ------------------------------------------------------

pacman::p_load(
  highcharter,
  shiny,
  shinyjs,
  shinyWidgets,
  shinydashboard,
  bslib,
  shiny,
  bsicons,
  purrr
)

# Functions ---------------------------------------------------------------

useShinydashboard <- function() {
  if (!requireNamespace(package = "shinydashboard"))
    message("Package 'shinydashboard' is required to run this function")
  deps <- htmltools::findDependencies(shinydashboard::dashboardPage(
    header = shinydashboard::dashboardHeader(),
    sidebar = shinydashboard::dashboardSidebar(),
    body = shinydashboard::dashboardBody()
  ))
  htmltools::attachDependencies(tags$div(class = "main-sidebar", style = "display: none;"), value = deps)
}

# Importing data ----------------------------------------------------------

overall_health_status <- readRDS("RData/overall_health_status.RDS")
overall_progress_uhc <- readRDS("RData/overall_progress_uhc.RDS")
access_health_services <- readRDS("RData/access_health_services.RDS")

# Value boxes -------------------------------------------------------------

vbs <-  overall_health_status %>%
  collapse::fmutate(Indicator = factor(Indicator, levels = c(unique(.$Indicator)))) %>%
  split(.$Indicator) %>%
  imap(\(x, y) {
    value_box(
      title = y,
      value = ifelse(
        is.na(x$`Current status fy2023/24`),
        "Data not available yet",
        x$`Current status fy2023/24`
      ),
      showcase = x$icon,
      #theme = x$theme,
      style = x$style,
      p("Current status fy2023/24")
    )
  }) |>
  setNames(c(NULL))

vbs_uhc <-  overall_progress_uhc %>%
  collapse::fmutate(Indicator = factor(Indicator, levels = c(unique(.$Indicator)))) %>%
  split(.$Indicator) %>%
  imap(\(x, y) {
    value_box(
      title = y,
      value = ifelse(
        is.na(x$`Current status fy2023/24`),
        "Data not available yet",
        x$`Current status fy2023/24`
      ),
      showcase = x$icon,
      #theme = x$theme,
      style = x$style,
      p("Current status fy2023/24")
    )
  }) |>
  setNames(c(NULL))

vbs_access <-  access_health_services %>%
  collapse::fmutate(Indicator = factor(Indicator, levels = c(unique(.$Indicator)))) %>%
  split(.$Indicator) %>%
  imap(\(x, y) {
    value_box(
      title = y,
      value = ifelse(
        is.na(x$`Current status fy2023/24`),
        "Data not available yet",
        x$`Current status fy2023/24`
      ),
      showcase = x$icon,
      # theme = x$theme,
      style = x$style,
      p("Current status fy2023/24")
    )
  }) |>
  setNames(c(NULL))
