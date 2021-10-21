#   ____________________________________________________________________________
#   Neighborhood Browser                                                    ####
# 
 neighborhoodDescription <- function() {
    tagList(
        div(class = "container",
            h1("Projects Browser", class = "title fit-h1"),
            p("First time dealing with massssive amounts of Financial Data!?,  Use Stanlytics FP&A Transformation Guidance to adress your Analysis & subsequently your Business goals."),
            
            p("At Stanlytics we analyze our financial data flows in deep at a transactional level to offer Automatic Reports,
               Dashboards & Interactive WebApps that intend to inspire our Decision Makers,
               we use Cutting Edge Technologies & our Business Experts Insights to create each deliverable with High Quality Standards."),
            
            p("We want to share with you a few of the Decision Intelligence Solutions we designed, Click at each subtitle to explore!"),
            
            p("Our Engine: Contribute to data democratization & financial literacy.")
            
        ),
        
        
        
        div(class="container",
            includeMarkdown("markd/projects.md"),
            #includeHTML("projects.Rhtml"),
            
            
            
            includeHTML("footer2.html"),
        
            
            
            
            
            # fluidRow(
            #     column(7,
            #            sliderInput("topK","Show top k census tracts",
            #                        10, max(pred$rank), 50, 10, width = "100%"),
            #            leafletOutput("map", height = 600)
            #            ),
            #     hidden(column(5, class = "hood-info", id = "reactiveOutput1",
            #            h1(textOutput("hood"), class = "heading"),
            #            htmlOutput("hoodInfo")
            #            ))
            # )
            # hidden(
            #     div(class = "kpi-group",
            #         fluidRow(style = "margin-top: 10px;",
            #                         id = "reactiveOutput2a",
            #                  column(3,
            #                         div(plotlyOutput("donut", height = "100%"), align = "center"),
            #                         h3("Intelligentsia Score", class = "kpi-name")
            #                  ),
            #                  column(3,
            #                         h2(textOutput("kpi1"), class = "kpi"),
            #                         h3("Median Home Value", class = "kpi-name")
            #                  ),
            #                  column(3,
            #                         h2(textOutput("kpi2"), class = "kpi"),
            #                         h3("Median Housing Cost", class = "kpi-name")
            #                  ),
            #                  column(3,
            #                         h2(textOutput("kpi3"), class = "kpi"),
            #                         h3("Year built (median)", class = "kpi-name")
            #                  )
            #         )
#                     fluidRow(id = "reactiveOutput2b",
#                              column(3,
#                                     h2(textOutput("kpi4"), class = "kpi"),
#                                     HTML("<h3 class='kpi-name'>Avg. Yelp Rating<sup>1</sup></h3>")
#                              ),
#                              column(3,
#                                     h2(textOutput("kpi5"), class = "kpi"),
#                                     HTML("<h3 class='kpi-name'>Walkability Index<sup>2</sup></h3>")
#                              ),
#                              column(3,
#                                     h2(textOutput("kpi6"), class = "kpi"),
#                                     HTML("<h3 class='kpi-name'># of Trees<sup>3</sup></h3>")
#                              ),
#                              column(3,
#                                     h2(textOutput("kpi7"), class = "kpi"),
#                                     HTML("<h3 class='kpi-name'>% Share of Taxicab Rides at Night<sup>4</sup></h3>")
#                              )
#                     ),
#                     fluidRow(id = "reactiveOutput2c",
#                              column(3,
#                                     h2(textOutput("kpi8"), class = "kpi"),
#                                     h3("% College Education", class = "kpi-name")
#                              ),
#                              column(3,
#                                     h2(textOutput("kpi9"), class = "kpi"),
#                                     h3("Median Age", class = "kpi-name")
#                              ),
#                              column(3,
#                                     h2(textOutput("kpi10"), class = "kpi"),
#                                     h3("% Family Households", class = "kpi-name")
#                              ),
#                              column(3,
#                                     h2(textOutput("kpi11"), class = "kpi"),
#                                     h3("% Crime", class = "kpi-name")
#                              )
#                     ),
#                     fluidRow(column(12,tags$small("Sources: U.S. Census Bureau, 1. Yelp, 2. BEH, 3. NYC Open Data, 4. NYC TLC")))
#                 ),
#                 hr(),
#                 fluidRow(id = "reactiveOutput3",
#                     column(12,
#                            h2("Development of real estate prices"),
#                            div(plotlyOutput("zillow1", width = "100%"), align = "center", 
#                                class = "chart", width = "100%")
#                            )
#                 ),
#                 hr(),
#                 fluidRow(id = "reactiveOutput4",
#                          column(12,
#                                 h2("Yelp reviews over time"),
#                                 div(plotlyOutput("yelp", height = "420px"), align = "center",
#                                     class = "chart")
#                                 )
#                 ),
#                 hr(),
#                 fluidRow(id = "reactiveOutput4a1",
#                          column(12,h2("Online Activities"))),
#                 fluidRow(id = "reactiveOutput4a",
#                          column(6,
#                                 h3("Google Search Trends"),
#                                 div(plotlyOutput("google"), align = "center",
#                                     class = "chart")
#                                 ),
#                          column(6,
#                                 h3("Wikipedia Edits"),
#                                 div(plotlyOutput("wiki"), align = "center",
#                                     class = "chart")
#                          )
#                 ),
#                 hr(),
#                 fluidRow(id = "reactiveOutput5",
#                          column(12,
#                                 h2("Taxi trips over time"),
#                                 div(plotlyOutput("taxi"), align = "center", 
#                                     class = "chart")
#                                 )
#                 ),
#                 hr(),
#                 fluidRow(id = "reactiveOutput6",
#                          column(12,
#                                 h2("Properties currently for sale on Zillow"),
#                                 div(htmlOutput("propertiesForSale"),
#                                     class = "property-card-container"))
#                          )
#             )
         )
     )
 }
# 
# 
# #   ____________________________________________________________________________
# #   Legend                                                 ####
# 
legend <- "<div class='legend-custom'>
               <div class='legend-group'>
                   <div class='legend-element-label' color='location'></div>
                   <div class='legend-element-name'>Property</div>
               </div>
               <div class='legend-group'>
                   <div class='legend-element-label' color='yelp'></div>
                   <div class='legend-element-name'>Yelp</div>
               </div>
               <div class='legend-group'>
                   <div class='legend-element-label' color='schools'></div>
                   <div class='legend-element-name'>Schools</div>
               </div>
           </div>"


