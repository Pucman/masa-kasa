from lxml import html
import requests
import time

count = 0 #your counter of pages

def parser(url):
    global count
    start = time.time() #start timer
    page = requests.get(url)
    tree = html.fromstring(page.text)

    your_text = str(tree.xpath('//span[@id="your_xpath"]/text()')) # insert your XPath code here
    with open('URLS.txt','ab') as f: f.write(url + ';' + your_text + '\r\n') # creating a file with text you want to parse and urls
    count = count + 1
    end = time.time() #stop timer
    print count , ': ' , end - start # reference of how many pages have been parsed already and how much time (in seconds) it took for each page


parser('www.google.com') #copy this fuction for any pages you want to parse
