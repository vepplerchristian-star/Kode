// **************************************************************
// Adding 'Px' under 'const' by Klaus Kristensen (kk) 2022-07-14
// plus the file & unit renamed to: 'KKwiringPi'
// **************************************************************

{
This wrapper of wiringPi was created by DWH.

I ran H2Pas against wiringPi.h, then cleaned up the resulting 
pp file, mainly commenting out stuff causing errors (and ultimately 
unneeded by me anyway).
}

{
  Automatically converted by H2Pas 1.0.0 from wiringPi.h
  The following command line parameters were used:
    wiringPi.h
    -d
}

{$mode objfpc}
{$linklib libwiringPi}

unit KKwiringPi;

interface

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}


{
    * wiringPi.h:
    *	Arduino like Wiring library for the Raspberry Pi.
    *	Copyright (c) 2012-2017 Gordon Henderson
    ***********************************************************************
    * This file is part of wiringPi:
    *	https://github.com/WiringPi/WiringPi/
    *
    *    wiringPi is free software: you can redistribute it and/or modify
    *    it under the terms of the GNU Lesser General Public License as published by
    *    the Free Software Foundation, either version 3 of the License, or
    *    (at your option) any later version.
    *
    *    wiringPi is distributed in the hope that it will be useful,
    *    but WITHOUT ANY WARRANTY; without even the implied warranty of
    *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    *    GNU Lesser General Public License for more details.
    *
    *    You should have received a copy of the GNU Lesser General Public License
    *    along with wiringPi.  If not, see <http://www.gnu.org/licenses/>.
    ***********************************************************************
}

{ Mask for the bottom 64 pins which belong to the Raspberry Pi }
{	The others are available for the other devices }

const
    { Handy defines }
    PI_GPIO_MASK                        = $FFFFFFC0;
    { wiringPi modes }
    WPI_MODE_PINS                       = 0;
    WPI_MODE_GPIO                       = 1;
    WPI_MODE_GPIO_SYS                   = 2;
    WPI_MODE_PHYS                       = 3;
    WPI_MODE_PIFACE                     = 4;
    WPI_MODE_UNINITIALISED              = -(1);

    { Pin modes }
    INPUT                               = 0;
    OUTPUT                              = 1;
    PWM_OUTPUT                          = 2;
    GPIO_CLOCK                          = 3;
    SOFT_PWM_OUTPUT                     = 4;
    SOFT_TONE_OUTPUT                    = 5;
    PWM_TONE_OUTPUT                     = 6;
    LOW                                 = 0;
    HIGH                                = 1;

    { Pull up/down/none }
    PUD_OFF                             = 0;
    PUD_DOWN                            = 1;
    PUD_UP                              = 2;

    { PWM }
    PWM_MODE_MS                         = 0;
    PWM_MODE_BAL                        = 1;

    { Interrupt levels }
    INT_EDGE_SETUP                      = 0;
    INT_EDGE_FALLING                    = 1;
    INT_EDGE_RISING                     = 2;
    INT_EDGE_BOTH                       = 3;

    { Pi model types and version numbers }
    {	Intended for the GPIO program Use at your own risk. }
    { https://www.raspberrypi.com/documentation/computers/raspberry-pi.html#new-style-revision-codes }
    PI_MODEL_A                          = 0;
    PI_MODEL_B                          = 1;
    PI_MODEL_AP                         = 2;
    PI_MODEL_BP                         = 3;
    PI_MODEL_2                          = 4;
    PI_ALPHA                            = 5;
    PI_MODEL_CM                         = 6;
    PI_MODEL_07                         = 7;
    PI_MODEL_3B                         = 8;
    PI_MODEL_ZERO                       = 9;
    PI_MODEL_CM3                        = 10;
    PI_MODEL_ZERO_W                     = 12;
    PI_MODEL_3BP                        = 13;
    PI_MODEL_3AP                        = 14;
    PI_MODEL_CM3P                       = 16;
    PI_MODEL_4B                         = 17;
    PI_MODEL_ZERO_2W                    = 18;
    PI_MODEL_400                        = 19;
    PI_MODEL_CM4                        = 20;

    PI_VERSION_1                        = 0;
    PI_VERSION_1_1                      = 1;
    PI_VERSION_1_2                      = 2;
    PI_VERSION_2                        = 3;
    PI_MAKER_SONY                       = 0;
    PI_MAKER_EGOMAN                     = 1;
    PI_MAKER_EMBEST                     = 2;
    PI_MAKER_UNKNOWN                    = 3;

{
    GPIO pins are 'weirdly numbered'. Per the author of wiringPi.h, he used the 
    pins labeled as GPIO0 - GPIO6 (GPIO0 is physical pin 11 or RPI GPIO17). His 
    explanation is here: https://projects.drogon.net/wiringpi-pin-numbering/

    I'm going to stick with his pin numbering scheme because, as he said, when RPI
    changed their PINs, he didn't have to change his.

    So here are the usable wiringPi GPIO pins:
}
    GPIO_PIN0			        = 0;
    GPIO_PIN1        			= 1;
    GPIO_PIN2				= 2;
    GPIO_PIN3				= 3;
    GPIO_PIN4				= 4;
    GPIO_PIN5				= 5;
    GPIO_PIN6				= 6;
    GPIO_PIN7				= 7;

{
    If you prefer to use the RPI GPIO pins (which is what is on most pin outs), they are:
}

    RPIO_PIN4				= GPIO_PIN7;
    RPIO_PIN17				= GPIO_PIN0;
    RPIO_PIN18				= GPIO_PIN1;
    RPIO_PIN22				= GPIO_PIN3;
    RPIO_PIN23				= GPIO_PIN4;
    RPIO_PIN24				= GPIO_PIN5;
    RPIO_PIN25				= GPIO_PIN6;
    RPIO_PIN27				= GPIO_PIN2;

// Pin mappings from P1 connector to WiringPi library
// Px represents to physical pin on the RaspberryPi P1 connector

    // P1
    // P2
    P3  = 8;
    // P4
    P5  = 9;
    //P6
    P7  = 7;
    P8  = 15;
    //P9
    P10 = 16;
    P11 = 0;
    P12 = 1;
    P13 = 2;
    //P14
    P15 = 3;
    P16 = 4;
    // P17
    P18 = 5;
    P19 = 12;
    // P20
    P21 = 13;
    P22 = 6;
    P23 = 14;
    P24 = 10;
    // P25
    P26 = 11;
    // pi2
    P27 = 30;
    P28 = 31;
    P29 = 21;
    // P30 =  GND
    P31  = 22;
    P32 = 26;
    P33 = 23;
    //P34 = GND;
    P35 = 24;
    P36 = 27;
    P37 = 25;   // ops was 24
    P38 = 28;
    // P39 = GND
    P40 = 29;

var
    piModelNames        : array[0..20] of ^char;cvar;external;
    piRevisionNames     : array[0..15] of ^char;cvar;external;
    piMakerNames        : array[0..15] of ^char;cvar;external;
    piMemorySize        : array[0..7]  of longint;cvar;external;

{ wiringPiNodeStruct: }
{	This describes additional device nodes in the extended wiringPi }
{	2.0 scheme of things. }
{	It's a simple linked list for now, but will hopefully migrate to }
{	a binary tree for efficiency reasons - but then again, the chances }
{	of more than 1 or 2 devices being added are fairly slim, so who }
{	knows.... }

type
    PwiringPiNodeStruct = ^wiringPiNodeStruct;
    wiringPiNodeStruct  = record
        pinBase         : longint;
        pinMax          : longint;
        fd              : longint;
        data0           : dword;
        data1           : dword;
        data2           : dword;
        data3           : dword;
        pinMode         : procedure(node:PwiringPiNodeStruct; pin:longint; mode:longint);cdecl;
        pullUpDnControl : procedure(node:PwiringPiNodeStruct; pin:longint; mode:longint);cdecl;
        digitalRead     : function(node:PwiringPiNodeStruct; pin:longint):longint;cdecl;
        digitalWrite    : procedure(node:PwiringPiNodeStruct; pin:longint; value:longint);cdecl;
        pwmWrite        : procedure(node:PwiringPiNodeStruct; pin:longint; value:longint);cdecl;
        analogRead      : function(node:PwiringPiNodeStruct; pin:longint):longint;cdecl;
        analogWrite     : procedure(node:PwiringPiNodeStruct; pin:longint; value:longint);cdecl;
        next : ^wiringPiNodeStruct;
        end;


var
    wiringPiNodes       : ^wiringPiNodeStruct;cvar;external;

{ Function prototypes }

{ Data }

{ Internal }

function wiringPiFailure(fatal:longint; message:Pchar; args:array of const):longint;
    cdecl;external;

function wiringPiFailure(fatal:longint; message:Pchar):longint;
    cdecl;external;

    { Core wiringPi functions }
procedure wiringPiVersion(major:Plongint; minor:Plongint);
    cdecl;external;

function wiringPiSetup:longint;
    cdecl;external;

function wiringPiSetupSys:longint;
    cdecl;external;

function wiringPiSetupGpio:longint;
    cdecl;external;

function wiringPiSetupPhys:longint;
    cdecl;external;

procedure pinModeAlt(pin:longint; mode:longint);
    cdecl;external;

procedure pinMode(pin:longint; mode:longint);
    cdecl;external;

procedure pullUpDnControl(pin:longint; pud:longint);
    cdecl;external;

function digitalRead(pin:longint):longint;
    cdecl;external;

procedure digitalWrite(pin:longint; value:longint);
    cdecl;external;

function digitalRead8(pin:longint):dword;
    cdecl;external;

procedure digitalWrite8(pin:longint; value:longint);
    cdecl;external;

procedure pwmWrite(pin:longint; value:longint);
    cdecl;external;

function analogRead(pin:longint):longint;
    cdecl;external;

procedure analogWrite(pin:longint; value:longint);
    cdecl;external;

{ Deprecated }
procedure piBoardId(model:Plongint; rev:Plongint; mem:Plongint; maker:Plongint; overVolted:Plongint);
    cdecl;external;

function wpiPinToGpio(wpiPin:longint):longint;
    cdecl;external;

function physPinToGpio(physPin:longint):longint;
    cdecl;external;

procedure setPadDrive(group:longint; value:longint);
    cdecl;external;

function getAlt(pin:longint):longint;
    cdecl;external;

procedure pwmToneWrite(pin:longint; freq:longint);
    cdecl;external;

procedure pwmSetMode(mode:longint);
    cdecl;external;

procedure pwmSetRange(range:dword);
    cdecl;external;

procedure pwmSetClock(divisor:longint);
    cdecl;external;

procedure gpioClockSet(pin:longint; freq:longint);
    cdecl;external;

function digitalReadByte:dword;
    cdecl;external;

function digitalReadByte2:dword;
    cdecl;external;

procedure digitalWriteByte(value:longint);
    cdecl;external;

procedure digitalWriteByte2(value:longint);
    cdecl;external;

{ Schedulling priority }
function piHiPri(pri:longint):longint;
    cdecl;external;

{ Extras from arduino land }
procedure delay(howLong:dword);
    cdecl;external;

procedure delayMicroseconds(howLong:dword);
    cdecl;external;

function millis:dword;
    cdecl;external;

function micros:dword;
    cdecl;external;


implementation

end.
