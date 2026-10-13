unit Motorkontrol;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Solpos; // Added Solpos to access TSolPosClock

type
  { TMotorController }
  TMotorController = class
  private
    FClockThread: TSolPosClock;
    // This method matches the TNotifyEvent signature
    procedure HandlePositionUpdate(Sender: TObject);
  public
    constructor Create(const APythonScript: string; AInterval: Integer = 30);
    destructor Destroy; override;
    procedure Start;
  end;

implementation

{ TMotorController }

constructor TMotorController.Create(const APythonScript: string; AInterval: Integer = 30);
begin
  // Initialize the tracking thread from solpos.pas
  FClockThread := TSolPosClock.Create(APythonScript, AInterval);

  // Assign the callback event that triggers when a position is received
  FClockThread.OnPositionUpdate := @HandlePositionUpdate;
end;

destructor TMotorController.Destroy;
begin
  FClockThread.Terminate;
  FClockThread.WaitFor;
  FClockThread.Free;
  inherited Destroy;
end;

procedure TMotorController.Start;
begin
  FClockThread.Start; // Resume the thread to start loops
end;

procedure TMotorController.HandlePositionUpdate(Sender: TObject);
var
  Clock: TSolPosClock;
begin
  // Cast the Sender back to TSolPosClock to read the new metrics safely
  if Sender is TSolPosClock then
  begin
    Clock := TSolPosClock(Sender);

    // Write the output cleanly to the console line
    WriteLn(Format('[%s] Position Updated -> Azimuth: %0.2f, Elevation: %0.2f', [
      DateTimeToStr(Clock.CurrentTime),
      Clock.Azimuth,
      Clock.Elevation
    ]));
  end;
end;

end.

