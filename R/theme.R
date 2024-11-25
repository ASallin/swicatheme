#' SWICA ggplot Theme and Palettes
#'
#' Provides ggplot themes and color palettes for SWICA
#' @import ggplot2
#' @import showtext
#' @import stringr
#' @import dplyr
#' @export


# Define the SWICA color palettes
# font_add("swica", "H:/SWICA_Fonts/Desktop/SWICA-Regular.otf")
# font_add("swica_bold", "H:/SWICA_Fonts/Desktop/SWICA-Bold.otf")
# showtext_auto()

# Check if the SWICA fonts are installed
check_swica_fonts <- function() {
  system_fonts <- systemfonts::system_fonts()

  swica_fonts <- dplyr::filter(system_fonts, stringr::str_detect(name, "SWICA"))

  if (nrow(swica_fonts) == 0) {
    warning("SWICA fonts are not installed on your system. Please install the SWICA-Regular and SWICA-Bold fonts.")
  } else {
    message("SWICA fonts are installed.")
  }
}


#' SWICA color palettes
#'
#' Provides ggplot themes and color palettes for SWICA
#' @import ggplot2
#' @export

# Define the SWICA color palettes
swica_colours <- list(
  swica_primaer = c(
    "#C0FAEA", "#01BBA8", "#00857C", "#06494A"
  ),
  swica_funktional = c("#042D2E", "#33E6BE", "#EEFFFA"),
  swica_sekundaer = c(
    "#CDEEFD", "#A4D8F5", "#7098BD", "#375B85",
    "#EDDCFF", "#D3BCE9", "#A28CB8", "#675682",
    "#F9D2C2", "#EEB392", "#B98B72", "#8E654E",
    "#F0ED90", "#D9D18A", "#B4AC91", "#8A8479"
  ),
  swica_discrete = c(
    "#01BBA8", "#C0FAEA", "#375B85", "#675682",
    "#8E654E", "#8A8479", "#06494A", "#00857C"
  ),
  swica_ampelfarben = c(
    "#CDEEFD", "#A4D8F5", "#1C77D2", "#145BA3",
    "#DCFDCD", "#D1F5A4", "#88BD70", "#4E8136",
    "#FDF0CD", "#F5DEA4", "#FFC023", "#AA5C00",
    "#FDCFCD", "#F5A8A4", "#E22920", "#B81B09"
  )
)


# Define the SWICA palettes function
swica_palettes <- function(name, n, all_palettes = swica_colours,
                           type = c("discrete", "continuous")) {
  palette <- all_palettes[[name]]
  if (missing(n)) {
    n <- length(palette)
  }
  type <- match.arg(type)
  out <- switch(type,
                continuous = grDevices::colorRampPalette(palette)(n),
                discrete = palette[1:n]
  )
  structure(out, name = name, class = "palette")
}


#' SWICA ggplot Theme and Palettes
#'
#' Provides ggplot themes and color palettes for SWICA
#' @import ggplot2
#' @import showtext
#' @import stringr
#' @import dplyr
#' @export

theme_swica <- function() {

  check_swica_fonts()

  theme_minimal(base_family = "SWICA") +
    theme(
      text = element_text(family = "SWICA", size = 12),
      plot.title = element_text(family = "SWICA", size = 15, hjust = 0), # Align title to the margin
      plot.subtitle = element_text(family = "SWICA", size = 13, hjust = 0), # Align subtitle to the margin
      plot.title.position = "plot", # Ensures title is aligned relative to the plot
      axis.text = element_text(size = 12),
      axis.line = element_blank(),
      axis.ticks = element_blank(),
      axis.title = element_text(size = 12),
      axis.title.y = element_text(angle = 0, vjust = 0.5, hjust = 0.5),
      panel.grid.major.x = element_blank(),
      panel.grid.minor = element_blank(),
      panel.grid.major.y = element_line(),
      legend.position = "bottom"
    )
}


#' SWICA colour scale functions for discrete variables
#'
#' @export

scale_colour_swica_discrete <- function(name) {
  ggplot2::scale_colour_manual(
    values = swica_palettes(
      name,
      type = "discrete"
    ))
}


#' SWICA color scale functions for discrete variables
#'
#' @export

scale_color_swica_discrete = scale_colour_swica_discrete


#' SWICA colour scale functions for continuous variables
#'
#' @export

scale_colour_swica_cont <- function(name) {
  ggplot2::scale_colour_gradientn(
    colours = swica_palettes(
      name = name,
      type = "continuous"
    ))
}

#' SWICA color scale functions for continuous variables
#'
#' @export
scale_color_swica_cont = scale_colour_swica_cont



#' SWICA fill functions for discrete values
#'
#' @export

scale_fill_swica_discrete <- function(name) {
  ggplot2::scale_fill_manual(
    values = swica_palettes(name,
                            type = "discrete"
    ))
}


#' SWICA fill functions for continuous values
#'
#' @export
scale_fill_swica_cont <- function(name) {
  ggplot2::scale_fill_gradientn(
    colours = swica_palettes(
      name = name,
      type = "continuous"
    ))
}

# # Example usage
# dftest <- data.frame(
#     x = rep(1:4),
#     y = rnorm(4, mean = 500, sd = 200),
#     group = rep(letters[1:4])
# )

# ggplot(dftest, aes(x = x, y = y, color = group, fill = group)) +
#     geom_bar(stat = "identity", position = "dodge") +
#     scale_colour_swica_discrete("swica_discrete") +
#     scale_fill_swica_discrete("swica_discrete") +
#     theme_swica() +
#     labs(
#         title = "Example Plot with SWICA Theme",
#         color = "Group",
#         fill = "Group"
#     )
