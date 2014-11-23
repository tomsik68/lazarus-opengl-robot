unit glFraktalApplication;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, glApplication, gl, glRobotUnit;

type

  { TFraktalApplication }

  TFraktalApplication = class(TGLApplication)
  private
    robot: TRobot;
    time: Integer;
    procedure Fraktal(dlzka: real; uroven, uhol: integer);
  public
    constructor Create();
    procedure Render; override;
    procedure Update; override;
  end;

implementation

procedure TFraktalApplication.Fraktal(dlzka: real; uroven, uhol: integer);
var
  i: integer;
begin
  with robot do
  begin
    SetPenColor(Random(256),Random(256),Random(256));
    for i := 1 to 4 do
    begin
      Fd(dlzka);
      if uroven > 0 then
      begin
        Lt(uhol);
        Fraktal(dlzka / 2, uroven - 1, uhol);
        Rt(uhol);
      end;
      Rt(90);
    end;
  end;
end;

{ TFraktalApplication }

constructor TFraktalApplication.Create;
begin
  Randomize;
  inherited Create('Fractal');
  robot := TRobot.Create(1920/2 - 150, 1080/2 - 150);
  time := 0;
end;

procedure TFraktalApplication.Render;
begin
  with Robot do
  begin
    beginDrawing();
    Fraktal(300, 7, time);

    endDrawing();
  end;
end;

procedure TFraktalApplication.Update;
begin
  Inc(time);
end;

end.
