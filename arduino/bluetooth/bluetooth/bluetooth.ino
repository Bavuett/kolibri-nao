#include <aci.h>
#include <acilib.h>
#include <acilib_defs.h>
#include <acilib_if.h>
#include <acilib_types.h>
#include <aci_cmds.h>
#include <aci_evts.h>
#include <aci_protocol_defines.h>
#include <aci_queue.h>
#include <aci_setup.h>
#include <ble_assert.h>
#include <boards.h>
#include <bootloader_setup.h>
#include <dtm.h>
#include <hal_aci_tl.h>
#include <hal_platform.h>
#include <lib_aci.h>

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  while(!Serial); // Leonardo/Micro should wait for serial init
  Serial.println(F("Adafruit Bluefruit Low Energy nRF8001 Print echo demo"));

  // BTLEserial.setDeviceName("NEWNAME"); /* 7 characters max! */

  BTLEserial.begin();
}

void loop() {
  // put your main code here, to run repeatedly:

}
