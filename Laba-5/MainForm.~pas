unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  ProcessInfo: TProcessInformation;
  StartupInfo: TStartupInfo;
  Timeout: Integer;

  FileText: TextFile;
  FileName: string;
  CurrentLine, LastLine: string;

begin
  FillChar(StartupInfo, SizeOf(StartupInfo), 0);
  StartupInfo.cb := SizeOf(StartupInfo);

  // Укажите путь к второму приложению
  if not CreateProcess(nil, 'Project2.exe', nil, nil, False,
    0, nil, nil, StartupInfo, ProcessInfo) then
  begin
    ShowMessage('Ошибка запуска второго приложения!');
    Exit;
  end;

  // Укажите временной интервал в миллисекундах
  Timeout := StrToIntDef(Edit1.Text, 0);

  // Выполнение задержки
  Sleep(Timeout*1000);

  // Прекращение работы второго приложения
  TerminateProcess(ProcessInfo.hProcess, 0);
  CloseHandle(ProcessInfo.hProcess);
  CloseHandle(ProcessInfo.hThread);

  ShowMessage('Работа второго приложения завершена!');

  FileName := 'result.txt';
  AssignFile(FileText, FileName);
  Reset(FileText);

  CurrentLine := '';
  LastLine := '';

  while not Eof(FileText) do
  begin
    ReadLn(FileText, CurrentLine);
    LastLine := CurrentLine;
  end;

  CloseFile(FileText);

  Memo1.Lines.Add(LastLine);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
     Edit1.Clear;
     Memo1.Clear;
end;

end.
