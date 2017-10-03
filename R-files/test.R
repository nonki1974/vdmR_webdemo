dfm <- eval(parse(text=POST$dataset))
dfmname <- POST$dataset
fpath <- tempfile("", tmpdir="")
dir.create(paste("../temp",fpath,sep=""))
setwd(paste("../temp",fpath,sep=""))

attach(POST)
histoptions <- ""
if(hiscol_enable=="1"){
	histoptions <- paste0(histoptions, ",color=", hiscol)
}
if(hisfill_enable=="1"){
	histoptions <- paste0(histoptions, ",fill=", hisfill)
}


scoptions <- ""
if(scsize_enable=="1"){
	scoptions <- paste0(scoptions, ",size=", scsize)
}

if(sccol_enable=="1"){
	scoptions <- paste0(scoptions, ",color=", sccol)
}

pcpoptions <- ""
if(pcpgc_enable=="1"){
	pcpoptions <- paste0(pcpoptions, ",groupColumn='", pcpgc,"'")	
}

histcmd <- paste0("vhist(",hisx,",dfm,\"",hisname,"\",\"",dfmname,"\"", histoptions,")")
eval(parse(text=histcmd))

scatcmd <- paste0("vscat(",scx,",",scy,",dfm,\"",scname,"\",\"",dfmname,"\"", scoptions,")")
eval(parse(text=scatcmd))

if(any(names(POST)=='pcpaxis')){
	pcpcmd <- paste0("vpcp(dfm,which(names(dfm)%in%POST[names(POST)=='pcpaxis']),'",pcpname,"','",dfmname,"'",pcpoptions,")")
	eval(parse(text=pcpcmd))
}

vlaunch(dfm, "main", dfmname, browse=FALSE)

resulturl <- paste0("../temp",fpath,"/main.",dfmname,".html")

setContentType("text/html")
cat("<html><head>")
cat("<meta http-equiv=\"refresh\" content=\"0; url=",resulturl,"\">",sep="")
cat("<title>Test</title></head><body>")
cat("<a href=",resulturl,">",resulturl,"</a>",sep="")
cat("<pre>")
cat("</pre>")
cat("</body></html>")

