#
# Example of placing text on R graphs 
# Modelled on Justin Zobel's example in jgraph
#
# Authour: Michael C. Harris <miharris@cs.rmit.edu.au>
# Date:    Tue May  1 13:56:01 EST 2007

# postscript("strings.ps", family="Times")
pdf("strings.pdf", family="serif")

    # Read data into vectors
space <- sort(c(44.7, 97.8, 158.1, 173.7, 31.7, 1, 300.0))
time <- sort(c(458.4, 71.8, 18.9, 1.45, 895.6, 7564.5, 0.95), TRUE)

    # set the box type "L" 
par(bty="l")

    # Plot the data
plot(space, time, log="y",
                  pch=20,
                  xlab="Space overhead (%)",
                  ylab="Time (ms)")

    # Draw labels in font 3 (italics) to the left of the points.
    # The first point is too close to the Y axis, so
    # draw the text below the point by passing a vector to pos.
text(space, time, LETTERS[1:7], pos=c(1,rep(2,6)), font=3)

    # Add line segments
    # Magic numbers are the edge of the plot
    # Vertical segments
segments(space, time, space, 10000, lty=2)
    # Horizontal segments
segments(space, time, 320, time, lty=2)

dev.off()  # This is only needed if you use pdf/postscript in interactive mode
