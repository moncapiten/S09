#define A 3
#define B 2
#define C 6
#define D 7
#define E 8
#define F 4
#define G 5

void setup() {
  Serial.begin(9600);

  pinMode(A, OUTPUT);
  pinMode(B, OUTPUT);
  pinMode(C, OUTPUT);
  pinMode(D, OUTPUT);
  pinMode(E, OUTPUT);
  pinMode(F, OUTPUT);
  pinMode(G, OUTPUT);

}

void loop() {
  digitalWrite(A, HIGH);
  delay(1000);
  digitalWrite(B, HIGH);
  delay(1000);
  digitalWrite(C, HIGH);
  delay(1000);
  digitalWrite(D, HIGH);
  delay(1000);
  digitalWrite(E, HIGH);
  delay(1000);
  digitalWrite(F, HIGH);
  delay(1000);
  digitalWrite(G, HIGH);
  delay(1000);
}
