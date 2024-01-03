library SendKey;

uses
  Sysutils,
  Classes,
  Windows,
  Messages;

const
  //���������������� ��������� 
  wm_LeftShow_Event=wm_User + 133;
  wm_RightShow_Event=wm_User + 134;
  wm_UpShow_Event=wm_User +135;
  wm_DownShow_Event=wm_User +136;
  wm_Other_Event=wm_User +137;
  wm_GlasnShow_Event=wm_User +138;
  wm_SoglShow_Event=wm_User +139;


var
  SaveExitProc: Pointer;
  //handle ��� �������
  HookHandle: hHook = 0;
  cntSogl,cntGlasn,cntAll:Integer;
  f : TextFile;

// ���������� �������
function Key_Hook(Code: integer; wParam: word; lParam: Longint): Longint; stdcall; export;
var
  H:HWND;
begin
  {���� Code >= 0, �� ������� ����� ���������� �������}
  if (Code >= 0) and (lParam and $40000000 = 0) then
  begin
    Inc(cntAll);
    //���� ���� ����������, �������� DLL ����� ���������� ��������.
    // ���������� ������ �� ����� ������ � �� ���������
    // Caption ����� �����������     ���������, ������� ������ ���� �����
    //'XXX' !!!!
    H:=FindWindow('TForm1', 'XXX');
    // ��� �� �������, ������� �������������?
    case wParam of
      VK_Left:  SendMessage(H,wm_LeftShow_Event, 0, 0);
      VK_Right: SendMessage(H,wm_RightShow_Event, 0, 0);
      VK_Up:    SendMessage(H,wm_UpShow_Event, 0, 0);
      VK_Down:  SendMessage(H,wm_DownShow_Event, 0, 0);
    else
      case chr(wParam) of
      'A','Q','E','Y','U','I','O','J':
        begin
          SendMessage(H,wm_GlasnShow_Event, 0, wParam);
          Inc(cntGlasn);
        end;
      'W','R','T','P','S','D','F','G','H','K','L','Z','X','C','V','B','N','M':
        begin
          SendMessage(H,wm_SoglShow_Event, 0, wParam);
          Inc(cntSogl);
        end;
      else
        SendMessage(H,wm_Other_Event, 0, wParam);
      end;
    end;
    //  ���� 0, �� ������� ������ ������ ���������� ��� �������, ���� 1 - ���
    Result:=0;
  end
  else
    if Code < 0 then
      { ���� Code < 0, �� ����� ������� ��������� ������� }
      Result := CallNextHookEx(HookHandle, Code, wParam, lParam);

  Rewrite(f);
  Writeln(f,'����� ������� ='+IntToStr(cntAll));
  Writeln(f,'- �������     ='+IntToStr(cntGlasn));
  Writeln(f,'- ���������   ='+IntToStr(cntSogl));
  Close(f);
end;
// ��� �������� DLL ���� ����� �������
procedure LocalExitProc; far;
begin
  if HookHandle <> 0 then
  begin
    UnhookWindowsHookEx(HookHandle);
    ExitProc:=SaveExitProc;
  end;
end;

exports Key_Hook;
// ������������� DLL ��� �������� �� � ������
begin
  AssignFile(f, 'keys.txt');
  cntAll:=0;
  cntSogl:=0;
  cntGlasn:=0;
  //�������� �������, ��������������� ������� ����������
  HookHandle:=SetWindowsHookEx(wh_Keyboard, @Key_Hook, hInstance, 0);
  if HookHandle = 0 then
     MessageBox(0, 'Unable to set hook!', 'Error', mb_Ok)
  else
  begin
    SaveExitProc := ExitProc;
    ExitProc := @LocalExitProc;
  end;
end.
