#postscript("log.ps")
pdf("log.pdf")

# Load second data table.
data_table_2 <- read.table("log-d2.data", col.names=c("DocLen2","NumDoc2"))

plot(data_table_2, 
        type="l", 
        xlab="Document length", 
        ylab="Number of documents", 
        log="y",
	lwd=3)

# Load first data table.
data_table_1 <- read.table("log-d1.data", col.names=c("DocLen1","NumDoc1"))
lines(data_table_1, lwd="1")

legend(50,50,legend=c("Data set 1", "Data set 2"), lwd=c(1,3))

    # a t.test just for fun!
t <- t.test(data_table_2$DocLen2, data_table_2$NumDoc2, paired=TRUE)
print(paste("t-test pvalue = ",t$p.value))

#dev.off()  # This is only needed if you use pdf/postscript in interactive mode
