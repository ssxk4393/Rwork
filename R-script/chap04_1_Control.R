chap04_1_Control


#####################################
## Chapter04_1. 제어문
#####################################



# 제어문 - 조건문과 반복문

# <실습> 산술연산자 
num1 <- 100 # 피연산자1
num2 <- 20  # 피연산자2
result <- num1 + num2 # 덧셈
result # 120
result <- num1 - num2 # 뺄셈
result # 80
result <- num1 * num2 # 곱셈
result # 2000
result <- num1 / num2 # 나눗셈
result # 5

result <- num1 %% num2 # 나머지 계산
result # 0

result <- num1^2 # 제곱 계산(num1 ** 2)
result # 10000
result <- num1^num2 # 100의 20승
result # 1e+40 -> 1 * 10의 40승과 동일한 결과


## <실습> 관계연산자 

# (1) 동등비교 
boolean <- num1 == num2 # 두 변수의 값이 같은지 비교
boolean # FALSE
boolean <- num1 != num2 # 두 변수의 값이 다른지 비교
boolean # TRUE

# (2) 크기비교 
boolean <- num1 > num2 # num1값이 큰지 비교
boolean # TRUE
boolean <- num1 >= num2 # num1값이 크거나 같은지 비교 
boolean # TRUE
boolean <- num1 < num2 # num2 이 큰지 비교
boolean # FALSE
boolean <- num1 <= num2 # num2 이 크거나 같은지 비교
boolean # FALSE

## <실습> 논리연산자
logical <- num1 >= 50 & num2 <=10 # 두 관계식이 같은지 판단 And
logical # FALSE
logical <- num1 >= 50 | num2 <=10 # 두 관계식 중 하나라도 같은지 판단 or
logical # TRUE

logical <- num1 >= 50 # 관계식 판단
logical # TRUE
logical <- !(num1 >= 50) # 괄호 안의 관계식 판단 결과에 대한 부정
logical # FALSE


x <- TRUE; y <- FALSE
xor(x,y) # [1] TRUE
x <- TRUE; y <- TRUE
xor(x,y) # [1] FALSE



###############################
## 1. 조건문
###############################

# 1) if()함수
x <- 10
y <- 5
z <- x * y
z

#if(조건식){ # 산술,관계,논리연산자
#   실행문1  <- 참
#}else{
#   실행문2  <- 거짓 
#}


if(x*y < 40){ # 산술 > 관계 > 논리 
    cat("x*y의 결과는 40 이상입니다.\n")  # \n 줄바꿈   # cat : 문자와 변수를 혼합해서 출력할 수 있는 것.
    cat("x*y =", z)
}else{
    cat("x*y의 결과는 40 미만입니다. x*y =", z,"\n")
}


# 학점 구하기
score <- scan()
score # 85

if(score >= 90){  # 조건식1
    result="A학점"  # 조건식1 참
}else if(score >=80){ # 조건식2
    result="B학점"  # 조건식1 거짓, 조건식2 참 
}else if(score >=70){
    result="C학점"
}else if(score >=60){
    result="D학점"
}else{
    result="F학점"
}  
cat("당신의 학점은 ",result)  # 당신의 학점은  B학점
print(result) 


######### [실습] 2의 배수 연산 ##########

10/2 #5
10 %% 2 # 0

# 문1) 키보드로 임의의 숫자를 입력받아서 짝수/홀수를 판별하시오
num1111 <- scan()

if(num1111 %% 2 ==1){
    cat("입력하신 숫자는 홀수 입니다. \n")
}else{
    cat("입력하신 숫자는 짝수 입니다.")
}

# 문2) 주민번호 14자리를 입력하여 8번째 숫자로 성병을 판별하시오.
# 예) 123456-[1]234567 -> 당신은 남자입니다.

library(stringr)
identifyNum <- scan(what = "")      # 문자를 입력할 때는 (what = "") 옵션 필

gen <- str_sub(identifyNum, 8,8)

if(gen=='1' | gen=='3'){
    cat("남자")
}else if(gen=='2' | gen=='4'){
    cat("여자")
}else{
    cat("잘못입력")
}




#### 2) ifelse(조건, 참, 거짓) - 3항 연산자 기능

score <- c(78, 95, 85, 65)
ifelse(score>=80, "우수","노력")  # 벡터 하나하나를 개별로 비교해서 값을 반환해줌.
# [1] "노력" "우수" "우수" "노력"


#ifelse() 응용
excel <- read.csv("c:/NCS/Rwork/Part-I/excel.csv", header = T)
head(excel)
str(excel)


q5 <- excel$q5  # 5점 척도(1~5)
result <- ifelse(q5 >= 3, '큰 값', '작은 값')   # Binary Data 2진화
result
table(result)

q1 <- excel$q1 # q1 변수값 추출
q1[1:5]
ifelse(q1>=4, sqrt(q1),q1) #4보다 큰 경우 sqrt()적용

#논리연산자 적용
range(q1) # 1 ~ 5
ifelse(q1>=2 & q1<=4, q1^2, q1) #1과 5만 출력, 나머지(2~4) 지수승

## [실습] NA -> 평균 치환
x <- c(75,85,NA,95,75)
x
y <- ifelse(is.na(x), mean(x, na.rm = T), x)
y   # [1] 75.0 85.0 82.5 95.0 75.0

ifelse(!is.na(x), x, mean(x,na.rm = T))



##### 3) switch 문
# 형식) switch(비교구문, 실행구문1, 실행구문2, 실행구문3)

# switch(식, case1, case2, case3 ...)
switch("pwd", id="hong", pwd="1234",age=105, name="홍길동")    

# 4) which 문
# which()의 괄호내의 조건에 해당하는 위치(인덱스)를 출력한다.
x <- c(2,3,5,7,8)
x 
which(x ==7)    # 7이 저장된 index를 반환한다.


# 벡터에서 사용-> index값 리턴
name <- c("kim","lee","choi","park")
which(name=="choi") # 3


# 데이터프레임에서 사용
no <- c(1:5)
name <-c("홍길동","이순신","강감찬","유관순","김유신")
score <- c(85,78,89,90,74)

exam <- data.frame(학번=no,이름=name,성적=score)
exam
which(exam$이름=="유관순") 







###############################
##
## 2. 반복문
##
###############################



#### 1) 반복문 - for(변수 in 값) {표현식}      ## 파이썬이랑 비슷!
i <- c(1:10)
i #  1  2  3  4  5  6  7  8  9 10
d <- numeric()  # 숫자를 저장하는 빈 vector

for(n in i){ # 10회 반복
    print(n * 10) # 계산식(numeric만 가능) 출력
    print(n)
    d[n] <- n*2
}
d  # [1]  2  4  6  8 10 12 14 16 18 20


for(n in i){
    if(n%%2 != 0) 
        print(n) # %% : 나머지값 - 짝수만 출력
} 

for(n in i){  # 10 
    if(n%%2==0){
        next # 짝수면 skip
    }else{
        print(n) # 홀수만 출력
    }    
} 


## 문1) 1-100까지 홀수의 합과 짝수의 합을 각각 구하시오.
# even, odd

num <- c(1:100)
even <- 0
odd <- 0

for(n in num){
    if(n%%2==0)
        even <- even+n
    else
        odd <- odd + n
}
cat('짝수합 : ', even,'\n홀수합 : ',odd)



# vector 생
kor <- c(80,78,91)
eng <- c(86,97,75)
mat <- c(80,64,80)
name <- c("홍길동","이순신","유관순")

# data.frame 생성
student <- data.frame(name, kor, eng, mat)
student
# 새로운 칼럼 추가 : 형식) 변수$새칼럼 <- vector 변
student$avg <- avg
student$tot <- tot

## 문2) 각 학생별 평균과 총점을 칼럼을 이용하여 계산하시오.
# <조건1> 평균 소숫점 2자리
# <조건2> for()함수 이용
avg <- numeric()
tot <- numeric()
cnt <- nrow(student)
cntt <- ncol(student)
index <- 1:cnt
for(i in index){
    t <- 0
    for(v in student[i,c(2:4)]){
        t <- t + v 
    }
    tot[i] <- t
    avg[i] <- tot[i]/(cntt-1)
}
student$avg <- round(avg,2)
student$tot <- tot
student$avg <- NULL
student$tot <- NULL

student





#### 2) 반복문 - while(조건){표현식}
i = 0
while(i < 10){
    i <- i + 1  # 카운터 변수 
    print(i) # 1~10까지 출력됨
}

#### 3) 반복문 - repeat{ 탈출조건 }
cnt <-1
repeat{
    print(cnt)
    cnt <- cnt + 2 
    if(cnt>15) break # cnt가 15보다 크면 탈출
}






