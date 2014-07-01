// Crate an array with E minor scale MIDI data 
[64,66,67,69,71,72,74,76] @=> int em[];

// Instantiate an oscillator
SinOsc osc;

// Connect the oscillator to the analog output
osc => dac;

while(true) {
  
    // selecte a random number between 0 and 6 
    Std.rand2(0,6) => int note_index;

    // .mtof is midi to frequency
    Std.mtof(em[note_index]) / 2 => osc.freq;

    // Try changing the time here 
    // you can use ::ms, or ::samp
    0.3::second => now;
}