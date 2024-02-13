# Netflix北美节目数据库整理及分析  

**数据来源：**  
https://www.netflix.com/  
https://unogs.com/  
（非官方的Netflix搜索网站，提供了API，但是本项目未使用，主要是访问次数有限。）  
https://www.imdb.com  
（提供API，15万刀一年。）  
http://www.imdb.com/interfaces  
（IMDb官方非盈利镜像站。感谢IMDb给穷学生一条生路.）  

**参考资料：**  
https://7color94.github.io/2016/01/imdb-db-structure/  

**工作流程：**
1.使用Python爬虫脚本爬取  
https://unogs.com/search/?country_andorunique=or&start_year=1900&end_year=2023&end_rating=10&genrelist=&audiosubtitle_andor=or&countrylist=78  
下所有我们所需的节目信息。同时爬取“Open Title in IMDB”背后的link以便我们将其与IMDb数据库匹配。  
unogs网站有一些访问限制，可能爬虫时间会比想象中长一些。  
2.导出unogs_us.csv。清洗并补充缺失的数据。  
3.下载镜像数据库并使用唯一特征码（ttxxxxxx）进行匹配，详见combine.R。  
4.导出Netflix_us_database.xlsx。  
5.进一步整理数据，留下我们想进行聚类分析的数据，导出Data_Net.xlsx。  
6.将summary拆散并对所有变量进行聚类分析，详见cluster.R。  
7.导出output.csv，分析并得出output_analysis.xlsx。  
