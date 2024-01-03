unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Label1: TLabel;
    Memo1: TMemo;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    SelectedValue: string;
  public
   // property SelectedValue: string read FSelectedValue write FSelectedValue;
  end;

var
  Form1: TForm1;
  p:pointer;
  SelectedValue: string;

implementation

{$R *.dfm}


procedure TForm1.Button1Click(Sender: TObject);
VAR
// SysInf:TSystemInfo;
 SysInf:SYSTEM_INFO;
begin
  GetSystemInfo(SysInf);
  Memo1.Clear;
  memo1.Lines.Add('������ �������� '+IntToStr(SysInf.dwPageSize)+' ����');
  memo1.Lines.Add('��������� '+IntToStr(SysInf.wProcessorArchitecture));
  memo1.Lines.Add('��������������� '+IntToStr(SysInf.wReserved));
  memo1.Lines.Add('���������� ����������� '+IntToStr(SysInf.dwNumberOfProcessors));
  memo1.Lines.Add('����� ��������� ���������� '+IntToStr(SysInf.dwActiveProcessorMask));
  memo1.Lines.Add('��� ���������� '+IntToStr(SysInf.dwProcessorType));
  memo1.Lines.Add('������������� ��������� �������� '+IntToStr(SysInf.dwAllocationGranularity));
  memo1.Lines.Add(' '+IntToStr(SysInf.wProcessorLevel));
  memo1.Lines.Add(' '+IntToStr(SysInf.wProcessorRevision));
end;


procedure TForm1.Button2Click(Sender: TObject);
VAR  //ms:MEMORYSTATUS;
     ms:TMEMORYSTATUS;
begin
  ms.dwLength:=sizeof(MEMORYSTATUS);
  GlobalMemoryStatus(ms);
  Memo1.Clear;
  Memo1.Lines.Add('��������� ������ '+IntToStr(ms.dwMemoryLoad)+' ����');
  Memo1.Lines.Add('����� ���������� ������ '+IntToStr(ms.dwTotalPhys)+' ����');
  Memo1.Lines.Add('��������� ���������� ������ '+IntToStr(ms.dwAvailPhys)+' ����');
  Memo1.Lines.Add('����� ������ ����������� ����� '+IntToStr(ms.dwTotalPageFile)+' ����');
  Memo1.Lines.Add('��������� ������ ����������� ����� '+IntToStr(ms.dwAvailPageFile)+' ����');
  Memo1.Lines.Add('����� ������ ����������� ������ '+IntToStr(ms.dwTotalVirtual)+' ����');
  Memo1.Lines.Add('��������� ������ ����������� ������ '+IntToStr(ms.dwAvailVirtual)+' ����');
end;


procedure TForm1.Button3Click(Sender: TObject);
VAR //mbi:MEMORY_BASIC_INFORMATION;
    mbi:TMemoryBasicInformation;
    dwRez:DWORD;
begin
  if Edit1.GetTextLen<=0
  then ShowMessage('������� ����������� �����')
  else
  begin
    dwRez:=VirtualQuery(pointer(StrToInt(Edit1.Text)),mbi,sizeof(MEMORY_BASIC_INFORMATION));
    Memo1.Clear;
    Memo1.Lines.Add('������� ����� '+IntToStr(integer(mbi.BaseAddress)));
    Memo1.Lines.Add('����� ����������'+IntToStr(integer(mbi.BaseAddress)));
    case mbi.AllocationProtect of
      0:            Memo1.Lines.Add('��� ���������������');
      PAGE_NOACCESS:Memo1.Lines.Add('������� ������ ��� PAGE_NOACCESS');
      PAGE_READONLY:Memo1.Lines.Add('������� ������ ��� PAGE_READONLY');
      PAGE_READWRITE:Memo1.Lines.Add('������� ������ ��� PAGE_READWRITE');
      PAGE_EXECUTE:Memo1.Lines.Add('������� ������ ��� PAGE_EXECUTE');
      PAGE_EXECUTE_READ:Memo1.Lines.Add('������� ������ ��� PAGE_EXECUTE_READ');
      PAGE_EXECUTE_READWRITE:Memo1.Lines.Add('������� ������ ��� PAGE_EXECUTE_READWRITE');
      PAGE_WRITECOPY:Memo1.Lines.Add('������� ������ ��� PAGE_WRITECOPY');
      PAGE_EXECUTE_WRITECOPY:Memo1.Lines.Add('������� ������ ��� PAGE_EXECUTE_WRITECOPY');
    end;
    Memo1.Lines.Add('������ ������� '+IntToStr(mbi.RegionSize)+' ����');
    case mbi.State of
      MEM_COMMIT: Memo1.Lines.Add('��������� ��� MEM_COMMIT');
      MEM_RESERVE: Memo1.Lines.Add('��������� ��� MEM_RESERVE');
      MEM_FREE: Memo1.Lines.Add('��������� ��� MEM_FREE');
    end;
    case mbi.Protect of
      0:            Memo1.Lines.Add('���������������');
      PAGE_NOACCESS:Memo1.Lines.Add('������� ������ ���.������ PAGE_NOACCESS');
      PAGE_READONLY:Memo1.Lines.Add('������� ������ ��� PAGE_READONLY');
      PAGE_READWRITE:Memo1.Lines.Add('������� ������ ��� PAGE_READWRITE');
      PAGE_EXECUTE:Memo1.Lines.Add('������� ������ ��� PAGE_EXECUTE');
      PAGE_EXECUTE_READ:Memo1.Lines.Add('������� ������ ��� PAGE_EXECUTE_READ');
      PAGE_EXECUTE_READWRITE:Memo1.Lines.Add('������� ������ ��� PAGE_EXECUTE_READWRITE');
      PAGE_WRITECOPY:Memo1.Lines.Add('������� ������ ��� PAGE_WRITECOPY');
      PAGE_EXECUTE_WRITECOPY:Memo1.Lines.Add('������� ������ ��� PAGE_EXECUTE_WRITECOPY');
    end;
  end;
end;


procedure TForm1.Button4Click(Sender: TObject);
VAR   ms:MEMORYSTATUS;
begin
  If Edit1.GetTextLen=0
  then p:=VirtualAlloc(nil,4096,MEM_COMMIT,PAGE_READWRITE)
  else p:=VirtualAlloc(pointer(StrToInt64(Edit1.Text)),4096,MEM_COMMIT,PAGE_READWRITE);
  Memo1.Clear;
  ms.dwLength:=sizeof(MEMORYSTATUS);
  GlobalMemoryStatus(ms);
  Memo1.Clear;
  Memo1.Lines.Add('��������� ������ '+IntToStr(ms.dwMemoryLoad)+' ����');
  Memo1.Lines.Add('����� ���������� ������ '+IntToStr(ms.dwTotalPhys)+' ����');
  Memo1.Lines.Add('��������� ���������� ������ '+IntToStr(ms.dwAvailPhys)+' ����');
  Memo1.Lines.Add('����� ������ ����������� ����� '+IntToStr(ms.dwTotalPageFile)+' ����');
  Memo1.Lines.Add('��������� ������ ����������� ����� '+IntToStr(ms.dwAvailPageFile)+' ����');
  Memo1.Lines.Add('����� ������ ����������� ������ '+IntToStr(ms.dwTotalVirtual)+' ����');
  Memo1.Lines.Add('��������� ������ ����������� ������ '+IntToStr(ms.dwAvailVirtual)+' ����');
end;


procedure TForm1.Button5Click(Sender: TObject);
VAR
    ms:MEMORYSTATUS;
begin
  VirtualFree(p,4096,MEM_DECOMMIT);
  VirtualFree(p,4096,MEM_RELEASE);
  Memo1.Clear;
  ms.dwLength:=sizeof(MEMORYSTATUS);
  GlobalMemoryStatus(ms);
  Memo1.Clear;
  Memo1.Lines.Add('��������� ������ '+IntToStr(ms.dwMemoryLoad)+' ����');
  Memo1.Lines.Add('����� ���������� ������ '+IntToStr(ms.dwTotalPhys)+' ����');
  Memo1.Lines.Add('��������� ���������� ������ '+IntToStr(ms.dwAvailPhys)+' ����');
  Memo1.Lines.Add('����� ������ ����������� ����� '+IntToStr(ms.dwTotalPageFile)+' ����');
  Memo1.Lines.Add('��������� ������ ����������� ����� '+IntToStr(ms.dwAvailPageFile)+' ����');
  Memo1.Lines.Add('����� ������ ����������� ������ '+IntToStr(ms.dwTotalVirtual)+' ����');
  Memo1.Lines.Add('��������� ������ ����������� ������ '+IntToStr(ms.dwAvailVirtual)+' ����');
end;


procedure TForm1.Button7Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var
  mbi:TMemoryBasicInformation;
  dwRez:DWORD;
  //SelectedValue: string;
  NewProtect, OldProtect: DWORD;
begin
  SelectedValue := ComboBox1.Items[ComboBox1.ItemIndex];

  if SelectedValue = 'PAGE_NOACCESS' then
  begin
    NewProtect := PAGE_NOACCESS;
    Memo1.Lines.Add('������� ������ ���.������ ������ �� PAGE_NOACCESS');
    Memo1.Lines.Add('������� ������ ��� ������ �� PAGE_NOACCESS');
  end;
  if SelectedValue = 'PAGE_READONLY' then
  begin
    NewProtect := PAGE_READONLY;
    Memo1.Lines.Add('������� ������ ���.������ ������ �� PAGE_READONLY');
    Memo1.Lines.Add('������� ������ ��� ������ �� PAGE_READONLY');
  end;
  if SelectedValue = 'PAGE_READWRITE' then
  begin
    NewProtect := PAGE_READWRITE;
    Memo1.Lines.Add('������� ������ ���.������ ������ �� PAGE_READWRITE');
    Memo1.Lines.Add('������� ������ ��� ������ �� PAGE_READWRITE');
  end;
  if SelectedValue = 'PAGE_EXECUTE' then
  begin
    NewProtect := PAGE_EXECUTE;
    Memo1.Lines.Add('������� ������ ���.������ ������ �� PAGE_EXECUTE');
    Memo1.Lines.Add('������� ������ ��� ������ �� PAGE_EXECUTE');
  end;
  if SelectedValue = 'PAGE_EXECUTE_READ' then
  begin
    NewProtect := PAGE_EXECUTE_READ;
    Memo1.Lines.Add('������� ������ ���.������ ������ �� PAGE_EXECUTE_READ');
    Memo1.Lines.Add('������� ������ ��� ������ �� PAGE_EXECUTE_READ');
  end;
  if SelectedValue = 'PAGE_EXECUTE_READWRITE' then
  begin
    NewProtect := PAGE_EXECUTE_READWRITE;
    Memo1.Lines.Add('������� ������ ���.������ ������ �� PAGE_EXECUTE_READWRITE');
    Memo1.Lines.Add('������� ������ ��� ������ �� PAGE_EXECUTE_READWRITE');
  end;
  if SelectedValue = 'PAGE_WRITECOPY' then
  begin
    NewProtect := PAGE_WRITECOPY;
    Memo1.Lines.Add('������� ������ ���.������ ������ �� PAGE_WRITECOPY');
    Memo1.Lines.Add('������� ������ ��� ������ �� PAGE_WRITECOPY');
  end;
  if SelectedValue = 'PAGE_EXECUTE_WRITECOPY' then
  begin
    NewProtect := PAGE_EXECUTE_WRITECOPY;
    Memo1.Lines.Add('������� ������ ���.������ ������ �� PAGE_EXECUTE_WRITECOPY');
    Memo1.Lines.Add('������� ������ ��� ������ �� PAGE_EXECUTE_WRITECOPY');
  end;
  mbi.AllocationProtect := NewProtect;
  VirtualProtect(Pointer(NewProtect), 4096, NewProtect, OldProtect);
  //Button6Click(SelectedValue);
end;

procedure TForm1.Button6Click(Sender: TObject);
VAR
    mbi:TMemoryBasicInformation;
    dwRez:DWORD;
begin
  if Edit1.GetTextLen<=0
  then ShowMessage('������� ����������� �����')
  else
  begin
    dwRez:=VirtualQuery(pointer(StrToInt(Edit1.Text)),mbi,sizeof(MEMORY_BASIC_INFORMATION));
    Memo1.Clear;
    Memo1.Lines.Add('������� ����� '+IntToStr(integer(mbi.BaseAddress)));
    Memo1.Lines.Add('����� ���������� '+IntToStr(integer(mbi.BaseAddress)));
    Memo1.Lines.Add('��� ��������������');
    Memo1.Lines.Add('������� ������ ��� ' +SelectedValue);
    Memo1.Lines.Add('������ ������� '+IntToStr(mbi.RegionSize)+' ����');
    case mbi.State of
      MEM_COMMIT: Memo1.Lines.Add('��������� ��� MEM_COMMIT');
      MEM_RESERVE: Memo1.Lines.Add('��������� ��� MEM_RESERVE');
      MEM_FREE: Memo1.Lines.Add('��������� ��� MEM_FREE');
    end;
    Memo1.Lines.Add('������� ������ ���.������ '+SelectedValue);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ComboBox1.Items.Add('PAGE_NOACCESS');
  ComboBox1.Items.Add('PAGE_READONLY');
  ComboBox1.Items.Add('PAGE_READWRITE');
  ComboBox1.Items.Add('PAGE_EXECUTE');
  ComboBox1.Items.Add('PAGE_EXECUTE_READ');
  ComboBox1.Items.Add('PAGE_EXECUTE_READWRITE');
  ComboBox1.Items.Add('PAGE_WRITECOPY');
  ComboBox1.Items.Add('PAGE_EXECUTE_WRITECOPY');
end;

end.
