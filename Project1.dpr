program Project1;

uses
  Vcl.Forms,
  UnitLetters in 'UnitLetters.pas' {FormLetters},
  UnitLettersChange in 'UnitLettersChange.pas' {FormLettersChange};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormLetters, FormLetters);
  Application.CreateForm(TFormLettersChange, FormLettersChange);
  Application.Run;
end.
