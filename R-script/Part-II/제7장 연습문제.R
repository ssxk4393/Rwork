#################################
## <제7장 연습문제>
################################# 

# 01. 본문에서 생성된 dataset2의 직급(position) 칼럼을 대상으로 1급 -> 5급, 5급 -> 1급 형식으로
# 역코딩하여 position2 칼럼에 추가하시오.


# 02. dataset2의 resident 칼럼을 대상으로 NA 값을 제거한 후 dataset2 변수에 저장하시오.


# 03. dataset2의 gender 칼럼을 대상으로 1->"남자", 2->"여자" 형태로 코딩 변경하여 
# gender2 칼럼에 추가하고, 파이 차트로 결과를 확인하시오.


# 04. 나이를 30세 이하 -> 1, 30~55 -> 2, 55이상 -> 3 으로 리코딩하여 age3 칼럼에 추가한 후 
# age, age2, age3 칼럼만 확인하시오.


# 05. 정제된 data를 대상으로 작업 디렉터리(c:/Rwork/Part-II)에 cleanData.csv 파일명으로 
# 따옴표와 행 이름을 제거하여 저장하고, new_data변수로 읽어오시오.

    # (1) 정제된 데이터 저장
    
    # (2) 저장된 파일 불러오기/확인



# 06. user_data.csv와 return_data.csv 파일을 이용하여 각 고객별 
# 반품사유코드(return_code)를 대상으로 다음과 같이 파생변수를 추가하시오.
    
    
    #<조건1> 반품사유코드에 대한 파생변수 칼럼명 설명 
    # 제품이상(1) -> return_code1, 변심(2) -> return_code2, 
    # 원인불명(3) -> return_code3, 기타(4) -> return_code4 
    
    
    #<조건2> 고객별 반품사유코드를 고객정보(user_data) 테이블에 추가(결과화면 참고) 
    head(user_return_data,10)
    #user_id age house_type resident job return_code1 return_code2 return_code3 return_code4
    #1     1001  35          4     전북   6           NA           NA           NA           NA
    #2     1002  45          4     경남   2           NA           NA           NA           NA
    #3     1003  55          4     경기   6           NA           NA           NA           NA
    #4     1004  43          3     대전   1           NA           NA           NA           NA
    #5     1005  55          4     경기   2           NA           NA           NA           NA
    #6     1006  45          1     대구   1           NA           NA           NA           NA
    #7     1007  39          4     경남   1           NA           NA           NA           NA
    #8     1008  55          2     경기   6            1            0            0            0
    #9     1009  33          4     인천   3            0            1            0            0
    #10    1010  55          3     서울   6           NA           NA           NA           NA
    
    # 단계1 : 고객 정보 파일 가져오기  
    user_data <- read.csv('user_data.csv', header=T)
    head(user_data)
    
    # 단계2 : 반품 정보 파일 가져오기 
    return_data <- read.csv('return_data.csv', header=T)
    head(return_data)
    
    # 단계3 : 고객별 반품사유코드에 따른 파생변수 생성 
    user_return_data <- dcast(return_data, user_id ~ return_code, length)
    head(user_return_data)
    names(user_return_data) <- c('user_id','제품이상(1)','변심(2)','원인불명(3)','기타(4)')    
    head(user_return_data)
    
    # 단계4 : 파생변수 추가 : 고객정보에 반품사유 칼럼 추가 
    library(plyr)
    user_return_data <- join(user_data, user_return_data, by="user_id")
    head(user_return_data, 10)
    
        
# 07. iris 데이터를 이용하여 5겹 2회 반복하는 교차검정 데이터를 샘플링 하시오.
    
    
    iris
    
    cross_i <- cvFolds(n=nrow(iris), K = 5, R = 2, type="random")

    cross_i$subsets[cross_i$which==1,2]
    cross_i$which
    
    R=1:2
    K=1:5
    
    for(r in R){
    
        for(k in K){
            idx <- cross_i$subsets[cross_i$which==k,r]
            cat("k = ", k, '검정데이터 \n')
            print(iris[idx,])
            
            for(i in K[-k]){
                idx <- cross_i$subsets[cross_i$which==k,r]
                cat("k = ", i,"훈련데이터 \n")
                print(iris[idx,])
            }
            
        }    
        
    }
    
    
      cat('k= ',k, '검정데이터 \n')
        print(df[idx,])
    
    
    
    
    
    
    
    
    
    
    

