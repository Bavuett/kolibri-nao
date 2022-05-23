#include <Servo.h>

Servo m1;

void setup() {
    // Setup code to run once.
    m1.attach(5);
    m1.writeMicroseconds(5000);
    delay(500);
}

void loop() {
    m1.write(10);
}
