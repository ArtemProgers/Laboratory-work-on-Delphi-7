unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, SyncObjs, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Edit3: TEdit;
    Label3: TLabel;
    Memo1: TMemo;
    Label4: TLabel;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  q: Integer;
  zapr: Integer;
  serv1: THandle;
  hThread2: THandle;
  ThreadId2: DWORD;
  hThread1: array[0..1000] of THandle;
  ThreadId1: array[0..1000] of DWORD;
  procedure Thread1;
  procedure Thread2;

implementation

{$R *.dfm}

procedure TForm1.Thread1;
var
  q1: Integer;
  begin
  q1 := q;
  WaitForSingleObject(serv1, INFINITE);

  if q1 > 0 then
  begin
  Sleep(1000 + Random(2000));
  Memo1.Lines.Add('Извлечён запрос с приоритетом ' + IntToStr(q1));
end;

ReleaseSemaphore(serv1, 1, nil);
end;

procedure TForm1.Thread2;
begin
  while q < zapr do
  begin
  Sleep(100 + Random(200));
  Inc(q);
  Edit3.Text := IntToStr(q);
  hThread1[q] := CreateThread(nil, 0, @Thread1, nil, 0, ThreadId1[q]);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  res:Integer;
begin
  Memo1.Clear;
  q:=0;
  res:=StrToInt(Edit1.text);
  zapr:=StrToInt(Edit2.text);
  serv1:=CreateSemaphore(nil,res,res,nil);
  hThread2:=CreateThread(nil,0,@Thread2,nil,0,ThreadID2);
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.Clear;
  Edit2.Clear;
  Edit3.Clear;
  Memo1.Clear;
end;

end.
 