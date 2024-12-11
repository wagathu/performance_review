
library(future)
library(promises)
plan(multisession)
source("global.R")
shinyOptions(cache = cachem::cache_disk("./myapp-cache"))
useShinydashboard()
options(future.rng.onMisuse = "ignore")
ui <- page(
    useShinydashboard(),
    includeCSS("styles.css"),
    includeCSS('landing_page.css'),
    includeCSS("nav.css"),
    includeCSS("menu.css"),
    includeCSS("accordion.css"),
    useShinyjs(),
    tags$head(
        tags$link(rel = "icon", href = "moh_logo.png")
    ),
    tags$head(
        tags$title("Performance Review")
    ),

   navset_pill(
    id = "main-tabset",
# 1. Landing page ---------------------------------------------------------

nav_panel(
    "Home",
        div(
            
            id = "welcome-container",
            div(
                id = "header",
                h2(style = "font-size: 3em;color: black;text-align:center", 'Monitoring and Evaluation Perfomance Review'),
                
                img(
                    src = "moh_log3.png",
                    alt = "Cema Image",
                    style = "margin-top: 50px; display: block; margin-left: auto; margin-right: auto; height: 300px"
                ),
                h3(style = "font-size: 2em;color: black;text-align:center", 'MINISTRY OF HEALTH'),
                
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
            background-color: #fff; 
            padding: 10px 20px; 
            color: black; 
            width: 100%; 
            position: fixed; 
            border-top: 1px solid #27AAE1;          
            bottom: 0; 
            left: 0;",
        
        # Left Section (Text and Contact Info)
        div(
            style = "text-align: left; background-color: #fff;",
            "© 2024 Ministry of Health. All rights reserved.",
            tags$p(
                "Contact us: ",
                tags$a(
                    href = "mailto:info@cema.africa", 
                    "info@cema.africa",
                    style = "color: black; text-decoration: none;"
                ),
                shinydashboardPlus::socialButton(
                    href = "https://www.linkedin.com/company/center-for-epidemiological-modelling-and-analysis-cema-africa/posts/?feedView=all",
                    icon = icon("linkedin")
                ),
                shinydashboardPlus::socialButton(
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
    ),
    

),


# 2.0 General health status ---------------------------------------------------

tabPanel("General health status", 
          gsUI("gs")
          ), 

# 2.0 Indicators for quartely performance review --------------------------

nav_menu(title =  "Indicators",
         
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
    
    observeEvent(input$get_started, {
        updateTabsetPanel(session, "main-tabset", selected = "Overall health status")
    })
    
# General health status ---------------------------------------------------
    
    gsServer("gs")
    
}


shinyApp(ui, server)
