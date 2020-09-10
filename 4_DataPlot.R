df <- as.data.frame(ggplot2 :: mpg)
head(df)
str(df)

df$drv <- as.factor(df$drv)
df$cyl <- as.factor(df$cyl)

#1변수 plot
plot(df$hwy)
plot(df$drv)

attach(df)

#2변수 plot
plot(cty, hwy)
plot(hwy~cty)
plot(drv, hwy)
plot(drv, cyl)

# 데이터 프레임 전체
plot(df)

# barplot
t_cyl <- table(cyl)
t_cyl
barplot(t_cyl)

t_class <- table(class)
t_class
barplot(t_class)

plot(cyl)
plot(as.factor(class))

# 평균 막대
mean_bar <- tapply(hwy, drv, mean)
mean_bar
barplot(mean_bar, ylim=c(0,40))

# boxplot
boxplot(cty)
boxplot(cty~drv)

# histogram
hist(cty)
hist(cty, breaks=seq(0,40,5))

# 저수준 차트 그리기
plot(cty~hwy, ann=F)
title(main='도시 연비와 도로 연비의 관계', xlab='도로 연비', ylab='도시 연비')
grid()

h_mean <- mean(hwy)
h_mean
abline(v=h_mean, col='red')

# line chart, 겹쳐 나타내기
runif(30)
ts1 <- sort(round(runif(30) * 100))
ts1
ts2 <- sort(round(runif(30) * 100))
ts2

plot(ts1, type='l')
lines(ts2, lty='dashed', col='red')

detach(df)

