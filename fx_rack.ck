HidMsg msg;
Hid hiKb;

Echo echo;
JCRev reverb;
Gain adcGain;

// Set Gain .gain parameter
1.0 => adcGain.gain;

// Set Delay parameters .max and .delay
.45::second => echo.max => echo.delay;


// Open the device
0 => int device;
if( !hiKb.openKeyboard( device ) ) me.exit();


// Patch
adc => adcGain => echo => reverb => dac; 

// Define function gainController
fun void gainController(Gain g) {
  
  while(true) {
    // Event from the keyboard received
    hiKb => now;
    
    if (hiKb.recv(msg)) {
      if( msg.isButtonDown() ) {
        
        // Down Arrow Key
        if (msg.which == 81) {
            adcGain.gain() - 0.5 => adcGain.gain;     
        }
        
        // Up Arrow Key
        if (msg.which == 82) {
            adcGain.gain() + 0.5 => adcGain.gain;     
        }
      }
    }
  }
}

//spawn gainController function.
spork ~ gainController(adcGain);

// infinite time loop
while( true ) {
  1::second => now;
}



