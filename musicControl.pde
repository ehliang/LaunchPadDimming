
// Processing code for this example
// Dimmer - sends bytes over a serial port
// by David A. Mellis
// Modified 16 April 2013
// by Sean Alvarado
// This example code is in the public domain.

import processing.serial.*;
import ddf.minim.analysis.*; 
import ddf.minim.*; 
import ddf.minim.signals.*; 

Serial port;
Minim minim; 
AudioOutput out; 
AudioInput input;
FFT fft; 
BeatDetect beat; 
float eRadius; 
int selection=1; 


void setup() {
  size(256, 150);

  println("Available serial ports:");
  println(Serial.list());
  
  minim = new Minim(this); 
  input = minim.getLineIn(Minim.STEREO, 2048); 
  beat = new BeatDetect(); 
  eRadius =0; 

  port = new Serial(this, Serial.list()[0], 9600); 
  //port = new Serial(this, "COM1", 9600);
}

void draw() {
  background(0);
  if (selection ==1){
    byte b = byte(0); 
    port.write(b);
    //pure off; 
  }
  else if (selection ==2){
    byte b = byte(255); 
    port.write(b);
    //pure on - full brightness
  }
  
  else if (selection ==3){

  beat.detect(input.mix);
  
  if ( beat.isOnset() ) eRadius = 255;
  eRadius*= 0.95; 
  if (eRadius<5) eRadius =0; 
  println(eRadius); 

  //write the eRadius value to a byte and send it through USB
  byte b= byte(eRadius); 
  port.write(b);
  //music mode
  }
}

void keyPressed(){
  byte b; 
  if (key == '1')
  {
    selection =1; 
  }
  else if (key == '2')
  {
    selection =2;  
  }
  else if (key == '3')
  {
    selection =3; 
  }
  else 
  {
    println("Invalid input"); 
  }
  
}