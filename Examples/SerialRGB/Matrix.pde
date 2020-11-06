import processing.serial.*;

final int NUM_TILES_X   = 1; // The number of tiles, make sure that the NUM_TILES const
final int NUM_TILES_Y   = 1; // has the correct value in the slave program
final int MATRIX_WIDTH  = 64;  
final int MATRIX_HEIGHT = 64;
final int NUM_CHANNELS  = 3; 

Serial serial;
PGraphics tex;
Graphic graphic;
byte[]buffer;  

void setupMatrix() {
  int buffer_length = NUM_TILES_X * MATRIX_WIDTH * NUM_TILES_Y * MATRIX_HEIGHT * NUM_CHANNELS;
  buffer = new byte[buffer_length];
  tex = createGraphics(NUM_TILES_X * MATRIX_WIDTH, NUM_TILES_Y * MATRIX_HEIGHT);
  graphic = new Graphic(tex);
  // Init serial
  if (scanSerial)
    serial = scanSerial();             // Mac
  // serial = new Serial(this, "COM3"); // Windows
}
void updateMatrix() {
  tex.beginDraw();
  graphic.update();
  tex.endDraw();

  // Write to the serial port (if open)
  if (serial != null) {    
    int idx = 0;
    for (int j=0; j<NUM_TILES_Y; j++) {
      for (int i=0; i<NUM_TILES_X; i++) {
        PImage tmp = tex.get(i * MATRIX_WIDTH, j * MATRIX_HEIGHT, MATRIX_WIDTH, MATRIX_HEIGHT);        
        for (color c : tmp.pixels) { 
          if (threshold) {
            if (brightness(c) > 0) {
              c = color(255);
            }
          }
          buffer[idx++] = (byte)(c >> 16 & 0xFF); 
          buffer[idx++] = (byte)(c >> 8 & 0xFF);
          buffer[idx++] = (byte)(c & 0xFF);
        }
      }
    }
    serial.write('*');     // The 'data' command
    serial.write(buffer);  // ...and the pixel values
  } 

  // Preview

  // Offset and size of the preview
  int preview_size = 6;
  int ox = 50;
  int oy = 160;

  // Grid background
  fill(0);
  noStroke();
  rect(ox, oy, tex.width * preview_size, tex.height * preview_size);  

  // LEDs
  for (int j=0; j<tex.height; j++) {
    for (int i=0; i<tex.width; i++) {
      int idx = i + j * tex.width;
      color c = tex.pixels[idx];
      fill(c); 
      int x = ox + i * preview_size;
      int y = oy + j * preview_size;
      rect(x, y, preview_size-1, preview_size-1);
    }
  }

  // Matrix outline
  noFill();
  stroke(255);
  for (int j=0; j<NUM_TILES_Y; j++) {
    for (int i=0; i<NUM_TILES_X; i++) {
      int x = i * MATRIX_WIDTH * preview_size + ox;
      int y = j * MATRIX_HEIGHT * preview_size + oy;
      rect(x, y, MATRIX_WIDTH * preview_size, MATRIX_HEIGHT * preview_size);
    }
  }

  // Some info
  String txt = "";
  txt += "FPS           : " + round(frameRate) + "\n";
  txt += "NUM_TILES_X   : " + NUM_TILES_X + "\n";
  txt += "NUM_TILES_Y   : " + NUM_TILES_Y + "\n";
  txt += "MATRIX_WIDTH  : " + MATRIX_WIDTH + "\n";
  txt += "MATRIX_HEIGHT : " + MATRIX_HEIGHT + "\n";
  txt += "NUM_CHANNELS  : " + NUM_CHANNELS + "\n";
  txt += "Serial        : " + (serial != null ? "connected" : "disconnected") + "\n";

  fill(255);
  textAlign(LEFT, TOP);
  text(txt, ox + 420, 160);
}
