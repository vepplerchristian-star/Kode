program Robotter;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, SysUtils, Solpos, Motorkontrol
  { you can add units after this };

var
  Controller: TMotorController;
begin
  Controller := TMotorController.Create('calc_sun_pos.py', 30);
  try
    Controller.Start;
    ReadLn;
  finally
    Controller.Free;
  end;



end.

