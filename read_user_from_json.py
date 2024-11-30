
import json 
import requests 

data = requests.get('https://jsonplaceholder.typicode.com/users', verify = False)  
data_in_dict = json.loads(data.text) 
# print(data_in_dict)
new_list = list()
print(data_in_dict)

for d in data_in_dict:
    #extract name,city,GPS and company_name from each user
    name = d['name']
    city = d['address']['city']
    GPS = d['address']['geo']
    company = d['company']['name']
    print(name,city,GPS,company)
    new_list.append({'name':name,'city':city,'GPS':GPS,'company':company})
    print(new_list)
with open('users.json','w') as f: 
    json.dump(new_list,f,indent = 4)

#write the extracted data to a csv file and each row for each user
import csv 
with open('users.csv', 'w', newline= '') as f:
    writer = csv.writer(f,delimiter= ';')
    for user in new_list:
        tmp_list = [user['name'],user['city'],user['GPS'],user['company']]
        writer.writerow(tmp_list)
print('Done')
