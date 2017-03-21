#################################
## <제15장 연습문제>
################################# 


# 01. product.csv 파일의 데이터를 이용하여 다음과 같은 단계로 다중회귀분석을 수행하시오.
product <- read.csv("C:/Rwork/Part-IV/product.csv", header=TRUE)

#  단계1 : 학습데이터(train),검정데이터(test)를 7 : 3 비율로 샘플링

#  단계2 : 학습데이터 이용 회귀모델 생성 
#           변수 모델링) y변수 : 제품_만족도, x변수 : 제품_적절성, 제품_친밀도

#  단계3 : 검정데이터 이용 모델 예측치 생성 

#  단계4 : 모델 평가 : cor()함수 이용  



# 02. ggplot2패키지에서 제공하는 diamonds 데이터 셋을 대상으로 
# carat, table, depth 변수 중 다이아몬드의 가격(price)에 영향을 
# 미치는 관계를 다중회귀 분석을 이용하여 예측하시오.

    #조건1) 다이아몬드 가격 결정에 가장 큰 영향을 미치는 변수는?
    #조건2) 다중회귀 분석 결과를 정(+)과 부(-) 관계로 해설

library(ggplot2)
data(diamonds)
str(diamonds)

    result <- lm(price~ carat + table+ depth, data=diamonds)
    result    
    summary(result)
    # (Intercept)        carat        table        depth  
    # 13003.4       7858.8       -104.5       -151.2 
    # Adjusted R-squared:  0.8537    
    #  캐럿이 다이아몬드의 가격에 가장 큰 영향을 미친다.
    #  0.85의 설명력을 가지고있음.
    #  정 : carat, 부 :  table, depth
    
    
    vif(result)
    # carat    table    depth 
    # 1.042039 1.141032 1.104275 
    # 다중공선성 검정이 10을 넘지 않으므로 변수들의 상관관계는 없다.!

    
    
    dwtest(result)
    plot(result)
    shapiro.test(sample(result$residuals, 5000))
    cor(result$fitted.values, diamonds$price)
    # [1] 0.923946
    
    
    
    
    
# 03. mpg 데이터 셋을 대상으로 7:3 비율로 학습데이터와 검정데이터로 각각 
# 샘플링한 후 각 단계별로 분류분석을 수행하시오.

# 조건) 변수모델링 : 독립변수(설명변수) : displ + cyl + year 
#       종속변수(반응변수) : cty

library(ggplot2)
data(mpg)
str(mpg) 

# 단계1 : 학습데이터와 검정데이터 샘플링
    idx <- sample(1:nrow(mpg), nrow(mpg) * 0.7) 
    train <- mpg[idx,]
    test <- mpg[-idx,]
    nrow(train)
    nrow(test)        

# 단계2 : formula(공식) 생성
    f <- cty~displ + cyl + year
    
# 단계3 : 학습데이터에 분류모델 적용
    model <- ctree(f, data=train)
    model
    
# 단계4 : 검정데이터에 분류모델 적용
    pred <- predict(model, test)
    cor(pred, test$cty)
    
# 단계5 : 분류분석 결과 시각화
    plot(model)
    
# 단계6 : 분류분석 결과 해설

    # displ = 2.5 를 기준으로 데이터가 분류되고,  
    # 1.9 < displ <= 2.5 일때에 year = 1999를 기준으로 분류된다.    

    
    
    
    
# 04. weather 데이터를 다음과 같은 단계별로 분류분석을 수행하시오. 

# 조건1) rpart() 함수 이용 분류모델 생성 
# 조건2) 변수 모델링 : y변수 : RainTomorrow, x변수 : Date와 RainToday 변수 제외한 나머지 변수
# 조건3) 비가 올 확률이 50% 이상이면 ‘Yes Rain’, 50% 미만이면 ‘No Rain’으로 범주화

# 단계1 : 데이터 가져오기
library(rpart)
weather = read.csv("c:/Rwork/Part-IV/weather.csv", header=TRUE) 

# 단계2 : 데이터 샘플링

# 단계3 : 분류모델 생성

# 단계4 : 예측치 생성 : 검정데이터 이용 

# 단계5 : 예측 확률 범주화('Yes Rain', 'No Rain') 

# 단계6 : 혼돈 matrix 생성 및 분류 정확도 구하기
