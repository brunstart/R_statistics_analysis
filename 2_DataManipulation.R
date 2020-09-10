install.packages('dplyr')
library(dplyr)

starwars
df <- as.data.frame(starwars)
head(df)

df %>% head(3)
df %>% tail(3)

# filter : 행 추출
df %>% 
  filter(species == 'Droid')

df %>% 
  filter(skin_color=='light', eye_color=='brown')

# slice : 위치 기반 일부 행 추출
df %>%
  slice(5:10)

# slice_sample: 임의 행 추출
df %>% 
  slice_sample(n=5)

df %>% 
  slice_sample(prop=.1)

# dim(df)

# slice_max, slice_min : 상위 또는 하위 데이터 추출. 단, NA 제거 선행
df %>% 
  filter(!is.na(height)) %>% 
  slice_max(height, n=3)

# select : 열 추출
df %>% 
  select(hair_color, skin_color, eye_color)

df %>% 
  select(hair_color:eye_color)

df %>% 
  select(!(hair_color:eye_color))

df %>% 
  select(name, ends_with('color'))

## select 를 이용한 변수 이름 변경 가능
df %>% 
  select(home_world = homeworld)

# rename : 변수명 변경
df %>% 
  rename(home_world = homeworld)

# mutate : 변수 추가
df %>% 
  mutate(height_m = height/100)

df %>% 
  mutate(height_m = height/100) %>% 
  select(height_m ,height, everything())

df %>% 
  mutate(
    height_m = height/100,
    BMI = mass / (height_m ^ 2)
  ) %>% 
  select (name, height_m, mass, BMI)

## transmute : 새로 추가한 변수만 확인
df %>% 
  transmute(
    height_m = height/100,
    BMI = mass / (height_m ^ 2)
  )

# arrange : 정렬
df %>% 
  arrange(mass)

df %>% 
  arrange(desc(mass))

# summarise : 요약 통계
df %>% 
  summarise(height = mean(height, na.rm=T))

#group_by : 그룹핑
df %>% 
  group_by(species) %>% 
  summarise(
    n=n(),
    height = mean(height, na.rm=T)
  ) %>% 
  filter(n>1)

# %>% 질의 연결
df %>% 
  group_by(species, sex) %>% 
  select(height, mass) %>% 
  summarise(
    height = mean(height, na.rm=T),
    mass = mean(mass, na.rm = T)
  )

# join : 두 테이블의 결합
d1 <- data.frame(kids = c('Jack', 'Jane', 'John', 'Lily'),
                 states = c('CA', 'NY', 'NV', 'TX'))

d2 <- data.frame(kids = c('Jack', 'Jane', 'Kevin'),
                 age = c(10,12,8))

d3 <- data.frame(age = c(10, 12, 8),
                 name = c('Jack', 'Jane', 'Kevin'))
d1; d2; d3

inner_join(d1, d2, by='kids')
left_join(d1, d2)
right_join(d1, d2, by = 'kids')
inner_join(d1, d3, by=c('kids'='name'))

# bind_rows : 두 테이블의 데이터 합치기(행)
t1 <- data.frame(id=c(1:5),
                 test=seq(10, 50, by=10))
t1
t2 <- data.frame(id=c(6:8),
                 test=seq(60, 80, by=10))
t2
bind_rows(t1, t2)
