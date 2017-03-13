# chap02_DataStructure




#####################################
## Chapter02. 데이터의 유형과 구조
#####################################

#####################################
#
# 1. Vector 자료구조
#
# - 동일한 자료형을 갖는 1차원 배열구조 
# - 생성 함수 : c(), seq(), rep()
#######################################


# 벡터 데이터 생성 함수
c(1:20) # 콜론 : 범위를 지정할 때 사용. 각각을 쓸때는 , 사용
seq(1, 10, 2) # 시작, 종료, 증감 
rep(1:3, 3) # 대상, 반복수  
rep(1:3, each = 3)  # 개별 원소를 반복할고 싶을 때 each 옵션
?rep


# 벡터 데이터 처리 함수
x <- c(1,3,5) 
y <- c(3,5)
union(x, y) # 합집합(x+y)
setdiff(x, y) # 차집합(x-y)
intersect(x, y) # 교집합(xy) 

# 벡터 변수에 저장
v1 <- c(33, -5, 20:23, 12, -2:3)
v2 <-c("홍길동", "이순신", "유관순")
v3 <-c(T, TRUE, FALSE, T, TRUE,F,T)
v1;v2;v3
v4 <- c(33, -5, 20:23, 12, "4")     # "4"로 인해 모두 문자화 된다.
v4 # 합계 구하기 
num <- as.numeric(v4)
sum(num)

# 같은 줄에 명령문 중복사용
v1; mode(v1) 
v2; mode(v2)
v3; mode(v3)


# 벡터에 컬럼명 지정
age <- c(30,35,40)
age
names(age) <- c("홍길동", "이순신", "강감찬")
age
age <-NULL # age 변수 데이터 삭제


# 색인(index) 이용 참조 
# 형식) 변수[색인] -> 색인 : 1부터 시작 

# 특정 요소 출력 및 제외
a <- c(1:50)
a[40] # 원소 1개 참조 
a[1:5] # 여러 개 원소 참조 
a[10:45] # a[c(10:45)]


a[-c(10:30)] # -를 붙이면 해당 범위를 제외하고 나타냄.
length(a) # 50
a[10 : (length(a)-5)] # 10~45
a[1, 2] # Error.    comma(,)로 연결되는 것은 차원으로 인식한다. 

# vector 객체 데이터 셋 
install.packages("RSADBE") # 패키지(데이터) 설치
library(RSADBE) # 패키지를 메모리에 로드

data(Severity_Counts) # RSADBE 패키지에서 제공되는 데이터 셋 가져오기
str(Severity_Counts) 
Severity_Counts 
data()





##################################################
#
# 2. Matrix : 동일 데이터 타입을 갖는 2차원 배열
#
# - 생성 함수 : matrix(), rbind(), cbind()
# - 관련함수 : apply() 
##################################################


# (1) c()함수 이용 matrix 생성
m <- matrix(c(1:5))     
m
m <- matrix(c(1:9), nrow=3)     # byrow = T  ===> 2차원 행렬을 만들 때 원소를 행 부터 채워넣는 옵션. 행 우선. 
m
m <- matrix(c(1:10), nrow=2, byrow=T) 
m
m[1:2, 2:4] # 부분 추출을 할 때는 범위지정을 하면 된닷.

# (2) rbind()/cbind() 함수 이용      
x1 <- c(5,40,50:52) 
x2 <- c(30,5,6:8) 
x1; x2
mr <- rbind(x1,x2) ## 행 단위로 묶기
mr
mc <- cbind(x1,x2)  ## 열 단위로 묶기
mc

# 전치행렬로 변경 시켜줌 
t(mc)

# (3) matrix()함수 이용  == (1)번
m3 <- matrix(10:19, 2)  # 10개 데이터를 2행으로 생성
m3

# 자료와 객체 Type 보기
mode(m3); class(m3) #numeric, matrix

# ma행렬 데이터 접근 : [행첨자,열첨자] 이용
m3[1,]      # 1행 전체
m3[,5]      # 5열 전체
m3[2,3]     #2행 3열의 데이터 1개 -> 15
m3[1, c(2:5)]   # 1행에서 2~5열 데이터 4개
m3[c(1:2),c(2:3)]   # box 형태 참조 
m3[,-3]         # 3번째 칼럼 제외 


# matrix 데이터 처리 함수      
x <- matrix(c(1:9), nrow=3, ncol=3) # 3행 3열 matrix 객체
length(x) # 데이터 개수 
ncol(x); nrow(x) # 열/행 수
x


# matrix에 컬럼이름 적용하기
colnames(x) <- c("one", "two", "three")   
# rownames(x) <- c(1,2,3)
x
## names() vs colnames()
# names() : vector
# colnames() : matrix, data.frame



# 형식) apply(변수(객체), 행/열, 내장함수)
apply(x,1,max) # 행 단위 최대값
apply(x,1,min) # 행 단위 최대값
apply(x,1,sum)
apply(x,2,mean) # 열 단위 평균값   


# 사용자 함수와 apply() 적용
f <- function(x){        #   =>>  x 매개변수 
    x * c(1,2,3)    # 매개변수로 넘어온 x가 행별로 들어온다. 반환은 열로 반환.
}
x
apply(x, 1, f)








####################################################
#                                                  #
# 3. Array : 동일 데이터 타입을 갖는 다차원 배열   #
#                                                  #
####################################################

d <- c(1:12) # 12개 벡터 객체 생성
arr <- array(d, c(3,2,2)) # 3행2열2면 -> 3차원 배열 객체 생성
arr

# 배열 조회
arr[,,1] #1면 
arr[,,2] #2면 

# 배열 자료형과 자료구조 
mode(arr); class(arr) #numeric, array

data("iris3")
iris3
str(iris3)
iris3[,,1]
iris3[,2,]

# 배열 객체 데이터 셋 
library(RSADBE) # 패키지를 메모리에 로드
data(Bug_Metrics_Software)
Bug_Metrics_Software






#############################################################################
#
# 4. List : 서로 다른 데이터 구조
#
# 성격이 다른 데이터(벡터, 행렬, 데이터프레임 등 모든 데이터)
# python : dict = {'id:''hong', 'name':'홍길동', 'age':35}
#  R vector(3) = |'id:''hong'|'name':'홍길동'|'age':35|
# l1 = [1,2,3] ,  l2 = [1,2,[2,3],3]
#############################################################################

# 1) 1차원 리스트 

# (1) 1차원 리스트 : 1개의 원소를 갖는 리스트 : key 생략 
list <- list("lee","이순신",95,"hong","홍길동",85)
list # 전체 리스트 확인 
# [[1]]     <- key생략했을 때 설정되는 key의 형태
# [1] "lee" <- value

list[[1]]  # key를 이용하여 value를 반환 

# vector[인덱스]
list[1]

# list 구조 제거 -> vector           리스트를 제거하면 벡터화가 된다.
vec_list <- unlist(list)        
vec_list

# (2) 1차원 리스트 : 2개 이상의 원소를 갖는 리스트
num <- list(c(1:5), c(6:10))
num
num[1]
num[2]

# (3) 1차원 리스트의 key = value 형식 
num2 <- list(first=c(1:5), second=c(6:10)) # key = value형태로 저장      
num2
num2[[1]] # 첫번째 value 
num2[1] # 첫번째 key, value 확인 

# key -> value 참조 
# 형식) 변수$키 
num2$first
num2$second

num2$first[1:3]

# key, value 형태로 저장
member <- list(name=c("홍길동","이순신"), age = 35,address="한양", gender="남자", htype="아파트")
member

member$name[1]
# "홍길동"


# list 원소 접근 - 변수$키
member$age <- 45  # 원소 수정 
member$id <- "hong" # 원소 추가 
member$pwd <- "1234" # 원소 추가       
member$age <- NULL  # 원소 제거     ==> age라는 key 자체가 없어진다.
member

# list의 데이터와 객체 타입 보기
mode(list); class(list) # list, list            여러가지 타입이 혼합되어있기때문에 list로 나온다.

length(member) # 6 -> 키 값의 수

# list data 처리 함수
a <- list(c(1:5))
b <- list(6:10)    
a; b

lapply(c(a,b), max) # list로 결과 반환
sapply(c(a,b), max)  # vactor로 결과 반환


## apply() vs lapply(), sapply()
# matrix , data.frame : apply()
# list : lapply(), sapply()



# 2) 다차원 리스트
# - list 내의 list 자료구조 [1,2,3,[4,5]]
multi_list <- list(c1=list(1,2,3), c2=list(10,20,30), c3=list(100,200,300))
multi_list

class(multi_list)   # list

multi_list$c1
multi_list$c2[[2]]
multi_list$c3

cbind(multi_list)
do.call(cbind, multi_list)
class(do.call(cbind, multi_list))







#####################################################################
#
# 5. Data Frame : 행과 열의 2차원 자료구조(=matrix), DB의 Table구조와 동일  
#
# matrix : 모든 값이 같은 타입이어야함. 
# Data Frame : 여러개의 타입 가능
#####################################################################


# 1) Vector이용 객체 생성
no <- c(1,2,3)
name <- c("hong", "lee", "kim")
pay <- c(150,250,300)
vemp <- data.frame(NO=no, Name=name, Pay=pay) #컬럼명 지정 
vemp

# 2) matrix이용 객체 생성
m <- matrix(
    c(1,"hong",150,
      2, "lee", 250,
      3, "kim", 300) ,3 ,by=T) # 행우선, 3개 리스트 생성
m
memp <- data.frame(m)      
memp
# 컬럼 이름 지정 
names(memp) <- c("No", "Name", "Pay")


# 3) txt파일 이용 객체 생성
getwd()
setwd("C:/NCS/Rwork/Part-I") 
txtemp <- read.table('emp.txt', header=T, sep="") # '파일이름', 헤더 유무, 구분자 
txtemp
class(txtemp) # "data.frame"

# 4) csv파일 이용 객체 생성
csvtemp <- read.csv('emp.csv', header=T) # '파일이름', 헤더유무, 콤마구분
csvtemp
class(csvtemp) # "data.frame"

str(csvtemp)


# list$ vs dataframe$
# list : 변수$key
# dataframe : 변수$column


# 급여의 평균과 합계 구하기 
pay <- csvtemp$pay # 칼럼 -> vector 
pay
avg = mean(pay)
tot = sum(pay)
avg; tot



# 컬럼명이 없는 파일인 경우
name <- c("사번","이름","급여")
read.csv('emp2.csv', header=F, col.names=name)    # '파일명', 헤더유무 = F or T , 컬럼명 지정



# 데이터프레임 객체 데이터 셋  
install.packages("psych") #　패키지 설치
library(psych) # 패키지 로드
data(galton) # galton 데이터 셋 가져오기 
str(galton) 



# [실습]
sid <- c(20017001,20017002,20017003)
score <- c(90,85,75)
gender <- c('M', 'F', 'M')
major <- c('영어', '수학', '컴퓨터')

student <- data.frame(sid, score,gender, major)
student

# score의 최대, 최소, 표준편차, 평균, 합계
sscore <- student$score

max(sscore)
min(sscore)
var(sscore)
sd(sscore); sqrt(var(sscore))
mean(sscore)
sum(sscore)


# 분산 : [1] 58.33333
# 표준편차 : [1] 7.637626

# 펴본에 대한 분산 공식
avg <- mean(sscore)
var <- ((sscore[1]-avg)^2 + (sscore[2]-avg)^2 + (sscore[3]-avg)^2)/(length(sscore)-1)
var
sd <- sqrt(var)
sd


# 5) apply() 함수 적용 : 데이터프레임 객체에 apply() 적용
# 형식 : apply('data.frame/matrix', 1/2(행/렬), Func)


r1 <- c(100,80,90)
r2 <- c(90,80,75)
r3 <- c(86,78,95)    
Data <-data.frame(r1=r1, r2=r2, r3=r3)
Data

apply(Data, 1, min) # 행 단위 함수 적용 - 86 78 75
apply(Data, 2, min) # 열 단위 함수 적용 - 80 75 78 


# 6) 서브셋 만들기 - subset(DF, 조건식)   # DF의 조건에 맞는 데이터 선별
x <- 1:5
y <- 6:10
df <- data.frame(x, y)
df

x1 <- subset(df, x>=3) # x가 3이상인 레코드 대상       
x1; class(x1)
y1 <- subset(df, y<=8) # y가 8이하인 레코드 대상 
y1

xy <- subset(df, x>=2 | y <=6)  # | : or
xy

xy2 <- subset(df, x>=2 & y <=6) # & : and
xy2



# 7) Data join : 칼럼 값으로 기준으로  두 개의 프레임 연결    

height <- data.frame(id=c(1,2), h=c(180,175))
weight <- data.frame(id=c(1,2), w=c(80,75))

height
weight

user <- merge(height, weight, by.x="id", by.y="id")
user <- merge(height, weight, by.y="id") # 한개만 써도 되네?? 
user



# 8) 문자열 처리 함수와 정규표현식 - p.65
# stringr 패키지에서 제공하는 함수 이용 문자열 처리

install.packages("stringr")  # 패키지 설치
library(stringr) # 메모리 로딩

# 형식) str_extract('문자열', '정규표현식')
str_extract("abcd12aaa33", "[0-9]{2}") # "12" -> 연속된 숫자2개 추출(첫번째)
str_extract_all("abcd12aaa33", "[0-9]{2}") # "12" "33" -> 모두


# 1. 반복수 관련 정규표현식 

str <- 'hoNgkildong35lee45kang55유관순25'
# 연속된 영문자 3개 추출 
result <- str_extract_all(str, '[a-zA-Z]{3}') # list 반환 
result

# 숫자 추출 
result <- str_extract_all(str, '[0-9]{2}') # list 반환
result

# 한글 추출 
result <- str_extract_all(str, '[가-히]{3}') # list 반환
result

# 특정 단어 추출 
str_extract_all(str, '유관순')


# 2. 단어와 숫자 관련 정규표현식 
# 단어 : \\w
# 숫자 : \\d

# 주민번호 양식 검사 
jumin <- '123456-3234567'
str_extract_all(jumin, '[0-9]{6}-[1,2,3,4][0-9]{6}')
str_extract_all(jumin, '\\d{6}-[1,2,3,4][0-9]{6}')

# email 양식 검사 
email <- 'kp1234@naver.com'
str_extract_all(email, '[a-z][a-zA-Z0-9]{4,}@[a-z]{3,}.[a-z]{2,}')
str_extract_all(email, '\\w{4,}@[a-z]{3,}.[a-z]{2,}')

# 3. 특정 문자열 제외하는 정규표현식 
str <- 'hongkildong35lee45kang55유관순25'
str_extract_all(str, '[^a-z]{2}')   # ^ : 제외의 의미

# 4. 문자열 길이 구하기 
length(str)
str_length(str) # 29


# 5. 문자열 위치(index)     str_locate_all
str_locate(str, 'k')
str_locate_all(str, 'k') # 5, 9

# 6. 부분 문자열    형식 str_sub('문자열', 시작, 끝)
str_s <- str_sub(str, 5, 15)
str_s

# 7. 문자열 교체
str2 <- '홍길동,이순신,유관순'
str_replace_all(str2, '홍길동', '김길동')   #형식 str_replace('문자열', 바꿀대상, 바꿀내용)

# 8. 문자열 분리 
str_p <- str_split(str2, ',')   # str_split(문자열, '구분자')
str_p
str_p[[1]]

# 9. 문자열 결합 - paste() : base 패키지 제공  
str3 <- c('홍길동', '이순신', '유관순')
str_result <- paste(str3, collapse = ',')   # 형식 paste(벡터, collapse='합칠 구분자')
str_result #  "홍길동,이순신,유관순"
# str_split(str_result, ',') -> paste와 split은 서로 반대


# 10. 특정 문자열 기준으로 양쪽 분리
# - 주민번호 길이 검사 
jumin2 <- '123456-1234567'
jumin_result <- str_split_fixed(jumin2, '-', 2)     # 형식 str_split_fixed(문자열, '분리기준', 나눌 개수)
jumin_result
jumin_result[,1] # "123456"
jumin_result[,2] # "1234567"











