# test

# 수업내용
# 1. 패키지와 세션보기
# 2. 패키지 사용법


# 1. 패키지와 세션 보기
dim(available.packages())
# [1] 9620(행 : 패키지수)   17(열)


sessionInfo()
# r의 version, 다국어 정보, 설치된 패키지, 



# 2. 패키지 사용법

install.packages('stringr')     #1단계. 패키지 설치
library(stringr)                #2단계. 메모리 로딩


#3단계. 함수 사용
str_extract_all('홍길동35이순신45강감찬55', '[0-9]{2}')
str_extract_all('홍길동35이순신45강감찬55', '[가-히]{3,}') 






# Rserver 패키지 설치
install.packages("Rserve")

# 차트 -> 이미지 저장
x <- rnorm(20, mean=0, sd=1)

x

barplot(x, main="정규분포를 따르는 난수 확률분포 시각화", col=rainbow(20))

# java project 폴더에 저장
setwd("C:\\NCS\\jsp\\workspace(jsp)\\chap10_Rtest\\WebContent\\view")
getwd()
jpeg('rnorm.jpg', width=720, height=450)    # 장치 open
barplot(x, main="rnorm result chart", col=rainbow(20))
dev.off() # 장치 close

















