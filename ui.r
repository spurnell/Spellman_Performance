ui <- dashboardPage(skin = "red",
                    dashboardHeader(title = "The Spellman Score"),
                    dashboardSidebar(
                      sidebarMenu(
                        menuItem("Leaderboard", tabName = "leaderboard"),
                        menuItem("Player Profile", tabName = "playerprofile"),
                        menuItem("Metric Weighting", tabName = "weighting")
                      )
                    ),
                    dashboardBody(
                      tabItems(
                        tabItem("leaderboard",
                                fluidRow(
                                  box(
                                    width = 12,
                                    DT::DTOutput("main_table")
                                )
                                )),
                        tabItem("playerprofile",
                                box(
                                  width = 10,
                                  selectInput("players", "Select a player", choices = names, selected = "Nick Dunn", multiple = FALSE),
                                  textOutput("playertext"),
                                  DTOutput("player"),
                                  plotlyOutput("bar_plot")
                                ),
                                fluidRow(
                                  box(
                                    width = 12,
                                    status = "success",
                                    tags$h2("The following are analyses of your performance on each invidual metric")
                                  )
                                ),
                                  fluidRow(
                                    box(tags$h3("Maximal Force Output Evaluation:"),
                                              plotlyOutput("V1_Bar"),
                                           textOutput("FOstrengths")),
                                    box(
                                      tags$h3("Maximal Velocity Output Evaluation:"),
                                      plotlyOutput("V2_Bar"),
                                      textOutput("VOstrengths")
                                    )),
                                  fluidRow(
                                    box(tags$h3("Max Power Output Evaluation"),
                                        plotlyOutput("V3_Bar"),
                                        textOutput("PMaxstrengths")),
                                    box(tags$h3("Decrease in Horizontal Force Evaluation"),
                                        plotlyOutput("V4_Bar"),
                                        textOutput("DRFstrengths"))
                                  ),
                                fluidRow(
                                  box(tags$h3("Maximal Horizontal Force at Start Evaluation"),
                                      plotlyOutput("V5_Bar"),
                                      textOutput("RFMaxstrengths"))
                                )
                                ),
                        tabItem("weighting",
                                  box(
                                    width = 5,
                                    sliderInput("V1_Weighting",
                                                "FO Norm",
                                                min = .05,
                                                max = 1.0,
                                                value = 0.15, 
                                                step = 0.05),
                                    sliderInput("V2_Weighting",
                                                "VO",
                                                min = .05,
                                                max = 1.0,
                                                value = 0.20,
                                                step = .05),
                                    sliderInput("V3_Weighting",
                                                "PMax Norm",
                                                min = .05,
                                                max = 1.0,
                                                value = 0.30,
                                                step = .05),
                                    sliderInput("V4_Weighting",
                                                "DRF",
                                                min = .05,
                                                max = 1.0,
                                                value = 0.15,
                                                step = 0.05),
                                    sliderInput("V5_Weighting",
                                                "RFMax",
                                                min = .05,
                                                max = 1.0,
                                                value = 0.20,
                                                step = 0.05)
                                  ),
                                box(
                                  helpText("Caution! Your weights must equal to 100%"),
                                  textOutput("weight_100"),
                                  h5("Once you click the slider, you can use the arrows on your keyboard to adjust"),
                                  h5("You can filter the table by the boxes above the columns")
                                )
                                
                                )
                      )
                    )
                    )