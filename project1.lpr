program project1;

uses
  GL, glu, Glut, glRobotUnit, glApplication, glFraktalApplication;

const
  // these numbers make your app work, so do respect them!
  WIDTH = 1920;
  HEIGHT = 1080;
  TIMER_INTERVAL = 24;
{$REGION 'OpenGL Magic'}
var
  Cmd: array of PChar;
  CmdCount, I: Integer;
  screenWidth, screenHeight: Integer;
  app: TGLApplication;
procedure ReSizeGLScene(Width, Height: Integer); cdecl;
begin
  if Height = 0 then
    Height := 1;
  glMatrixMode(GL_PROJECTION);
  glPushMatrix();
  glLoadIdentity();
  gluOrtho2D(0, WIDTH, HEIGHT, 0);

  glMatrixMode(GL_MODELVIEW);
  glPushMatrix();
  glLoadIdentity();
  glDisable(GL_DEPTH_TEST);
end;

procedure DrawGLScene(); cdecl;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glLoadIdentity();
  app.Render;
  glutSwapBuffers;
end;

procedure TimerFunc(i: Integer); cdecl;
begin
  DrawGLScene();
  app.Update;
  glutTimerFunc(TIMER_INTERVAL, @TimerFunc, 0);
end;

procedure InitializeGL;
begin
  glClearColor(0, 0, 0, 0);
end;

procedure GLKeyboard(Key: Byte; X, Y: Longint); cdecl;
begin
  if Key = 27 then
    Halt(0);
end;
{$ENDREGION}
begin
  // Change THIS line:
  app := TFraktalApplication.Create;
  {$REGION 'Magic'}
  CmdCount := 1;
  SetLength(Cmd, CmdCount);
  glutInit(@CmdCount, @Cmd);
  glutInitDisplayMode(GLUT_DOUBLE or GLUT_RGB or GLUT_DEPTH);

  screenWidth := glutGet(GLUT_SCREEN_WIDTH);
  screenHeight := glutGet(GLUT_SCREEN_HEIGHT);

  glutInitWindowPosition((screenWidth - WIDTH) div 2,
    (screenHeight - HEIGHT) div 2);
  glutInitWindowSize(WIDTH, HEIGHT);
  glutCreateWindow(PChar(app.Title));

  InitializeGL;

  glutDisplayFunc(@DrawGLScene);
  glutReshapeFunc(@ReSizeGLScene);
  glutKeyboardFunc(@GLKeyboard);
  glutTimerFunc(TIMER_INTERVAL, @TimerFunc, 0);

  glutMainLoop;
  {$ENDREGION}
end.

