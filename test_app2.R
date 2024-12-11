gsUI <- \(id) {
  ns <- NS(id)
  accordion(
    open = F,
    accordion_panel(
      "Overall health status (Click to view)",
      div(id = "intro",
          page_fluid(
            layout_columns(!!!vbs,
                           col_widths = 3
            )
            
          ))
    ),
    accordion_panel(
      title = "Overall progress towards UHC (Click to view)",
      div(id = "intro",
          page_fluid(
            layout_columns(!!!vbs_uhc,
                           col_widths = 3
            )
            
          ))
    ),
    accordion_panel(
      title = "Access to health services (Click to view)",
      div(id = "intro",
          page_fluid(
            layout_columns(!!!vbs_access,
                           col_widths = 3
            )
            
          ))
      
    ),
    accordion_panel(
      title = "Underlying causes of death (Click to view)",
      navset_tab(
        nav_panel("First",
                  layout_columns(
                    card(
                      card_title(
                        style = "text-align: center;",
                        border_radius = "none",
                        "Under five years"
                      ),
                      pickerInput(
                        inputId = ns("cause"),
                        label = "Select the cause of death",
                        choices = c(
                          "Pneumonia, organism unspecified",
                          "Preterm newborn, unspecified",
                          "Severe birth asphyxia",
                          "Sepsis of fetus or newborn",
                          "Birth asphyxia, unspecified",
                          "Neonatal aspiration of meconium",
                          "Gastroenteritis or colitis without specification of origin",
                          "Infectious meningitis, unspecified",
                          "Other specified pneumonia",
                          "Respiratory distress syndrome of newborn, unspecified",
                          "Severe acute malnutrition in infants, children or adolescents",
                          "Infectious gastroenteritis or colitis without specification of infectious agent",
                          "Anaemias or other erythrocyte disorders, unspecified",
                          "Sepsis with septic shock"
                        ),           
                        options = pickerOptions(container = "body",liveSearch = TRUE),
                        width = "70%",
                        selected = "Pneumonia, organism unspecified",
                        multiple = T
                      ),
                      highchartOutput(ns("under_five"))
                    ),
                    card(
                      card_title(
                        style = "text-align: center;",
                        border_radius = "none",
                        "Over five years"
                      ),
                      pickerInput(
                        inputId = ns("cause2"),
                        label = "Select the cause of death",
                        choices = c(
                          "Essential hypertension, unspecified",
                          "Pneumonia, organism unspecified",
                          "Human immunodeficiency virus disease without mention of associated disease or condition, clinical stage unspecified",
                          "Respiratory tuberculosis, without mention of bacteriological or histological confirmation",
                          "Anaemias or other erythrocyte disorders, unspecified",
                          "Diabetes mellitus, type unspecified",
                          "Stroke not known if ischaemic or haemorrhagic",
                          "Congestive heart failure",
                          "Heart failure, unspecified",
                          "Chronic kidney disease, stage unspecified",
                          "Acute kidney failure, stage unspecified",
                          "Sepsis with septic shock",
                          "Chronic obstructive pulmonary disease, unspecified",
                          "Sepsis without septic shock",
                          "Bacteraemia",
                          "Unintentional land transport traffic event injuring a user of unspecified land transport",
                          "Cardiopulmonary arrest",
                          "Injuries to the head, unspecified"
                        ),            
                        options = pickerOptions(container = "body",liveSearch = TRUE),
                        width = "70%",
                        selected = "Essential hypertension, unspecified",
                        multiple = T
                      ),
                      
                      highchartOutput(ns("over_five"))
                      
                    )
                  )),
        nav_panel("second")
      )),
    accordion_panel(
      title = "Morbidity patterns of disease burden (Click to view)",
      layout_columns(
        card(
          card_title(
            style = "text-align: center;",
            border_radius = "none",
            "Under five years"
          ),
          pickerInput(
            inputId = ns("morb_cause"),
            label = "Select the cause of morbidity",
            choices = c(
              "Pneumonia, organism unspecified",
              "Sepsis of fetus or newborn",
              "Malaria due to Plasmodium falciparum, unspecified",
              "Preterm newborn, unspecified",
              "Gastroenteritis or colitis without specification of origin",
              "Neonatal hyperbilirubinaemia, unspecified",
              "Febrile seizures, unspecified",
              "Birth asphyxia, unspecified",
              "Infectious gastroenteritis or colitis without specification of infectious agent",
              "Neonatal aspiration of meconium",
              "Bacteraemia",
              "Acute tonsillitis, unspecified"
            ),     
            options = pickerOptions(container = "body",liveSearch = TRUE),
            width = "70%",
            selected = "Pneumonia, organism unspecified",
            multiple = T
          ),
          highchartOutput(ns("morb_under_five"))
        ),
        card(
          card_title(
            style = "text-align: center;",
            border_radius = "none",
            "Over five years"
          ),
          pickerInput(
            inputId = ns("morb_cause2"),
            label = "Select the cause of morbidity",
            choices = c(
              "Spontaneous vertex delivery",
              "Delivery by emergency caesarean section",
              "Pneumonia, organism unspecified",
              "Single spontaneous delivery, unspecified",
              "Malaria due to Plasmodium falciparum, unspecified",
              "Anaemias or other erythrocyte disorders, unspecified",
              "Delivery by elective caesarean section",
              "Single delivery by caesarean section, unspecified",
              "Unspecified abortion, incomplete, without complication",
              "Essential hypertension, unspecified"
            ),        
            options = pickerOptions(container = "body",liveSearch = TRUE),
            width = "70%",
            selected = "Spontaneous vertex delivery",
            multiple = T
          ),
          
          highchartOutput(ns("morb_over_five"))
          
        )
      )
      
      
    )
    
  )
  
}

gsServer <- \(id) {
  moduleServer(id, \(input, output, session){
    
    # Under five-mortality --------------------------------------------------------------
    
    output$under_five <- renderHighchart({
      
      df <- readRDS("RData/top_mortality_causes.RDS")  |>
        dplyr::filter(`Cause Mortality` %in% input$cause) |>
        dplyr::filter(type == "Under 5 years")
      
      df |> 
        hchart(
          hcaes(
            x = date,
            y = Numbers,
            group = `Cause Mortality`
          ),
          type = "spline"
        ) |> 
        hc_tooltip(
          shared = TRUE, # Enable shared tooltip
          crosshairs = TRUE, # Show vertical line when hovering
          formatter = JS("function() {
              const date = new Date(this.x);
              const options = { year: 'numeric', month: 'long' };
              const formattedDate = date.toLocaleDateString('en-US', options);
              let tooltip = '<b>' + formattedDate + '</b><br/>';
              this.points.forEach(function(point) {
                tooltip += '<span style=\"color:' + point.color + '\">●</span> ' +
                  point.series.name + ': <b>' + point.y.toLocaleString() + '</b><br/>';
              });
              return tooltip;
            }")
        ) |> 
        hc_xAxis(
          crosshair = TRUE, # Add crosshair for the x-axis
          labels = list(
            style = list(
              color = "black",
              font = "Arial"
            )
          ),
          title = list(
            text = "Date",
            style = list(
              color = "black",
              font = "Arial"
            )
          )
        ) |> 
        hc_yAxis(
          labels = list(
            style = list(
              color = "black",
              font = "Arial"
            )
          ),
          title = list(
            text = "Number of deaths",
            style = list(
              color = "black",
              font = "Arial"
            )
          )
        ) |> 
        hc_add_theme(
          hc_theme_google()
        )
      
    }) |> bindCache(input$cause, cache = "app")
    
    # over five-mortality --------------------------------------------------------------
    
    output$over_five <- renderHighchart({
      
      df <- readRDS("RData/top_mortality_causes.RDS") |>
        dplyr::filter(
          `Cause Mortality` %in% input$cause2,
          type == "Over 5 years"
        )
      
      df |> 
        hchart(
          hcaes(
            x = date,
            y = Numbers,
            group = `Cause Mortality`
          ),
          type = "spline"
        ) |> 
        hc_tooltip(
          shared = TRUE, # Enable shared tooltip
          crosshairs = TRUE, # Show vertical line when hovering
          formatter = JS("function() {
              const date = new Date(this.x);
              const options = { year: 'numeric', month: 'long' };
              const formattedDate = date.toLocaleDateString('en-US', options);
              let tooltip = '<b>' + formattedDate + '</b><br/>';
              this.points.forEach(function(point) {
                tooltip += '<span style=\"color:' + point.color + '\">●</span> ' +
                  point.series.name + ': <b>' + point.y.toLocaleString() + '</b><br/>';
              });
              return tooltip;
            }")
        ) |> 
        hc_xAxis(
          crosshair = TRUE, # Add crosshair for the x-axis
          labels = list(
            style = list(
              color = "black",
              font = "Arial"
            )
          ),
          title = list(
            text = "Date",
            style = list(
              color = "black",
              font = "Arial"
            )
          )
        ) |> 
        hc_yAxis(
          labels = list(
            style = list(
              color = "black",
              font = "Arial"
            )
          ),
          title = list(
            text = "Number of deaths",
            style = list(
              color = "black",
              font = "Arial"
            )
          )
        ) |> 
        hc_add_theme(
          hc_theme_google()
        )
      
    }) |> bindCache(input$cause2, cache = "app")   
    
    # Under five-morbidity --------------------------------------------------------------
    
    output$morb_under_five <- renderHighchart({
      
      df <- readRDS("RData/top_morbidity_causes.RDS")  |>
        dplyr::filter(`Cause of Morbidity` %in% input$morb_cause) |>
        dplyr::filter(type == "Under 5 years")
      
      df |> 
        hchart(
          hcaes(
            x = date,
            y = Numbers,
            group = `Cause of Morbidity`
          ),
          type = "spline"
        ) |> 
        hc_tooltip(
          shared = TRUE, # Enable shared tooltip
          crosshairs = TRUE, # Show vertical line when hovering
          formatter = JS("function() {
              const date = new Date(this.x);
              const options = { year: 'numeric', month: 'long' };
              const formattedDate = date.toLocaleDateString('en-US', options);
              let tooltip = '<b>' + formattedDate + '</b><br/>';
              this.points.forEach(function(point) {
                tooltip += '<span style=\"color:' + point.color + '\">●</span> ' +
                  point.series.name + ': <b>' + point.y.toLocaleString() + '</b><br/>';
              });
              return tooltip;
            }")
        ) |> 
        hc_xAxis(
          crosshair = TRUE, # Add crosshair for the x-axis
          labels = list(
            style = list(
              color = "black",
              font = "Arial"
            )
          ),
          title = list(
            text = "Date",
            style = list(
              color = "black",
              font = "Arial"
            )
          )
        ) |> 
        hc_yAxis(
          labels = list(
            style = list(
              color = "black",
              font = "Arial"
            )
          ),
          title = list(
            text = "Number of morbidities",
            style = list(
              color = "black",
              font = "Arial"
            )
          )
        ) |> 
        hc_add_theme(
          hc_theme_google()
        )
      
    }) |> bindCache(input$morb_cause, cache = "app")
    
    # over five-morbidity --------------------------------------------------------------
    
    output$morb_over_five <- renderHighchart({
      
      df <- readRDS("RData/top_morbidity_causes.RDS") |>
        dplyr::filter(
          `Cause of Morbidity` %in% input$morb_cause2,
          type == "Over 5 years"
        )
      
      df |> 
        hchart(
          hcaes(
            x = date,
            y = Numbers,
            group = `Cause of Morbidity`
          ),
          type = "spline"
        ) |> 
        hc_tooltip(
          shared = TRUE, # Enable shared tooltip
          crosshairs = TRUE, # Show vertical line when hovering
          formatter = JS("function() {
              const date = new Date(this.x);
              const options = { year: 'numeric', month: 'long' };
              const formattedDate = date.toLocaleDateString('en-US', options);
              let tooltip = '<b>' + formattedDate + '</b><br/>';
              this.points.forEach(function(point) {
                tooltip += '<span style=\"color:' + point.color + '\">●</span> ' +
                  point.series.name + ': <b>' + point.y.toLocaleString() + '</b><br/>';
              });
              return tooltip;
            }")
        ) |> 
        hc_xAxis(
          crosshair = TRUE, # Add crosshair for the x-axis
          labels = list(
            style = list(
              color = "black",
              font = "Arial"
            )
          ),
          title = list(
            text = "Date",
            style = list(
              color = "black",
              font = "Arial"
            )
          )
        ) |> 
        hc_yAxis(
          labels = list(
            style = list(
              color = "black",
              font = "Arial"
            )
          ),
          title = list(
            text = "Number of morbidities",
            style = list(
              color = "black",
              font = "Arial"
            )
          )
        ) |> 
        hc_add_theme(
          hc_theme_google()
        )
      
    }) |> bindCache(input$morb_cause2, cache = "app")   
    
  })
}