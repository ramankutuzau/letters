unit UnitStatusIncoming;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, mySQLDbTables;

type
  TFormStatusIncoming = class(TForm)
    ComboBoxStatus: TComboBox;
    MySQLQueryStatus: TMySQLQuery;
    constructor Create();
    procedure RequestChangeStatus();
    procedure ComboBoxStatusChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStatusIncoming: TFormStatusIncoming;
  ID : string;
  Status : String;
  ID_Status : Integer;

implementation

{$R *.dfm}

uses UnitMails;

procedure TFormStatusIncoming.ComboBoxStatusChange(Sender: TObject);
begin
    if ComboBoxStatus.ItemIndex = 0 then ID_Status := 4;
    if ComboBoxStatus.ItemIndex = 1 then ID_Status := 5;
    if ComboBoxStatus.ItemIndex = 2 then ID_Status := 6;
    RequestChangeStatus();
    FormMails.ListOutGoingView;
    FormMails.ListIncomingView;
    FormStatusincoming.Close;
end;

constructor TFormStatusIncoming.Create();
begin
     if Status = 'Письмо зарегистрировано' then ID_Status := 4;
     if Status = 'Ответ отправлен' then ID_Status := 5;
     if Status = 'Письмо закрыто' then ID_Status := 6;

     ComboBoxStatus.ItemIndex := ID_status - 4;
end;


procedure TFormStatusIncoming.RequestChangeStatus();
begin

    MySQLQueryStatus := TMySQLQuery.Create(Application);
    MySQLQueryStatus.Database := FormMails.MySQLDatabaseLetters;
    MySQLQueryStatus.SQL.Text := 'UPDATE `ListIncomingMails` SET '+
    '`StatusMailsID` =  ''' + inttostr(ID_Status) + ''' ' +
    ' WHERE `ListIncomingMailsID` = ''' + ID + ''' ';
    MySQLQueryStatus.ExecSQL;

end;


end.
