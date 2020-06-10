# tic-tac-toe

[![Codacy Badge](https://api.codacy.com/project/badge/Grade/43be375eddd9441c93cb083f386c8cf8)](https://app.codacy.com/app/sumanthratna/tic-tac-toe?utm_source=github.com&utm_medium=referral&utm_content=sumanthratna/tic-tac-toe&utm_campaign=Badge_Grade_Dashboard)

Tic-Tac-Toe using the [Processing](https://processing.org/) language, with input from an [Arduino](https://www.arduino.cc/) using the [Firmata protocol](https://github.com/firmata/protocol), played against a CPU.

-   There is a slight lack of documentation/comments for the helper classes. If you wish, you may attempt to interpret the code and make a pull request with the correct comments.
-   Also, the code is very inefficient - you'll see tons of nested `for` loops. Please don't change this, this repository is meant to be for beginners, so I want this to be readable.
-   Throughout the code there are various TODOs—if you want to work on your Processing/Java syntax or your OOP skills, implement the TODOs.

## Preliminaries

-   I don't have the Arduino IDE; I've never needed to use it. Instead, I use [Arduino Create](https://create.arduino.cc/).
-   For the Processing part, install the Processing IDE. I'm particularly attached to my Eclipse IDE, so I tried to install Processing plugins. They don't work—so if you ever try to develop in the Processing language in Eclipse, don't try the plugins.

## Instructions

### Loading `StandardFirmata`

Upload the [`src/arduino.ino`](./src/arduino.ino) file to your Arduino. This is the `StandardFirmata` file, so it's also available in the Arduino IDE (File > Examples). If you're using the Arduino Create web IDE, there should be a tab on the left called "Examples"—click this and search for "StandardFirmata" and you should be able to find the file.

The `StandardFirmata` file, simply put, works by sending data from the Arduino to the computer with a certain Baud rate (in our case, `57600`). You shouldn't need to install anything else—I've included all the necessary libraries in the folder `lib`.

### Wiring Your Arduino

-   wire an LED to digital (PWM) pin 3 (optional)
-   wire an LED to digital pin 6 (optional)
-   wire an LED to digital pin 7 (optional)
-   wire an LED to digital pin 8 (optional)
-   wire a pushbutton to digital pin 5 (required)
-   wire a potentiometer to analog pin A0 (required)

### Loading the Processing Code

1.  Open your Processing IDE and open the [`src/processing/processing.pde`](./src/processing/processing.pde) file. There should be 4 "program" tabs at the top.
2.  Click the run button in the top-left corner of the Processing IDE. If your Arduino has been wired properly, you should be able to play the game correctly.
