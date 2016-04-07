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

  println("Available serial ports:");
  println(Serial.list());
  
  minim = new Minim(this); 
  input = minim.getLineIn(Minim.STEREO, 2048); 
  beat = new BeatDetect(); 
  eRadius =0; 

  port = new Serial(this, Serial.list()[1], 9600); 
  //port = new Serial(this, "/dev/tty.uart-C1FF4A55BBC82651", 9600);
}

void draw() {
  background(0);
  if (selection ==1){
    port.write(0);
    //pure off; 
  }
  else if (selection ==2){
    port.write(255);
    //pure on - full brightness
  }
  
  else if (selection ==3){

  beat.detect(input.mix);
  
  if ( beat.isOnset() ) eRadius = 254;
  eRadius*= 0.92; 
  if (eRadius<5) eRadius =0; 
  println(eRadius); 

  //write the eRadius value to a byte and send it through USB
  port.write(byte(eRadius));
  //music mode
  }
}

void keyPressed(){
  if (key == '1')
  {
    if (selection==3)
    port.write(255); 
    
    selection=1; 
  }
  else if (key == '2')
  {
    if (selection==3)
    port.write(255); 
    
    selection=2; 
  }
  else if (key == '3')
  {
    selection = 3; 
    port.write(162); 
  }
  else 
  {
    println("Invalid input"); 
  }
}

void exit(){
  if (selection==3){
   port.write(255); 
  }
   super.exit(); 
}
