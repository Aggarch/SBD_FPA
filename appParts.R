#   ____________________________________________________________________________
#   Neighborhood Browser                                                    ####


 
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
        
            

         )
     )
 }

 
 
#    ____________________________________________________________________________
#   Legend                                                 ####
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


