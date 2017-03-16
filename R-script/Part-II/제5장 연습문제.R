#################################
## <제5장 연습문제>
################################# 

# 01. iris3 데이터 셋을 대상으로 다음 조건에 맞게 산점도를 그리시오.

# 조건1) iris3 데이터 셋의 칼럼명 확인 
attributes(iris3)   # [1] 50  4  3      => 50행, 4열, 3

# 조건2) iris3 데이터 셋의 구조 보기   
mode(iris3)
class(iris3)
str(iris3)

# 조건3) 꽃의 종류 별로 산점도 그리기 
par(mfrow=c(1,1))
plot(iris3[,c(1,3),1], main="Setosa")
plot(iris3[,c(1,3),2], main="Versicolor")
plot(iris3[,c(1,3),3], main="Virginica")


# 02.  iris 데이터 셋을 대상으로 다음 조건에 맞게 시각화 하시오.
attributes(iris)
#  조건1) 1번 컬럼 x축, 3번 컬럼 y축으로 차트 작성
#         힌트) plot(x, y)
plot(iris[,1,], iris[,2,], xlab = "Sepal L", ylab ="Petal L", main="iris Length")

#  조건2) 5번 컬럼으로 색상 지정 
#         힌트) plot(x, y, col=컬럼)
plot(iris[,1], iris[,2], xlab = "Sepal L", ylab ="Petal L", col=iris$Species)

#  조건3) "iris 데이터 테이블 산포도 차트" 제목 추가  
#          힌트) title(main="제목")
title(main="iris 데이터 테이블 산포도 차트")

#  조건4) 다음 조건에 맞게 작성한 차트를 파일에 저장하기

setwd("c:/NCS/Rwork/output")

#작업 디렉터리 : "C:/Rwork/output"
#파일명 : iris.jpg
#픽셀 : 폭(720픽셀), 높이(480 픽셀)
jpeg("exam_iris.jpg", width=720, height=480)
plot(iris[,1], iris[,2], xlab = "Sepal L", ylab ="Petal L", col=iris$Species, main="iris 데이터 테이블 산포도 차트")
#title(main="iris 데이터 테이블 산포도 차트")
dev.off() # 장치 종료 






