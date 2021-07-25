unit UnitStatusChange;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,UnitMails, Vcl.StdCtrls, Data.DB,
  mySQLDbTables, Vcl.DBCtrls, IWVCLBaseControl, IWBaseControl,
  IWBaseHTMLControl, IWControl, IWCompListbox, IWDBStdCtrls;

type
  TFormStatusChange = class(TForm)
    DBLookupComboBoxStatus: TDBLookupComboBox;
    procedure RequestChangeStatus();
    constructor Create();
    procedure DBLookupComboBoxStatusClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormStatusChange: TFormStatusChange;
  StatusType,ID_Status : Integer;
  ID,Status: string;
  DataSourceStatus: TDataSource;

implementation

{$R *.dfm}


constructor TFormStatusChange.Create();
begin


   MySQLQueryLetters:= TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := FormMails.MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT ListStatusMailsID,StatusMails FROM ListStatusMails'+
   ' WHERE  StatusType = '''+inttostr(StatusType)+''' ';
   MySQLQueryLetters.Active := true;


   DataSourceStatus := TDataSource.Create(Application);
   DataSourceStatus.DataSet := MySQLQueryLetters;

   DBLookupComboBoxStatus.ListSource := DataSourceStatus;
   DBLookupComboBoxStatus.ListField := 'StatusMails';
   DBLookupComboBoxStatus.KeyField := 'ListStatusMailsID';


end;

procedure TFormStatusChange.DBLookupComboBoxStatusClick(Sender: TObject);
begin

   RequestChangeStatus();
   if StatusType = 0 then FormMails.ListOutGoingView;
   if StatusType = 1 then FormMails.ListIncomingView;
   FormStatusChange.Close;

end;

procedure TFormStatusChange.RequestChangeStatus();
var id_status : string;
begin

    id_status := DBLookupComboBoxStatus.KeyValue;

    if StatusType = 0 then
    begin
    MySQLQueryLetters := TMySQLQuery.Create(Application);
    MySQLQueryLetters.Database := FormMails.MySQLDatabaseLetters;
    MySQLQueryLetters.SQL.Text := 'UPDATE `listoutgoingmails` SET '+
    '`StatusMailsID` =  ''' + id_status + ''' ' +
    ' WHERE `ListOutGoingMailsID` = ''' + ID + ''' ';
    MySQLQueryLetters.ExecSQL;
    end;

    if StatusType = 1 then
    begin
    MySQLQueryLetters := TMySQLQuery.Create(Application);
    MySQLQueryLetters.Database := FormMails.MySQLDatabaseLetters;
    MySQLQueryLetters.SQL.Text := 'UPDATE `ListIncomingMails` SET '+
    '`StatusMailsID` =  ''' + id_status + ''' ' +
    ' WHERE `ListIncomingMailsID` = ''' + ID + ''' ';
    MySQLQueryLetters.ExecSQL;
    end;


end;







end.
