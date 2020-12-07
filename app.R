
library(shiny)


ui <- fluidPage(

    # Application title
    titlePanel("Quantile Calculator"),

    # Sidebar with a slider input for x
    sidebarLayout(
        sidebarPanel(
            sliderInput("x",
                        "X:",
                        min = -5,
                        max = +5,
                        value = 0,
                        step = .1),
            h3("Documentation:"),
            "This App calculates the probability p(X>x) using Standard Normal 
            distribution, whereas X is controlled by the slider.
            You can see the position of X in the graph."
        ),

        # Show a plot of the SN-Distribution with a vertical line at x
        mainPanel(
           plotOutput("distPlot"),
           h3("Probability p(X > x):"),
           textOutput("CumulDist")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        p <- seq(-5, 5, .1)
        y <- dnorm(p)
        # draw the histogram with the specified number of bins
        plot(p, y, type = "l", xlab = "X", ylab = "Probability Density")
        abline(v = input$x, col = "red")
    })
    output$CumulDist <- renderText(pnorm(input$x))
}

# Run the application 
shinyApp(ui = ui, server = server)
