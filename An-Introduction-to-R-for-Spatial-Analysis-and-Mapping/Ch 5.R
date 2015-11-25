##
## Code for Chapter 5
##
## This shows R functions to perform 
## GIS like operations 
## 


## 5.1 INTRODUCTION

## 5.2 SPATIAL INTERSECTION OR CLIP OPERATIONS

library(GISTools)
  
# set plot parameters and initial plot for map extent
par(mar=c(0,0,0,0))
plot(us_states)
# plot the data using a shading with a transparency term 
# see the add.alpha() function for this
plot(us_states, add = T)

summary(torn)

index <- us_states$STATE_NAME == "Texas" | 
	us_states$STATE_NAME == "New Mexico" | 
	us_states$STATE_NAME == "Oklahoma" | 
	us_states$STATE_NAME == "Arkansas"

plot(AoI)

AoI.torn <- gIntersection(AoI, torn, byid = TRUE) 
par(mar=c(0,0,0,0))

AoI.torn <- gIntersection(AoI, torn, byid = TRUE)

head(data.frame(AoI.torn))

rownames(data.frame(us_states[index,]))

us_states$STATE_NAME[index]

# assign rownames to tmp and split the data by spaces " " 
tmp <- rownames(data.frame(AoI.torn))
torn.id <- (sapply(tmp, "[[", 2))
torn.id <- as.numeric(torn.id)

## Info box

# set up some variables
state.list <- rownames(data.frame(us_states[index,])) 
tmp <- rownames(data.frame(AoI.torn))
# loop through these, removing the state.list variable
for (i in 1: length(state.list)) {
	replace.val <- sprintf("%s ", state.list[i])
	tmp <- gsub(replace.val, "", tmp)
}
# again use torn.id to subset the torn data and assign to df1
torn.id <- as.numeric(tmp)
df1 <- data.frame(torn[torn.id,])

df2 <- us_states$STATE_NAME[as.numeric(state.id)] 
df <- cbind(df2, df1)

AoI.torn <- SpatialPointsDataFrame(AoI.torn, data = df) 
# write out as a shapefile if you wish

# match df2 defined above to us_states$STATE_NAME
df3 <- data.frame(us_states)[index2,]

## 5.3 BUFFERS

# select an Area of Interest and apply a buffer
AoI.buf <- gBuffer(AoI, width = 25000)

data(georgia)

plot(buf.t[1,])

## 5.4 MERGING SPATIAL FEATURES

AoI.merge <- gUnaryUnion(us_states)
plot(AoI.merge, add = T, lwd = 1.5)

## 5.5 POINT-IN-POLYGON AND AREA CALCULATIONS 

## 5.5.1 Point-in-Polygon

## Info Box
poly.counts

torn.count <- poly.counts(torn, us_states) 
head(torn.count)

names(torn.count)

## 5.5.2 Area Calculations

proj4string(us_states2)

poly.areas(us_states2)
# hectares
poly.areas(us_states2) / (1000 * 1000)

## Self-Test Question 1.

library(GISTools)

ft2miles(ft2miles(poly.areas(blocks)))

## 5.5.3 Point and Areas Analysis Exercise

data(newhaven)

plot(blocks$P_OWNEROCC,densities)

breaches ~ Poisson(exp(a + b * blocks$P_OWNEROCC+log(AREA)))

# load and attach the data
n.breaches = poly.counts(breach,blocks)
model1=glm(n.breaches~P_OWNEROCC,offset=log(area),family= poisson)

model1
summary(model1)

s.resids = rstandard(model1)
resid.shades = shading(c(-2,2),c("red","grey","blue"))

par(mar=c(0,0,0,0)) 
choropleth(blocks,s.resids,resid.shades) 
# reset the plot margins

attach(data.frame(blocks))
model2=glm(n.breaches~P_OWNEROCC+P_VACANT,
s.resids.2 = rstandard(model2) 
detach(data.frame(blocks))

s.resids.2 = rstandard(model2) 
par(mar=c(0,0,0,0)) 
choropleth(blocks,s.resids.2,resid.shades) 
# reset the plot margins

## 5.6 CREATING DISTANCE ATTRIBUTES

data(newhaven)
centroids. <- gCentroid(blocks, byid = T, id = rownames(blocks))

distances <- gWithinDistance(places, blocks, byid = T, dist = miles2ft(1.2))

## 5.6.1 Distance Analysis/Accessibility Exercise

distances <- ft2miles(gDistance(places, centroids., byid = T))

# extract the ethnicity data from the blocks variable
ethnicity <- apply(ethnicity, 2, function(x) (x * blocks$POP1990))
colnames(ethnicity) <- c("White", "Black",

# use xtabs to generate a crosstabulation
# then transpose the data
data.set = as.data.frame(mat.access.tab)

modelethnic = glm(Freq~Access*Ethnicity, data=data.set,family=poisson)
# summary(modelethnic)

summary(modelethnic)$coef
mod.coefs = summary(modelethnic)$coef

tab <- 100*(exp(mod.coefs[,1]) - 1) 
tab <- tab[7:10]
tab

mosaicplot(t(mat.access.tab),xlab='',ylab='Access to Supply', 
	main="Mosaic Plot of Access",shade=TRUE,las=3,cex=0.8)

## Self-Test Question 2. 

plot(blocks,border='red')

blocks$OCCUPIED
blocks2 = blocks[blocks$OCCUPIED > 0,]

attach(data.frame(blocks2))
notforced.rate = 2000*poly.counts(burgres.n,blocks2)/ OCCUPIED

model1 = lm(forced.rate~notforced.rate)
summary(model1)

## 5.7 COMBINING SPATIAL DATASETS AND THEIR ATTRIBUTES

data(newhaven)
int.layer <- SpatialPolygonsDataFrame(
names(int.layer) <- "ID"

int.res <- gIntersection(int.layer, tracts, byid = T)

# set some plot parameters
# set the plot extent

names(int.res)

tmp <- strsplit(names(int.res), " ") 
tracts.id <- (sapply(tmp, "[[", 2)) 
intlayer.id <- (sapply(tmp, "[[", 1))

# generate area and proportions
tract.areas <- gArea(tracts, byid = T)
tract.areas <- tract.areas[index]
df <- data.frame(df, houses, int.areas)

int.layer.houses <- xtabs(df$houses~df$intlayer.id) 
index <- as.numeric(gsub("g", "", names(int.layer.houses)))

int.layer <- SpatialPolygonsDataFrame(int.layer, 
	data = data.frame(data.frame(int.layer), i.houses), 
	match.ID = FALSE)

# set the plot parameters and the shading variable
# map the data
plot(tracts, add = T)
# reset the plot margins

## Self-Test Question 3. 
install.packages("rgdal", dep = T)

## 5.8 CONVERTING BETWEEN RASTER AND VECTOR

## 5.8.1 Raster to Vector

library(GISTools) 
library(raster) 
data(tornados)

# Points
r <- raster(nrow = 180 , ncols = 360, ext = extent(us_states2))
t2 <- as(torn2, "SpatialPoints")
r <- rasterize(t2, r, fun=sum)
# set the plot extent by specifying the plot colour 'white'
plot(r, add = T)

# Lines
r <- raster(nrow = 180 , ncols = 360, ext = extent(us_states2)) 
r <- rasterize(us_outline , r, "STATE_FIPS") 
plot(r)

# Polygons
r <- rasterize(us_states2, r, "POP1997")
plot(r)
r

## Info box

d <- 50000 
dim.x <- d 
dim.y <- d

bb <- bbox(us_states2)
cells.x <- (bb[1,2]-bb[1,1]) / dim.x 
cells.y <- (bb[2,2]-bb[2,1]) / dim.y 
round.vals <- function(x){
		x <- as.integer(x) + 1
		}}
extent(r) <- ext
# and examine the results
plot(r)

## 5.8.2 Converting to sp Classes

r <- raster(nrow=60,ncols=120,ext = extent(us_states2)) 
r <- rasterize(us_states2, r, "STATE_FIPS")
g <- as(r, 'SpatialGridDataFrame')

head(data.frame(g)) 
head(data.frame(p))

# set up and create the raster
r <- rasterize(us_states2 , r, "POP1997") 
r2 <- r
# seubset the data
r2[r < 10000000] <- NA
g <- as(r2, 'SpatialGridDataFrame')
p <- as(r2, 'SpatialPixelsDataFrame')
# not run
# image(g, bg = "grey90")
par(mar=c(0,0,0,0))
plot(p, cex = 0.5, pch = 1)

## 5.8.3 Vector to Raster

# load the data and convert to raster
poly1 <- rasterToPolygons(r, dissolve = T)
# convert to points
par(mar=c(0,0,0,0))

## 5.9 INTRODUCTION TO RASTER ANALYSIS

## 5.9.1 Raster Data Preparation

library(GISTools) 
library(raster) 
library(sp)
data(meuse.grid)
# create 3 raster layers

image(r1, asp = 1) 
image(r2, asp = 1) 
image(r3, asp = 1)

## 5.9.2 Raster Reclassification

Raster_Result <- r2 + (r3 * 10)
spplot(Raster_Result, col.regions=brewer.pal(9, "Spectral"), cuts=8)

r1a <- r1 > 0.5 
r2a <- r2 >= 2 
r3a <- r3 < 3

Raster_Result <- r1a * r2a * r3a 
table(as.vector(Raster_Result$values))
plot(Raster_Result, legend = F, asp = 1)

Raster_Result <- r1a + r2a + r3a 
table(as.vector(Raster_Result$values))
image(Raster_Result, col = heat.colors(3), asp = 1) 
legend(x='bottomright',

## 5.9.3 Other Raster Calculations

Raster_Result <- sin(r3) + sqrt(r1) 
Raster_Result <- ((r1 * 1000 ) / log(r3) ) * r2 
image(Raster_Result)

my.func <- function(x) {log(x)} 
Raster_Result <- calc(r3, my.func) 
# this is equivalent to 
Raster_Result <- calc(r3, log)

Raster_Result <- overlay(r2,r3,

# load meuse and convert to points
r <- raster(meuse.grid)
plot(dist)

## ANSWERS TO SELF-TEST QUESTIONS

## Q1.
densities= poly.counts(breach,blocks) / 
	ft2miles(ft2miles(poly.areas(blocks)))
	cols=brewer.pal(5, "Oranges"), cutter=rangeCuts)
choro.legend(533000,161000,density.shades) title("Incidents per Sq. Mile")

## Q2. 
# Analysis with blocks
attach(data.frame(blocks2))
notforced.rate = 2000*poly.counts(burgres.n,blocks2)/ OCCUPIED
cat("expected(forced rate)= ",coef(model1)[1], "+", coef(model1)[2], "* (not forced rate) ")

# Analysis with tracts
# align the projections
proj4string(tracts2) <- CRS(ct)
notforced.rate = 2000*poly.counts(burgres.n,tracts2)/ OCCUPIED

cat("expected(forced rate) = ",coef(model1)[1], "+", 
	coef(model1)[2], "* (not forced rate) ")
cat("expected(forced rate) = ",coef(model2)[1], "+",

## Q3. 

int.poly.counts <- function(int.layer, tracts, 
	tracts.var, var.name) {
# split the intersection references
# calculate areas
tract.areas <- gArea(tracts, byid = T) 
# match this to the new layer
tract.areas <- tract.areas[index]
# and create data frame for the new layer
int.layer.houses <- xtabs(df$houses~df$intlayer.id)
# create temporary variable
names(int.layer2) <- c("ID", var.name) 
return(int.layer2)

int.layer2 <- int.poly.counts(int.layer, 
	tracts,tracts$HSE_UNITS, "i.house" )
	

	tmp <- 	strsplit(names(int.res), " ")
	intlayer.id <- (sapply(tmp, "[[", 1))
	int.areas <- gArea(int.res, byid = T)
	tract.areas <- gArea(int.layer2, byid = T)
	index <- match(int.layer2.id, row.names(int.layer2)) 
	tract.areas <- tract.areas[index]
	df <- data.frame(df, var, int.areas)
	tmp <- vector("numeric", length = dim(data.frame(int.layer1))[1])
	names(int.layer.out) <- c("ID", var.name) 
	return(int.layer.out)}

# Set up the packages and data
library(GISTools)
bb <- bbox(tracts)
	cellsize=c(10000,10000), cells.dim = c(5,5))
proj4string(int.layer) <- CRS(ct) 
int.layer <- spTransform(int.layer, CRS(proj4string(blocks)))
plot(blocks, add = T, lty = 2, lwd = 1.5) 
choro.legend(530000, 159115, bg = 	"white", shades, title = "Count", under = "")

matrix(data.frame(int.result)[,2], nrow = 5, ncol = 5, byrow = T)