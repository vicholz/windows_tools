#include "DigiKeyboard.h"
#define KEY_TAB 0x2b

int LED_PIN = 1;
int DELAY = 100;
boolean HAS_RUN = false;

void setup() {
  pinMode(LED_PIN, OUTPUT);
  digitalWrite(LED_PIN, HIGH);
  delay(1000);
  digitalWrite(LED_PIN, LOW);
  delay(1000);
}

void loop() {
  if (!HAS_RUN){
    digitalWrite(LED_PIN, HIGH);
    DigiKeyboard.sendKeyStroke(0);
    //DigiKeyboard.sendKeyStroke(MOD_SHIFT_LEFT, KEY_F10);
    DigiKeyboard.delay(1000);
    DigiKeyboard.println("reg.exe add HKLM\SYSTEM\Setup\LabConfig");
    DigiKeyboard.println("reg.exe add HKLM\SYSTEM\Setup\LabConfig /v BypassTPMCheck /t REG_DWORD /d 1");
    DigiKeyboard.println("reg.exe add HKLM\SYSTEM\Setup\LabConfig /v BypassRAMCheck /t REG_DWORD /d 1");
    DigiKeyboard.println("reg.exe add HKLM\SYSTEM\Setup\LabConfig /v BypassSecureBootCheck /t REG_DWORD /d 1");
    DigiKeyboard.println("exit");
    digitalWrite(LED_PIN, LOW);
    HAS_RUN = true;
  } else {
    digitalWrite(LED_PIN, HIGH);
    delay(100);
    digitalWrite(LED_PIN, LOW);
    delay(100);
  }
}

//  DigiKeyboard.update();
//  DigiKeyboard.sendKeyStroke(0);
//  DigiKeyboard.delay(3000);
