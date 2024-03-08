import sys

string1 = 'household'

with open(sys.argv[1], 'r') as f:
    contents = f.read()

# checking condition for string found or not
if string1 in contents: 
    print('String', string1, 'Found In File')
else: 
    print('String', string1 , 'Not Found') 
  
