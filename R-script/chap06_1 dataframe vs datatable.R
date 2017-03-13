# chap06_1 dataframe vs datatable



####################################
###
### data.frame   vs  data.table  ###
###     
### 1. 다양한 indexing 제공 (통계량을 구하기 좋네)
### 2. 접근 속도 빠름
####################################



install.packages('data.table')
library(data.table)


# 1) data.frame 생성

df <- data.frame(x=c(1:3), y=c('one', 'two', 'three'))
df
class(df)


# 2) data.table 생성
dt <- as.data.table(df)
dt
class(dt)
dt2 <- data.table(x=c(1:3), y=c('one', 'two', 'three'))
dt2
class(dt2)



## 1. 다양한 indexing 제공
data(iris)
str(iris)
class(iris)

# 1) data.frame indexing
iris[1, "Sepal.Length"]     # 5.1
iris[1:10, c("Sepal.Length","Sepal.Width")]
iris[1:10, c(1,2)]

# 2) data.table indexing
iris_table <- as.data.table(iris)
head(iris_table)
iris_table[1,"Sepal.Length"]
iris_table[1:10, c("Sepal.Length","Sepal.Width")]
iris_table[,mean(Sepal.Length)]     # 컬럼에 대해 내장 함수 적용 가능
iris_table[,list(mean(Sepal.Length), mean(Sepal.Width))]    # 2개 이상의 컬럼에 적용 가능. List로 묶어주면 됨
iris_table[,list(avg1=mean(Sepal.Length), avg2=mean(Sepal.Width))]  # 적용한 컬럼에 이름을 정해줄 수 있음.
iris_table[,list(avg1=mean(Sepal.Length), avg2=mean(Sepal.Width)), by=Species]





#########################################################################################
library(stringr)

# 특수문자 처리 함수 정의
num_pro <- function(str){
    # 함수처리에 필요한 라이브러리가 있다면 함수안에 라이브러리를 올려주는게 좋다.
    library(stringr)
    str2 <- str_replace_all(str, '\\,|\\$|\\%|\\(|\\)', '')
    num <- as.numeric(str2)
    return(num)
}


str <- '($123,456%)'
num_pro(str)


getwd()
stock <- read.csv('C:/NCS/Rwork/Part-I/stock.csv', header=T, stringsAsFactors = F)
str(stock)
head(stock)

#1) char 칼럼과 num 칼럼
char_col <- stock[,1:6]
num_col <- stock[,7:15]

#2) 사용자 함수에 적용(num_col)
rnum_col <- apply(num_col,2,num_pro)
head(rnum_col)

# 3) char_col + rnum_col
stock_result <- cbind(char_col, rnum_col)
str(stock_result)
class(stock_result)
head(stock_result)


# Sector : 분야, Market.Cap : 시가총액, P.E : 주가이익, Forward.P.E : 예상 주가이익


## 문) 숫자컬럼을 대상으로 평균을 구하시오(컬럼단위로)
apply(stock_result[,7:15], 2, mean, na.rm=T)


## 문2) 분야별(Sector) 시가총액, 주가이익, 예상주가이익의 평균을 구하시오

stock_table <- as.data.table(stock_result)
head(stock_table)
stock_table[, list(Market.Cap=mean(Market.Cap, na.rm = T),
                   P.E=mean(P.E, na.rm = T), 
                   Forward.P.E=mean(Forward.P.E, na.rm = T)), 
            by=Sector]


#######################################################################################


## 2. 접근 속도 빠름

# R에서 기본으로 제공하는 상수
LETTERS
letters

x <- runif(2600000, min=0, max=100) # 0~100사이의 260만개
y <- rep(LETTERS, each=100000)
length(x); length(y)
# data.frame 생성
df <- data.frame(x,y)
head(df); tail(df)


# 수행 시간 체크
system.time(df[df$y=='Z',]) # y칼럼의 Z검색시간
# 사용자  시스템 elapsed 
# 0.16    0.02    0.17 



#data.table
dt <- as.data.table(df)
head(dt); tail(dt)

# 검색대상을 key
setkey(dt,y)    # y칼럼을 검색대상으로 지정
system.time(dt[J('Z'),])    # y칼럼의 Z 검색











