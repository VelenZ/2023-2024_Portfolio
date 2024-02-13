import csv
import matplotlib.pyplot as plt
from datetime import datetime

filename = 'data/sitka_weather_2018_simple.csv'

with open(filename) as f:
    #创建阅读器对象
    reader = csv.reader(f)
    #next返回文件下一行，此处返回第一行
    header_row = next(reader)
    
    #导出每一行的每一个索引及值
    #for index, column_header in enumerate(header_row):
    #    print(index, column_header)

    #获取日期及最高最低温度
    dates, highs ,lows = [] ,[] ,[]
    #遍历对应各行获取数据
    for row in reader:
        #日期转换，详见教材P397
        current_date = datetime.strptime(row[2], '%Y-%m-%d')
        #防止出现日期缺失
        try:
            high = int(row[5])
            low = int(row[6])
        except ValueError
        #输出缺失日期
            print(f"Missing data for {current_date}.")
        else:
        dates.append(current_date)
        highs.append(high)
        lows.append(low)

#根据最高温度绘制图形
plt.style.use('seaborn')
fig, ax = plt.subplots()
#x轴为时间，y轴为气温，绘制两条线分别表示最高与最低，利用alpha控制透明度
ax.plot(dates, highs, c='red', alpha=0.5)
ax.plot(dates, lows, c='blue', alpha=0.5)
#在两条线之间填充颜色
ax.fill_between(dates, highs, lows, facecolor=(1, 0, 1), alpha=0.1)

#设置图形的格式
ax.set_title("2018年每日最高及最低温度", fontsize=24)
ax.set_xlabel('', fontsize=16)
#绘制倾斜的日期标签
fig.autofmt_xdate()
ax.set_ylabel("温度 (F)", fontsize=16)
ax.tick_params(axis='both', which='major', labelsize=16)

import ChineseFont
plt.show()