#include <Wire.h>
#include <Adafruit_SSD1306.h>

#define input 9
#define clock 10

#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 32 // OLED display height, in pixels

#define OLED_RESET     -1 // Reset pin # (or -1 if sharing Arduino reset pin)
#define SCREEN_ADDRESS 0x3C ///< See datasheet for Address; 0x3D for 128x64, 0x3C for 128x32
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);

boolean state, oldState;
byte num = 0;

void setup() {
  Serial.begin(9600);
  
  pinMode(input, INPUT);
  pinMode(clock, INPUT);

  // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
  if(!display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS)) {
    Serial.println(F("SSD1306 allocation failed"));
    for(;;); // Don't proceed, loop forever
  }

}

void loop() {
  state = digitalRead(clock);

  if(state != oldState){
    if(state == HIGH){
      num = num << 1;
      
      Serial.println(digitalRead(input));

      if(digitalRead(input)){
//        Serial.println("foo");
        bitSet(num, 0);
      } else {
//        Serial.println("bar");
        bitClear(num, 0);
      }

      Serial.println(num & B00001111);
      displaySmth(num & B11111111);
      Serial.println("-------");
      
    }
  }
  
  
  oldState = state;

}


void displaySmth(int val){
  display.clearDisplay();
  display.setTextSize(4);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(10, 0);
  display.println((val));
  display.display();      // Show initial text
  
}

























