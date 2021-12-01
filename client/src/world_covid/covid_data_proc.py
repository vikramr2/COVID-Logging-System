import pandas as pd
import json
import csv
import re

df = pd.read_csv('owid-covid-data.csv')
df = df[['location', 'date', 'total_cases']]

continents = ['North America', 'South America', 'Africa', 'Asia', 'Europe', 'Antarctica', 'World', 'Upper middle income',
              'Sint Maarten (Dutch part)', 'Micronesia (country)', 'Lower middle income', 'Low income', 'Isle of Man', 'International', 'High income',
              'European Union']

df = df[~df['location'].isin(continents)]
df = df[df['date'] == '2021-11-29']
df = df[['location', 'total_cases']]
df = df[df['location'] != ""]

df.to_csv('world_covid.csv', index=False)

def csv_to_json(csvFilePath, jsonFilePath):
    jsonArray = []
      
    #read csv file
    with open(csvFilePath, encoding='utf-8') as csvf: 
        #load csv file data using csv library's dictionary reader
        csvReader = csv.DictReader(csvf) 

        #convert each csv row into python dict
        for row in csvReader: 
            #add this python dict to json array
            jsonArray.append(row)
  
    #convert python jsonArray to JSON String and write to file
    with open(jsonFilePath, 'w', encoding='utf-8') as jsonf: 
        jsonString = json.dumps(jsonArray, indent=4)
        jsonf.write(jsonString)

csv_to_json('world_covid.csv', 'world_covid.json')

