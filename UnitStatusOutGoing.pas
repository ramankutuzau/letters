unit UnitStatusOutGoing;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,UnitMails, Data.DB,
  mySQLDbTables;

type
  TFormStatusOutGoing = class(TForm)
    ComboBoxStatus: TComboBox;
    constructor Create();
    procedure ComboBoxStatusChange(Sender: TObject);
    procedure RequestChangeStatus();
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStatusOutGoing: TFormStatusOutGoing;
  ID : string;
  Status : String;
  ID_Status : Integer;

implementation

{$R *.dfm}

procedure TFormStatusOutGoing.ComboBoxStatusChange(Sender: TObject);
begin
    if ComboBoxStatus.ItemIndex = 0 then ID_Status := 1;
    if ComboBoxStatus.ItemIndex = 1 then ID_Status := 2;
    if ComboBoxStatus.ItemIndex = 2 then ID_Status := 3;
    RequestChangeStatus();
    FormMails.ListOutGoingView;
    FormMails.ListIncomingView;
    FormStatusOutGoing.Close;
end;

constructor TFormStatusOutGoing.Create();
begin
     if Status = 'Письмо сформировано' then ID_Status := 1;
     if Status = 'Письмо отправлено' then ID_Status := 2;
     if Status = 'Письмо не получено получателем' then ID_Status := 3;

     ComboBoxStatus.ItemIndex := ID_status - 1;
end;

procedure TFormStatusOutGoing.RequestChangeStatus();
begin


    MySQLQueryLetters := TMySQLQuery.Create(Application);
    MySQLQueryLetters.Database := FormMails.MySQLDatabaseLetters;
    MySQLQueryLetters.SQL.Text := 'UPDATE `listoutgoingmails` SET '+
    '`StatusMailsID` =  ''' + inttostr(ID_Status) + ''' ' +
    ' WHERE `ListOutGoingMailsID` = ''' + ID + ''' ';
    MySQLQueryLetters.ExecSQL;


end;

end.
