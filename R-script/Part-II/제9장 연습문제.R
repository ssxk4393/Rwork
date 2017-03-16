#################################
## <제9장 연습문제>
################################# 

# 01. 다음과 같은 단계를 통해서 테이블을 생성하고, SQL문을 이용하여 레코드를 조회하시오.(DBMS는 자유 선택)

# [단계 1] 상품정보(GoodsInfo)테이블 생성(SQLPLUS 이용)

# [단계 2] 레코드 추가(SQLPLUS 이용)

# [단계 3] 전체 레코드 검색(R 소스 코드 이용)


# 02. 공공데이터 사이트에서 관심분야 데이터 셋을 다운로드 받아서 빈도수가 5회 이상 단어를 이용하여 
#      단어 구름으로 시각화 하시오.

# 공공데이터 : www.data.go.kr
 









# 분석 절차
# 1단계 : 토픽분석(단어의 빈도수)
# 2단계 : 연관어 분석(관련 단어 분석) 
# 단계3 - 감성 분석(단어의 긍정/부정 분석) 

# 패키지 설치 및 로딩
# 1) java install : http://www.oracle.com
# -> java 프로그램 설치(64비트 환경 - R(64bit) - java(64bit))

# 2) rJava 설치 : R에서 java 사용을 위한 패키지
install.packages("rJava")
Sys.setenv(JAVA_HOME='C:\\Program Files\\Java\\jre1.8.0_111')
library(rJava) # 로딩

# 3) install.packages
install.packages(c("KoNLP", "wordcloud"))
install.packages("http://cran.r-project.org/bin/windows/contrib/3.0/tm_0.5-10.zip",repos=NULL)
library(tm)


# 4) 패키지 로딩
library(KoNLP) # 세종사전. 8만여개정도의 단어가 들어가 있음. 
library(tm)     # 영문 텍스트 마이닝 관련 라이브러리
library(wordcloud) # RColorBrewer()함수 제공




##################################################
# 단계1 - 토픽분석(텍스트 마이닝) 
#- 시각화 : 단어 빈도수에 따른 워드 클라우드
###################################################


# 1) facebook_bigdata.txt 가져오기
judge <- file("C:/NCS/Rwork/Part-II/judge.txt", encoding="UTF-8")
judge_file <- readLines(judge) # 줄 단위 데이터 생성

judge_file

head(judge_file) # 앞부분 6줄 보기 - 줄 단위 문장 확인 
str(judge_file) # chr [1:76]

##    
## 2) Corpus : 벡터 대상 자료집(documents)생성 함수, tm 패키지 제공
##
judge_corpus <- Corpus(VectorSource(judge_file))
judge_corpus
inspect(judge_corpus) # 76개 자료집에 포함된 문자 수 제공 




##    
## 3) 세종 사전 사용 및 단어 추가
##    
install.packages('curl')
library(curl)
useSejongDic() # 세종 사전 불러오기

mergeUserDic(data.frame(c("R 프로그래밍","페이스북","소셜네트워크"), c("ncn"))) 
# ncn -명사지시코드



extractNoun('우리나라 대한민국 나는 홍길동 입니다.')
## [1] "우리나라" "대한"     "민국"     "나"       "홍길동"  


##    
## 4) 단어추출 사용자 함수 정의
##    
# (1) 사용자 정의 함수 실행 순서 : 문자변환 -> 명사 단어추출 -> 공백으로 합침
exNouns <- function(x) { paste(extractNoun(as.character(x)), collapse=" ")}

# (2) exNouns 함수 이용 단어 추출 
# 형식) sapply(적용 데이터, 적용함수) -> 요약 100개를 대상으로 단어 추출
judge_nouns <- sapply(judge_corpus, exNouns) 

# (3) 단어 추출 결과
#class(facebook_nouns) # [1] "character" -> Vector 타입
judge_nouns[1] # 단어만 추출된 첫 줄 보기 


##
## 5) 데이터 전처리   
##
# (1) 추출된 단어 이용 자료집 생성
myCorputjudge <- Corpus(VectorSource(judge_nouns)) 
myCorputjudge # Content:  documents: 76

# (2) 데이터 전처리 
myCorputjudge <- tm_map(myCorputjudge, removePunctuation) # 문장부호 제거
myCorputjudge <- tm_map(myCorputjudge, removeNumbers) # 수치 제거
myCorputjudge <- tm_map(myCorputjudge, tolower) # 소문자 변경
myCorputjudge <- tm_map(myCorputjudge, removeWords, stopwords('english')) # 불용어제거

# (3) 전처리 결과 확인 
inspect(myCorputjudge[1:5]) # 데이터 전처리 결과 확인


##        
## 6) 단어 선별(단어 길이 2개 이상)
##  

install.packages("SnowballC")
library(SnowballC)

# PlainTextDocument 함수를 이용하여 myCorpus를 일반문서로 변경
myCorputjudge_txt <- tm_map(myCorputjudge, PlainTextDocument) 

myCorputjudge_txt

# TermDocumentMatrix() : 일반텍스트문서를 대상으로 단어 선별
# 단어길이 2개 이상인 단어만 선별 -> matrix 변경
myCorputjudge_txt <- TermDocumentMatrix(myCorputjudge_txt, control=list(wordLengths=c(2,Inf)))
myCorputjudge_txt
# <<TermDocumentMatrix (terms: 883, documents: 76)>>


# matrix -> data.frame 변경
myCorputjudge_txt.df <- as.data.frame(as.matrix(myCorputjudge_txt)) 
dim(myCorputjudge_txt.df) # [1] 883  76


##
## 7) 단어 빈도수 구하기
##
wordResult <- sort(rowSums(myCorputjudge_txt.df), decreasing=TRUE) # 빈도수로 내림차순 정렬
wordResult[1:10]


##
## 8) wordcloud 생성 (디자인 적용전)
##
myName <- names(wordResult) # 단어 이름 생성 -> 빈도수의 이름 
wordcloud(myName, wordResult) # 단어구름 적성





#-----------<불필요한 단어 제거 시작>-------------------

# 5) 데이터 전처리 - "사용", "하기" 단어 제거 
myCorputjudge <- tm_map(myCorputjudge, removePunctuation) # 문장부호 제거
myCorputjudge <- tm_map(myCorputjudge, removeNumbers) # 수치 제거
myCorputjudge <- tm_map(myCorputjudge, tolower) # 소문자 변경
myStopwords = c(stopwords('english'), "하기");
myCorputjudge = tm_map(myCorputjudge, removeWords, myStopwords);

inspect(myCorputjudge[1:5]) # 데이터 전처리 결과 확인

# 6) 단어 선별(단어 길이 2개 이상)
# PlainTextDocument 함수를 이용하여 myCorpus를 일반문서로 변경
myCorputfacebook_txt <- tm_map(myCorputjudge, PlainTextDocument) 
myCorputfacebook_txt

# TermDocumentMatrix() : 일반텍스트문서를 대상으로 단어 선별
# 단어길이 2개 이상인 단어만 선별 -> matrix 변경

myCorputfacebook_txt <- TermDocumentMatrix(myCorputfacebook_txt, control=list(wordLengths=c(2,Inf)))
myCorputfacebook_txt
#<<TermDocumentMatrix (terms: 880, documents: 76)>>

# matrix -> data.frame 변경
myTermfacebook.df <- as.data.frame(as.matrix(myCorputfacebook_txt)) 
dim(myTermfacebook.df) # [1] 880  76

# 7) 단어 빈도수 구하기
wordResult <- sort(rowSums(myTermfacebook.df), decreasing=TRUE) # 빈도수로 내림차순 정렬
wordResult[1:10]
#빅데이터     분석     처리     수집     결과 
#21       19       16       15       13  

# 8) 단어 구름(wordcloud) 생성  생성 - 디자인 적용 전
myName <- names(wordResult) # 단어 이름 추출(빈도수 이름) 
wordcloud(myName, wordResult) # 단어구름 시각화 
#myName



#-----------<불필요한 단어 제거 종료 >-------------------





# 9) 단어구름에 디자인 적용(빈도수, 색상, 랜덤, 회전 등)

# (1) 단어이름과 빈도수로 data.frame 생성
word.df <- data.frame(word=myName, freq=wordResult) 
str(word.df) # word, freq 변수

# (2) 단어 색상과 글꼴 지정
pal <- brewer.pal(12,"Paired") # 12가지 색상 pal <- brewer.pal(9,"Set1") # Set1~ Set3

# 폰트 설정세팅 : "맑은 고딕", "서울남산체 B"
windowsFonts(malgun=windowsFont("맑은 고딕"))  #windows

# (3) 단어 구름 시각화 - 별도의 창에 색상, 빈도수, 글꼴, 회전 등의 속성을 적용하여 
x11( ) # 별도의 창을 띄우는 함수
wordcloud(word.df$word, word.df$freq, 
          scale=c(5,1), min.freq=3, random.order=F, 
          rot.per=.1, colors=pal, family="malgun")
#wordcloud(단어, 빈도수, 5:1비율 크기,최소빈도수,랜덤순서,랜덤색상, 회전비율, 색상(파렛트),컬러,글꼴 )



# 10) 차트 시각화 - 서진수(2011), R까지, 느린 생각  

# (1) 상위 10개 토픽추출
topWord <- head(sort(wordResult, decreasing=T), 10) # 상위 10개 토픽추출 

# (2) 파일 차트 생성 
pie(topWord, col=rainbow(10), radius=1) # 파이 차트-무지개색, 원크기

# (3) 빈도수 백분율 적용 
pct <- round(topWord/sum(topWord)*100, 1) # 백분율
names(topWord)

# (4) 단어와 백분율 하나로 합친다.
lab <- paste(names(topWord), "\n", pct, "%")

# (5) 파이차트에 단어와 백분율을 레이블로 적용 
pie(topWord, main="SNS 빅데이터 관련 토픽분석", 
    col=rainbow(10), cex=0.8, labels=lab)

