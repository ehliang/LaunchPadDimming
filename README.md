# LaunchPadDimming

##Motivation

I bought some LED strips a while ago with the intent of putting them in my desktop to jazz things up. What I didn't realize was that they were too jazzy and I needed to be able to turn them off. The original plan was to install a mechanical switch, but that needed me to drill through my case. 

##Stuff I Used
I had a LaunchPad MSP430 lying around and I decided to turn it into an LED contoller, The script for the board was written in the Energia IDE with C. The board communicates with the computer through the usb port and I wrote a Processing script to send serial data in bytes. The script provided on, off and beat detection modes the latter of which responded to music. The mode gets stored in the flash memory on the Launchpad so that it stays in the same mode when the computer reboots. Changing modes is completed through the compiled Java application.  

##Demo
https://youtu.be/UL-QoU3faXQ


##Considerations
Because I was running a hackintosh, the output signal had to be grouped as an input signal for the script. This was done with Soundflower. The board connected to an internal usb header. 
