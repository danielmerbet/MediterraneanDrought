library(SPEI); library(lubridate); 
library(loadeR); library(transformeR);
library(drought4R);library(loadeR.2nc); library(visualizeR)

#location of data
nc_pr <- "/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/pr_Amon_GFDL-ESM4_ssp126_r1i1p1f1_gr1_20150116-21001216_v20180701.nc"
nc_pe <- "/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/evspsbl_Amon_GFDL-ESM4_ssp126_r1i1p1f1_gr1_20150116-21001216_v20180701.nc"

#catalunya lon lat
lonLim <- c(0.15, 3.33) # Or just a point, in this case the interpolation using interpGrid function is not required (but will work even if applying interpGrid)
latLim <- c(40.4, 42.9)

#loading data
pr <- loadGridData(dataset = nc_pr, var = "pr", lonLim = lonLim, latLim = latLim)
pr <- gridArithmetics(pr, 86400,30, operator="*")
pet <- loadGridData(dataset = nc_pe, var = "evspsbl", lonLim = lonLim, latLim = latLim)
pet <- gridArithmetics(pet, 86400,30, operator="*")

SPEI3 <- speiGrid(pr,pet)
grid2nc(SPEI3, NetCDFOutFile="/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/SPEI3.nc4")
SPEI6 <- speiGrid(pr,pet, scale=6)
grid2nc(SPEI6, NetCDFOutFile="/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/SPEI6.nc4")
SPEI12 <- speiGrid(pr,pet, scale=12)
grid2nc(SPEI12, NetCDFOutFile="/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/SPEI12.nc4")
SPEI18 <- speiGrid(pr,pet, scale=18)
grid2nc(SPEI18, NetCDFOutFile="/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/SPEI18.nc4")
SPEI24 <- speiGrid(pr,pet, scale=24)
grid2nc(SPEI24, NetCDFOutFile="/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/SPEI24.nc4")

P_PE <- gridArithmetics(pr, pet, operator = "-")
P_PE_agg <- aggregateGrid(P_PE, aggr.lat=list(FUN = "mean", na.rm=T),
                          aggr.lon=list(FUN = "mean", na.rm=T))

data_spei3 <- spei(ts(as.numeric(P_PE_agg$Data), freq=12, start=c(2015,1)), 
                   3, ref.start= c(2015,1), ref.end= c(2100,12))

pdf("/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/spei3.pdf")
plot.spei(data_spei3)
dev.off()

data_spei6 <- spei(ts(as.numeric(P_PE_agg$Data), freq=12, start=c(2015,1)), 
                   6, ref.start= c(2015,1), ref.end= c(2100,12))
pdf("/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/spei6.pdf")
plot.spei(data_spei6)
dev.off()

data_spei12 <- spei(ts(as.numeric(P_PE_agg$Data), freq=12, start=c(2015,1)), 
                    12, ref.start= c(2015,1), ref.end= c(2100,12))
pdf("/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/spei12.pdf")
plot.spei(data_spei12)
dev.off()

data_spei18 <- spei(ts(as.numeric(P_PE_agg$Data), freq=12, start=c(2015,1)), 
                    18, ref.start= c(2015,1), ref.end= c(2100,12))
pdf("/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/spei18.pdf")
plot.spei(data_spei18)
dev.off()

data_spei24 <- spei(ts(as.numeric(P_PE_agg$Data), freq=12, start=c(2015,1)), 
                    24, ref.start= c(2015,1), ref.end= c(2100,12))
pdf("/home/ry4902/Documents/MediterraneanDrought/CMIP6/GFDL/spei24.pdf")
plot.spei(data_spei24)
dev.off()


SPI3 <- speiGrid(pr)
SPI6 <- speiGrid(pr, scale=6)
SPI12 <- speiGrid(pr, scale=12)
SPI18 <- speiGrid(pr, scale=18)
SPI24 <- speiGrid(pr, scale=24)

#calculate diference: pr-pet
data_m$P_PE <- data_m$P- data_m$PE

#SPEi
data_m_spei <- spei(ts(data_m[,'P_PE'], freq=12, start=c(1971,1)), 
                    12, ref.start= c(1971,1), ref.end= c(2015,12))
plot.spei(data_m_spei)

#SPI
data_m_spi <- spi(ts(data_m[,'P'], freq=12, start=c(1971,1)), 
                  12, ref.start= c(1971,1), ref.end= c(2015,12))
plot.spei(data_m_spi)
