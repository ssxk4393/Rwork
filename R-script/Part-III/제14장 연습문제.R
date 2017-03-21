#################################
## <제14장 연습문제>
################################# 

# 01. 다음은 drinkig_water_example.sav 파일의 데이터 셋이 구성된 테이블이다. 
# 전체 2개의 요인에 의해서 7개의 변수로 구성되어 있다. 아래에서 제시된 각 단계에 맞게  
# 요인분석을 수행하시오.  

# 단계 1 : 데이터 파일 가져오기 
library(memisc)
setwd("C:/NCS\\Rwork\\Part-III")
data.spss <- as.data.set(spss.system.file('drinking_water_example.sav'))
data.spss
drinkig_water_exam <- data.spss[1:7]
drinkig_water_exam_df <- as.data.frame(drinkig_water_exam) 
str(drinkig_water_exam_df)

#단계 2 : 베리멕스 회전법, 요인수 2, 요인점수 회귀분석 방법을 적용하여 요인분석  

    p <- prcomp(drinkig_water_exam_df) # scale = TRUE
    summary(p)
    plot(p)
    biplot(p)
    
    # 상관관계 행렬 대상 고유값 계산  
    cor(drinkig_water_exam_df) # 6개 과목변수 간의 상관계수 보기 

    # eigen()함수를 이용하여 상관계수 행렬을 대상으로 고유값 계산 
    en <- eigen(cor(drinkig_water_exam_df)) # $values : 고유값, $vectors : 고유벡터   
    names(en)

    # $values : 고유값(스칼라) 보기  
    en$values # 결과치가 1이상이면 요인으로 본다.
    # - 고유값이란 어떤 행렬(상관관계수 행렬)로부터 유도되는 특정한 실수값

    plot(en$values, type="o") # 

    result <- factanal(drinkig_water_exam_df, factors = 2, rotation = 'varimax', scores = "regression")
    result # p-value is 0.114
    
    
#단계 3 : 요인적재량 행렬의 칼럼명 변경 
    
    print(result, digits = 2, cutoff=0.5) 
    result$loadings
    colnames(result$loadings) <- c('요인1','요인2')
    
    
#단계 4 : 요인점수를 이용한 요인적재량 시각화
    result
    head(result$scores)
    plot(result$scores[,1], result$scores[,2], main='요인 1,2 시각화')

    
    # 요인점수행렬(= 관측치 수) 
    # row = Factor1, column = Factor2
    
    # 관측치별 이름 매핑(rownames mapping)
    text(result$scores[,1], result$scores[,2], 
         labels = rownames(result$scores), cex = 0.7, pos = 3, col = "blue")
    
    # 요인적재량 plotting
    points(result$loadings[,c(1:2)], pch=19, col = "red")
    
    text(result$loadings[,1], result$loadings[,2], 
         labels = rownames(result$loadings), 
         cex = 0.8, pos = 3, col = "red")
    
#단계 5 : 요인축소 : 요인분석 지표 이용 요인 축소 

    final <- as.data.frame(as.matrix(drinkig_water_exam_df) %*% as.matrix(result$loadings))
    final
    

    
    
# 02. 문제 01에서 생성된 두 개의 요인을 데이터프레임으로 생성한 후 이를 이용하여 
# 두 요인 간의 상관관계 계수를 제시하시오.

    
    cor(final)
    #          Factor1  Factor2
    # Factor1 1.000000 0.829311
    # Factor2 0.829311 1.000000
    
    
