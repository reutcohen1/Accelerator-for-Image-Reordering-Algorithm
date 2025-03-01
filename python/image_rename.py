import os
import random

# Directory containing the PNG files (current directory)
directory = '.'

# Get a list of PNG files in the directory
png_files = [f for f in os.listdir(directory) if f.endswith('.png')]
png_files.sort()

# Counter for the sequential number
i = 1

# Iterate over the shuffled files and rename them
for old_filename in png_files:
    # Generate the new filename
    new_filename = 'image{:d}.png'.format(i)
    
    # Rename the file
    os.rename(os.path.join(directory, old_filename), os.path.join(directory, new_filename))
    
    # Increment the counter
    i += 1