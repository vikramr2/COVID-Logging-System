import pandas as pd

df = pd.read_csv('owid-covid-data.csv')
df = df[['location', 'date', 'total_cases']]

continents = ['North America', 'South America', 'Africa', 'Asia', 'Europe', 'Australia', 'Antarctica']

df = df[~df['location'].isin(continents)]
df = df[df['date'] == '2021-11-29']
df = df[['location', 'total_cases']]

df.to_csv('word_covid.csv', index=False)