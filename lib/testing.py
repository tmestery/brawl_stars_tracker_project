# script.py
from time import time, ctime

# Define a function that prints the current time
def print_current_time():
    print("Today is", ctime(time()))

# Call the function
print_current_time()