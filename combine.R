# 基本信息 Basic Information
imdb_title_basics <-
  read.delim("title.basics.tsv", sep = "\t", header = TRUE)
# 导演、编剧 Director, Writer
imdb_title_crew <-
  read.delim("title.crew.tsv", sep = "\t", header = TRUE)
# 评分 Rating
imdb_title_ratings <-
  read.delim("title.ratings.tsv", sep = "\t", header = TRUE)

# 主数据库 Main Database
unogs_us <-
  read.delim("unogs_us_imdb.csv", sep = ",", header = TRUE)

# 重命名 Rename
names(unogs_us)[names(unogs_us) == "IMDBid"] <- "tconst"

# 清洗错误数据 Clean Incorrect Data
unogs_us <- unogs_us %>%
  lapply(function(x)
    ifelse(x == "tt8434720tt81354739", "tt13642264", x)) %>%
  as.data.frame()
unogs_us <- unogs_us %>%
  lapply(function(x)
    ifelse(x == "tt0452568tt80201328", "tt8680560", x)) %>%
  as.data.frame()
unogs_us <- unogs_us %>%
  lapply(function(x)
    ifelse(x == "tt7691766tt80175351", "tt7131720", x)) %>%
  as.data.frame()

# 合并数据 Merge Data
unogs_merged <-
  merge(unogs_us, imdb_title_basics, by = "tconst", all.x = TRUE)
unogs_merged <-
  merge(unogs_merged,
        imdb_title_crew,
        by = "tconst",
        all.x = TRUE)
unogs_merged <-
  merge(unogs_merged,
        imdb_title_ratings,
        by = "tconst",
        all.x = TRUE)

# 完善NA写法 Refine NA Entries
unogs_merged_cleaned <- unogs_merged %>%
  lapply(function(x)
    ifelse(x == "na" | x == "\\N" | x == "", NA, x)) %>%
  as.data.frame()

# 删除全是NA的行 Delete Rows Entirely NA
unogs_merged_cleaned <-
  unogs_merged_cleaned[rowSums(is.na(unogs_merged_cleaned))
                       < ncol(unogs_merged_cleaned), ]

# 计算每列完整程度 Calculate Completeness of Each Column
non_missing_counts <-
  sapply(unogs_merged_cleaned, function(column)
    sum(!is.na(column)))
total_rows <- nrow(unogs_merged_cleaned)
completeness_ratios <- non_missing_counts / total_rows
print(completeness_ratios)

# 输出Excel Export to Excel
install.packages("openxlsx")
library(openxlsx)
write.xlsx(unogs_merged_cleaned,
           "/Users/velen/Desktop/Netflix_us_database.xlsx")
