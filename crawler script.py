from DrissionPage import ChromiumPage,ChromiumOptions,SessionOptions
import time
import csv

def get_list():
    port = 9222
    co = ChromiumOptions(ini_path=r'.\configs.ini').set_paths(local_port=port,user_data_path=r'.\userdata\9222')  
    page = ChromiumPage(addr_driver_opts=co,timeout=5)
    page.get('https://unogs.com/search/?country_andorunique=or&start_year=2022&end_year=2023&end_rating=10&genrelist=&audiosubtitle_andor=or&countrylist=78')
    while True:
        time.sleep(2)
        page.scroll.to_bottom()
        datalist = page.eles('.titleitem')
        print(len(datalist))
        if len(datalist) >= 1744:
            break
    for data in datalist:
        url = data.ele('xpath:/div/div[3]/h3/a').attr('href')
        print(url)
        listls = [url]
        with open('unogs_url_list.csv', "a", newline="",encoding='utf-8') as csv_file:
            writer = csv.writer(csv_file)
            writer.writerow(listls)
    print('over')

def get_data(id):
    port = 9222
    co = ChromiumOptions(ini_path=r'.\configs.ini').set_paths(local_port=port,user_data_path=r'.\userdata\9222')  
    page = ChromiumPage(addr_driver_opts=co,timeout=5)
    with open('unogs_url_list.csv', 'r', encoding='GBK') as file:
        reader = csv.reader(file)
        url_list = list(reader)  
    for url in url_list[id:]:
        print(f'执行 {id}')
        while True:
            try:
                page.get(url[0])
                time.sleep(2)
                titile = page.ele('.media-heading dropshadowBlack').text.strip()
                text = page.ele('.tab-pane fade active in').text.strip()
                well = page.ele('.well')
                well_list = well.eles('tag:div')[0].eles('tag:span')
                well_text = ''
                for x in well_list:
                    well_text = well_text + x.text.strip()
                
                list_ls = [titile,text,well_text]
                with open('unogs_data.csv', "a", newline="",encoding='utf-8') as csv_file:
                    writer = csv.writer(csv_file)
                    writer.writerow(list_ls)    
                id = id + 1    
                break
            except:
                continue


get_list()
get_data(0)
print('完成')