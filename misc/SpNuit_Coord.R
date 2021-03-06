library(data.table)
#library(rgdal)
#library(raster)
#library(sp)
#library(ggplot2)
#library(MASS)
#library(rgeos)
#pour afficher les milisecondes
op <- options(digits.secs=3)

#r�cup�ration des donn�es participation
Particip=fread("C:/wamp64/www/p_export.csv")
#r�cup�ration des localit�s
SiteLoc=fread("C:/wamp64/www/sites_localites.txt")

args="SpNuit2_50_DataLP_PF_exportTot"
#args="ALL"

if(args=="ALL")
{
  SelPar=Particip  
}else{
#recup�ration des donn�es chiros
DataCPL3=fread(paste0(args,".csv"))

#liste des coordonn�es existantes dans ce jeu de donn�es
ListPar=levels(as.factor(DataCPL3$participation))

SelPar=subset(Particip,Particip$participation %in% ListPar)
}

SelParSL=merge(SiteLoc,SelPar,by.x=c("site","nom"),by.y=c("site","point"))
CoordCPL3=aggregate(SelParSL$participation
                ,by=c(list(SelParSL$longitude),list(SelParSL$latitude))
                ,FUN=length)

fwrite(CoordCPL3,paste0("./VigieChiro/GIS/coordWGS84_",args,".csv"))

