#include <Servo.h>

Servo m1;

void setup() {
    // Setup code to run once.
    m1.attach(5);
    m1.write(180);
    delay(2000);
    m1.write(0);
    delay(2000);
    m1.write(20);
    delay(2000);
    m1.write(0);
}

void loop() {
    m1.write(10);
}