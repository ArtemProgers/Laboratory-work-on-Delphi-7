unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    SpecFuncM:function(x:Single):Single;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
var
  x:Single;
  z1:Single;
  instance:LongWord;
begin
  instance:=LoadLibrary('Calc.dll');
  SpecFuncM:=GetProcAddress(instance,'SpecFunc');
  x:=StrToFloat(Edit1.Text);
  try
    z1:=SpecFuncM(x);

    Label3.Caption:=FloatToStr(z1);
  except
    On E: Exception do ShowMessage(E.Message)
    else
      ShowMessage('����������� ������');
  end;
  FreeLibrary(instance);  
end;

end.
