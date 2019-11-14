  // Processing UDP example to send and receive string data from Arduino
  // press any key to send the "Hello Arduino" message

import hypermedia.net.*;
import processing.sound.*;
SinOsc sine;

UDP udp;  // define the UDP object


void setup() {
  udp = new UDP( this, 57222 );
  //udp.log( true );
  udp.listen( true );
  sine = new SinOsc(this);
  sine.freq(0);
  sine.play();
}

void draw()
{
}

void receive( byte[] data ) {
  if ( data != null ) {
	int data1 = 0;
	for ( int i = 0; i < data.length; i++ )
		data1 = data1 * 10 + int( data[i] );
	sine.freq( data1 );
  }
}
