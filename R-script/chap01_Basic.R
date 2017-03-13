# Chap01_Basic

# 수업내용
# 1. 패키지와 session 보기
# 2. 패키지 사용법
# 3. 변수와 데이터 유형
# 4. 기본함수 사용 및 작업공간


################ 1. 패키지와 세션 보기 ##################

pack <- available.packages()
dim(pack)
# [1] 10135(행 : 패키지수)   17(열)

sessionInfo()
# r의 version, 다국어 정보, 설치된 패키지(7개)


# 주요 단축키
# SCRIPT 실행 : Ctrl + Enter, Ctrl + R
# 자동완성 : Ctrl + space
# 저장 : Ctrl + S


#### R 실행방법 2가지 ####

# 1) 줄 단위 실행
a <- rnorm(20)    # 난수 정수를 만드는 함수 n=20
hist(a) # histogram을 그려주는 함수
mean(a)



# 2) 블럭 단위 실행
pdf("c:/NCS/Rwork/output/test.pdf")     # 장치 open
hist(a)
dev.off()   # 장치 close        RStudioGD의 값이 2라고 나오면 제대로 동작하고 종료까지 완료한 것.



######################################################
################## 2. 패키지 사용법 ##################
######################################################


# 패키지 = function(알고리즘) + data set -> 꾸러미

# 1) 패키지 설치
install.packages("stringr")     #install.packages("설치할 패키지 명")
library(stringr)        # 다운받은 패키지를 메모리로 올리는 작업. 메모리 로딩!! 메모리에 올려놔야 사용할 수 있다.

str <- '홍길동35이순신45유관순18'
# str 대상 이름 추출
str_extract_all(str,"[가-히]{3}")

#str 대상 숫자 추출
str_extract_all(str,"[0-9]{2,}")



######################################
## 설치과정 중 Error 발생 해결 방법 ##
######################################

# 1. 최초 install시에 발생하는 오류 : 관리자 모드로 실행하여 설치
# 2. 기존 version -> new version 할 때 발생하는 오류
#   1) 패키지 제거 
#   2) 컴퓨터 rebooting
#   3) 패키지 재설치



# 2) 패키지 삭제
remove.packages("stringr")


# 3) 기본 패키지/데이터 셋
# sessionInfo() : 확인(7)
data()  #R에서 기본으로 제공되는 데이터 set을 보여줌
data("Nile")
Nile
length(Nile)
plot(Nile)
hist(Nile)




######################################################
############### 3. 변수와 데이터 유형 ################
######################################################

# (1) 변수 : 메모리(휘발성) 이름   :: Environment 창에 확인 가능

# (2) 변수 작성 규칙
# - 첫자는 영문자, 두번째부터는 숫자, 특수문자(_,.) 사용 가능
# - 예약어 사용 불가
# - 대소문 구분 ( num != NUM)
# - 변수 선언 시 type 없음 : 할당된 값에 의해서 자동 결정된다. 
#    -> int num = 10  
# - 특징 : 가장 최근값만 저장
# - 특징 : R의 모든 변수는 객체(참조변수)  = Python


# [실습] 

var1 <- 0 # int var = 10;
var1 <- 1
var1
var2 <- 10
var3 <- 20

var1; var2; var3


# 변수명.멤버   cf) 객체.멤버
member.id <- 'hong'
member.pwd <- '1234'
member.name <- '홍길동'
member.age <- '35'

member.id; member.age




# scalar vs vector 변수

# scalar 변수 : 원소 1개
age <- 35
name <- '홍길동'
age; name


# vector 변수 : 원소 1개 이상
age <- c(35, 45, 25)
name <- c('홍길동', '이순신', '유관순')
age; name

# cf) java, python : 0
# R index : 1
name[2] #이순신

# data structure : chap02 참고
# scalar(0차원) -> vector(1차원) -> matrix(2차원) -> array(3차원)


# 패키지 목록 보기
search()
# 사용한 변수 목록 보기
ls()


# (3) 자료형 (data type) : p.26
# - 숫자형, 문자형, 논리형

int <- 100  # 숫자형
string <- "대한민국"  # 문자형
boolean <- TRUE # T or FALSE(F)

int; string; boolean


# (a) 변수의 자료형 보기 함수 : mode(), is.XXX
mode(int); mode(string); mode(boolean)  # 해당 변수의 자료형을 반환함
is.numeric(int) # 자료의 타입과 변수의 타입의 일치 여부를 TRUE/FALSE로 반환
is.character(string)    # TRUE
is.logical(boolean)     # TRUE
is.character(int)       # FALSE

score <- c(85, 95, NA, 75, 65)
score
mean(score)
mean(score, na.rm = T)  # 80    # na.remove => na.rm
sum(score, na.rm = T)   # 320


### NA를 0으로 바꾸기
score[is.na(score)] <- 0
score



##############################
########## 연습문제 ##########
##############################



# (4) 자료 형변환 (casting) p.28

# (a) 문자열 -> 숫자형(연산, plotting)
x <- c(10, 20, 30)  # 벡터는 같은 자료형만 가질 수 있다.
mode(x) # numeric
x   ## [1] 10 20 30

x1 <- c(10, 20, "30")
mode(x1)    # character
x1  ## [1] "10" "20" "30"
sum(x1) #Error


num <- as.numeric(x1)   # 문자열 -> 숫자형
num
sum(num); plot(num)

#########################################################


# (b) 요인형(Factor)
# - 동일한 값을 범주로 갖는 vector 자료

gender <- c('M', 'F', 'F', 'M', 'M')
gender
plot(gender)

fgender <- as.factor(gender)
fgender
plot(fgender)
str(fgender)
##  Factor w/ 2 levels "F","M": 2 1 1 2 2

# 요인형 순서 변경
x <- c('M','F') # M=1, F=2
fgender2 <- factor(gender, levels = x)
fgender2
plot(fgender2)

class(gender)   # [1] "character"
class(fgender)  # [1] "factor"


# 1. 숫자 -> 요인
x <- c(4,2,4,2)
f <- as.factor(x)   # numeric -> factor
f
# Levels: 2 4
# num <- as.numeric(f)
# num     # 2 1 2 1

# 숫자 -> 요인 -> 숫자

# 2. 요인 -> 문자형
s <- as.character(f)

# 3. 문자형 -> 숫자
num <- as.numeric(s)
num




## (c) 날짜형 변환      strptime(날자, 형식문자)
Sys.Date()  # [1] "2017-02-28"
Sys.time()  # [1] "2017-02-27 12:47:15 KST"


# (1) 문자열 -> 날짜형
today <- '2017-02-27 12:47:39'
mode(today)
class(today)    # [1] "character"

ctoday <- strptime(today, "%Y-%m-%d %H:%M:%S")
mode(ctoday)
class(ctoday)    # [1] "POSIXlt" "POSIXt" 


# mode() vs class()
# mode() : data type 리턴
# class() : 자료구조 리턴


# (2) 영어식 날짜 -> 한국식 날짜
sdate <- '20-Jun-17' # 2017-06-20

# 다국어 정보 : 한국 -> 영어
Sys.getlocale() # LC_COLLATE=Korean_Korea
Sys.setlocale(locale = 'English_USA')   # 미국식

kdate <- strptime(sdate, "%d-%b-%y")
kdate

Sys.setlocale(locale = 'Korean_Korea')


## 
today2 <- as.Date(today,"%Y-%m-%d")
today2
class(today2)  # "Date"


# strptime() vs as.Date()
# strptime() : 날짜/시간
# as.Date() : 날짜 객체 생성




# 입력이 벡터가 들어오면 출력도 벡터가 나온다.
data <- c('02/28/17', '02/29/17', '03/01/17')
as.Date(data, '%m/%d/%y')




# 4. 기본함수 사용 및 작업공간

help("as.Date")
install.packages("stringr")
library(stringr)
help("str_extract")
?sum


args(sum)   # function (..., na.rm = FALSE) 

example(sum)    # 해당 함수가 사용되는 예 보기.
d <- c(10,20)
sum(d)  # 30
sum(10,20)  # 30

mean(d) # 15
mean(10,20) #10
?mean



test <- c(rnorm(10))
test
mean(test, trim=0.3)
# mean함수의 trim : 인수를 정렬한 다음 주어진 값만큼 양쪽 절사평균을 정해줌.

## google에서 정보를 보는 법
# stringr in r



# 작업공간 
getwd() #"C:/NCS/Rwork/Part-I"
setwd("C:/NCS/Rwork/Part-I")    # 구분자 / or \\

test <- read.csv('test.csv')
test

# 메모리 객체(참조변수) -> file 저장
ls()    # 메모리에 올라와 있는 변수들 보는 방법

rm(list = ls()) # 메모리 초기화!

x <- 1:10
x
y <- 101:200
y

setwd('c:/NCS/Rwork/output')
getwd()
save(x,y, file = 'xy.RData')

rm(list=ls())


# file 
load('xy.RData')

women
plot(women)
names(women) <- c('weight', 'height')
