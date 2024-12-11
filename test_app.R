
library(future)
library(promises)
plan(multisession)
source("global.R")
options(future.rng.onMisuse = "ignore")

ui <- fillPage(
  includeCSS("styles.css"),
  includeCSS('landing_page.css'),
  includeCSS("nav.css"),
  includeCSS("menu.css"),
  useShinyjs(),
  tags$head(
    tags$link(rel = "icon", href = "moh_logo.png")
  ),
  tags$head(
    tags$title("Performance Review")
  ),
  
  tabsetPanel(
    id = "main-tabset",
    type = "pills",
    
    # 1. Landing page ---------------------------------------------------------
    tabPanel(
      "Home",
      div(
        id = "welcome-container",
        div(
          id = "header",
          h2(style = "font-size: 3em;color: #003366;text-align:center", 'Monitoring and Evaluation Perfomance Review'),
          
          img(
            src = "moh_log3.png",
            alt = "Cema Image",
            style = "margin-top: 50px; display: block; margin-left: auto; margin-right: auto; height: 300px"
          ),
          h3(style = "font-size: 2em;color: #003366;text-align:center", 'MINISTRY OF HEALTH'),
          
          h1(typedjs::typedOutput("title"), class = "header shadow-dark", style = "text-align: center;"),
          
          p( HTML("This dashboard contains the analysis of "),
             style = "color: black; text-align: center;"
          ),
          div(
            style = "display: flex; justify-content: center; align-items: center;",
            actionButton(
              inputId = "get_started",
              label = "Get started",
              class = "welcome-button"
            )
          )
        )
      ),
      # Footer
      div(
        style = "display: flex; 
            justify-content: space-between; 
            align-items: center; 
            background-color: #003366; 
            padding: 10px 20px; 
            color: #fe760d; 
            width: 100%; 
            position: fixed; 
            bottom: 0; 
            left: 0;",
        
        # Left Section (Text and Contact Info)
        div(
          style = "text-align: left;",
          "© 2024 Ministry of Health. All rights reserved.",
          tags$p(
            "Contact us: ",
            tags$a(
              href = "mailto:info@cema.africa", 
              "info@cema.africa",
              style = "color: #fe760d; text-decoration: none;"
            ),
            socialButton(
              href = "https://www.linkedin.com/company/center-for-epidemiological-modelling-and-analysis-cema-africa/posts/?feedView=all",
              icon = icon("linkedin")
            ),
            socialButton(
              href = "https://x.com/CEMA_Africa",
              icon = icon("x")
            )
            
          )
        ),
        
        # Right Section (Logo)
        img(
          src = "cema_logo2.png",
          alt = "Cema Image",
          style = "height: 100px;"
        )
      )
      
      
    ),
    
    
    # Overall health status ---------------------------------------------------
    tabPanel("Overall health status"),
    
    # 2.0 Indicators for quartely performance review --------------------------
    
    navbarMenu(title =  "Indicators for quartely performance review",
               
               ## 2.1 General health status -----------------------------------------------
               
               tabPanel("General health status",
                        dashboardPage(
                          dashboardHeader(title = "Indicators"),
                          dashboardSidebar(width = "200px", 
                                           sidebarMenu(
                                             menuItem("Overall health status", tabName = "ohs", selected = T, startExpanded = T),
                                             menuItem("Overall progress towards UHC", tabName = "uhc"),
                                             menuItem("Underlying causes of death",  tabName = "death"),
                                             menuItem("Morbidity patterns of disease burden", tabName = "disease burden")
                                           )
                                           
                          ),
                          dashboardBody(
                            tabItems(
                              tabItem(
                                tabName = "ohs"
                              ),
                              tabItem(
                                tabName = "uhc"
                              ),
                              tabItem(
                                tabName = "death"
                              ),
                              tabItem(
                                tabName = "disease burden"
                              )
                            )
                          )
                        )
                        
               ),
               
               ## 2.2 Progress on priority projects -------------------------------------------
               
               tabPanel("Progress on priority projects"),
               
               ## 2.3 Progress on health outputs: Access, demand... --------
               
               tabPanel("Progress on health outputs: Access, demand, capacity and utilization"),
               
               ## 2.4 Progress on strategic objectives ------------------------------------
               
               tabPanel("Progress on strategic objectives")
    )
    
  )
) 


# Server ------------------------------------------------------------------

server <- \(input, output, session) {
  
  # 1. Landing page ---------------------------------------------------------
  
  
}

shinyApp(ui, server)
