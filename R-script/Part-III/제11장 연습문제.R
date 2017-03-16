#################################
## <제11장 연습문제>
################################# 

#01. MASS 패키지에 있는 Animals 데이터 셋을 이용하여 각 단계에 맞게 기술통계량을 구하시오.

#<단계 1> MASS 패키지 설치 및 메모리 로딩
#library(MASS) # MASS 패키지 불러오기
#data(Animals) # Animals 데이터셋 로딩
#head(Animals) # Animals 데이터셋 보기
library(MASS)
data(Animals)
str(Animals)

#<단계 2> R의 기본함수를 이용하여 brain 칼럼을 대상으로 다음 기술통계량 구하기
dim(Animals)# Animals 데이터 셋 차원보기

brain <- Animals$brain
mean(brain)
var(brain)
sd(brain)
sum(brain)
median(brain)

#<단계 3> 패키지에서 제공되는 describe()와 freq()함수를 이용하여 Animals 데이터 셋 전체를 대상으로 기술통계량 구하기
describe(Animals)
freq(Animals)





#02. descriptive.csv 데이터 셋을 대상으로 다음 조건에 맞게 빈도분석 및 기술통계량 분석을 수행하시오
setwd("c:/NCS/Rwork/Part-III")
data <- read.csv("descriptive.csv", header=TRUE)
head(data) # 데이터셋 확인

# 조건1) 명목척도 변수인 학교유형(type), 합격여부(pass) 변수에 대해 빈도분석을 수행하고 
# 결과를 막대그래프와 파이차트로 시각화 

    attach(data)
    tt <- table(type)
    tp <- table(pass)    
    prop.table(tt)
    
    barplot(tt)
    barplot(tp)
    
    pie(tt)
    pie(tp)
    
        
# 조건2) 비율척도 변수인 나이 변수에 대해 요약치(평균,표준편차)와 비대칭도(왜도와 첨도)
# 통계량을 구하고, 히스토그램으로 비대칭도 설명

    mean(age)
    sd(age)
    skewness(age)   ## 양수! 오른쪽 꼬리, mean이 median보다 크다.
    kurtosis(age)
    
    hist(age, freq = F)
    
# 조건3) 나이 변수에 대한 밀도분포곡선과 정규분포 곡선으로 정규분포 검정

    # 확률밀도 분포 곡선 
    lines(density(age), col='blue')

    # 표준정규분포 곡선 
    x <- seq(35, 75, 0.1)
    curve( dnorm(x, mean(age), sd(age)), col='red', add = T)

    shapiro.test(age)
    # W = 0.92312, p-value = 2.633e-11  귀무가설 기각! 정규분포와 지대한 차이가 있음.
    

    detach(data)





