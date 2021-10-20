#   ____________________________________________________________________________
#   Server                                                                  ####

library(shiny)
library(rgdal)
library(leaflet)
library(sp)
library(plotly)
library(dplyr)
library(tidyr)
library(magrittr)
library(lubridate)
library(ggmap)
library(xts)
library(shinyjs)
library(jsonlite)
library(urltools)
library(utils)
library(rvest)
library(stringr)
library(rgeos)
library(xml2)
library(selectr)
library(raster)
library(purrr)
library(RColorBrewer)
library(DT)
library(shinyBS)


### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### Variables for testing                                                   ####

#CT <- 36047019500
#CT <- 36061010200
#input <- NULL
#input$addr <- "51 Kent Ave, Brooklyn, NY 11249"
#addr <- data.frame(lat = 40.7223311,
#                   lon = -73.9614495,
#                   GEOID = 36061010200)
#addrSearch <- "120 Willoughby Ave, Brooklyn"


### . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . ..
### Pretty-print function                                                   ####

# format_metric <- function(x, type) {
#     switch(type,
#            currency = paste0("$",
#                              formatC(round(as.numeric(x), 0),
#                                      big.mark = ",",
#                                      digits = nchar(as.character(round(as.numeric(x), 0)))
#                              )
#            ),
#            real = format(round(as.numeric(x), 1),
#                          nsmall = 1, big.mark = ","),
#            int = formatC(as.numeric(x), big.mark = ",",
#                          digits = nchar(as.character(x))),
#            year = round(as.numeric(x),0),
#            pct = paste0(format(round(as.numeric(x) * 100, 1),
#                                nsmall = 1, big.mark = ","),"%"))
# }
# 
 shinyServer(function(input, output) {
# 
# 
# ##  ............................................................................
# ##  Innovation Browser                                                      ####
# 
# ##  ............................................................................
# ##  Map chart                                                               ####
# 
#     GeoDFr <- reactive({
#         GeoDF[GeoDF$rank <= input$topK,]
#     })
# 
#     geoIDs <- reactive({
#         GeoDF <- GeoDF[GeoDF$rank <= input$topK,]
#         as.vector(GeoDF$GEOID)
#     })
# 
#     CTlabels <- reactive({
#         GeoDF <- GeoDF[GeoDF$rank <= input$topK,]
#         sprintf(
#             "<strong>CT: %s</strong><br/>Score: %g",
#             GeoDF$GEOID, round(GeoDF$bin_20*100),1) %>% lapply(htmltools::HTML)
#     })
# 
#     # ---------------------------
#     # create color scheme for map
#     bins <- c(seq(0,1,.2))
#     pal <- colorBin("YlOrRd", domain = rev(GeoDF$bin_20), bins = rev(bins))
# 
#     output$map <- renderLeaflet({
# 
#         leaflet(GeoDFr()) %>%
#             addProviderTiles(providers$CartoDB.Positron) %>%
#             setView(-73.885343, 40.720403, 11) %>%
#             addPolygons(layerId = geoIDs(),
#                         weight = 1, smoothFactor = 0.5,
#                         opacity = 1.0, fillOpacity = 0.8,
#                         color = NA,
#                         fillColor = ~pal(bin_20),
#                         highlightOptions = highlightOptions(
#                             color = "white", weight = 2,
#                             bringToFront = TRUE),
#                         label = CTlabels(),
#                         labelOptions = labelOptions(
#                             style = list("font-weight" = "normal",
#                                          padding = "3px 8px"),
#                             textsize = "15px",
#                             direction = "auto")) %>%
#             leaflet::addLegend(pal = pal,
#                       values = ~bin_20,
#                       opacity = 0.7,
#                       title = NULL,
#                       position = "bottomright")
#     })
# 
#     # --------------------------------------------------------
#     # observe click events in map and get neighborhood details
# 
#     geo <- eventReactive(input$map_shape_click, {
#         shinyjs::show("reactiveOutput6")
#         shinyjs::show("reactiveOutput5")
#         shinyjs::show("reactiveOutput4a1")
#         shinyjs::show("reactiveOutput4a")
#         shinyjs::show("reactiveOutput4")
#         shinyjs::show("reactiveOutput3")
#         shinyjs::show("reactiveOutput2a")
#         shinyjs::show("reactiveOutput2b")
#         shinyjs::show("reactiveOutput2c")
#         shinyjs::show("reactiveOutput1")
#         shinyjs::removeClass(class = "shinyjs-hide", selector = "hr")
#         shinyjs::removeClass(class = "shinyjs-hide", selector = ".kpi-group")
# 
#         click <- input$map_shape_click
#         print(click$id)
#         as.numeric(click$id)
#     })
# 
#     addrHood <- reactive({
# 
#         CT <- geo()
# 
#         CT <- CTshapes[CTshapes$GEOID == CT,]
#         CT <- gCentroid(CT)
# 
#         # ------------------------------------------------
#         # Set the projection of the SpatialPointsDataFrame
#         # using the projection of the shapefile
#         proj4string(CT) <- proj4string(hoods)
# 
#         o <- over(CT, hoods)
#         print(o)
#         o
#     })
# 
#     # -----------------
#     # neighborhood name
#     output$hood <- renderText({
#         hood <- addrHood()
#         hood$ntaname
#     })
# 
#     # -----------------
#     # neighborhood info
#     output$hoodInfo <- renderUI({
#         n <- addrHood()
# 
#         g <- paste0("https://www.google.com/search?aq=f&gcx=w&sourceid=chrome&ie=UTF-8&q=wiki+",
#                     n$ntaname, "+", str_replace_all(n$boro_name, "-", "+"), "&*") %>%
#             str_replace_all(" ", "+") %>%
#             URLdecode()
# 
#         print(g)
# 
#         ghtml <- read_html(g)
# 
#         # -----------------------------------------------
#         # get url to wikipedia article from google search
#         w <- ghtml %>% html_node(xpath = "//h3[@class='r']/a") %>%
#             html_attr("href") %>%
#             str_extract("http.+?(?=&)") %>%
#             URLdecode()
# 
#         print(w)
# 
#         whtml <- read_html(w)
# 
#         wtext <- whtml %>%
#             html_nodes(xpath = "//div[@id='mw-content-text']//p") %>%
#             html_text()
# 
#         wtext <- wtext[wtext != ""]
# 
#         wtext %<>% purrr::discard(function(x) substr(x,1,11) == "Coordinates")
# 
#         HTML(sprintf("<p>%s</p>", wtext[1:2])) %>%
#             paste0(
#                 HTML(sprintf("<small>Source: <a href='%s' target='_blank'>Wikipedia</a></small>", w)),
#                 collapse="") %>%
#             lapply(htmltools::HTML)
#     })
# 
#     # ------
#     # zillow
# 
#     output$zillow1 <- renderPlotly({
# 
#         p %>%
#             dplyr::filter(GEOID == geo()) %>%
#             plot_ly(x = ~date) %>%
#             add_lines(y = ~round(avg.z.sqft,2),
#                       line = list(shape = "linear", color = "#4fbfa8"),
#                       name = "Zestimate") %>%
#             layout(xaxis = list(title = "",
#                                 showgrid = FALSE,
#                                 ticks = "",
#                                 fixedrange = TRUE,
#                                 gridcolor = "#a0a0a0"),
#                    yaxis = list(title = "Average Zestimate per sqft",
#                                 fixedrange = TRUE, zeroline = TRUE,
#                                 rangemode = "tozero",
#                                 ticks = "", gridcolor = "#a0a0a0"),
#                    legend = list(x = .5, y = -.1, xanchor = "center",
#                                  orientation = "h"),
#                    annotations = list(text = "Source: Zillow", align = "left",
#                                       x = 0, y = -.15, showarrow = FALSE,
#                                       xref = "paper", yref = "paper"),
#                    margin = list(b = 50, pad = 3),
#                    font = list(family = "'Raleway', sans-serif"),
#                    paper_bgcolor = "rgba(1,1,1,0)",
#                    plot_bgcolor = "rgba(1,1,1,0)") %>%
#             config(displayModeBar = FALSE)
#     })
# 
#     # --------------------
#     # google search trends
# 
#     output$google <- renderPlotly({
# 
#         g %>%
#             dplyr::filter(shapeID == geo()) %>%
#             plot_ly(x = ~year) %>%
#             add_bars(y = ~round(queries,0),
#                      type = "bar", marker = list(color = "#436983"),
#                      name = "Google Searches") %>%
#             layout(xaxis = list(title = "",
#                                 showgrid = FALSE,
#                                 ticks = "",
#                                 fixedrange = TRUE,
#                                 gridcolor = "#a0a0a0"),
#                    yaxis = list(title = "Search volume",
#                                 fixedrange = TRUE, zeroline = TRUE,
#                                 rangemode = "tozero",
#                                 ticks = "", gridcolor = "#a0a0a0"),
#                    legend = list(x = .5, y = -.1, xanchor = "center",
#                                  orientation = "h"),
#                    annotations = list(text = "Source: Google", align = "left",
#                                       x = 0, y = -.15, showarrow = FALSE,
#                                       xref = "paper", yref = "paper"),
#                    margin = list(b = 50, pad = 3),
#                    font = list(family = "'Raleway', sans-serif"),
#                    paper_bgcolor = "rgba(1,1,1,0)",
#                    plot_bgcolor = "rgba(1,1,1,0)") %>%
#             config(displayModeBar = FALSE)
#     })
# 
#     # ---------------
#     # wikipedia edits
# 
#     output$wiki <- renderPlotly({
# 
#         w %>%
#             dplyr::filter(shapeID == geo()) %>%
#             plot_ly(x = ~year) %>%
#             add_bars(y = ~round(edits,0),
#                      type = "bar", marker = list(color = "#436983"),
#                      name = "Wikipedia Article Edits") %>%
#             layout(xaxis = list(title = "",
#                                 showgrid = FALSE,
#                                 ticks = "",
#                                 fixedrange = TRUE,
#                                 gridcolor = "#a0a0a0"),
#                    yaxis = list(title = "# of Article Edits",
#                                 fixedrange = TRUE, zeroline = TRUE,
#                                 rangemode = "tozero",
#                                 ticks = "", gridcolor = "#a0a0a0"),
#                    legend = list(x = .5, y = -.1, xanchor = "center",
#                                  orientation = "h"),
#                    annotations = list(text = "Source: Wikipedia", align = "left",
#                                       x = 0, y = -.15, showarrow = FALSE,
#                                       xref = "paper", yref = "paper"),
#                    margin = list(b = 50, pad = 3),
#                    font = list(family = "'Raleway', sans-serif"),
#                    paper_bgcolor = "rgba(1,1,1,0)",
#                    plot_bgcolor = "rgba(1,1,1,0)") %>%
#             config(displayModeBar = FALSE)
#     })
# 
#     # ----
#     # yelp
# 
#     output$yelp <- renderPlotly({
#         yelpByCT %>% dplyr::filter(GEOID == geo()) %>%
#             dplyr::arrange(date) %>%
#             plot_ly(x = ~date) %>%
#             add_lines(y = ~rollingReviews,
#                       line = list(shape = "linear", color = "#4fbfa8"),
#                       name = "Reviews") %>%
#             add_lines(y = ~round(avgRating,2), yaxis = "y2",
#                       line = list(shape = "linear", color = "#416983"),
#                       name = "Rating") %>%
#             layout(xaxis = list(title = "",
#                                 showgrid = FALSE,
#                                 ticks = "",
#                                 fixedrange = TRUE,
#                                 gridcolor = "#a0a0a0"),
#                    yaxis = list(title = "# of Yelp reviews",
#                                 fixedrange = TRUE, zeroline = TRUE,
#                                 ticks = "", gridcolor = "#a0a0a0",
#                                 rangemode = "tozero"),
#                    yaxis2 = list(title = "Avg. Rating", side = "right",
#                                  fixedrange = TRUE, zeroline = FALSE,
#                                  showgrid = TRUE, autorange = TRUE,
#                                  rangemode = "tozero", overlaying = "y"),
#                    legend = list(x = .5, y = -.1, xanchor = "center",
#                                  orientation = "h"),
#                    annotations = list(text = "Source: Yelp", align = "left",
#                                       x = 0, y = -.15, showarrow = FALSE,
#                                       xref = "paper", yref = "paper"),
#                    font = list(family = "'Raleway', sans-serif"),
#                    margin = list(r = 40, b = 30, pad = 3),
#                    paper_bgcolor = "rgba(1,1,1,0)",
#                    plot_bgcolor = "rgba(1,1,1,0)") %>%
#             config(displayModeBar = FALSE)
#     })
# 
#     # -----------------
#     # taxitrips
# 
#     output$taxi <- renderPlotly({
#         taxi %>% dplyr::filter(GEOID == geo()) %>%
#             dplyr::arrange(date) %>%
#             plot_ly(x = ~date) %>%
#             add_lines(y = ~rollingTrips,
#                       line = list(shape = "linear", color = "#4fbfa8"),
#                       name = "trips") %>%
#             layout(xaxis = list(title = "",
#                                 showgrid = FALSE,
#                                 ticks = "",
#                                 fixedrange = TRUE,
#                                 gridcolor = "#a0a0a0"),
#                    yaxis = list(title = "# of taxitrips",
#                                 fixedrange = TRUE, zeroline = TRUE,
#                                 ticks = "", gridcolor = "#a0a0a0",
#                                 rangemode = "tozero"),
#                    legend = list(x = .5, y = -.1, xanchor = "center",
#                                  orientation = "h"),
#                    annotations = list(text = "Source: NYC Taxi & Limousine Commission", align = "left",
#                                       x = 0, y = -.15, showarrow = FALSE,
#                                       xref = "paper", yref = "paper"),
#                    margin = list(b = 50, pad = 3),
#                    font = list(family = "'Raleway', sans-serif"),
#                    paper_bgcolor = "rgba(1,1,1,0)",
#                    plot_bgcolor = "rgba(1,1,1,0)") %>%
#             config(displayModeBar = FALSE)
#     })
# 
#     # -----------------
#     # donut chart
# 
#     output$donut <- renderPlotly({
# 
#         iScore <- round(pred[pred$ct == geo(),"bin_20"] * 100,0)
# 
#         color <- brewer.pal(9,"YlOrRd")[max(1,floor((iScore-1) / 10))]
# 
#         lw <- 0
# 
#         plot_ly(width = 80, height = 80,
#                 marker = list(colors = c(color, "rgba(0,0,0,0)"),
#                               line = list(width = lw, color = "#444"))) %>%
#             add_pie(values = c(iScore, 100 - iScore),
#                     hole = .7, sort = FALSE, direction = "clockwise",
#                     textposition = 'none') %>%
#             layout(font = list(family = "'Raleway', sans-serif"),
#                    autosize = TRUE,
#                    xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
#                    yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
#                    paper_bgcolor = "rgba(1,1,1,0)",
#                    plot_bgcolor = "rgba(1,1,1,0)",
#                    hovermode = FALSE,
#                    showlegend = FALSE,
#                    margin = list(l = 0, r = 0, t = 5, b = 0),
#                    annotations = list(text = paste0("<b>",iScore,"</b>"),
#                                       align = "center",
#                                       font = list(size = 28),
#                                       showarrow = FALSE)) %>%
#             config(displayModeBar = F)
#     })
# 
#     kpis <- reactive({
#         CT <- geo()
#         pred[pred$ct == CT,]
#     })
# 
# 
#     output$kpi1 <- renderText({
#         kpis <- kpis()
#         format_metric(kpis$MHV, "currency")
#     })
# 
#     output$kpi2 <- renderText({
#         kpis <- kpis()
#         format_metric(kpis$mhc, "currency")
#     })
# 
#     output$kpi3 <- renderText({
#         kpis <- kpis()
#         kpis$myb
#     })
# 
#     output$kpi4 <- renderText({
#         yelpByCT %>%
#             filter(GEOID == geo()) %>%
#             top_n(12, date) %>%
#             summarise(mean(avgRating)) %>%
#             round(1) %>%
#             format_metric("real")
#     })
# 
#     output$kpi5 <- renderText({
#         kpis <- kpis()
#         round(kpis$t10walk,1)
#     })
# 
#     output$kpi6 <- renderText({
#         kpis <- kpis()
#         format_metric(kpis$trees, "int")
#     })
# 
#     output$kpi7 <- renderText({
#         kpis <- kpis()
#         format_metric(kpis$taxi_share, "pct")
#     })
# 
#     output$kpi8 <- renderText({
#         kpis <- kpis()
#         format_metric(kpis$pct_all_coll, "pct")
#     })
# 
#     output$kpi9 <- renderText({
#         kpis <- kpis()
#         kpis$med_tage
#     })
# 
#     output$kpi10 <- renderText({
#         kpis <- kpis()
#         format_metric(kpis$pct_family, "pct")
#     })
# 
#     output$kpi11 <- renderText({
#         kpis <- kpis()
#         format_metric(kpis$pct_crime, "pct")
#     })
# 
#     observe({
#         kpis <- kpis()
#         if (kpis$pct_occup < 0) {
#             shinyjs::removeClass("kpi1", "pos-x")
#             shinyjs::addClass("kpi1", "neg-x")
#         } else {
#             shinyjs::removeClass("kpi1", "neg-x")
#             shinyjs::addClass("kpi1", "pos-x")
#         }
#     })
# 
#     # --------------------------
#     # get properties from zillow
# 
#     output$propertiesForSale <- renderUI({
# 
#         CT <- geo()
#         CT <- CTshapes[CTshapes$GEOID == CT,]
#         CT <- gCentroid(CT)
# 
#         # ------------------------------------------------
#         # Set the projection of the SpatialPointsDataFrame
#         # using the projection of the shapefile
#         proj4string(CT) <- proj4string(zillowHoods)
# 
#         o <- over(CT, zillowHoods)
# 
#         print(o)
# 
#         hood <- o$NAME
# 
# 
#         n <- paste0("https://www.zillow.com/homes/for_sale/", o$REGIONID, "_rid/")
# 
#         print(n)
# 
#         nhtml <- read_html(n)
# 
#         captions <- nhtml %>% html_nodes(xpath = "//ul[@class='photo-cards']//div[@class='zsg-photo-card-caption']/h4") %>%
#             html_text()
# 
#         if(length(captions) > 0) {
#             fc <- captions == "Pre-Foreclosure"
#             captions <- captions[!fc]
# 
#             # get URLs of properties
#             urls <- nhtml %>% html_nodes(xpath = "//ul[@class='photo-cards']/li//a[contains(@class,'zsg-photo-card-overlay-link routable')]") %>%
#                 html_attr("href")
#             urls <- urls[!fc]
# 
#             urls %<>% paste0("http://www.zillow.com", .)
# 
#             prices <- nhtml %>% html_nodes(xpath = "//ul[@class='photo-cards']//div[@class='zsg-photo-card-caption']//span[@class='zsg-photo-card-price']") %>%
#                 html_text()
#             prices <- prices[!fc]
# 
#             info <- nhtml %>% html_nodes(xpath = "//ul[@class='photo-cards']//div[@class='zsg-photo-card-caption']//span[@class='zsg-photo-card-info']") %>%
#                 html_text()
#             info <- info[!fc]
# 
#             imgs <- nhtml %>% html_nodes(xpath = "//ul[@class='photo-cards']//div[@class='zsg-photo-card-img']/img") %>%
#                 html_attr("src")
#             imgs <- imgs[!fc]
# 
#             properties <- tibble(captions, prices, info, imgs, urls)
# 
#             properties %<>% dplyr::filter(substr(imgs,1,4) != "data")
# 
#             propertiesForSale <- sprintf("<a href='%s' target='_blank'>
#                                          <figure>
#                                          <img src='%s' alt='property image'>
#                                          </figure>
#                                          <div class='property-info'>
#                                          <h4>%s</h4>
#                                          <p class='property-price'>%s</p>
#                                          <p class='property-details'>%s</p>
#                                          </div>
#                                          </a>",
#                                          properties$urls,
#                                          properties$imgs,
#                                          properties$captions,
#                                          properties$prices,
#                                          properties$info) %>% lapply(htmltools::HTML)
# 
#             return(propertiesForSale)
#         } else {
#             print("No Zillow results found.")
#             return(htmltools::HTML("<div class='text-center'>
#                                    <p>Unfortunately, we could not find any properties for you.</p>
#                                    <p>View properties in New York City directly on <a href='https://www.zillow.com/homes/for_sale/New-York-City_rb/' target='_blank'>Zillow</a>.</p>
#                                    </div>"))
#         }
#         })

    })
