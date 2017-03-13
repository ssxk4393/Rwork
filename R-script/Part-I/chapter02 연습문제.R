#################################
## <제2장 연습문제>
#################################

### 01. 다음과 같은 벡터 객체를 생성하시오.  c(), seq(), rep()

#1) Vec1 벡터 변수를 만들고, "R" 문자가 5회 반복되도록 하시오.

Vec1 <- rep("R",5)
Vec1

#2) Vec2 벡터 변수에 1~10까지 3간격으로 연속된 정수를 만드시오.

Vec2 <- seq(1, 10, 3)   # 시작, 종료, 증감
Vec2

#3) Vec3에는 1~10까지 3간격으로 연속된 정수가 3회 반복되도록 만드시오.

Vec3 <- rep(seq(1,10,3), each=3)
Vec3
Vec33 <- rep(Vec2,3)
Vec33

#4) Vec4에는 Vec2~Vec3가 모두 포함되는 벡터를 만드시오.

Vec4 <- union(Vec2,Vec3)
Vec4
Vec44 <- c(Vec2, Vec3)
Vec44


#5) 25~ -15까지 5간격으로 벡터 생성- seq()함수 이용 

seq(25, -15, -5)

#6) Vec4에서 홀수번째 값들만 선택하여 Vec5에 할당하시오.(첨자 이용)

Vec5 <- Vec4[seq(1,length(Vec4),2)]
Vec5



### 02. 다음과 같은 벡터를 칼럼으로 갖는 데이터프레임을 생성하시오.

name <-c("최민수","유관순", "이순신","김유신","홍길동")
age <-c(55,45,45,53,15) #연령
gender <-c(1,2,1,1,1) #1:남자, 2: 여자
job <-c("연예인","주부","군인","직장인","학생")
sat <-c(3,4,2,5,5) # 만족도
grade <- c("C","C","A","D","A")
total <-c(44.4,28.5,43.5,NA,27.1) #총구매금액(NA:결측치)

# <조건1> 위 7개 벡터를 user이름으로 데이터 프레임 생성

user <- data.frame(Name=name, Age=age, Gender=gender, Job=job, Sat=sat, Grade=grade, Total=total)
user

# <조건2> 성별(gender) 변수를 이용하여 히스토그램 그리기
userAge <- user$Age
hist(userAge)

# <조건3> 만족도(sat) 변수를 이용하여 산점도 그리기
userSat <- user$Sat
plot(userSat)


### 03. Data를 대상으로 apply()를 적용하여 행/열 방향으로 조건에 맞게 통계량을 구하시오.

kor <- c(90,85,90)
eng <- c(70,85,75)
mat <- c(86,92,88)    

# 조건1) 3개의 과목점수를 이용하여 데이터프레임(Data)을 생성한다. 

data <- data.frame(KOR=kor, ENG=eng, MATH=mat)


# 조건2) 행/열 방향으로 max()함수를 적용하여 최댓값 구하기
apply(data, 1, max)
apply(data, 2, max)


# 조건3) 행/열 방향으로 mean()함수를 적용하여 평균 구하기(소숫점 2자리 까지 표현)
#  힌트 : round(data, 자릿수)
round(apply(data, 1, mean),2)
round(apply(data, 2, mean),2)

# 조건3) 행 단위 분산과 표준편차 구하기  
round(apply(data, 1, var),2)
round(apply(data, 2, var),2)
round(apply(data, 1, sd),2)
round(apply(data, 2, sd),2)



### 04. 다음의 Data2 객체를 대상으로 정규표현식을 적용하여 문자열을 처리하시오
Data2 <- c("2017-02-05 수입3000원","2017-02-06 수입4500원","2017-02-07 수입2500원")
library(stringr)
Data2

# 조건1) 일짜별 수입을 다음과 같이 출력하시오. 
#        출력 결과) "3000원" "4500원" "2500원" 
income <- str_extract_all(Data2, '[0-9]{4,}[가-히]')
unlist(income)


# 조건2) 위 벡터에서 연속하여 2개 이상 나오는 모든 숫자를 제거하시오.  
#        출력 결과) "-- 수입원" "-- 수입원" "-- 수입원"  
str_replace_all(Data2, '[0-9]{2,}', '')
# str_extract_all(Data2, '[^0-9]{1}')

"$1,234" -> "1234" -> as.numeric : 1234 


# 조건3) 위 벡터에서 -를 /로 치환하시오.
#        출력 결과) "2017/02/05 수입3000원" "2017/02/06 수입4500원" "2017/02/07 수입2500원"  
str_replace_all(Data2, '-', '/')


# 조건4) 모든 원소를 쉼표(,)에 의해서 하나의 문자열로 합치시오. 
# 힌트) paste(데이터셋, collapse="구분자")함수 이용
#        출력 결과) "2017-02-05 수입3000원,2017-02-06 수입4500원,2017-02-07 수입2500원"
paste(Data2, collapse=',')



### 05. email 양식검사. id가 숫자, 특수문자($,&)로 시작하는 양식 검사하는 정규표현식
email <- '12&k123@naver.com'
str_extract_all(email, '[^0-9|$|&]\\w{4,}@\\w{3,}.\\w{2,}')





