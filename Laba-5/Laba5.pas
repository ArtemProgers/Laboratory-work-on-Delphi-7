unit Laba5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
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

function Factorial(n: Integer): Extended;
var
  i: Integer;
begin
  Result := 1;
  for i := 1 to n do
    Result := Result * i;
end;


procedure TForm1.Button1Click(Sender: TObject);
var
  x, sum: Extended;
  n: Integer;
  i: Integer;
  ResultsFile: TextFile;
begin
  // значение x
  x := 2;
  x := StrToIntDef(Edit1.Text, 0);
  // количество интераций (n)
  n := 10;
  n := StrToIntDef(Edit2.Text, 0);
  
  AssignFile(ResultsFile, 'result.txt');
  Rewrite(ResultsFile);

  sum := 0;
  for i := 0 to n do
  begin

    sum := sum + Power(-1, i) * Power(x, 2 * i) / Factorial(2 * i);

    Writeln(ResultsFile, 'n=', i, ': sum=', sum);

    Memo1.Lines.Add('n = '+FloatToStr(i) +':   sum = '+FloatToStr(sum));
  end;

  CloseFile(ResultsFile);

  ShowMessage('Вычисления завершины. Результаты записаны в файл.');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
    Memo1.Clear;
    Edit1.Clear;
    Edit2.Clear;
end;

end.
