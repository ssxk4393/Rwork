#################################
## <제6장 연습문제>
################################# 

# <plyr 패키지 관련 연습문제>
library(plyr)
install.packages("ggplot2")
library(ggplot2)
data("mtcars")
str(mtcars)
#  01. 'mtcars' 데이터셋을 대상으로 실린더 수(cyl)와 기어단수(gear)별로 
#  연비(mpg)의 평균과 표준편차 통계치를  계산하시오.

ddply(mtcars, .(cyl), summarise, avg=mean(mpg), sd=sd(mpg))
ddply(mtcars, .(gear), summarise, avg=mean(mpg), sd=sd(mpg))
ddply(mtcars, .(cyl, gear), summarise, avg=mean(mpg), sd=sd(mpg))

subset(mtcars, cyl==6&gear==5)

mtcars_table <- as.data.table(mtcars)
head(mtcars_table)
mtcars_table[, list(avg=mean(mpg), sd=sd(mpg)), by=c('cyl','gear')]

# 조건1) 데이터 셋 구조 보기
str(mtcars)
# 조건2) 평균과 표준편차 통계치 계산




# <dplyr 패키지 관련 연습문제> 
library(dplyr)
library(hflights) 
hflights_df <- tbl_df(hflights)

# 02. 평균 비행시간(AirTime)을 구하시오.
summarise(hflights_df, avg=mean(AirTime, na.rm = T))

# 03. n(), sum()를 이용하여 평균 비행시간을 구하시오.
select(mutate(hflights_df, count=n(), 
              Tot_Time=sum(AirTime, na.rm = T), 
              avg_flight=sum(AirTime, na.rm = T)/n()), 
       count, Tot_Time, avg_flight)

summarise(hflights_df, count=n(), Tot_time=sum(AirTime, na.rm = T), Avg_time=Tot_time/count)


# 04 NA값으로 인하여 평균에 차이가 발생하였다.
# 평균 비행시간의 차이를 보정하시오.
filter_data <- filter(hflights_df, AirTime >=1)
hflights_df # 227,496 × 21
filter_data # 223,874 × 21      3622개 필터
summarise(filter_data, count=n(), Tot_time=sum(AirTime, na.rm = T), Avg_time=Tot_time/count)


# 05. 도착시간(ArrTime) 표준편차와 분산(표준편차의 제곱근) 구하기
summarise(hflights_df, sd_ArrTime = sd(ArrTime, na.rm=T), var_ArrTime=sd_ArrTime^2)
summarise(hflights_df, sd = sd(ArrTime, na.rm=T), var=var(ArrTime, na.rm = T))

# <reshape2 패키지 관련 연습문제> 
library('reshape2')



# 06. reshape2 패키지를 적용하여 각 다음 조건에 맞게 iris 데이터 셋을 처리하시오. 

str(iris)
# 조건1) 꽃의 종류(Species)를 기준으로 ‘넓은 형식’을 ‘긴 형식’으로 변경하기(melt()함수 이용)
long <- melt(iris, id="Species")
long

# 조건2) 꽃의 종별로 나머지 4가지 변수의 합계 구하기(dcast()이용)
dcast(long, Species, sum)

# 조건3) 꽃의 종별로 4가지 변수 평균과 각 행/열 대상 평균 계산 칼럼 추가(acast()이용)

