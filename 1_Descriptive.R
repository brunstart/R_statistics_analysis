# 단순 임의 추출
## 비복원 추출
dt <- iris$Petal.Length
str(dt)
sample(dt, 10)

## 복원 추출
sample(dt, 10, replace=T)

sample(1:5, 5)
sample(1:5, 5, replace=T)

## 가중치를 고려한 추출
sample(1:5, 5, replace = T, prob=c(10, 20, 20, 50, 1))

# 층화 임의 추출 : sampling::strata
install.packages('sampling')
library(sampling)

## strata
x <- strata(data=iris, stratanames = c('Species'), size=c(3,3,3), method='srswor')
x

## getdata
getdata(iris, x)

## 층마다 다른 수의 표본 추출
strata(data=iris, stratanames = c('Species'), size=c(3,2,1), method='srswor')
iris$Species2 <- rep(1:2, 75)

## 다수의 층에서 표본 추출
strata(data=iris, stratanames = c('Species', 'Species2'),
       size=c(1,2,1,2,1,2), method='srswor')

## 계통 추출 : doBy::sample_by
install.packages('doBy')
library(doBy)

x <- data.frame(x=1:10)
x
sample_by(data=x, formula=~1, frac=.2, systematic = T)
sample_by(data=iris, formula=~Species, frac=.2, systematic = T)

# 기술 통계
## 평균
mean(dt)

## 표본 분산
var(dt)

## 자유도 확인
dt
m <- mean(dt)
m
length(dt)

sum((dt-m)^2)/length(dt)
sum((dt-m)^2)/(length(dt) - 1)

## 표본 표준 편차
sd(dt)

# 5 number summary : min, 1Q, 2Q(median), 3Q, max
fivenum(dt)
summary(dt)

## 최빈값
## 분할표 작성
table(dt)
which.max(table(dt))
names(table(dt))[5]

# 검정을 위한 분할표 작성 : table, xtabs
table(iris$Species)

xtabs(~Species, data=iris)

d<-data.frame(x=c('1','2','2','1'),
              y=c('A','B','A','B'),
              num=c(3,5,8,7))
d

xtabs(num ~ x+y, data=d)

# 합계산 : margin.table

xt <- xtabs(num ~ x+y, data=d)
margin.table(xt, 1)
margin.table(xt, 2)
margin.table(xt)

# 비율 계산 : prop.table
xt
prop.table(xt, 1)
prop.table(xt, 2)
prop.table(xt)


# 독립성 검정

## 데이터 로드 : MASS::survey

library(MASS)
data(survey)
str(survey)

# 성별 : Sex, 운동의 정도 : Exer
ta <- xtabs(~ Sex + Exer, data=survey)
ta
# 카이제곱검정, p-value가 보통 0.05 이하일 때 귀무가설이 거짓이라고 판단함.
#                                                  (귀무가설 기각)
# 귀무가설 : 해당 두 변수는 서로 독립적이다.

chisq.test(xtabs(~ Sex + Exer, data=survey))
#자유도 계산 : 성별 2, 운동정도 3가지, (2-1)(3-1) = 2

xtabs(~ W.Hnd + Clap, data=survey)
chisq.test(xtabs(~ W.Hnd + Clap, data=survey))
fisher.test(xtabs(~ W.Hnd + Clap, data=survey))

# 맥니머 검정 : 특정 사건을 전후로 데이터의 분포가 어떻게 달라지는지를 확인하는 방법,
#               사건의 영향력 확인

Performance <-
  matrix(c(794, 86, 150, 570),
         nrow = 2,
         dimnames = list("1st Survey" = c("Approve", "Disapprove"),
                         "2nd Survey" = c("Approve", "Disapprove")))
Performance
mcnemar.test(Performance)

# t-test : 집단 간 비교시 평균의 차이가 의미가 있는지를 검정
mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)

## compact, suv 자동차의 도시 연비 차이
mpg_diff <- mpg %>% 
  select(class, cty) %>% 
  filter(class %in% c('compact', 'suv'))

table(mpg_diff)

#분산은 같다는 가정, 클래스에 따른 도시연비 비교
t.test(data = mpg_diff, cty ~ class, var.equal=T)

## 일반 휘발유와 고급 휘발유의 도시 연비 비교
mpg_diff2 <- mpg %>% 
  select(fl, cty) %>% 
  filter(fl %in% c('r', 'p'))

table(mpg_diff2$fl)

t.test(data = mpg_diff2, cty ~ fl, var.equal=T)

# 상관분석 : 둘 이상의 변수들이 서로 관련이 있는지 검정
# 상관계수 : -1 ~ 1 사이의 값, 1에 가까울수록 관련성이 큼, 양수면 정비례, 음수면 반비례
#           0이면 관계 없음.

economics <- as.data.frame(ggplot2::economics)
str(economics)
cor.test(economics$unemploy, economics$pce)
# 위와 똑같이 p-value로 귀무가설 검증. cor 값이 상관계수

# 상관행렬

head(mtcars)
car_cor <- cor(mtcars)
round(car_cor, 2)

# 히트맵
install.packages('corrplot')
library(corrplot)
corrplot(car_cor)
corrplot(car_cor, method='number')

corrplot(car_cor,
         method='color',
         type='lower',
         order='hclust',
         addCoef.col = 'black',
         tl.col = 'gray',
         tl.srt = 45,
         diag = F)
