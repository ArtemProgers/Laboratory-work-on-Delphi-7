unit Unit1;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, TLHelp32, Grids;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
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
  hSnapshot: THandle;
  pe32: TProcessEntry32;
  rowIndex: Integer;
begin

  StringGrid1.DefaultColWidth := 150;
  StringGrid1.DefaultRowHeight := 25;

  StringGrid1.Cells[0,0]:='��� �����';
  StringGrid1.Cells[1,0]:='������� ID';
  //StringGrid1.Cells[2,0]:='������������ ������� ID';
  StringGrid1.Cells[2,0]:='������������ ������������'
  StringGrid1.RowCount := 1;
  rowIndex := 1;

  hSnapshot := CreateToolHelp32Snapshot(TH32CS_SNAPPROCESS, 0); //������ ������ ���� ���������
  if hSnapshot <> INVALID_HANDLE_VALUE then
  begin
    pe32.dwSize := SizeOf(TProcessEntry32);  //������ ���������
    if Process32First(hSnapshot, pe32) then  // ���� � ������ ��������
    begin
      repeat
        StringGrid1.Cells[0, rowIndex] := pe32.szExeFile;
        StringGrid1.Cells[1, rowIndex] := IntToStr(pe32.th32ProcessID);
        //StringGrid1.Cells[2, rowIndex] := IntToStr(pe32.th32ParentProcessID);
        StringGrid1.Cells[2, rowIndex] := IntToStr(pe32.GetProcessFileName);
        StringGrid1.RowCount := StringGrid1.RowCount + 1;
        Inc(rowIndex);

      until not Process32Next(hSnapshot, pe32); //��� � ���������� ��������
    end
    else
    begin
      ShowMessage('Error when getting information about the process: ' + SysErrorMessage(GetLastError));
    end;

    CloseHandle(hSnapshot);   //��������� ����������
  end
  else
  begin
    ShowMessage('Error when creating a snapshot of the process: ' + SysErrorMessage(GetLastError));
  end;
end;

end.
