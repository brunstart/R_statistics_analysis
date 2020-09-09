x <- 1:99
x <- x[(x %% 3)==0]
x

y <- 1:99
y <- y[(y %% 4)==0]
y

union(x, y)
intersect(x, y)
setdiff(x, y)

data()

air <- airquality
str(air)
air[max(air$Wind),]
mean(air$Ozone, na.rm=T)

str(quakes)
max(quakes$mag)
