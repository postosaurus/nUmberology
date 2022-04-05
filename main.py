#!/usr/bin/env python3
#
# Numerologie Application for Umberto and his Umbertology
import sys, json
import subprocess
import datetime
import itertools
DATE = datetime.datetime.now()

# This application takes in the birthdate and the name of person and outputs a
# charttable with all the numbers calculated and ready for the reading.
#
# For this kind of reading we need to consider some SPECIAL NUMBERS. These are
# carmic numbers, masternumbers and that every letter in the alphabet is related
# to a value.
# Carmic and master numbers have a value(digital root) but will be considered as
# the number they represent/are. But still we want to display and consider in
# further calcualtion the value of every number.

# So here we define our lists of carmic and master numbers. Also the LETTERS are

CARMICS = [13, 14, 16, 19]
VOWELS = ['i', 'o', 'e', 'u', 'a']
MASTERS = [11, 22, 33, 44]
LETTERS = {
    'a' : 1,
    'b' : 2,
    'c' : 3,
    'd' : 4,
    'e' : 5,
    'f' : 6,
    'g' : 7,
    'h'  : 8,
    'i' : 9,
    'j' : 1,
    'k' : 2,
    'l' : 3,
    'm' : 4,
    'n' : 5,
    'o' : 6,
    'p' : 7,
    'q' : 8,
    'r' : 9,
    's' : 1,
    't' : 2,
    'u' : 3,
    'v' : 4,
    'w' : 5,
    'x' : 6,
    'y' : 7,
    'z' : 8
}
data = {
'names' : "",
'sexe' : "",
'day' : 0,
'month' : 0,
'year' : 0,

'peaks' : [ {}, {}, {}, {}],
'intensity_date' : [0, 0, 0, 0, 0, 0, 0, 0, 0,],
'intensity_name' : [0, 0, 0, 0, 0, 0, 0, 0, 0,],
'average_intensity_name': [
    {'min': 3, 'max': 5},
    {'min': 1, 'max': 3},
    {'min': 1, 'max': 2},
    {'min': 1, 'max': 1},
    {'min': 4, 'max': 6},
    {'min': 1, 'max': 3},
    {'min': 1, 'max': 2},
    {'min': 1, 'max': 2},
    {'min': 3, 'max': 4}
    ]
}

#FUNCTIONS
# The main function in this application is the DigitalRoot(n), that loops as long
# as the input is greater or equal to 10, otherwise it returns n. When our input
# more or equal to 10 it will sum all the digits together and check again if the
# number is over 10.
def DigitalRoot(n):
    while n >= 10:
        n = sum(int(i) for i in str(n))
    return n
# In order to have different bevahior with the carmic and master numbers we need
# the function CheckSpecialNumbers(n), that checks if the given number is in one
# of the two lists carmic  and MASTERS. It simply return True or False.
def CheckSpecialNumbers(n):
    if n in CARMICS or n in MASTERS:
        return True
    return False
# Also we need a new function to calculate the digital root. In this application
# a carmic or master number should not be anymore reduced. We want to display the
# number as itself and as a further information show it s value(digital root).
# The DigitalRootChecked(n) is the same function as DigitalRoot(n) with two
# additional CheckSpecialNumbers(n) that check if the input is a special number,
# if so return, then sums the numbers up and checks again.
def DigitalRootChecked(n):
    while n >= 10:

        if CheckSpecialNumbers(n):
            return n

        n = sum(int(i) for i in str(n))

        if CheckSpecialNumbers(n):
            return n

    return n

# Functions to help make the programm clearer
def Diff(a, b):
    if a > b:
        return a - b
    else:
        return b - a

 # w and y are considered as VOWELS when preceeded by another vowel. with y there are #more spexific cases but that later...

def IsSpecialVowel(name, pos):
    if name[pos] == 'w':
        if name[pos - 1] in VOWELS:
            return True
    elif name[pos] == 'y':
        if name[pos - 1] in VOWELS:
            return True
    return False

def ProcessData(name, day, month, year, sexe):

    data['name'] = ProcessName(name)
    # data['name_vowels'] = ProcessNameVowels(data['name'])
    # data['name_kons'] = ProcessNameKonsonants(data['name'])
    data['day'] = {}
    data['month'] = {}
    data['year'] = {}
    data['sexe'] = sexe
    data['peaks'] = [ {}, {}, {}, {}]
    data['intensity_date'] = [0, 0, 0, 0, 0, 0, 0, 0, 0,]
    data['intensity_name'] = [0, 0, 0, 0, 0, 0, 0, 0, 0,]
    CalculateBirthDate(int(day), int(month), int(year))
    CalculateRepeatingSubelemetsDate()
    CalculateRepeatingSubelemetsName()
    CalculateChallenge()
    CalculateMaturity()
    CalculateUniversalYear()
    CalculatePeaks()
    CalculateIntensitiesDate()
    CalculateIntensitiesName()
    CalculateExpression()

    return data
def CalculateBirthDate(day, month, year):
    # Calculate digital roots of the date and the lesson  , which is the digital roots of day, month, year aummed up. sublesson is the sum of the digits of the day and its digital root.
    data['day'] = {
        'day': day,
        'digit': DigitalRootChecked(int(day)),
        'root': DigitalRoot(int(day))
    }

    data["month"] = {
        'month': month,
        'digit': DigitalRootChecked(int(month)),
        'root': DigitalRoot(int(month))
    }
    data['year'] = {
        'year':  year,
        'sum': sum(int(i) for i in str(year)),
        'digit': DigitalRootChecked(sum(int(i) for i in str(year))),
        'root': DigitalRoot(year)
    }
    lesson = data["day"]['digit'] + data["month"]['digit'] + data["year"]['digit']
    data['lesson'] = {
        'lesson': lesson,
        'digit': DigitalRootChecked(lesson),
        'root': DigitalRoot(lesson)
    }
    data["sublesson"] = {
        'sublesson': day,
        'digit': DigitalRootChecked(int(day)),
        'root': DigitalRoot(int(day))
    }
def CalculateRepeatingSubelemetsDate():
# if any of the digitalroots of d, m, y is the same add it to the
# data["repeated_subelements"]. If the DigitalRoot(n) of the year is equal to the
# DigitalRoot(n) of Lesson also add it to data["repeated_subelements"].
    data["repeating_subelements_date"] = []
    d = data["day"]['digit']
    m = data["month"]['digit']
    y = data["year"]['digit']
    s = data["lesson"]['digit']

    if d == m or d == y:
        if data["repeating_subelements_date"] == []:
            data["repeating_subelements_date"].append(d)
        data["repeating_subelements_date"].append(d)
    if  m == y:
        if data["repeating_subelements_date"] == []:
            data["repeating_subelements_date"].append(m)
        data["repeating_subelements_date"].append(m)
    if s == d or s == m or s == y:
        data["repeating_subelements_date"].append(s)

def CalculateRepeatingSubelemetsName():
    data['repeating_subelements_name'] = []
    listOfElemts = []
    for i in range(len(data['name'])):
        listOfElemts.append(data['name'][i]['digit_kons'])
        for a, b in itertools.combinations(listOfElemts, 2):
            if a == b:
                listOfElemts.remove(a)
                # listOfElemts.remove(b)
                if len(data['repeating_subelements_name']) <= 0:
                    data['repeating_subelements_name'].append(b)
                data['repeating_subelements_name'].append(a)


# The challeng is the diiference between digital root of day and month. The the
# difference between digital root of year and day, afterwards we take the differnce
# between the two outcomes
def CalculateChallenge():
    data["challenge"] = Diff(Diff(DigitalRoot(data["day"]['digit']), DigitalRoot(data["month"]['digit'])),
     Diff(DigitalRoot(data["year"]['digit']), DigitalRoot(data["day"]['digit'])))
# Maturity age and date is basicly 36 - the digitroot of the lesson, with this we
# find the year of maturity by sdding this number to the year of birth
def CalculateMaturity():
    data['maturity'] = {
        'age': 36 - data["lesson"]['digit'],
        'year': data["year"]['year'] + (36 - data["lesson"]['digit'])
    }
    # Peaks appear every 9 years and we consider 4 of these peaks and want to output
    # the year, the age and the value of this 9 years period.
    #
    # The peaks start in the maturity_year and will occour every 9 years. So a
    # simple loop that increases the year by 9. On the bottom we write the digitalRoot
    # of Month, Day, Year, on the next row we take the DigitalRoot of  M+D(1. Peak),
    # D+Y(2. Peak). The row above we take the DigitalRootChecked(n) of (M+D) and (D+Y)
    # (3. Peak). The 4. Peak is the DigitalRootChecked of M+Y.
    # The Sum of day and month of year is in which number the year stands.
    #
def CalculatePeaks():
    for i in range(4):
        empty_peak = {
                "year" : data["year"]['year'] + data['maturity']['age'] + (i * 9),
                "age" : data['maturity']['age'] + (i * 9),
                "value" : 0 }
        if i == 0:
            empty_peak["value"] = DigitalRoot( DigitalRoot(data["month"]['digit']) + DigitalRoot(data["day"]['digit']) )
        elif i == 1:
            empty_peak["value"] = DigitalRoot( DigitalRoot(data["day"]['digit']) + DigitalRoot(data["year"]['digit']) )
        elif i == 2:
            value = data["peaks"][0]["value"] + data["peaks"][1]["value"]
            if value == 10 or value == 11:
                empty_peak["value"] = value
            else:
                empty_peak["value"] = DigitalRoot(value)
        elif i == 3:
            value = data["month"]['digit'] + data["year"]['digit']
            if value >= 10 or value <= 11:
                empty_peak["value"] = value
            else:
                empty_peak["value"] = DigitalRoot(value)
        data["peaks"][i] = empty_peak
def CalculateUniversalYear():
# The universal year is the current year, the personal year is the digital roots
# of day, month and year summed up.
    data["universal_year"] = {
        'year': DATE.year,
          'digit': DigitalRootChecked(DATE.year),
        'root': DigitalRoot(DATE.year)
        }
    sum = data["day"]['digit'] + data["month"]['digit'] + data["universal_year"]['digit']
    data["personal_year"] = {
        'sum': sum,
        'digit': DigitalRootChecked(sum),
        'root': DigitalRoot(sum)
        }
# The intensity of the date or name is simply to count how much of a number
# appears in the date or name.
def CalculateIntensitiesDate():
    str_date = str(data["day"]['day']) + str(data["month"]['month']) + str(data["year"]['year'])
    int_date = int(str_date)
    for i in range(len(str_date)):
        if str_date[i] == "0":
            continue
        data["intensity_date"][ int(str_date[i]) - 1 ] += 1

    if data["sexe"] == "female":
        data["intensity_date"][1] += 1


# Processing Names
def ProcessName(name):
    name = name.lower()
    names = name.split()

    for n in range(len(names)):
        value = 0
        value_kons = 0
        value_vow = 0
        for l in range(len(names[n])):
            letter = names[n][l]
            value += LETTERS[ letter ]

            if letter in VOWELS or IsSpecialVowel(names[n], l):
                value_vow += LETTERS[letter]
            else:
                value_kons += LETTERS[letter]

        while value > 81:
            value -=81
        while value_kons > 81:
            value_kons -=81
        while value_vow > 81:
            value_vow -=81

        root = DigitalRoot(value)
        digit = DigitalRootChecked(value)

        names[n] = {
            'name' : names[n],
            'value' : value,
            'root' : root,
            'digit' : digit,

            'kons': ProcessNameKonsonants(names[n]),
            'value_kons' : value_kons,
            'root_kons' : DigitalRoot(value_kons),
            'digit_kons' : DigitalRootChecked(value_kons),

            'vow': ProcessNameVowels(names[n]),
            'value_vow' : value_vow,
            'root_vow' : DigitalRoot(value_vow),
            'digit_vow' : DigitalRootChecked(value_vow),
        }
    return names

def ProcessNameVowels(name):
    numbers = []
    # for n in range(len(name)):
    #     numbers.append([])

    for l in range(len(name)):
        letter = name[l]
        if letter in VOWELS or IsSpecialVowel(name, l):
            numbers.append(LETTERS[letter])
        else:
            numbers.append(" ")

    return numbers

def ProcessNameKonsonants(name):
    numbers = []
    # for n in range(len(name)):
    #     numbers.append([])

    for l in range(len(name)):
        letter = name[l].lower()
        if letter not in VOWELS and not IsSpecialVowel(name, l):
            numbers.append(LETTERS[letter])
        else:
            numbers.append(" ")
    return numbers

def CalculateIntensitiesName():
    str_name  = ''
    for i in range(len(data['name'])):
        str_name += data['name'][i]['name']

    for j in range(len(str_name)):
        value = LETTERS[str_name[j]]

        data['intensity_name'][value - 1] += 1

def CalculateExpression():
    sumOfNameValues = 0
    sumOfNameKons = 0
    sumOfNameVowel = 0
    for i in range(len(data['name'])):
        sumOfNameValues += data['name'][i]['digit']
        sumOfNameVowel += data['name'][i]['digit_vow']
        sumOfNameKons += data['name'][i]['digit_kons']


    data['expression'] = {
        'expression': sumOfNameValues,
        'digit': DigitalRootChecked(sumOfNameValues),
        'root': DigitalRoot(sumOfNameValues)
        }
    data['soul'] = {
        'soul': sumOfNameVowel,
        'digit': DigitalRootChecked(sumOfNameVowel),
        'root': DigitalRoot(sumOfNameVowel)
        }
    data['ego'] = {
        'ego': sumOfNameKons,
        'digit': DigitalRootChecked(sumOfNameKons),
        'root': DigitalRoot(sumOfNameKons)
        }
    data['growth'] = {
        'growth': data['name'][0]['value'],
        'digit': data['name'][0]['digit'],
        'root': data['name'][0]['root']
        }

def PrintData():
    print('\n##############################\n\n####### Names')
    for n in range(len(data["name"])):
        data["name"][n]['name']
        name_vowels = '';
        name_kons = '';
        print("   "+ str(data['name'][n]['root_vow']))
        for v in range(len(data['name'][n]['vow'])):
            name_vowels += str(data["name"][n]['vow'][v])
        print(name_vowels)

        print(data["name"][n]['name'].capitalize() + '(' + str(data["name"][n]['value']) +'/' + str(data["name"][n]['root']) +') ')

        for v in range(len(data['name'][n]['kons'])):
            name_kons += str(data["name"][n]['kons'][v])
        print(name_kons)
        print("   "+ str(data['name'][n]['root_kons']))
        print("\n")


    print('####### Birthdate\n' + str(data["day"]['day']) + "/"
        + str(data["month"]['month']) + "/"
        + str(data["year"]['year']))

    print(str(data["day"]['digit']) + "/"
        + str(data["month"]['digit']) + "/"
        + str(data["year"]['sum']) + "(" + str(data["year"]['root']) + ")")
    print("\n")

    print('####### Table\nLesson: ' + str(data["lesson"]['lesson']) + "/" + str(data["lesson"]['digit']) )
## Doing some checks to not repeat the same number in the display
    if CheckSpecialNumbers(data["sublesson"]['sublesson']) or data["sublesson"]['sublesson'] < 10:
        print( "Sublesson: " + str(data["sublesson"]['sublesson']) )
    else:
        print( "Sublesson: " + str(data["sublesson"]['sublesson']) + "/" + str(data["sublesson"]['digit']) )


    print( "Challenge: " + str(data["challenge"]) + "\n\n####### Reapting Subelements")

    if data["repeating_subelements_date"] is not []:
        text = "Subelement(s): "
        for element in data["repeating_subelements_date"]:
            text += str(element) + " "
        print(text)
    if data["repeating_subelements_name"] is not []:
        text = "Subelement(s) name: "
        for element in data["repeating_subelements_name"]:
            text += str(element) + " "
        print(text)

    print("\n####### Expression\nExpression: " + str(data['expression']['expression']) + "/" + str(data['expression']['digit']))
    print("Soul: " + str(data['soul']['soul']) + "/" + str(data['soul']['digit']))
    print("Ego: " + str(data['ego']['ego']) + "/" + str(data['ego']['digit']))
    print("Growth: " + str(data['growth']['growth']) + "/" + str(data['growth']['digit']))
    # print("Intensity: " + str(data['growth'][0]) + "/" + str(data['growth'][1]))

    print("\n####### Peaks")
    for i in range(len(data["peaks"])):
        # print(data["peaks"])
        year = str(data["peaks"][i]["year"])
        age = str(data["peaks"][i]['age'])
        peaks = str(data["peaks"][i]['value'])
        print( str(i+1) + ". Peak in the year " + year + ", in the age of " + age +" under the influence of " + peaks +".")


    print( "\n####### Years\nYear of maturity is " + str(data["maturity"]['year']) + " in the age of " + str(data['maturity']['age']) + "." )

    print( "Universal Year: " + str(data["universal_year"]['year']) + "/" + str(data["universal_year"]['digit']) )
    print( "Personal year: " + str(data["personal_year"]['sum']) + "/" + str(data["personal_year"]['digit']) )

    print('\n####### Intensity Date')
    i = 2
    while i >= 0:
        print( str(data["intensity_date"][i]) + " | " + str(data["intensity_date"][i + 3]) + " | "  + str(data["intensity_date"][i + 6]) )
        i -= 1

    print('\n####### Intensity Date')
    intens = ''

    for i in range(len(data['intensity_name'])):
        # print(data['intensity_name'][i])
        if data['intensity_name'][i] == 0:
            intens = 'KL'
        elif data['intensity_name'][i] < data['average_intensity_name'][i]['min']:
            intens = "I-"
        elif data['intensity_name'][i] > data['average_intensity_name'][i]['max']:
            intens = 'I+'
        else:
            intens = 'ok'
        print(str(i+1) +"s: " + str(data['intensity_name'][i]) +" "+ intens)
    print('\n##############################')

if __name__ == '__main__':
    running = True
    while(running):
        subprocess.run('clear')
        print('##################################')
        print('Welcome to nUmberology v.1.5. To receive your numerology reading please follow the instructions below.')
        print('##################################\n')
        name = input('Fill in your full name: ')
        day = input("DD: ")
        month = input("MM: ")
        year = input("YYYY: ")
        sexe = input("Your gender (m for 'male', f for 'female'): ")
        if sexe == 'f':
            sexe = 'female'
        else:
            sexe = 'male'

        ProcessData(name, day, month, year, sexe)
        PrintData()

        print("\n\nDo you want to do another reading, then enter 'r, otherwise just hit enter to close.")
        z = input('What do you want: ')
        if z != 'r':
            running = False

        # d = json.dumps(data)
        # print(d)
