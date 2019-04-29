/**
 * Tic-Tac-Toe on a GUI, controlled by Arduino. GUI capabilities provided by Processing.
 * Uses input from an Arduino UNO. Note: this is not actually Arduino code. A series of
 * very similar languages (including Arduino and Processing) have very similar syntaxes.
 * However, Arduino is based off of C++, while Processing code is converted to Java at
 * compile-time. Some notable differences include <code>final</code> (in Processing)
 * and <code>const</code> (in Arduino). Furthermore, there is no "necessary"
 * <code>void loop</code> method, instead there is a <code>void draw</code> method,
 * which is essentially the same as <code>void loop</code>. Lastly, and perhaps the
 * most important difference for our use, is that Processing uses column-major order for
 * 2 dimensional arrays, while most other C-based languages use row-major order.
 *
 * @author Sumanth Ratna
 * @author Andrew Kim
 * December 2018
 * Thomas Jefferson High School for Science and Technology
 */

import cc.arduino.*;
import processing.serial.*; //required for some Firmata library functions
import org.firmata.*;
//there are other classes that we use - for example, Button
//Processing imports these automatically because they are in the same source folder

/**
 * This is the play button at beginning, disappears after clicked
 */
Button play;

/**
 * Light blue square to represent the currently selected cell on the board
 */
PShape highlight;

Arduino arduino;
int analogVal;

final char X = 'X', O = 'O';
final int SIZE = 300; //board size

char[][] board = new char[3][3]; //TODO: create Cell class, use Cell[][]
Solver solver = new Computer(); //TODO: implement multiple algorithms and allow user to choose

int status; //-1 not started, 0 started, 1 over
int[] current; //row, col

void arduinoSetup() {
  arduino = new Arduino(this, Arduino.list()[2], 57600);
  arduino.pinMode(6, Arduino.OUTPUT);
  arduino.pinMode(7, Arduino.OUTPUT);
  arduino.pinMode(8, Arduino.OUTPUT);
  //arduino.pinMode(3,Arduino.OUTPUT); //pwm pin
  arduino.pinMode(5, Arduino.INPUT); //pushbutton
}
void setup() {
  surface.setTitle("Tic-Tac-Toe");
  size(300, 300);
  //textAlign(CENTER,TOP);
  //textFont(createFont("Arial",128,true)); //change font
  play = new Button(110, 135, 80, 30, "PLAY");
  status = -1;
  current = new int[2];
  println((Object[])Arduino.list()); //cast to Object[] to hide warning
  highlight = createShape(RECT, 0, 0, SIZE/3, SIZE/3); //TODO: remove?
  arduinoSetup();
}

void hideHighlight() {
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      fill(color(204, 204, 204));
      PShape temp = createShape(RECT, j*SIZE/3.0, i*SIZE/3.0, SIZE/3.0, SIZE/3.0);
      shape(temp);
    }
  }
  drawBoard();
}
void drawBoard() {
  //base(); //not necessary, removed for efficiency
  textAlign(CENTER, TOP);
  textFont(createFont("Arial", 128, true)); //change font
  //highlight.setVisible(false);
  for (int i=0; i<3; i++) {
    for (int j=0; j<3; j++) {
      if (board[j][i]==0) {
        continue;
      }
      float x = j*(SIZE/3.0)+(SIZE/6.0);
      float y = i*(SIZE/3.0)-19;
      fill(board[j][i]==X ? color(255, 0, 0):color(0, 0, 255)); //red for x, blue for o
      text(board[j][i], x, y);
    }
  }
}
void setSpot(int x, int y, char arg) {
  if (board[y][x]!=0) {
    return;
  }
  arduino.analogWrite(3, (int)map(analogVal, 0, 1023, 0, 255)); //analog output
  board[y][x] = arg;
  drawBoard();
  if (gameOver()) {
    println("DONE");
    status = 1;
    return;
  }
  if (arg==O) {
    return;
  }

  int[] loc = solver.calculate(board);
  setSpot(loc[0], loc[1], O);
}
boolean gameOver() {
  for (int i=0; i<3; i++) {
    if (board[0][i]==board[1][i] && board[1][i]==board[2][i] && board[1][i]!=0) {
      return true;
    }
    if (board[i][0]==board[i][1] && board[i][1]==board[i][2] && board[i][1]!=0) {
      return true;
    }
  }
  if (board[0][0]==board[1][1] && board[1][1]==board[2][2] && board[1][1]!=0) {
    return true;
  }
  if (board[2][0]==board[1][1] && board[1][1]==board[0][2] && board[1][1]!=0) {
    return true;
  }
  return false;
}
void arduinoLoop() { //for the Arduino part
  int digRd = arduino.digitalRead(5);
  if (digRd == Arduino.HIGH) {
    println("CLICKED");
    if (status==-1) {
      hidePlayButton();
      //return;
    } else {
      setSpot(current[1], current[0], X);
    }
  }
  if (status!=0) { //game hasn't started
    return;
  }
  analogVal = arduino.analogRead(0);
  //analogVal = int(random(1024)); //TESTING
  println(analogVal);
  int temp = int(map(analogVal, 0, 1023, 0, 8));
  arduino.digitalWrite(current[0]+6, Arduino.LOW);
  current[0] = temp%3;
  current[1] = temp/3;
  arduino.digitalWrite(current[0]+6, Arduino.HIGH);
  /* TESTING
   	if (640<analogVal && analogVal<768) {
   setSpot(current[0],current[1],X);
   setSpot(1,0,X);
   }*/
}
void base() {
  background(204);
  stroke(0);
  strokeWeight(4);
  for (int i=0; i<=3; i++) {
    line(i*SIZE/3, 0, i*SIZE/3, SIZE); //vertical
    line(0, i*SIZE/3, SIZE, i*SIZE/3); //horizontal
  }
}
void highlightSquare() {
  hideHighlight();
  highlight = createShape(RECT, current[0]*SIZE/3.0, current[1]*SIZE/3.0, SIZE/3, SIZE/3);
  highlight.setFill(color(200, 200, 255)); //TODO: remove?...
  highlight.setVisible(true); //...
  shape(highlight);
}
void draw() {
  if (status==1) {
    hideHighlight();
    noLoop();
    return;
  }
  arduinoLoop();
  if (status==0) {
    //highlight.setVisible(false);
    highlightSquare();
    drawBoard();
  }
  //delay(1000); //TESTING
}

boolean withinButton() {
  return (play.X<mouseX && mouseX<play.X+play.width) && (play.Y<mouseY && mouseY<play.Y+play.height);
}
void hidePlayButton() {
  background(204);
  status = 0;
  base();
  play.hide();
}
void mousePressed() {
  if (status!=-1) {
    return;
  }
  if (withinButton()) {
    hidePlayButton();
  }
}
