i = as.numeric(Sys.getenv("SLURM_ARRAY_TASK_ID"))
cat("Starting run i = ",i,"\n")

# do something useful and store in 'results'
Theta=rnorm(5)/i
results=list(task=i, Theta=Theta, sum=sum(Theta))

outputName=paste("task-",i,".RData",sep="")
outputPath=file.path("Output",outputName)
save("results",file=outputPath)
