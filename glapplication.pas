unit glApplication;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type

  { TGLApplication }

  TGLApplication = class
    private
      fTitle: string;
    public
      constructor Create(nTitle: string);
      procedure Init; virtual; abstract;
      procedure Render; virtual; abstract;
      procedure Update; virtual; abstract;
      destructor Destroy; virtual; abstract;
      procedure Tick(); cdecl;
      property Title: String read fTitle;
  end;

implementation

{ TGLApplication }

constructor TGLApplication.Create(nTitle: string);
begin
  fTitle := nTitle;
end;

procedure TGLApplication.Tick; cdecl;
begin
  Render;
  Update;
end;

end.

