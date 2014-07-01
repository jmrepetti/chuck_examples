HidMsg msg;
Hid hiKb;

Echo echo;
// Set delay parameters
.45::second => echo.max => echo.delay;

JCRev reverb;

Gain adcGain;
// Input Gain
1.0 => adcGain.gain;

// 0 is the first keyboard connected
0 => int device;
// Open the device
if( !hiKb.openKeyboard( device ) ) me.exit();


// Patch
// adc is the input device, in my case is a multieffect ZOOM G3X connected throug USB.
adc => adcGain => echo => reverb => dac; 


// Define function gainController
fun void gainController(Gain g) {

    while(true) {
        // Event key received
        hiKb => now;
        
        if (hiKb.recv(msg)) {
            
            if( msg.isButtonDown() )
            {
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



