
install.packages("RCurl")
library(RCurl)

# url에서 넘어온 JSON을 list형식으로 변형하기 위해 필요한 함수. fromJSON
install.packages('RJSONIO')
library(RJSONIO)

Sys.setenv(JAVA_HOME = 'C:\\Program Files\\Java\\jre1.8.0_111')


url = 'https://owapi.net/api/v3/u/'
userName <- '베지밀맛있어-3128'
userName <- iconv(userName, "CP949", "UTF-8")
userName <- URLencode(userName)
cate <- '/heroes'   # /blob /stats
path <- paste(url, userName, sep="")
path <- paste(path, cate, sep="")
path

page <- readLines(path, warn = "F",encoding="UTF-8")
page


json_page = fromJSON(page)

str(json_page)

# rbind로 묶으면 경쟁전 평균 스탯
class(json_page$kr$stats$competitive$average_stats)

# rbind로 묶으면 경쟁전 게임 스탯?
class(json_page$kr$stats$competitive$game_stats)


# 경쟁전 통합정보
json_page$kr$stats$competitive$overall_stats$games
json_page$kr$stats$competitive$overall_stats$wins
json_page$kr$stats$competitive$overall_stats$comprank
json_page$kr$stats$competitive$overall_stats$level
json_page$kr$stats$competitive$overall_stats$losses
json_page$kr$stats$competitive$overall_stats$ties
json_page$kr$stats$competitive$overall_stats$prestige
json_page$kr$stats$competitive$overall_stats




# 빠른대전 평균 스탯(numeric)
json_page$kr$stats$quickplay$average_stats

# 빠대 전체 스탯(numeric)
json_page$kr$stats$quickplay$game_stats
json_page$kr$stats$competitive$game_stats

x <- rbind(json_page$kr$stats$quickplay$game_stats, json_page$kr$stats$competitive$game_stats)

x <- as.data.frame(x)

str(x)

#
str(json_page$kr$stats$quickplay$overall_stats)
json_page$kr$stats$quickplay$overall_stats






sum(sort(json_page$kr$heroes$playtime$quickplay))




