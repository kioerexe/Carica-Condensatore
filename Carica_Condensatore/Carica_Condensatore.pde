import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;

float tensione = 0.0f;
Arduino ardu;

void setup()
{
  size(700, 500);
  background(255);
  surface.setTitle("Carica condensatore");
  textSize(FONT_WEIGHT);
  grafico = get((width - WIDTH_GRAFICO) / 2 - 160, (height - HEIGHT_GRAFICO) / 2, WIDTH_GRAFICO, HEIGHT_GRAFICO);
  
  grafico.loadPixels();
  
  for(int i=0; i < (grafico.width * grafico.height); i++)
    grafico.pixels[i] = color(255);
    
  grafico.updatePixels();
  
  xvals = new float[WIDTH_GRAFICO];
  ardu = new Arduino(this, Arduino.list()[1], 57600);
  ardu.pinMode(PIN_CONDENSATORE, Arduino.INPUT);
  ardu.pinMode(PIN_ALIMENTAZIONE, Arduino.OUTPUT);
}

void draw()
{
  background(255);
  tensione = ardu.analogRead(PIN_CONDENSATORE);
  
  //se arrivo al massimo, scarico il condensatore
  if(tensione >= 1023.0f)
    ardu.digitalWrite(PIN_ALIMENTAZIONE, Arduino.LOW);
  else if(tensione == 0.0f)
    ardu.digitalWrite(PIN_ALIMENTAZIONE, Arduino.HIGH);
    
  //testi per il layout
  fill(0);
  text("Grafico", (width - WIDTH_GRAFICO) / 2 - 160, (height - HEIGHT_GRAFICO) / 2 - 10);
  text("Condensatore", (width - WIDTH_CONDENSATORE) / 2 + 160, (height - HEIGHT_CONDENSATORE) / 2 - 10);
  
  //disegno condensatore e grafico
  DisegnaCondensatore((width - WIDTH_CONDENSATORE) / 2 + 160, (height - HEIGHT_CONDENSATORE) / 2);
  DisegnaGrafico((width - WIDTH_GRAFICO) / 2 - 160, (height - HEIGHT_GRAFICO) / 2);
}
