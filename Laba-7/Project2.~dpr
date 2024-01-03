program Project2;

{$APPTYPE CONSOLE}

uses
  Windows,
  SysUtils;

var
  q: Integer;
  zapr: Integer;
  serv1: THandle;
  hThread2: THandle;
  ThreadId2: DWORD;
  hThread1: array[0..1000] of THandle;
  ThreadId1: array[0..1000] of DWORD;

procedure Thread1;
var
  q1: Integer;
  pri: Integer;
begin
  q1 := q;
  WaitForSingleObject(serv1, INFINITE);
  
  if q1 > 0 then
  begin
    Sleep(1000 + Random(2000));
    pri := Random(3);
    case pri of
      0: SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_LOWEST);
      1: SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_BELOW_NORMAL);
      2: SetThreadPriority(GetCurrentThread, THREAD_PRIORITY_NORMAL);
    end;
    Writeln('Priority request retrieved ' + IntToStr(q1) + '. Processing priority: ' + IntToStr(pri));
  end;
  ReleaseSemaphore(serv1, 1, nil);
end;

procedure Thread2;
begin
  while q < zapr do
  begin
    Sleep(100 + Random(200));
    Inc(q);
    Writeln('Current number of requests: ' + IntToStr(q));
    hThread1[q] := CreateThread(nil, 0, @Thread1, nil, 0, ThreadId1[q]);
  end;
end;

var
  res: Integer;
begin
  try
    Writeln('Enter the initial number of resources:');
    Readln(res);
    Writeln('Enter the number of requests:');
    Readln(zapr);
    
    q := 0;
    serv1 := CreateSemaphore(nil, res, res, nil);
    hThread2 := CreateThread(nil, 0, @Thread2, nil, 0, ThreadId2);
    
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

