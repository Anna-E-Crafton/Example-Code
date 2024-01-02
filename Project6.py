#Anna Crafton
#12/5/2023
#Project 6
#Hangman Game

import random

#getWord()
#Reads a txt file names wordlist.txt and retuns a random word of length n from the file
#If file is missing, exits the program
def getWord(n):
    
    lookForWord = True #bool for checking word length
   
    try:
        file = open('wordlist.txt', 'r')
        wordList = file.read()
     
        while lookForWord == True:
            #pick a random line from wordList
            line = random.choice(open('wordlist.txt').readlines())
            
            #make sure it has no spaces
            line = str(line).replace(' ','')
            
            #Keep if the length is right
            if (len(line) - 1) == int(n):
                lookForWord = False
                
        
        #close the fine and retun the word
        file.close()
        
        #make sure line is a string before returning
        line = str(line)
        return line
        
        #exit gracefully if the file doesn'nt exist
    except IOError:
        return
    
#getGuess(word)    
#returns the number of guesses player gets for a given word
#guesses is (2n - 1)
def getGuess(word):
        
    n = len(word)
    #remove one for end of line char
    n = n - 1
    
    #do 2n-1 to get number of guesses
    total = 2*n
    total = total - 1
    
    return total
    
#getWordLength()
#returns length of the longest word in the list
#needs to exit if file doesnt open!!
def getWordLength():
    
     try:
     
        #get longest line in the txt file
        bigWord = (max(open('wordlist.txt'), key=len))
      
        bigWord = len(bigWord)
        bigWord = bigWord - 1
      
        return bigWord
        
        #exit gracefully if the file doesn'nt exist
     except IOError:
        return False
    

#endGame()
#checks if game is over, puts out stats if it is
#takes two strings to compaire and the number of remaining guesses
#returns true if game is over, false if not
def endGame(word, hiddenWord, guessRemain):
    
    #check if player has guessed word, and congradulates if they won
    
    if (word == hiddenWord):
        
        print('Congratulations, you guessed it!\nGame Over!')
        return True 
        
        
    IsMatch = True
        
    #check if player guessed a word 1 by 1.
    for idx in range(len(word) - 1):
        if hiddenWord[idx] != word[idx]:
            IsMatch = False
  
    if IsMatch == True:
        print("Congratulations, you guessed it!\nGame Over!")
        return True
        
        
    #Tells player they lost if they ran out of guesses
    if (guessRemain < 1):
        
        print('You ran out of guesses!\nThe word was ' + str(word))
        print('Game Over!', end='')
        return True
        
    return False
    
    
#guess()
#asks player to guess a letter or word
#takes usedLetters
#returns guess
def guess(usedLetters, n):
    
    letter = '@'
    loop = True
    
    while loop:
        
        letter = input('Type a letter or a word guess: ' ) 
        usedLetter = '@'+ letter +'@'
        
        
        
        #check if player already guessed that letter
        if (usedLetter in usedLetters) or (letter == '@'):
            print ('You already guessed ' + letter)
            
        #check if input is 2 letters or longer than the word.
        elif (len(letter) == 2) or (len(letter) > n):
            print ('Your guess is too long or too short!')
        else:
            loop = False
            
    return letter
    
#guessWord()
#takes word, hiddenWordm and letter or word to check for
#returns updated hiddenword if guess was correct
def guessWord(hiddenWord, word, guess):
    
    
    numFound = 0 #number of times a guess is in word
    wordCopy = list(word) #copy of word
    newHiddenWord = list(hiddenWord)  #word to send back
        
    
    
    #Multiple letter guess is assumed to be a word
    if (len(guess)) > 1:
        
        if (guess in word) and len(guess) == (len(word) -1): 
            newHiddenWord = word
            return str(newHiddenWord)
            
        #if guessed multiple letters and it wasn't the whole word, 
        #player failed to guess the word, so don't change hiddenWord
        else: 
            print ('Sorry, the word is not ' + guess)
            return hiddenWord

    
    #get number of times a single letter guess is in word, 
    #then replace * in hidden word
    if guess in str(word):
        
        #get number of times guess is in word and output it
        numFound = (str(word)).count(guess)
        print ("There are " + str(numFound) + ' ' + guess + "'s.")
        
        #unhide guessed parts of hiddenWord
        for idx in range(len(word)-1):
            
            if word[idx] == guess[0]:
                
                newHiddenWord[idx] = guess[0]

    else:
        print ('Sorry, there are no ' + str(guess) + "'s.")
        
        
        
    return str(newHiddenWord)
    
#getWordSize(bigWord)
#asks user for input until it gets a positive int < bigWord,
#then returns it.
def getWordSize(bigWord):
 
   #loops forever until good input
    doInputLoop = True
 
    while doInputLoop == True:
        wordSize = input('What word length would you like to play? (3 to ' + str(bigWord) + ') ')
        
        try:
            int(wordSize)
            
            #make sure input is between 3 and n
            if(int(wordSize) > 2) and (int(wordSize) < bigWord+1):
                return wordSize
                
            else: 
                print ('Word Size is out of range!')
            
        except:
            print('Word length must be a positive int below ' + str(bigWord) + '!')
            pass
    
    
#main()
def main():
    
    #variables
    bigWord = getWordLength() #max word length
    
    #Exit if file is not found
    if (bigWord) == False: 
        print ('File not Found')
        return
    
    #variables
    word = '' #word for player to guess
    wordLength = 0 #word's length
    hiddenWord = '' #string of * and correctly guessed letters
    guessRemain = 0 #number of guesses player gets
    usedLetters = '@' #string of letters the player has guessed
    letter = '' #player's guess

    #get input form user
    wordSize = getWordSize(bigWord)
    #pick a word and update variables
    word = getWord(wordSize)
    wordLength = (len(word) - 1)
    guessRemain = getGuess(word) 
    
    #hiddenWord is a string of * for each letter in word
    for i in range(wordLength):
        hiddenWord = hiddenWord + "*"
    
    
    #Loop until end of game
    while not endGame(word, hiddenWord, guessRemain): 
        
        #loopWord = word
     
        #put out game info for player
        print('\nWord: ' + hiddenWord)
        
        wrangWord = str(hiddenWord) 
        cleanWord = ''
        
        print('You have ' + str(guessRemain) + ' guesses remaining.')
        
        #get guess form playerlist(filter(lambda a: a != 2, x))
        letter = guess(usedLetters, wordLength)
        
        #update hiddenWord if the guess was correct
        hiddenWord = guessWord(hiddenWord, word, letter)
        
        
        #get hidden word in string format
        for i in hiddenWord:
            
            if i not in [',',"'",']','[', ' ']:
                cleanWord += i
        
        hiddenWord = ''.join(cleanWord)
        
        if endGame(word, hiddenWord, guessRemain):
            return
        
        
        usedLetters = usedLetters + letter + '@'
        guessRemain = guessRemain - 1
        
    return


#call main
main()
