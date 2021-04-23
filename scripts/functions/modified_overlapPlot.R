plotTimeAxis <- function(xscale, ...) {
  # Deal with ... argument:
  dots <- list(...)
  if(length(dots) == 1 && class(dots[[1]]) == "list")
    dots <- dots[[1]]
  selPlot <- names(dots) %in%
    c("cex.axis", "col.axis", "family", "font.axis", "las", "tck", "tcl", "xaxt",
      "tick", "lwd.ticks", "col.ticks")
  plotArgs <- dots[selPlot]
  plotArgs$side <- 1
  
  if(is.na(xscale)) {
    plotArgs$at <- c(-pi, -pi/2, 0, pi/2, pi, 3*pi/2, 2*pi)
    plotArgs$labels <- c(expression(-pi), expression(-pi/2), "0",
                         expression(pi/2), expression(pi),
                         expression(3*pi/2), expression(2*pi))
  } else if(xscale == 24) {
    plotArgs$at <- c(-12, -6, 0,6,12,18,24)
    plotArgs$labels <- c("12:00", "18:00", "0:00", "6:00", "12:00", "18:00", "24:00")
  } else if(xscale == 1) {
    plotArgs$at <- c(-0.5, -0.25, 0, 0.25, 0.5, 0.75, 1)
    plotArgs$labels <- TRUE
  }
  do.call(axis, plotArgs, quote=TRUE)
}



my_overlapPlot <-function(A, B, xscale=24, xcenter=c("noon", "midnight"),
           linetype=c(1, 2), linecol=c('black', 'blue'),
           linewidth=c(1,1), olapcol='lightgrey', rug=FALSE, extend=NULL,
           n.grid=255, kmax = 3, adjust = 1, ...)  {
    # xlab="Time", ylab="Density", ylim, now passed via "..."
 
    isMidnt <- match.arg(xcenter) == "midnight"
    
    xsc <- if(is.na(xscale)) 1 else xscale / (2*pi)
    # xxRad <- seq(0, 2*pi, length=n.grid)
    if (is.null(extend)) {
      xxRad <- seq(0, 2*pi, length=n.grid)
    } else {
      xxRad <- seq(-pi/4, 9*pi/4, length=n.grid)
    }
    if(isMidnt)
      xxRad <- xxRad - pi
    xx <- xxRad * xsc
    # densA <- densityFit(A, xxRad, bwA) / xsc
    # densB <- densityFit(B, xxRad, bwB) / xsc
    densOL <- pmin(A, B)
    
    # Deal with ... argument:
    dots <- list(...)
    if(length(dots) == 1 && class(dots[[1]]) == "list")
      dots <- dots[[1]]
    defaultArgs <- list(
      #main=paste(deparse(substitute(A)), "and", deparse(substitute(B))), 
      xlab="Time", ylab="Density",
      bty="o", type="l", xlim=range(xx), ylim = c(0, max(A, B)))
    useArgs <- modifyList(defaultArgs, dots)
    
    selPlot <- names(useArgs) %in%
      c(names(as.list(args(plot.default))), names(par(no.readonly=TRUE)))
    plotArgs <- useArgs[selPlot]
    plotArgs$x <- 0
    plotArgs$y <- 0
    plotArgs$type <- "n"
    plotArgs$xaxt <- "n"
    do.call(plot, plotArgs, quote=TRUE)
    
    plotTimeAxis(xscale, ...)
    polygon(c(max(xx), min(xx), xx), c(0, 0, densOL), border=NA, col=olapcol)
    if(!is.null(extend)) {
      if(isMidnt) {
        wrap <- c(-pi, pi) * xsc
      } else {
        wrap <- c(0, 2*pi) * xsc
      }
      edge <- par('usr')
      rect(c(edge[1], wrap[2]), rep(edge[3], 2), c(wrap[1], edge[2]), rep(edge[4],2),
           border=NA, col=extend)
      box(bty=useArgs$bty)
    }
    
    segments(xx[1], 0, xx[n.grid], 0, lwd=0.5)
    lines(xx, A, lty=linetype[1], col=linecol[1], lwd=linewidth[1])
    lines(xx, B, lty=linetype[2], col=linecol[2], lwd=linewidth[2])
   
    
  }