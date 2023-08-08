import json
import csv
import json
import sys

file = sys.argv[1]
output = sys.argv[2]

# Read CSV file
with open(file, 'r') as f:
    data = list(csv.reader(f)) # Convert to list
    headers = data[0]
    data = data[1:]

# Create prompt and completion pairs
pairs = []
for row in data:
    prompt_text = f"Channel: {row[headers.index('Youtuber')]} - Category: {row[headers.index('category')]} - Subscribers: {row[headers.index('subscribers')]}"
    completion_text = f"Title: {row[headers.index('Title')]} - Views: {row[headers.index('video views')]} - Country: {row[headers.index('Country')]}"
    pairs.append({"prompt": prompt_text, "completion": completion_text})

# Export to JSON file
with open(output, 'w') as f:
    json.dump(pairs, f)

