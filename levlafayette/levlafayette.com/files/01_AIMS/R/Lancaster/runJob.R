# get the job id from the environment
jobID=Sys.getenv("SLURM_JOB_ID")

# do something useful and store in 'results'
i=23
Theta=rnorm(5)/i
results=list(task=i, Theta=Theta, sum=sum(Theta))

outputName=paste("job-",jobID,".RData",sep="")
outputPath=file.path("Output",outputName)
save("results",file=outputPath)
