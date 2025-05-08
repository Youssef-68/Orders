#OPEN Jupyter Notebook and read csv file


# import libraries
import piplite
await piplite.install('seaborn')

import pandas as pd
import numpy as np

import seaborn as sns
import matplotlib.pyplot as plt
%matplotlib inline

import os
os.listdir()

# open the file
url =r"orders.csv.zip"
df = pd.read_csv(url
                 ,compression='zip' #to loud file
                ,na_values= ['Not Available', 'unknown']) #replace those names to null values (nun)


#Know what is the Ship Modes and null values
df['Ship Mode'].unique()


#find the types of data
df.dtypes

#calculite the discount and the total price after discount
df['Discount'] = df['List Price'] * df['Discount Percent'] / 100
df['Final Price'] = df['List Price'] - df['Discount']
df

#calculite the profits
df['Profit'] = df['Final Price'] - df['cost price']

#convert order date from object data type to datetime
df['Order Date'] = pd.to_datetime(df['Order Date'])
df.dtypes

#load the data into sql server using csv file

df.to_csv('orders', index=False)
