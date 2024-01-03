program VirtualMemory;

{$APPTYPE CONSOLE}

uses
  SysUtils, Windows;

var
  a, z: Single;
  i: Integer;
  addrString: string;
  addr: Pointer;
  memInfo: TMemoryBasicInformation;
  bytesRead: DWORD;
  buffer: array[0..99] of Byte;

begin
  try
    // Вычисление значений функции
    for i := 1 to 10  do
    begin
      a := i * 0.1;
      z := (Cos(a) + Sin(a)) / (Cos(a) - Sin(a));
      Writeln('a = ', a:0:1, ', z = ', z:0:2);
    end;

    // Ввод адреса
    Write('Enter the address: ');
    ReadLn(addrString);

    addr := Pointer(StrToInt(addrString));
    // Получение информации о памяти по указанному адресу
    VirtualQuery(addr, memInfo, SizeOf(memInfo));

    // Проверка, выделена ли физическая память по указанному адресу
    if (memInfo.State = MEM_COMMIT) and (memInfo.Protect and PAGE_GUARD = 0) then
    begin
      // Чтение первых ста байт
      ReadProcessMemory(GetCurrentProcess, addr, @buffer, SizeOf(buffer), bytesRead);

      // Вывод содержимого первых ста байт
      for i := 0 to bytesRead - 1 do
        Write(buffer[i], ' ');

      Writeln;
    end
    else
    begin
      Writeln('there is no allocated physical memory at the specified address');
    end;

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

  // Освобождение памяти
  VirtualFree(addr, 0, MEM_RELEASE);

  ReadLn;
end.

