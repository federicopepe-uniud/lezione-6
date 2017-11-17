/*
 * Linguaggi Visuali per Sistemi Complessi
 * Università di Udine
 * prof. Federico Pepe - federico.pepe@uniud.it
 *
 * Week 6
 */


Table table;
IntDict province, tipologie;
PImage map;

// Province
IntDict belluno, padova, rovigo, treviso, venezia, verona, vicenza;

// Variabili per accedere alle colonne del CSV in modo più semplice
int colProvincia = 0;
int colComune = 1;
int colTipologia = 2;

void setup() {
  size(800, 800);
  background(255);

  map = loadImage("mappa_veneto.png");
  image(map, 50, 50);

  getData();

  displayData();

}

void draw() {
}

void displayData() {
  // Display Data
  int dataMin = min(province.valueArray());
  int dataMax = max(province.valueArray());
  int rangeMin = 50;
  int rangeMax = 85;
  int value;
  float diameter;

  noStroke();
  fill(#007AB5);

  // VERONA
  value = province.get("VERONA");
  diameter = map(value, dataMin, dataMax, rangeMin, rangeMax);
  //ellipse(190, 520, diameter, diameter);
  pieChart(190, 520, diameter, verona.valueArray());
  // VICENZA
  value = province.get("VICENZA");
  diameter = map(value, dataMin, dataMax, rangeMin, rangeMax);
  //ellipse(320, 430, diameter, diameter);
  pieChart(320, 430, diameter, vicenza.valueArray());
  // PADOVA
  value = province.get("PADOVA");
  diameter = map(value, dataMin, dataMax, rangeMin, rangeMax);
  //ellipse(400, 550, diameter, diameter);
  pieChart(400, 550, diameter, padova.valueArray());
  // VENEZIA
  value = province.get("VENEZIA");
  diameter = map(value, dataMin, dataMax, rangeMin, rangeMax);
  pieChart(540, 530, diameter, venezia.valueArray());
  //ellipse(540, 530, diameter, diameter);
  // ROVIGO
  value = province.get("ROVIGO");
  diameter = map(value, dataMin, dataMax, rangeMin, rangeMax);
  //ellipse(420, 660, diameter, diameter);
  pieChart(420, 660, diameter, padova.valueArray());
  // TREVISO
  value = province.get("TREVISO");
  diameter = map(value, dataMin, dataMax, rangeMin, rangeMax);
  //ellipse(500, 380, diameter, diameter);
  pieChart(500, 380, diameter, treviso.valueArray());
  // BELLUNO
  value = province.get("BELLUNO");
  diameter = map(value, dataMin, dataMax, rangeMin, rangeMax);
  //ellipse(480, 200, diameter, diameter);
  pieChart(480, 200, diameter, belluno.valueArray());
  
  // Tipologie
  int barX = 10;
  int barY = 30;
  
  for(int i = 0; i < tipologie.size(); i++) {
    String[] keys = tipologie.keyArray();
    textAlign(RIGHT, CENTER);
    text(keys[i], barX+125, barY);
    rect(barX+140, barY-8, tipologie.get(keys[i])/20, 20);
    barY += 25;
  }
  
}

void pieChart(int xPos, int yPos, float diameter, int[] data) {
  int somma = 0;
  for(int i = 0; i < data.length; i++) {
    somma += data[i];
  }
  
  float lastAngle = 0;
  for (int i = 0; i < data.length; i++) {
    float radianti = map(data[i], 0, somma, 0, 360);
    float gray = map(i, 0, data.length, 0, 255);
    fill(gray);
    arc(xPos, yPos, diameter, diameter, lastAngle, lastAngle+radians(radianti));
    lastAngle += radians(radianti);
  }
}

void getData() {

  table = loadTable("data.csv", "header");

  province = new IntDict();
  tipologie = new IntDict();

  // Inizializzo per tutte le province
  belluno = new IntDict();
  padova = new IntDict();
  rovigo = new IntDict();
  treviso = new IntDict(); 
  venezia = new IntDict();
  verona = new IntDict(); 
  vicenza = new IntDict();

  // Acquisiamo tutti i dati della tabella
  for (int i = 0; i < table.getRowCount(); i++) {
    // Utilizzando la classe IntDict, filtriamo i dati
    String provincia = table.getString(i, colProvincia);
    String tipologia = table.getString(i, colTipologia);
    province.increment(provincia);
    tipologie.increment(tipologia);
    switch(provincia) {
    case "BELLUNO":
      belluno.increment(tipologia);
      break;
    case "PADOVA":
      padova.increment(tipologia);
      break;
    case "ROVIGO":
      rovigo.increment(tipologia);
      break;
    case "TREVISO":
      treviso.increment(tipologia);
      break;
    case "VENEZIA":
      venezia.increment(tipologia);
      break;
    case "VERONA":
      verona.increment(tipologia);
      break;
    case "VICENZA":
      vicenza.increment(tipologia);
      break;
    }
    tipologie.increment(tipologia);
  }

  // Riordiniamo in ordine discendente
  province.sortValuesReverse();
  tipologie.sortValuesReverse();

  println("*** DATA LOADED ***");

  //println(tipologie);
}