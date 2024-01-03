library Calc;

uses
  SysUtils,
  Classes;

{$R *.res}
function SpecFunc(x:Single):Single;       
begin
  result:=(x*x+2*x-3+(x+1)*sqrt(x*x-9))/(x*x-2*x-3+(x-1)*sqrt(x*x-9));
end;

exports SpecFunc;

begin
end.
 