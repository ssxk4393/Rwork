# Formal(2_MariaDB)
# Maria DB 정형 데이터 처리

# 패키지 설치  : ## 한번 설치 했기에 안해도 된다. 다운받아져 있는 것
# - RJDBC 패키지를 사용하기 위해서는 우선 java를 설치해야 한다.
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC") # JDBC()함수 제공 



# 패키지 로딩 :  ## 컴퓨터를 껏다 켰으면 다시 해야함
library(DBI)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_111')
library(rJava)
library(RJDBC) # rJava에 의존적이다.

################ MariaDB or MySql ###############
drv <- JDBC(driverClass="com.mysql.jdbc.Driver", 
            classPath="C:\\NCS\\python\\util\\mysql-connector-java-5.1.40\\mysql-connector-java-5.1.40\\mysql-connector-java-5.1.40-bin.jar")

# driver가 완전히 로드된 후 db를 연결한다.
conn <- dbConnect(drv, "jdbc:mysql://127.0.0.1:3306/work", "scott", "tiger")
#################################################           

# DB 연결 확인 :  테이블의 컬럼 보기 
dbListFields(conn, "goods") # conn, table name


query <- "select * from goods"
dbGetQuery(conn,query)

query <- "select * from goods where dan >= 700000"
dbGetQuery(conn,query)



#db 구조 변경
# 1. 레코드 삽입
dbSendUpdate(conn, "insert into goods values(8, '전화기', 4, 450000)")
dbGetQuery(conn, 'select * from goods')


#2. 레코드 수정
dbSendUpdate(conn, "update goods set name='phone' where code=8")
dbGetQuery(conn, 'select * from goods')


#3. 레코드 삭제
dbSendUpdate(conn, "delete from goods where code=7")
dbGetQuery(conn, 'select * from goods')



## file -> DB 저장
recode <- read.csv("C:\\NCS\\Rwork\\data\\recode.csv", header = T)
recode
dbWriteTable(conn, 'goods', recode)    ## 기존 'goods' 데이터는 손실
goods <- dbGetQuery(conn, 'select * from goods')
str(goods)



## price = []       # 빈 list만들기

price <- numeric()      # 빈 vector 만들기

for(i in 1:nrow(goods)){            # 1~ goods의 행의 수까지
    price[i] <- goods$su[i] * goods$dan[i]
}  

price
                
goods$price <- price       # goods에 price라는 칼럼 만들고 그 칼럼에 price의 값을 입력!
goods




# table 생성
query <- "create or replace table goods_manager(code int, name varchar(50), su int, dan int, price int)"
dbSendUpdate(conn, query)


# goods 변수 내용을 goods_manager 테이블에 저장하기
dbWriteTable(conn, 'goods_manager', goods)
dbGetQuery(conn, 'select * from goods_manager')



# table 삭제 
dbSendUpdate(conn,'drop table goods_manager')


# dadta.csv 파일 읽어오기
dataset <- read.csv(file.choose())          # file.choose --> 파일 선택기. 직접 파일 선택할 수 있음
str(dataset)
dataset
date <- dataset$Date    # dataset에서 날짜 칼럼 가져오
date # 20150101 -> 2015-01-01   -> date 생성


library(stringr)

year <- str_sub(date,1,4)
month <- str_sub(date,5,6)
day <- str_sub(date,7,8)
year; month; day

sDate <- str_c(year, month, day, sep="-")
sDate


#문자열 -> 날짜형 형변
sDate <- as.Date(sDate, '%Y-%m-%d')
sDate

class(sDate)



#date 칼럼 교체
dataset$Date <- sDate
dataset




# 문1) dataset 변수 내용을 다음과 같이 테이블에 저장하시오
# table명 : customer
# 칼럼(자료형) : udate(date), id(int), buy(int)
# dataset  -> customer 테이블에 저장

query <- "create or replace table customer(udate date, id int, buy int)"
dbSendUpdate(conn, query)
dbWriteTable(conn, 'customer', dataset)                 ## 이게 생성까지 같이 해줌. cutomer라는 테이블을 dataset으로 생성함.
customer <- dbGetQuery(conn, 'select * from customer')


# 문2) 고객별 구매수량 합계를 구하고, 막대차트로 시각화하시오.

str(customer)
customer

query <- "select Customer_ID, sum(Buy) from customer group by Customer_ID"
result <- dbGetQuery(conn, query)
result

barplot(result$`sum(Buy)`, col=rainbow(nrow(result)),
        names.arg = result$Customer_ID, main = "고객별 구매수량")


## 문3) 구매 날짜별 구매수량 합계를 구하고, 막대차트로 시각화하시오.
query <- "select date, sum(buy) from customer group by date"
result2 <- dbGetQuery(conn, query)
result2

barplot(result2$`sum(buy)`, col=rainbow(nrow(result2)),
        names.arg = result2$Date, main = "고객별 구매수량")


# table 생성




dd



















## db 연결 종료
dbDisconnect(conn)































