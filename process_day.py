import json

bootcamp_days = json.load(fp=open('data/bootcamp-course-days.json','r'))
# print(bootcamp_days['daysOfWeek'])
# print(bootcamp_days['days'][0])

general = []
css = []
algos = []
ux = []
ip = []
projects = []

items = [general, css, algos, ux, ip, projects]

def append_if_not_empty(list, course_day):
    if course_day["preClass"] != {} or course_day["inClass"] != {} or course_day['postClass'] != {}:
        list.append(course_day)

for day in bootcamp_days['days']:
    # print(day['courseDay'])
    # general.append(day['dateTypes']['general'])
    append_if_not_empty(general, day['dateTypes']['general'])
    append_if_not_empty(css,day['dateTypes']['css'])
    append_if_not_empty(algos, day['dateTypes']['algos'])
    append_if_not_empty(ux,day['dateTypes']['ux'])
    append_if_not_empty(ip,day['dateTypes']['ip'])
    append_if_not_empty(projects,day['dateTypes']['projects'])


for item in items:
    print(item[0]['type'], 'has', len(item),'lesson days')


json.dump(general ,fp=open('data/general.json', 'w'))
json.dump(css ,fp=open('data/css.json', 'w'))
json.dump(algos ,fp=open('data/algos.json', 'w'))
json.dump(ux ,fp=open('data/ux.json', 'w'))
json.dump(ip ,fp=open('data/ip.json', 'w'))
json.dump(projects ,fp=open('data/projects.json', 'w'))
