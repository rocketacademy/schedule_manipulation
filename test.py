
# print('hello world. this is python')


def capitalizeName(name):
    names = name.split(' ')
    final_name = ''

    print(names)

    for n in names:
        final_name = final_name + n.capitalize() + ' '

    return final_name


# c = capitalizeName('michael first second third albano')
# print(c)
# c = capitalizeName('MILOS JELENJEV')
# print(c)
# c = capitalizeName('abcd ANCD AbCd dEFg')
# print(c)

def exercise_14():
    #get the name
    name = str(input('Enter your name in lowercase: '))

    # names = name.split(' ')
    
    adjusted_name = myCapitalize(name)
    
    print(adjusted_name)

def myCapitalize(name):
    #seperate first letter
    #capitalize and print first letter
    #lowercase everything else and add
    first = name[0]
    second = name[1:len(name)]
    output = first.upper() + second.lower()
    return output


def madLibs():
    college = input('\nenter a college class: ') #'CLASS'
    adjective = input('\nenter an adjective: ') #'nice'
    activity = input('\nenter an activity: ') #eat worms'

    output = "{} class was really {} today. We learned how to {} today in class. I can't wait for tomorrow's class!".format(college, adjective, activity)
    print('\n')
    print(output)
    print('\n')

# madLibs()

def personalizedLetter():
    name = input('enter your name: ')
    names = name.split(' ')
    first = names[0].capitalize()
    second = names[1].capitalize()

    output = f'''
    Dear {first} {second},
        I am pleased to offer you our new Platinum Plus Rewards card
        at a special introductory APR of 47.99%.  {first}, an offer
        like this does not come along every day, so I urge you to call
        now toll-free at 1-800-314-1592. We cannot offer such a low
        rate for long, {first}, so call right away.
        '''

    # output = '''
    # Dear {} {},
    #     I am pleased to offer you our new Platinum Plus Rewards card
    #     at a special introductory APR of 47.99%.  {}, an offer
    #     like this does not come along every day, so I urge you to call
    #     now toll-free at 1-800-314-1592. We cannot offer such a low
    #     rate for long, {}, so call right away.
    #     '''.format(first, second, first, first)
    print(output)

# personalizedLetter()

def alphabetRotation():
    s = 'abcdefghijklmnopqrstuvwxyz'

    for i in range(len(s)):
        print(i,': \t', s[i:]+s[:i])

def exercise17a():
    print('this is exercies 17')

    letter = input('enter a letter: ')
    s = input('enter a string: ')

    i=0
    found = False
    while (i<len(s)):
        if (s[i] == letter):
           found = True
        i = i+1
           
    if found:
        print('FOUND')
    else:
        print('not found')

def exercise17b():
    print('this is exercies 17b')

    letter = input('enter a letter: ')
    s = input('enter a string: ')

    i=0
    count = 0
    while (i<len(s)):
        if (s[i] == letter):
           count = count + 1
        i = i+1
           
    if count > 0:
        print('FOUND', count)
    else:
        print('not found')

def exercise17c():
    print('this is exercies 17c')

    letter = input('enter a letter: ')
    s = input('enter a string: ')

    i=0
    found = False
    while (i<len(s)):
        if (s[i] == letter):
           found = True
           break
        i = i+1
           
    if found:
        print('FOUND at index:', i)
    else:
        print('not found')

def printLargeInteger():
    iString = input('enter a large integer: ')
    output = ''
    start = len(iString)-1
    end = -1

    for i in range(start, end, -1):
       output = iString[i] + output
       if ((len(iString) - i) % 3 == 0):
            output = ',' + output
    
    if output[0] == ',':
        output = output[1:]
    print(output)

# printLargeInteger()

def printLargeNumberMath():
    iNum = eval(input('enter a large number: '))
    output = ''

    while iNum > 0:
        print(iNum)
        ones = iNum % 1000
        print('ones:',ones)
        iNum = iNum // 1000
        # print('new iNum:', iNum)
        if (output != ''):
            output = str(ones) + ',' + output
        else:
            #don't add a comma on the very first
            output = str(ones)
    
    
    print(output)

# printLargeNumberMath()

def flipAMPM(ampm):
    if ampm.lower() == 'am': 
        ampm = 'pm'
    else: 
        ampm = 'am'
    return ampm


def timeConverter():
    zones = ['CEST', 'EST', 'PHT']
    inputTimeString = input('enter the time: ')
    inputTimeZone = int(input('What timezone did you enter:\n\t1. CEST\n\t2. EST\n\t3. PHT\n'))
    targetTimeZone = int(input('Convert to what timezone?\n\t1. CEST\n\t2. EST\n\t3. PHT\n'))

    print(f'converting {inputTimeString} from {zones[inputTimeZone-1]} to {zones[targetTimeZone-1]}')

    # get hour and minute values
    hour = int(inputTimeString.split(':')[0])
    minute = int(inputTimeString.split(':')[1][:2])
    ampm = inputTimeString.split(':')[1][2:]

    if (hour == 12) and (ampm.lower() == 'am'): hour = 0
    if (ampm.lower() == 'pm'): hour = hour + 12
    print(f'time entered is {inputTimeString} {zones[inputTimeZone-1]}')

    # compute adjustment
    adjustment = 0

    # CEST
    if (inputTimeZone == 1):
        start = 2
    # PHT
    if (inputTimeZone == 3):
        start = 8
    # EST
    if (inputTimeZone == 2):
        start = -4
    
    # CEST
    if (targetTimeZone == 1):
        adjustment = start - 2
    # PHT
    if (targetTimeZone == 3):
        adjustment = start - 8
    # EST
    if (targetTimeZone == 2):
        adjustment = start - -4
    
    print(f'start: {start}, adjustment: {adjustment}')

    # conversion
    # if (abs(adjustment) == 12): 
    #     ampm = flipAMPM(ampm)
    # else:

    print(f'hour {hour} minute: {minute}')
    
    hour = hour - adjustment

    print(f'subtracted ajdustment : hour {hour} minute: {minute}')

    # convert previous day
    if hour < 0:
        hour = 24 + hour
        # ampm = 'pm'    
    
    # convert from 24 hour clock
    if hour > 12:
        hour = hour - 12
        ampm = 'pm'
    else:
        ampm = 'am'
    
    # convert single digit minutes to start with '0'
    if minute < 10: 
        minuteString = '0'+str(minute)
    else:
        minuteString = str(minute)

    print(f'\n\nconverted time is {hour}:{minuteString}{ampm} {zones[targetTimeZone-1]}')

# timeConverter()

def numberConverter():
    s = input('enter text: ')
    s = s.lower();

    l = [ord(c) - ord('a') +1 for c in s]
    print(l)

    # print('')
    # print('')
    # for c in s:
    #     v = ord(c) - ord('a') +1
    #     if v < 0:   
    #         print(c,end=' ')
    #     else:
    #         print(v, end='-')
    # print('')
    # print('')

# numberConverter()

def decodeNumbers():
    s = "9- 1-13- 4-15-14-5-. 1-18-5- 25-15-21-?"
    # s = '20-8-5-  17-21-9-3-11-  2-18-15-23-14-  6-15-24-,   10-21-13-16-19-  15-22-5-18-  20-8-5-  12-1-26-25-  4-15-7-!'
    words = s.split(' ')

    for word in words:
        # print(word)
        chars = word.strip().split('-')
        # print(chars)
        if '' in chars: chars.remove('')
        w = [chr(int(c)+ ord('a')-1) for c in chars if c.isdecimal()]
        
        print(str(w))

decodeNumbers()