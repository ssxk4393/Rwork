#################################
## <제16장 연습문제>
################################# 

# 01. iris 데이터 셋의 1~4번째 변수를 대상으로 유클리드 거리 매트릭스를 구하여 
# idist에 저장한 후 계층적 클러스터링을 적용하여 결과를 시각화 하시오.

    iris[1:4] # 4개변수 전체
    
    d <- iris[1:4]

    #단계1. 유클리드 거리 계산
        result <- dist(d, method="euclidean")
    
    #단계2. 계층형 군집분석(클러스터링)
        hc <- hclust(result)

    #단계3. 분류결과를 대상으로 음수값을 제거하여 덴드로그램 시각화
        plot(hc, hang=-1)
    
    #단계4. 그룹수를 4개로 지정하고 그룹별로 테두리 표시
        rect.hclust(hc, k=4, border="red")
    




# 02. 다음과 같은 조건을 이용하여 각 단계별로 비계층적 군집분석을 수행하시오.

# 조건1) 대상 파일 : c:/Rwork/Part-IV/product_sales.csv
# 조건2) 변수 설명 : tot_price : 총구매액, buy_count : 구매횟수, 
#                    visit_count : 매장방문횟수, avg_price : 평균구매액

sales <- read.csv("c:/NCS/Rwork/Part-IV/product_sales.csv", header=TRUE)
head(sales) 

# 단계1: 비계층적 군집분석 : 3개 군집으로 군집화
    ks <- kmeans(sales, 3)
    
    
    # 계층적 군집분석도 해봐서 비교해봄!
    hs <- hclust(dist(sales), method='average')
    plot(hs, hang=-1)
    rect.hclust(hs, k=3)
    sales$hclust <- cutree(hs, k=3)

    table(sales$cluster, sales$hclust)
    
# 단계2: 원형(원래의 데이터)데이터에 군집수 추가
    
    sales$cluster <- ks$cluster
    sales
        
# 단계3 : tot_price 변수와 가장 상관계수가 높은 변수와 군집분석 시각화

    cor(sales[,-5])
    #               tot_price visit_count   buy_count  avg_price
    # tot_price    1.00000000   0.8179536 -0.01305105  0.8717542
    # visit_count  0.81795363   1.0000000 -0.23061166  0.9627571
    # buy_count   -0.01305105  -0.2306117  1.00000000 -0.2785045
    # avg_price    0.87175416   0.9627571 -0.27850452  1.0000000
    
    # tot_price와 avg_price가 가장 큰 상관관계!
    
    corrgram(sales[,-5])
    corrgram(sales[,-5], upper.panel = panel.conf)
    
    
# 단계4. 군집의 중심점 표시

    
    plot(sales$avg_price, sales$tot_price, col=sales$cluster)
    points(ks$centers[,c(4,1)], col=c(2,4), pch=8, cex=5)    
    
    

        
# 03. tranExam.csv 파일을 대상으로 중복된 트랜잭션 없이  
# 1~2컬럼만 single 형식으로 트랜잭션 객체를 생성하시오.
    
    # (파일경로 : C:/Rwork/Part-IV/tranExam.csv)
        tran <- read.transactions('C:/NCS/Rwork/Part-IV/tranExam.csv', 
                                  format = 'single', rm.duplicates = T, cols = c(1,2), sep=',')
        tran
    
    # 단계1 : 트랜잭션 객체 생성 및 확인
        inspect(tran)

    # 단계2 : 각 item별로 빈도수 확인
        
        summary(tran)
        # sizes
        # 2 4 
        # 4 1 
        # 아이템 2개로 구성된 트랜잭션이 4개!
        # 아이템 4개로 구성된 트랜잭션이 1개!
        
    # 단계3 : 파라미터(supp=0.3, conf=0.1)를 이용하여 규칙(rule) 생성 
    
        rule <- apriori(tran, parameter = list(supp=0.3, conf=0.1))
    
    # 단계4 : 연관규칙 결과 보기

        rule    
        inspect(sort(rule, by='lift'))
        
        
        
        
        
# 04. Adult 데이터셋을 대상으로 다음 단계별로 연관분석을 수행하시오.

# 단계1: 최소 support=0.5, 최소 confidence=0.9를 지정하여 연관규칙 생성

# 단계2: 수행한 결과를 lift 기준으로 정렬하여 상위 10개 규칙 확인

# 단계3: 연관분석 결과를  LHS와 RHS의 빈도수로 시각화 

# 단계4: 연관분석 결과를 연관어 네트워크 형태로 시각화

# 단계5: 연관어 중심 단어 해설

# 05. Adult 데이터셋을 대상으로 다음 단계별로 연관분석을 수행하시오.

# 단계1 : support=0.3, confidence=0.95가 되도록 연관규칙 생성

#  단계2 : 왼쪽 item이 백인(White)인 규칙만 서브셋으로 작성하고, 시각화

#  단계3 : 왼쪽 item이 백인이거나 미국인을 대상으로 서브셋을 작성하고, 시각화

#  단계4 : 오른쪽 item에서 'Husband' 단어를 포함 규칙을 서브셋으로 작성하고, 시각화
