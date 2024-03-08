import sys

# Check if the correct number of command line arguments are provided
if len(sys.argv) != 2:
    print("Usage: python script.py <filename>")
    sys.exit(1)

string_to_find = 'household'

try:
    with open(sys.argv[1], 'r') as file:
        contents = file.read()
except FileNotFoundError:
    print("Error: File not found.")
    sys.exit(1)
except Exception as e:
    print(f"Error: {e}")
    sys.exit(1)

# Perform a case-insensitive search
if string_to_find.lower() in contents.lower():
    print(f'String "{string_to_find}" Found In File')
else:
    print(f'String "{string_to_find}" Not Found')
