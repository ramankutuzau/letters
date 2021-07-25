program Project1;

uses
  Vcl.Forms,
  UnitMails in 'UnitMails.pas' {FormMails},
  UnitAddLetters in 'UnitAddLetters.pas' {FormAddLetters},
  UnitStatusChange in 'UnitStatusChange.pas' {FormStatusChange};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
//  Application.CreateForm(TFormLetters, FormLetters);
//  Application.CreateForm(TFormLettersChange, FormLettersChange);
  Application.CreateForm(TFormMails, FormMails);
  Application.CreateForm(TFormAddLetters, FormAddLetters);
  Application.CreateForm(TFormStatusChange, FormStatusChange);
  Application.Run;
end.
