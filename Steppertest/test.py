#!/usr/bin/env python3
"""
Simple stepper test: NEMA 23 (23HM20-0384D, 0.9 deg/step) via STEP/DIR driver
on a Raspberry Pi 3.

Wiring (BCM numbering):
    GPIO 17 (pin 11) -> PUL+ / STEP
    GPIO 27 (pin 13) -> DIR+
    GPIO 22 (pin 15) -> ENA+   (optional)
    Pi GND           -> PUL- / DIR- / ENA-   (common ground with driver inputs)

Run:  python3 stepper_test.py
Stop: Ctrl+C
"""

import time
import RPi.GPIO as GPIO

# ---------------- Settings ----------------
STEP_PIN = 24
DIR_PIN = 23
ENA_PIN = None #22          # set to None if you don't wire the enable pin
ENA_ACTIVE_LOW = True # most drivers: ENA low = enabled. Flip if motor won't hold/turn.

MOTOR_STEPS_PER_REV = 400   # 0.9 deg motor -> 360 / 0.9 = 400
MICROSTEPS = 4              # MUST match the DIP-switch setting on your driver
REVOLUTIONS = 2             # how many turns per direction
RPM = 60                    # keep low for a first test
# ------------------------------------------

STEPS_PER_REV = MOTOR_STEPS_PER_REV * MICROSTEPS


def setup():
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(STEP_PIN, GPIO.OUT, initial=GPIO.LOW)
    GPIO.setup(DIR_PIN, GPIO.OUT, initial=GPIO.LOW)
    if ENA_PIN is not None:
        GPIO.setup(ENA_PIN, GPIO.OUT)
        enable(True)


def enable(on):
    if ENA_PIN is None:
        return
    level = GPIO.LOW if (on == ENA_ACTIVE_LOW) else GPIO.HIGH
    GPIO.output(ENA_PIN, level)


def rotate(revs, rpm, clockwise=True):
    steps = int(abs(revs) * STEPS_PER_REV)
    steps_per_sec = rpm * STEPS_PER_REV / 60.0
    half_period = 1.0 / (2 * steps_per_sec)   # time for high and for low

    GPIO.output(DIR_PIN, GPIO.HIGH if clockwise else GPIO.LOW)
    time.sleep(0.01)  # let DIR settle before stepping

    for _ in range(steps):
        GPIO.output(STEP_PIN, GPIO.HIGH)
        time.sleep(half_period)
        GPIO.output(STEP_PIN, GPIO.LOW)
        time.sleep(half_period)


def main():
    setup()
    print(f"{STEPS_PER_REV} pulses per revolution, {RPM} RPM, "
          f"{RPM * STEPS_PER_REV / 60:.0f} pulses/s")
    try:
        print("Clockwise...")
        rotate(REVOLUTIONS, RPM, clockwise=True)
        time.sleep(1)
        print("Counter-clockwise...")
        rotate(REVOLUTIONS, RPM, clockwise=False)
        print("Done.")
    except KeyboardInterrupt:
        print("\nStopped.")
    finally:
        enable(False)
        GPIO.cleanup()


if __name__ == "__main__":
    main()