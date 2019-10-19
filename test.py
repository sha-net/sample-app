#test={"a":7,"b":8,"c":9}
#for x,y in test.items():
#  print(f"{x} : {y}")
#t = lambda x, y : x*y
#print(t(5,3))

class test:
  def __init__(self,age=1,name="a"):
    self.age = age
    self.name = name
  
  def printname(self):
    print(self.name)

  def printage(self):
    print(self.age)

a = test()
a.printage()
a.printname()

b = test(3,"shavit")
b.printage()
b.printname()

from datetime import datetime, timedelta
d = datetime.today() + timedelta(0,0,0,0,0,0,5)
print (d)

import json

# some JSON:
x = '{"q1":{"question": "Which one is correct team name in NBA?","options": ["New York Bulls","Los Angeles Kings"],"answer": "Huston Rocket"}}'

# parse x:
y = json.loads(x)

# the result is a Python dictionary:
print(y["q1"]["question"])

import json

# a Python object (dict):
x = {
  "name": "John",
  "age": 30,
  "cities": "New York"
}

# convert into JSON:
y = json.dumps(x,indent=2)

# the result is a JSON string:
print(y)

try:
  f = open("/tmp/demofile.txt")
  f.write("Lorum Ipsum")
  f.close()
except:
  print("Something went wrong when writing to the file")
finally:
  print("next thing to do")

myorder = "I have a {carname}, it is a {model}."
print(myorder.format(carname = "Ford", model = "Mustang"))

#f = open("demofile2.txt", "a")
#f.write("Now the file has more content!")
#f.close()
#import rhinoscriptsyntax as rs
import json

#prompt the user for a file to import
#filter = "JSON file (*.json)|*.json|All Files (*.*)|*.*||"
filename = open("demofile2.json")

#Read JSON data into the datastore variable
#if filename:
#    with open(filename, 'r') as f:
datastore = json.load(filename)

#Use the new datastore datastructure
print(datastore["office"]["parking"]["style"])