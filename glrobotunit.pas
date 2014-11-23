unit glRobotUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Math, GL;

type

  { TRobot }

  TRobot = class
  private
    positionSent: Boolean;
    x, y, angle: real;
    isPenDown: boolean;
    // util procedures

    procedure sendPositionToGL();
  public
    constructor Create(nX, nY: real);
    constructor Create(nX, nY, nAngle: real);

    procedure Fd(D: real);
    procedure Rt(DeltaAngle: real);
    procedure Lt(DeltaAngle: real);

    procedure beginDrawing();
    procedure endDrawing();

    procedure PU;
    procedure PenUp;
    procedure PD;
    procedure PenDown;

    procedure SetPenColor(r,g,b: Byte);

  end;

implementation

{ TRobot }

procedure TRobot.beginDrawing;
begin
  glBegin(GL_LINES);
end;

procedure TRobot.sendPositionToGL;
begin
  glVertex2d(x, y);
end;

procedure TRobot.endDrawing;
begin
  glEnd;
end;

constructor TRobot.Create(nX, nY: real);
begin
  Create(nX, nY, 0);
end;

constructor TRobot.Create(nX, nY, nAngle: real);
begin
  x := nX;
  y := nY;
  angle := nAngle/180*pi;
  isPenDown := True;
  positionSent := False;
end;

procedure TRobot.Fd(D: real);
begin
  if not positionSent then
    sendPositionToGL();
  x := x + d * cos(angle);
  y := y + d * sin(angle);
  if not isPenDown then
  begin
    endDrawing();
    beginDrawing();
  end;
  sendPositionToGL();
end;

procedure TRobot.Rt(DeltaAngle: real);
begin
  angle := angle + DeltaAngle/180*pi;
  if angle > 2*pi then
    angle := angle - 2*PI;
  if angle < 0 then
    angle := 2*pi + angle;
end;

procedure TRobot.Lt(DeltaAngle: real);
begin
  Rt(-DeltaAngle);
end;

procedure TRobot.PU;
begin
  PenUp;
end;

procedure TRobot.PenUp;
begin
  isPenDown := False;
end;

procedure TRobot.PD;
begin
  PenDown;
end;

procedure TRobot.PenDown;
begin
  isPenDown := True;
end;

procedure TRobot.SetPenColor(r, g, b: Byte);
begin
  glColor3b(r,g,b);
end;

end.

