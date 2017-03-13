# chap03_DataIO

install.packages("stringr")
library(stringr)


#####################################
## Chapter03. 데이터 입출력 
#####################################



###########################
#
# 1. 데이터 불러오기
#
###########################


### 1-1. 키보드 입력

# 1) scan() 함수를 이용
# 숫자입력 
x <- scan()
x #  10 20 30

# 합계 구하기
sum <- sum(x) 
sum * 2

# 문자입력
y <- scan(what="")
y # [1] "홍길동" "이순신" "유관순"


# 2) edit() 함수를 이용한 입력
df = data.frame() #빈 데이터프레임 생성
df = edit(df) # 데이터 편집기
df <- data.frame()
df <- edit(df)
df



### 1-2. 파일 데이터 가져오기

## 1) read.table() 함수 이용

# (1) 컬럼명이 없는 파일 불러오기
getwd()
setwd("C:/NCS/Rwork/Part-I")
student  <- read.table(file="student.txt")
student

# (2) 컬럼명이 있는 파일 불러오기
student1  <- read.table(file="student1.txt", header=TRUE)
student1

# (3) 구분자가 있는 경우(세미콜론, 탭)
student2  <- read.table(file="student2.txt", header=TRUE, sep=";") # 세미콜론
student2

# (4) 특정문자 NA 처리(- 문자열을 NA로 처리)
student3 <- read.table(file="student3.txt", sep=" ", header=TRUE, 
                       na.strings=c("-","&")) # 해당 문자열 벡터  -> NA로 변경 

h <- student3$키
mean(h, na.rm=T)

class(student3) # "data.frame"
student3




## 2)  read.csv() 함수 이용

student4 <- read.csv(file="student4.txt", na.strings="-")
student4
student4 <- read.csv(file.choose(), sep=",", na.strings="-")   # 파일위치가 애매할때 직접 가져오기 choose



## 3) read.xlsx() 함수 이용 - 엑셀데이터 읽어오기
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_111')

# rJava를 로드하기 때문에 rJava 패키지 설치 필요
install.packages("rJava")
library(rJava) # 로딩

# xlsx 패키지 설치
install.packages("xlsx") # JAVA 개발 패키지 
library(xlsx) # 로딩

# studentex.xlsx 파일 선택
studentex <- read.xlsx(file.choose(), 
                       sheetIndex=1, encoding="UTF-8")
studentex



## 4) 웹문서 가져오기
install.packages("XML")
library(XML)

# 미국의 각 주별 1인당 소득자료
info.url <- "http://www.infoplease.com/ipa/A0104652.html"

# readHTMLTable() 함수 역할 - <table>,<tr>,<td> 태그 이용
info.df<-readHTMLTable(info.url, header=T, which=1, stringsAsFactors=F)
# header=T : 컬럼명 있음, which=1 : 첫번째, stringsAsFactors 문자는 범주(값의 목록)처리 안함 -> 순수하게 문자열로 가져옴

info.df
str(info.df)

# 레코드 수 변경 확인 <- update
info.df<-info.df[1:53,] # NA 레코드 제거(54행 제거)
info.df[2,] <- str_replace_all(info.df[2,], fixed('$'), '')
info.df[28,] <- str_replace_all(info.df[28,], fixed('$'), '')
info.df

nrow(info.df)


# 컬럼명 변경
info.df <-info.df[c(-1),] # 1,2행 제거

# 컬럼명 추가
names(info.df) <- c("State",'y1980','y1990','y1995','y2000','y2003','y2006','y2009','y2012','y2015')
head(info.df) 
info.df



##################################
# 파일 저장 
##################################
setwd('c:/NCS/Rwork/output')
write.csv(info.df,"info.csv", row.names=F) # 행 이름 제거


info.df2 <- read.csv("info.csv", header=T)
info.df2



## 문제) 2015년도 전체 합계와 평균을 구하시오.


# 1. 칼럼 vector 생성
y2015 <- unlist(info.df2$y2015)

# 2. 콤마 특수문자 제거
y2015 <- str_replace_all(y2015, ',', '')

# 3. 숫자 형변환
y2015 <- as.numeric(y2015)
y2015
# 4. 통계량 계
mean(y2015)
sum(y2015)


## 문제2) 미국 10개 주 대상 2015년도 1인당 소득 시각화
barplot(y2015[1:10], col=rainbow(10), main='미국 10개 주 대상 2015년도 1인당 소득', names.arg=info.df2$State[1:10])








########################
#
# 2. 데이터 저장하기
#
########################


### 2-1. 화면(콘솔) 출력

# 1) cat() 함수         # cat : 문자열과 혼용해서 사용 가능, R은 결합연산자가 +가 아니라 ,이다.
x <- 1
y <- 20
z <- x * y
cat("x*y의 결과는 ", z ," 입니다.\n")  # \n 줄바꿈
cat("x*y = ", z)

# 2) print() 함수
print(z) # 변수 또는 수식만 가능
print(z*10)
print('x*y =', z) # Error       # print는 문자열과 수식의 혼용 불가



### 2-2. 파일에 데이터 저장


## 1) sink() 함수를 이용 파일 저장
setwd("C:/NCS/Rwork/output") 
library(xlsx)

sink("savework.txt") # sink : 시작점의 개념. sink 안에서 행해진 결과를 해당 파일명으로 저장한다.
# studentexcel.xlsx 파일 선택
studentx <- read.xlsx(file.choose(), sheetIndex=1, encoding="UTF-8") 
studentx 
sink() # 해제 


## 2) write.table()함수 이용 파일 저장
getwd() # C:/Rwork/output 경로 확인 

#(1) 기본옵션으로 저장 - 행 이름과 따옴표 붙음
write.table(studentx, "stdt.txt") 

#(2) 행 이름 제거하여 저장
write.table(studentx, "stdt2.txt", row.names=FALSE) 

#(3) 따옴표 제거하여 저장
write.table(studentx, "stdt3.txt", row.names=FALSE, quote=FALSE) 


## 3) write.xlsx() 함수 이용 파일 저장 - 엑셀 파일로 저장
library(xlsx) # excel data 입출력 함수 제공

# studentexcel.xlsx 파일 선택
st.df <- read.xlsx(file.choose(), sheetIndex=1, encoding="UTF-8")
str(st.df)
write.xlsx(st.df, "studentx.xlsx") # excel형식으로 저장

## 4) write.csv() 함수 이용 파일 저장
# data.frame 형식의 데이터를 csv 형식으로 저장
setwd("C:/NCS/Rwork/output")
st.df
write.csv(st.df,"stdf.csv", row.names=F, quote=F) # 행 이름, "" 제거








