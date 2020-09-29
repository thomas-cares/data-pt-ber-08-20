DATA CLEANING EXERCISES
Thomas Spitzer
Ironhack Data Analyst Course, Part-Time, Aug 2020
Started: 2020-09-28

TASK
The goal of this project is to combine everything you have learned about data wrangling, cleaning, and manipulation with Pandas so you can see how it all works together. For this project, you will start with this messy data set Shark Attack. You will need to import it, use your data wrangling skills to clean it up, prepare it to be analyzed, and then export it as a clean CSV data file.

INTIAL DATASET
From: https://www.kaggle.com/teajay/global-shark-attacks
Download link: https://www.kaggle.com/teajay/global-shark-attacks/download

FILE NAME: data-wrangling_thomas.ipynb

JUPYTER NOTBOOK Version 6.1.1
PYTHON 3.8.3
PACKAGES & MODULES: pandas, numpy, regular expression

IMPORT OF CSV
UTF-8 codec gave an error
encoding="latin-1" worked fine

INSPECTION
data types: only numeric 'Year','original order'
Columns: 24

EMPTY COLUMNS
Huges amounts of empty fields
Particularly 'Unnamed: 22' 'Unnamed: 23' with 99% empty fields

EMPTY ROWS
Are there completly empty rows?
17020 completly empty rows
New DF only with records containing at least 1 value

COLUMNS 
'Unnamed: 23' only 2 records with any kind of value at all: ['Teramo', 'change filename']
'Unnamed: 22' only 1 record with any kind of value at all 'stopped here'

I decide to drop both columns

'original orders': 2394 are null; 6309 have a value that might help to get something in chronological order. I decide to keep it for now

