library SendKey;

uses
  Sysutils,
  Classes,
  Windows,
  Messages;

const
  //пользовательские сообщения 
  wm_LeftShow_Event=wm_User + 133;
  wm_RightShow_Event=wm_User + 134;
  wm_UpShow_Event=wm_User +135;
  wm_DownShow_Event=wm_User +136;
  wm_Other_Event=wm_User +137;
  wm_GlasnShow_Event=wm_User +138;
  wm_SoglShow_Event=wm_User +139;


var
  SaveExitProc: Pointer;
  //handle для ловушки
  HookHandle: hHook = 0;
  cntSogl,cntGlasn,cntAll:Integer;
  f : TextFile;

// собственно ловушка
function Key_Hook(Code: integer; wParam: word; lParam: Longint): Longint; stdcall; export;
var
  H:HWND;
begin
  {если Code >= 0, то ловушка может обработать событие}
  if (Code >= 0) and (lParam and $40000000 = 0) then
  begin
    Inc(cntAll);
    //ищем окно приложения, которому DLL будет передавать сведения.
    // Приложение ищется по имени класса и по заголовку
    // Caption формы управляющей     программы, который должен быть равен
    //'XXX' !!!!
    H:=FindWindow('TForm1', 'XXX');
    // это те клавиши, которые отслеживаются?
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
    //  если 0, то система должна дальше обработать это событие, если 1 - нет
    Result:=0;
  end
  else
    if Code < 0 then
      { если Code < 0, то нужно вызвать следующую ловушку }
      Result := CallNextHookEx(HookHandle, Code, wParam, lParam);

  Rewrite(f);
  Writeln(f,'Всего нажатий ='+IntToStr(cntAll));
  Writeln(f,'- гласных     ='+IntToStr(cntGlasn));
  Writeln(f,'- согласных   ='+IntToStr(cntSogl));
  Close(f);
end;
// при выгрузке DLL надо снять ловушку
procedure LocalExitProc; far;
begin
  if HookHandle <> 0 then
  begin
    UnhookWindowsHookEx(HookHandle);
    ExitProc:=SaveExitProc;
  end;
end;

exports Key_Hook;
// инициализация DLL при загрузке ее в память
begin
  AssignFile(f, 'keys.txt');
  cntAll:=0;
  cntSogl:=0;
  cntGlasn:=0;
  //Создание ловушки, перехватывающей события клавиатуры
  HookHandle:=SetWindowsHookEx(wh_Keyboard, @Key_Hook, hInstance, 0);
  if HookHandle = 0 then
     MessageBox(0, 'Unable to set hook!', 'Error', mb_Ok)
  else
  begin
    SaveExitProc := ExitProc;
    ExitProc := @LocalExitProc;
  end;
end.
