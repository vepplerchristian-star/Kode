unit Solpos;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Process;

type
  { TSolPosClock }
  TSolPosClock = class(TThread)
  private
    FCurrentTime: TDateTime;
    FPythonScript: string;
    FAzimuth: Double;
    FElevation: Double;
    FIntervalSeconds: Integer;
    FLastCheckTime: TDateTime;
    FOnPositionUpdate: TNotifyEvent;
    procedure CallPythonScript;
    procedure UpdatePosition;
  protected
    procedure Execute; override;
  public
    constructor Create(const APythonScriptPath: string; AIntervalSec: Integer = 30);
    procedure SetInitialTime(ADateTime: TDateTime);
    property CurrentTime: TDateTime read FCurrentTime;
    property Azimuth: Double read FAzimuth;
    property Elevation: Double read FElevation;
    property OnPositionUpdate: TNotifyEvent read FOnPositionUpdate write FOnPositionUpdate;
  end;

implementation

{ TSolPosClock }

constructor TSolPosClock.Create(const APythonScriptPath: string; AIntervalSec: Integer = 30);
begin
  inherited Create(True); // Create suspended
  FPythonScript := APythonScriptPath;
  FIntervalSeconds := AIntervalSec;
  FCurrentTime := Now; // Default starting time
  FLastCheckTime := 0;
  FAzimuth := 0.0;
  FElevation := 0.0;
  FreeOnTerminate := False;
end;

procedure TSolPosClock.SetInitialTime(ADateTime: TDateTime);
begin
  FCurrentTime := ADateTime;
  FLastCheckTime := 0; // Force immediate update on next execution cycle
end;

procedure TSolPosClock.CallPythonScript;
var
  Process: TProcess;
  OutputList: TStringList;
  UnixTimestamp: Int64;
  OutputStr: string;
  SpacePos: Integer;
  Fs: TFormatSettings;
begin
  // Convert TDateTime to Unix Timestamp
  UnixTimestamp := Round((FCurrentTime - 25569.0) * 86400.0);

  // Initialize objects safely outside the protected blocks
  Process := TProcess.Create(nil);
  OutputList := TStringList.Create;

  try // This primary block guarantees memory cleanup
    try // This nested block handles unexpected operational runtime exceptions safely
      Process.Executable := 'python';
      Process.Parameters.Add(FPythonScript);
      Process.Parameters.Add(IntToStr(UnixTimestamp));
      Process.Options := [poWaitOnExit, poUsePipes];

      Process.Execute;

      OutputList.LoadFromStream(Process.Output);
      if OutputList.Count > 0 then
      begin
        OutputStr := Trim(OutputList[0]);
        SpacePos := Pos(' ', OutputStr);
        if SpacePos > 0 then
        begin
          Fs := DefaultFormatSettings;
          Fs.DecimalSeparator := '.';

          FAzimuth := StrToFloatDef(Copy(OutputStr, 1, SpacePos - 1), 0.0, Fs);
          FElevation := StrToFloatDef(Copy(OutputStr, SpacePos + 1, Length(OutputStr)), 0.0, Fs);

          if Assigned(FOnPositionUpdate) then
            UpdatePosition;
        end;
      end;
    except
      on E: Exception do
      begin
        // Catch exceptions safely so the worker thread loop doesn't instantly crash
        WriteLn('[FEJL i tråd]: ' + E.Message);
      end;
    end;
  finally
    // This will execute safely no matter what happens inside the nested try block
    OutputList.Free;
    Process.Free;
  end;
end;


procedure TSolPosClock.UpdatePosition;
begin
  if Assigned(FOnPositionUpdate) then
    FOnPositionUpdate(Self);
end;

procedure TSolPosClock.Execute;
var
  LastTick, CurrentTick, DeltaMS: QWord;
begin
  LastTick := GetTickCount64;
  while not Terminated do
  begin
    Sleep(100); // Check software clock tick interval
    
    CurrentTick := GetTickCount64;
    DeltaMS := CurrentTick - LastTick;
    LastTick := CurrentTick;
    
    // Progress internal software clock manually based on actual elapsed real-world time
    FCurrentTime := FCurrentTime + (DeltaMS / 86400000.0);
    
    // Check if the configured interval (e.g., 30s) has passed since the last script run
    if (FLastCheckTime = 0) or ((FCurrentTime - FLastCheckTime) * 86400.0 >= FIntervalSeconds) then
    begin
      FLastCheckTime := FCurrentTime;
      CallPythonScript;
    end;
  end;
end;

end.
