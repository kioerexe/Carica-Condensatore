final int WIDTH_CONDENSATORE = 120;
final int HEIGHT_CONDENSATORE = 200;
final int WIDTH_GRAFICO = 240;
final int HEIGHT_GRAFICO = HEIGHT_CONDENSATORE;
final float MAX_VALORE = 1024.0f;
final int FONT_WEIGHT = 18;
final int PIN_CONDENSATORE = 0;
final int PIN_ALIMENTAZIONE = 8;
PImage grafico;
float xvals[];
int i_grafico = 0;

void DisegnaCondensatore(float x, float y)
{
  fill(200);
  rect(x, y, WIDTH_CONDENSATORE, HEIGHT_CONDENSATORE);
  float perc_tensione = (tensione / MAX_VALORE);
  float h_livello = perc_tensione * (float) HEIGHT_CONDENSATORE;
  
  //disegno il rettangolo per il livello
  fill(200, 255, 0);
  rect(x, y + (float)HEIGHT_CONDENSATORE - h_livello, WIDTH_CONDENSATORE, h_livello);
  
  //testo percentuale
  fill(0);
  String t_perc = str((int)(perc_tensione * 100.0f)) + "%";
  text(t_perc, x + (WIDTH_CONDENSATORE - (t_perc.length() * FONT_WEIGHT) / 2) - 50, y + (HEIGHT_CONDENSATORE / 2));
}

void DisegnaGrafico(float x, float y)
{
  //cancellazione grafico
  for(int i=0; i < (grafico.width * grafico.height); i++)
    grafico.pixels[i] = color(255);
    
   if(i_grafico < WIDTH_GRAFICO)
     i_grafico++;
    
  xvals[i_grafico - 1] = tensione;
     
  //shift dei dati
  //faccio lo shift solo se raggiungo il limite del grafico
  if(i_grafico == WIDTH_GRAFICO)
  {
    for(int i =1; i < i_grafico; i++)
      xvals[i-1] = xvals[i];
  }
  
  //ridisegno il grafico
  for(int i=0; i < WIDTH_GRAFICO; i++)
  {
    int ygrafico = (int)map(xvals[i], 0.0f, MAX_VALORE, HEIGHT_GRAFICO - 1, HEIGHT_GRAFICO * 0.1f);    
    grafico.pixels[(ygrafico * WIDTH_GRAFICO) + i] = color(0);
  }
  
  grafico.updatePixels();
  
  noFill();
  image(grafico, x, y);
  rect(x-1, y-1, WIDTH_GRAFICO + 1, HEIGHT_GRAFICO + 1);
}
