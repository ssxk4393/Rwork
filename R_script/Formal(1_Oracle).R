# Formal(1_Oracle)


# Formal(1_Oracle)
# Oracle DB 정형 데이터 처리

# 1. 패키지 설치
# - RJDBC 패키지를 사용하기 위해서는 우선 java를 설치해야 한다.
install.packages("rJava")
install.packages("DBI")
install.packages("RJDBC")

# 2. 패키지 로딩
library(DBI)
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_111')
library(rJava)
library(RJDBC) # rJava에 의존적이다.(rJava 먼저 로딩)

# 3) Oracle 연동   

############ Oracle 10g ##############
# driver  
drv<-JDBC("oracle.jdbc.driver.OracleDriver", 
          "C:\\oraclexe\\app\\oracle\\product\\10.2.0\\server\\jdbc\\lib\\ojdbc14.jar")
# db연동(driver, url,uid,upwd)   
conn<-dbConnect(drv, "jdbc:oracle:thin:@//127.0.0.1:1521/xe","scott","tiger")
####################################

############ Oracle 11g ##############
# driver  
drv<-JDBC("oracle.jdbc.driver.OracleDriver", 
          "C:\\app\\acorn\\product\\11.2.0\\dbhome_1\\jdbc\\lib\\ojdbc6.jar")     ## 두번째 인자는 oracle의 경로를 지정해줘야 한다.
# db연동(driver, url,uid,upwd)   
conn<-dbConnect(drv, "jdbc:oracle:thin:@//127.0.0.1:1521/orcl","scott","tiger")
####################################



########################
# 1. DML 명령어 사용 ##
########################
query <- "select * from test order by sid"     # ;은 붙지지 말것
result <- dbGetQuery(conn, query)               # 쿼리문 조회
result

# db 내용 수정 : insert, update, delete


#### 1. 레코드 추가 : 시퀀스 객체 이용
query <- "insert into test values(seq_sid.nextval, '1234', '강감찬', 55)"
dbSendUpdate(conn, query)
dbGetQuery(conn, "select * from test order by sid")



#### 2. 레코드 수정  sid : 1002, 홍길동 -> 김길동
query <- "update test set name = '김길동' where sid= 1002"
dbSendUpdate(conn, query)
dbGetQuery(conn, 'select * from test order by sid')


#### 3. 레코드 조회 : 나이가 40세 이상 레코드 조회
query <- "select * from test where age>=40"
dbGetQuery(conn, query)


#### 4. 레코드 삭제 : sid : 1002 레코드 삭제
query <- "delete from test where sid=1005"
dbSendUpdate(conn, query)
dbGetQuery(conn, 'select * from test order by sid')



emp <- dbGetQuery(conn, 'select * from emp')
str(emp)  ## data.frame':	14 obs. of  8 variables:   --> 14개의 레코드, 8개의 변수

sal <- emp$SAL
sal
sum(sal)
mean(sal)


## 문1)  sal 2500 이상이고, 직책(job)이 MANAGER인 사원을 검색하시오


query <- "select * from emp where sal>=2500 and job = 'MANAGER'"
dbGetQuery(conn,query)



## 문2) Sub Query 관련 문제
# 부서가 'SALES'인 전체 사원의 이름, 급여, 직책을 출력하시오.
# sub쿼리 : dept,         main쿼리 : emp

dbGetQuery(conn, 'select * from dept')

query <- "select ename, sal, job from emp where deptno = (select deptno from dept where dname='SALES')" 
dbGetQuery(conn,query)


## 문3) 'WARD'사원의 상사(MGR)와 동일한 사원이름, 직책,연봉을 출력하시오
# sub, main :EMP 테이블

query <- "select ename, job, sal from emp where MGR = (select MGR from emp where ename='WARD')"
dbGetQuery(conn, query)


## 문4) join 쿼리
dbGetQuery(conn, 'select * from product')
dbGetQuery(conn, 'select * from sale')

query <- "select p.code, p.name, s.price, s.sdate from product p, sale s where p.code = s.code and p.name like '%기'"
dbGetQuery(conn,query)



#######################
## 2. DB 데이터 활용
#######################


emp <- dbGetQuery(conn, 'select * from emp')
str(emp)    # 'data.frame':	14 obs. of  8 variables:

# 컬럼선택 형식 : 변수명$컬럼명
cat('수당의 합계 :', sum(emp$COMM, na.rm=T))    # na.rm : na의 값을 remove 한다. 
cat('수당의 평균 :', mean(emp$COMM, na.rm=T))   ## cat함수는 print와 같은데 문자열과 결합된 내용을 출력할 수 있다.

# 문) 전체 사원의 연봉의 합계, 평균 구하기
cat('사원의 연봉 합계 :', sum(emp$SAL, na.rm=T))    # na.rm : na의 값을 remove 한다. 
cat('사원의 연봉 평균 :', mean(emp$SAL, na.rm=T))
cat('사원의 연봉 표준편차 :', sd(emp$SAL, na.rm=T))
cat('사원의 연봉 분산 :', var(emp$SAL, na.rm=T))


# 전체 사원의 연봉 정보를 막대차트로 시각화
help(barplot)

nrow(emp)
ncol(emp)

barplot(emp$SAL, main='전체 사원의 연봉 정보',
        col = rainbow(nrow(emp)), names.arg = emp$ENAME)
plot(emp$SAL,  main='전체 사원의 연봉 정보',
        col = rainbow(nrow(emp)))


# 문) 부서별 연봉 평균과 총금액을 구하고, 막대차트로 부서별 총금액을 시각화 하시오.
query <- 'select * from emp '
query <- 'select avg(sal), sum(sal) from emp group by deptno'
result <- dbGetQuery(conn, query)
result


DNAME <- c('회계', '연구', '판매')
DNAME # [1] "회계" "연구" "판매"

result$DNAME <- DNAME


result$DNAME
result

barplot(result$`SUM(SAL)`, main='부서별 총 연봉', col = rainbow(nrow(result)), name.arg=result$DNAME,
        xlab = '부서번호',
        ylab = '연봉')

sum(emp$SAL, na.rm=T)
mean(emp$SAL, na.rm=T)


dbDisconnect(conn)






