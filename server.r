server <- (function(input, output) {
  
  #Creates SSAT Score and binds to original for datatable output
  data <-  reactive({
    x1 <- scale(df[,2], center = TRUE, scale = TRUE) * input$V1_Weighting
    x2 <- scale(df[,3], center = TRUE, scale = TRUE) * input$V2_Weighting
    x3 <- scale(df[,4], center = TRUE, scale = TRUE) * input$V3_Weighting
    x4 <- scale(df[,5], center = TRUE, scale = TRUE) * input$V4_Weighting
    x5 <- scale(df[,6], center = TRUE, scale = TRUE) * input$V5_Weighting
    df <- mutate(df, "Spellman Score" = ( rescale((x1 + x2 + x3 + x4 + x5), to = c(0,100)))) 
    
  })
  
  data_c <-  reactive({
    x1 <- scale(df_c[,2], center = TRUE, scale = TRUE) * input$V1_Weighting
    x2 <- scale(df_c[,3], center = TRUE, scale = TRUE) * input$V2_Weighting
    x3 <- scale(df_c[,4], center = TRUE, scale = TRUE) * input$V3_Weighting
    x4 <- scale(df_c[,5], center = TRUE, scale = TRUE) * input$V4_Weighting
    x5 <- scale(df_c[,6], center = TRUE, scale = TRUE) * input$V5_Weighting
    df <- mutate(df_c, "Spellman Score" = ( rescale((x1 + x2 + x3 + x4 + x5), to = c(0,100)))) 
    
  })
  
  
api_data <-  reactive({
  api_data <- data() %>% 
    select("Full Name", "Spellman Score")
  
}) 

saveData <- function({
  
  sheet <- gs_titl
  
})
    
  
  #Render 100% text
  output$weight_100 <-  reactive({
    Total <- (input$V1_Weighting + input$V2_Weighting + input$V3_Weighting + input$V4_Weighting + input$V5_Weighting)
    paste("Your Current Total =", formattable::percent(Total))
  })
  
  
  #Rendering Main DataTable Leaderboard
  output$main_table <- DT::renderDT({ 
    DT::datatable(data = data(),
                  extensions = c('FixedColumns', 'FixedHeader', 'Buttons'),
                  rownames = FALSE,
                  filter = "top",
                  options = list(
                    dom = 'Bfrtip',
                    scrollY = TRUE,
                    scrollX = TRUE,
                    fixedColumns = TRUE,
                    fixedHeader = TRUE,
                    buttons = c("copy", "csv", "excel")
                  )
    ) %>% 
      formatRound("Spellman Score", 3)
  })
  

# ***BUG HERE **** Cannot find way to display reactive score against calculation 
# Filter datatable adn gather(transpose) by playername for strengths/weaknesses
  # start: add "| Performance Standard to access"
  player_p <- reactive({
    df_p %>% 
      filter(`Full Name` == as.character(input$players)) %>% 
      t()
      
  })  
  
  #Renderdatatable of playerprofile
  output$player <- DT::renderDT({
    DT::datatable(player_p(),
                  rownames = FALSE,
                  options = list(
                    dom = 't',
                    lengthChange = FALSE
                  )) 
  })
  
  
#Main Spellman Score Barchart data frame
bar_data_main <-  reactive({
  data_c() %>% filter(`Full Name` == as.character(input$players) | `Full Name` == "Performance Standard") %>% 
    select(c("Full Name","Spellman Score"))
    
})  

#Series of dataframes to make bar charts for progress page - These report raw z score (not adjusted)
bar1 <- reactive({
  z_scores <-  as.data.frame(scale(df_c[2:6], center = TRUE, scale = TRUE)) 
  with_z  <- cbind(df_c, z_scores)
  newnames <- c("Full Name", 
                "Maximal Force Output",
                "Maximal Velocity Output",
                "Max Power Output", 
                "Decrease in Horizontal Force",
                "Maximal Horizontal Force at Start",
                "Maximal Force Z Score", 
                "Maximal Velocity Output Z Score",
                "Max Power Z Score", 
                "Decrease in Horizontal Force Z Score", 
                "Horizontal Force at Start Z Score")
  names(with_z) <- newnames  
  with_z <- with_z %>% 
    filter(`Full Name` == as.character(input$players)  | `Full Name` == "Performance Standard") %>% 
    dplyr::select(c("Full Name", "Maximal Force Z Score"))
})
  

#bar2
bar2 <- reactive({
  z_scores <-  as.data.frame(scale(df_c[2:6], center = TRUE, scale = TRUE)) 
  with_z  <- cbind(df_c, z_scores)
  newnames <- c("Full Name", 
                "Maximal Force Output",
                "Maximal Velocity Output",
                "Max Power Output", 
                "Decrease in Horizontal Force",
                "Maximal Horizontal Force at Start",
                "Maximal Force Z Score", 
                "Maximal Velocity Output Z Score",
                "Max Power Z Score", 
                "Decrease in Horizontal Force Z Score", 
                "Horizontal Force at Start Z Score")
  names(with_z) <- newnames  
  with_z <- with_z %>% 
    filter(`Full Name` == as.character(input$players)  | `Full Name` == "Performance Standard") %>% 
    dplyr::select(c("Full Name", "Maximal Velocity Output Z Score"))
})

#bar3
bar3 <- reactive({
  z_scores <-  as.data.frame(scale(df_c[2:6], center = TRUE, scale = TRUE)) 
  with_z  <- cbind(df_c, z_scores)
  newnames <- c("Full Name", 
                "Maximal Force Output",
                "Maximal Velocity Output",
                "Max Power Output", 
                "Decrease in Horizont Force",
                "Maximal Horizontal Force at Start",
                "Maximal Force Z Score", 
                "Maximal Velocity Output Z Score",
                "Max Power Z Score", 
                "Decrease in Horizontal Force Z Score", 
                "Horizontal Force at Start Z Score")
  names(with_z) <- newnames  
  with_z <- with_z %>% 
    filter(`Full Name` == as.character(input$players)  | `Full Name` == "Performance Standard") %>% 
    dplyr::select(c("Full Name", "Max Power Z Score"))
})

#bar4
bar4 <- reactive({
  z_scores <-  as.data.frame(scale(df_c[2:6], center = TRUE, scale = TRUE)) 
  with_z  <- cbind(df_c, z_scores)
  newnames <- c("Full Name", 
                "Maximal Force Output",
                "Maximal Velocity Output",
                "Max Power Output", 
                "Decrease in Horizont Force",
                "Maximal Horizontal Force at Start",
                "Maximal Force Z Score", 
                "Maximal Velocity Output Z Score",
                "Max Power Z Score", 
                "Decrease in Horizontal Force Z Score", 
                "Horizontal Force at Start Z Score")
  names(with_z) <- newnames  
  with_z <- with_z %>% 
    filter(`Full Name` == as.character(input$players)  | `Full Name` == "Performance Standard") %>% 
    dplyr::select(c("Full Name", "Decrease in Horizontal Force Z Score"))
})

#bar5
bar5 <- reactive({
  z_scores <-  as.data.frame(scale(df_c[2:6], center = TRUE, scale = TRUE)) 
  with_z  <- cbind(df_c, z_scores)
  newnames <- c("Full Name", 
                "Maximal Force Output",
                "Maximal Velocity Output",
                "Max Power Output", 
                "Decrease in Horizont Force",
                "Maximal Horizontal Force at Start",
                "Maximal Force Z Score", 
                "Maximal Velocity Output Z Score",
                "Max Power Z Score", 
                "Decrease in Horizontal Speed Z Score", 
                "Horizontal Force at Start Z Score")
  names(with_z) <- newnames  
  with_z <- with_z %>% 
    filter(`Full Name` == as.character(input$players)  | `Full Name` == "Performance Standard") %>% 
    dplyr::select(c("Full Name", "Horizontal Force at Start Z Score"))
})

#Main BarChart Output
  output$bar_plot <- renderPlotly({
    
    p <- bar_data_main() %>% 
      ggplot(aes(x=`Full Name`, y = `Spellman Score`, fill=`Full Name`)) +
      geom_bar(stat = "identity",
               show.legend = FALSE) +
      scale_fill_manual(values = c("Black", "Red")) +
      theme_minimal() +
      theme(legend.position = "none",
            axis.title.x = element_blank( ))
    
      fig <- ggplotly(p)
      fig
  })
  
  
#Series of chartoutputs for individual analyses 
output$V1_Bar <- renderPlotly({
  p <- bar1() %>% 
    ggplot(aes(x=`Full Name`, y = `Maximal Force Z Score`, fill=`Full Name`)) +
    geom_bar(stat = "identity",
             show.legend = FALSE) +
    theme_minimal() +
    scale_fill_manual(values = c("Black", "Red")) +
    theme(legend.position = "none",
          axis.title.x = element_blank())
  
  
  fig <- ggplotly(p)
  
  fig
  
})

#Bar2 chart
output$V2_Bar <- renderPlotly({
  p <- bar2() %>% 
    ggplot(aes(x=`Full Name`, y = `Maximal Velocity Output Z Score`, fill=`Full Name`)) +
    geom_bar(stat = "identity",
             show.legend = FALSE) +
    theme_minimal() +
    scale_fill_manual(values = c("Black", "Red")) +
    theme(legend.position = "none",
          axis.title.x = element_blank())
  
  
  fig <- ggplotly(p)
  
  fig
  
})

#Bar3 Chart
output$V3_Bar <- renderPlotly({
  p <- bar3() %>% 
    ggplot(aes(x=`Full Name`, y = `Max Power Z Score`, fill=`Full Name`)) +
    geom_bar(stat = "identity") +
    scale_fill_manual(values = c("Black", "Red")) +
    theme_minimal() +
    theme(legend.position = "none",
          axis.title.x = element_blank())
  
  fig <- ggplotly(p)
  
  fig
  
})

#Bar4 Chart
output$V4_Bar <- renderPlotly({
  p <- bar4() %>% 
    ggplot(aes(x=`Full Name`, y = `Decrease in Horizontal Force Z Score`, fill=`Full Name`)) +
    geom_bar(stat = "identity") +
    scale_fill_manual(values = c("Black", "Red")) +
    theme_minimal() +
    theme(legend.position = "none",
          axis.title.x = element_blank())
  
  fig <- ggplotly(p)
  
  fig
  
})

#Bar5 Chart
output$V5_Bar <- renderPlotly({
  p <- bar5() %>% 
    ggplot(aes(x=`Full Name`, y = `Horizontal Force at Start Z Score`, fill=`Full Name`)) +
    geom_bar(stat = "identity") +
    scale_fill_manual(values = c("Black", "Red")) +
    theme_minimal() +
    theme(legend.position = "none",
          axis.title.x = element_blank())
  
  fig <- ggplotly(p)
  
  fig
  
})

  
  #strengths reactive function  
  player_strengths <- reactive({
    z_scores <-  as.data.frame(scale(df[2:6], center = TRUE, scale = TRUE)) 
    with_z  <- cbind(df, z_scores)
    newnames <- c("Full Name", "FO norm", "VO", "Pmax", "DRF", "RFMax", "FO_norm_z", "VO_z", "Pmax_Norm_z", "DRF_z", "RFMax_z")
    names(with_z) <- newnames  
    with_z <- with_z %>% 
      filter(`Full Name` == input$players)  
  })
  
  #VO if 
  y <- reactive({
    if (player_strengths()[,"FO_norm_z"] > 0.75) 
      paste("Maximal Force Output Velocity is one of your strengths. Keep it up!")
    
    else {
      paste("Your Maximal Force Output could use some work. Here are some drills to improve it:")
    }
  
  })
  
  #FO if 
  y1 <- reactive({
    if (player_strengths()[,"VO_z"] > 0.75) 
      paste("Maximal Velocity Output is one of your strengths. Keep it up!")
    
    else {
      paste("Your Maxiaml Velocity Output could use some work. Here are some drills to improve it:")
    }
  })
  
  #Pmax if
  y2 <- reactive({
    if (player_strengths()[,"Pmax_Norm_z"] > 0.75) 
      paste("Congrats!!!! Your Max Power Output is one of your strengths. Keep it up!")
    
    else {
      paste("Your Max Power Output could use some work. Here are some drills to improve it:")
      
    }
  })
  
  #DRF if
  y3 <- reactive({
    if (player_strengths()[,"DRF_z"] > 0.75) 
      paste("Decrease in Horizontal Force is one of your strengths. Keep it up!")
    
    else {
      paste("Your Decrease in Horizontal Force could use some work. Here are some drills to improve it:")
    }
  })
  
  #RFmax if 
  y4 <- reactive({
    if (player_strengths()[,"RFMax_z"] > 0.75) 
      paste("Maximal Horizontal Force at Start is one of your strengths. Keep it up!")
    
    else {
      paste("Your Maximal Horizontal Force at Start could use some work. Here are some drills to improve it:")
    }
  })
  
  #output of strengths  - FO
  output$FOstrengths <- renderText({
    y() 
  })
    
  #VO output 
  output$VOstrengths <- renderText({
    y1()
  })
  
  #Pmax Output
  output$PMaxstrengths <- renderText({
    y2()
  })
  
  #DRF output 
  output$DRFstrengths <- renderText({
    y3()
  })
  
  #RFMax output
  output$RFMaxstrengths <- renderText({
    y4()
  })
  
})
