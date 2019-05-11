#' ggshuffle
#'
#' \code{ggshuffle} is a RStudio-Addin that delivers a graphical interface for
#' detecting if you charts appearance change with plotting order..
#'
#' @details To run the addin, either highlight a ggplot2-object in your current
#'     script and select \code{ggshuffle} from the Addins-menu within RStudio,
#'     or run \code{ggshuffle(plot)} with a ggplot2 object as the parameter.
#' @param plot A ggplot2 plot object.
#' @examples
#' \dontrun{
#' # example for ggshuffle command line usage.
#' library(ggplot2)
#' gg <- ggplot(na.omit(txhousing), aes(volume, median, color = year)) +
#'   geom_point()
#'
#' ggshuffle(ddd)
#' }
#' @return Nothing.
#' @import miniUI
#' @importFrom shiny fillCol fillRow h3 selectInput plotOutput renderPlot
#' @importFrom shiny observeEvent stopApp dialogViewer runGadget
#' @name ggshuffle
#' @export
ggshuffle <- function(plot) {

  if (ggplot2::is.ggplot(plot)) {
    gg_original <- plot
  } else {
    gg_original <- try(eval(parse(text = plot)), silent = TRUE)
  }

  ui <- miniPage(
    gadgetTitleBar("Can you see a difference?", left = NULL),
    miniContentPanel(
      fillCol(flex = c(1, 3),
        fillRow(
          selectInput("select", label = h3("Select shuffle order"),
                       choices = shuffle_options(gg_original),
                       selected = "original"),
          selectInput("reversal", label = h3("Reverse order"),
                      choices = list(Yes = TRUE, No = FALSE),
                      selected = FALSE)
        ),
        fillRow(
          plotOutput("plot1"),
          plotOutput("plot2")
        )
      )
    )
  )

  server <- function(input, output, session) {
    output$plot1 <- renderPlot({
      gg_original
    })

    output$plot2 <- renderPlot({
      shuffle_ggplot(gg_original, input$select, input$reversal)
    })

    observeEvent(input$done, {
      invisible(stopApp())
    })
    observeEvent(input$cancel, {
      invisible(stopApp())
    })
  }


  viewer <- dialogViewer("ggshuffle", width = 1200)
  runGadget(ui, server, viewer = viewer)
}

ggshuffleAddin <- function() {
  # Get the document context.
  context <- rstudioapi::getActiveDocumentContext()

  # Set the default data to use based on the selection.
  text <- context$selection[[1]]$text

  if (nchar(text) == 0) {
    stop('Please highlight a ggplot2 plot before selecting this addin.')
  }

  ggshuffle(text)
}
