import json
import csv
import json
import sys

file = sys.argv[1]
output = sys.argv[2]
input_variables = sys.argv[3].split(",")
target_variables = sys.argv[4].split(",")

# Read CSV file
with open(file, 'r') as f:
    data = list(csv.reader(f)) # Convert to list
    headers =  [x.lower() for x in data[0]]
    data = data[1:]

# Create prompt and completion pairs
pairs = []

for row in data:
    prompt = ""
    completion = ""
    prompt_text = ""
    completion_text = ""
    
    for input_variable in input_variables:
        input_variable = input_variable.lower()
        prompt_text += f"{input_variable}: {row[headers.index(input_variable)]} - "
    
    for target_variable in target_variables:
        target_variable = target_variable.lower()
        completion_text += f"{target_variable}: {row[headers.index(target_variable)]} - "
    
    
    prompt += prompt_text
    completion += completion_text
    pairs.append({"prompt": prompt, "completion": completion})

# Export to JSON file
with open(output, 'w') as f:
    json.dump(pairs, f)

