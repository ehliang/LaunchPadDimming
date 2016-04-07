/*
  Dimmer
*/

#include "MspFlash.h"
#define flash SEGMENT_D

const int ledPin = 14; // the pin that the TIP212 is connected to 
boolean setRun=true, writeEnabled=false; 
unsigned char value; 
void setup()
{
  // initialize the serial communication:
  Serial.begin(9600);
  // initialize the ledPin as an output:
  pinMode(ledPin, OUTPUT);
}

void loop() {
  byte brightness;
  // check if data has been sent from the computer:
  if (Serial.available()) {
    // read the most recent byte (which will be from 0 to 255):
    brightness = Serial.read();
    // set the brightness of the LED:
    if (!writeEnabled){
      switch(brightness) {
        case 0: 
         analogWrite(ledPin, brightness); 
         value = 0; 
         Flash.erase(flash); 
         Flash.write(flash, &value,1); 
         //erases and writes to flash to save light state
         break; 
        case 162: 
          writeEnabled=true; 
         break;   	
        case 255: 
         analogWrite(ledPin, brightness);
         value=255; 
         Flash.erase(flash); 
         Flash.write(flash, &value,1);
         break; 
        default: 
         break;
      }
    }
    else{ 
     if (brightness == 255){
         writeEnabled=false; 
         setRun=true;
     }
     else  
       analogWrite(ledPin, brightness);
   } 
  }
  else
  {
  if (setRun){
    unsigned char data =0; 
    Flash.read(flash, &data, 1); 
    //read from flash
    analogWrite(ledPin,data); 
    setRun=false; 
  }
  }
}
