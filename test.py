import debugpy

# 5678 is the default attach port in the VS Code debug configurations
print("Waiting for debugger attach")
debugpy.listen(('0.0.0.0', 5678))
debugpy.wait_for_client()


import random
def guess_the_number():
    print("Welcome to 'Guess the Number'!")
    print("I'm thinking of a number between 1 and 100.")

    number = random.randint(1, 100)
    attempts = 0

    while True:
        attempts += 1
        guess = int(input("Make a guess: "))

        if guess < number:
            print("Too low.")
        elif guess > number:
            print("Too high.")
        else:
            print(f"You got it! The number was {number}.")
            print(f"You took {attempts} guesses.")
            break

guess_the_number()

