unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  FileName: string;
  FileHandle: THandle;
  FileMapping: THandle;
  FileMappingSize: Integer;
  FileContent: Pointer;
  FileSize: Integer;
  I: Integer;
  TextFile: Text;
  Line: string;
  FilePtr: PAnsiChar;

  FileText: TStringList;
implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);

begin
  if OpenDialog1.Execute then
  begin
    FileName := OpenDialog1.FileName;
    // открываем файл для чтения и записи
    FileHandle := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, FILE_SHARE_READ or FILE_SHARE_WRITE, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    if FileHandle <> INVALID_HANDLE_VALUE then
    begin
      try
        // размер файла
        FileSize := GetFileSize(FileHandle, nil);
        
        // проецируем отображение файла в памяти
        FileMappingSize := FileSize;
        FileMapping := CreateFileMapping(FileHandle, nil, PAGE_READWRITE, 0, FileMappingSize, nil);
        if FileMapping <> 0 then
        begin
          FileContent := MapViewOfFile(FileMapping, FILE_MAP_WRITE, 0, 0, FileMappingSize);
          if Assigned(FileContent) then
          begin
            // заменяем числа на '**'
            for I := 0 to FileSize - 2 do
            begin
              if (PChar(FileContent)[I] in ['0'..'9']) and (PChar(FileContent)[I + 1] in ['0'..'9']) then
              begin
                PChar(FileContent)[I] := '*';
                PChar(FileContent)[I + 1] := '*';
              end;
            end;
          end;
          
          UnmapViewOfFile(FileContent);
        end;
        
        CloseHandle(FileMapping);
      finally
        CloseHandle(FileHandle);
      end;
      
      ShowMessage('файл успешно обработан.');
    end
    else
      ShowMessage('не удалось открыть файл.');
  end;

  if FileExists(FileName) then
  begin
    FileText := TStringList.Create;
    try
      FileText.LoadFromFile(FileName); // загружаем содержимое файла в TStringList
      Memo1.Lines := FileText; // вывод в Memo1
    finally
      FileText.Free;
    end;
  end
  else
    ShowMessage('Файл не найден');

end;

end.
