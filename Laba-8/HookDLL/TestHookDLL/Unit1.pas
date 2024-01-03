unit Unit1;

interface

uses
  WinTypes,WinProcs, Messages, SysUtils, Classes, Graphics,
   Controls, Forms, Dialogs,   StdCtrls;

Const
  wm_LeftShow_Event=wm_User + 133;    {������� �����}
  wm_RightShow_Event=wm_User + 134;  {������� ������}
  wm_UpShow_Event=wm_User + 135;      {������� �����}
  wm_DownShow_Event=wm_User + 136; {������� ����}
  wm_Other_Event=wm_User + 137;            {��� ��������� �������}
  wm_GlasnShow_Event=wm_User +138;   {�������}
  wm_SoglShow_Event=wm_User +139;   {���������}

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    procedure	WM_LeftMSG(Var M: TMessage); message wm_LeftShow_Event;
    procedure	WM_RightMSG(Var M: TMessage); message wm_RightShow_Event;
    procedure	WM_UpMSG(Var M: TMessage); message wm_UpShow_Event;
    procedure WM_DownMSG(Var M: TMessage); message wm_DownShow_Event;
    procedure WM_OtherMSG(Var M: TMessage); message wm_Other_Event;
    procedure WM_GlasnMSG(Var M: TMessage); message wm_GlasnShow_Event;
    procedure WM_SoglMSG(Var M: TMessage); message wm_SoglShow_Event;    
  public
  
  end;

var
  Form1: TForm1;
  P:Pointer;

implementation

{$R *.dfm}
// �������� DLL
function Key_Hook(Code: integer; wParam: word; lParam: Longint): Longint;
         stdcall; external 'SendKey.dll' name 'Key_Hook';


procedure TForm1.WM_GlasnMSG(Var M: TMessage);
begin
  Label1.Caption := '������� - '+chr(M.LParam);
end;

procedure TForm1.WM_SoglMSG(Var M: TMessage);
begin
  Label1.Caption := '��������� - '+chr(M.LParam);
end;

procedure TForm1.WM_LeftMSG(Var M: TMessage);
begin
  Label1.Caption := 'Left';
end;

procedure TForm1.WM_RightMSG(Var M: TMessage);
begin
  Label1.Caption := 'Right';
end;

procedure TForm1.WM_UpMSG(Var M: TMessage);
begin
  Label1.Caption := 'Up';
end;

procedure TForm1.WM_DownMSG (Var M : TMessage);
begin
  Label1.Caption := 'Down';
end;

procedure TForm1.WM_OtherMSG(Var M: TMessage);
begin
 case chr(M.LParam) of
  chr(27):  Label1.Caption :='Esc';
 else
  Label1.Caption :=chr(M.LParam);
 end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  { ���� �� ������������ ����� ��������� �� DLL � ���������, �� ���������� ������     �������� DLL �� ��������� }
    P:=@Key_Hook;
end;

end.
