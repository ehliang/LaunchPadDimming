//Modified from Dimmer Example provided by Energia
//Controls intensity of LED Strip based on option selected
//Ethan Liang

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
int selection; 
byte b; 


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
    b = byte(0); 
    port.write(b);
    //pure off; 
  }
  else if (selection ==2){
    b = byte(255); 
    port.write(b);
    //pure on - full brightness
  }
  
  else if (selection ==3){

  beat.detect(input.mix);
  
  if ( beat.isOnset() ) eRadius = 255;
  eRadius*= 0.92; 
  if (eRadius<5) eRadius =0; 
  println(eRadius); 

  //write the eRadius value to a byte and send it through USB
  b = byte(eRadius); 
  port.write(b);
  //music mode
  }
}

void keyPressed(){
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
    b = byte(162);
    port.write(b); 
  }
  else 
  {
    println("Invalid input"); 
  }
}

void exit(){
  if (selection==3)
   port.write(b); 
   super.exit(); 
}