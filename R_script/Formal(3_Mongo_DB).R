# Formal(3_Mongo_DB)
# - MongoDB(NoSQL) 데이터 처리


# 패키지 설치 
install.packages('RMongo')

# 패키지 로딩           ## 자바를 기반으로 만든 패키지들은 자바의 위치를 알려줘야 한다. 그게 (rJava)
library(rJava)
library(RMongo) # Loading required package: rJava
# MongoDB에 접속하기 위한 패키지 로더


####################################
# 1. MongoDB에서 특정 DB 연결 
####################################

# mongoDbConnect(dbName, host="127.0.0.1", port=27017)
conn <-mongoDbConnect('local',host="127.0.0.1", port=27017) # local DB 연결  


# 전체문서 조회 - dbGetQuery(conn, collection, query, skip=0, limit=1000) 
result <-dbGetQuery(conn, "startup_log", "") # startup_log 컬렉션 전체 검색 
result # starup_log 컬렉션에서 12개의 Document 검색

# DB 연결 해제 
dbDisconnect(conn)



####################################
# 2. MongoDB에서 db/colletion/document 생성 
####################################


# 1) DB 연결 객체 생성

conn2 <- mongoDbConnect('user_db', host='127.0.0.1')    # 포트를 생략하고 생성해보자. user_db라는 db가 없지만 생성하면서 사용

# 2) Colletion 객체 생성
dbInsertDocument(conn2, 'user_coll', "{'name':'hong', 'age':35, 'gender':'man'}")

# 3) document 조회
result <- dbGetQuery(conn2, 'user_coll', "")
result

# 4) Document 추가
dbInsertDocument(conn2, 'user_coll', "{'name':'lee', 'age':45, 'gender':'man'}")
dbInsertDocument(conn2, 'user_coll', "{'name':'Yoo', 'age':18, 'gender':'woman'}")


# 5) Document 삭제
dbRemoveQuery(conn2, "user_coll", "{'name':'hong'}")


















