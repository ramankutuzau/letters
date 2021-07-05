unit UnitLettersChange;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,Vcl.ExtCtrls, mySQLDbTables,System.Zip,idFTP,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase;

type
  TFormLettersChange = class(TForm)
    procedure AddContentView(BoxCaption : String);
    procedure ButtonAttachOnClick(Sender: TObject);
    procedure ButtonChangeOnClick(Sender: TObject);
    procedure RequestAdd();
    constructor Create();
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLettersChange: TFormLettersChange;
  GroupBoxMain : TGroupBox;
  GroupBoxTittle : TGroupBox;
  GroupBoxContent : TGroupBox;
  LabeledEditTittle : TLabeledEdit;
  LabelContent : TLabel;
  MemoContent : TMemo;
  ButtonAttach : TButton;
  ButtonChange : TButton;
  variant : integer;
  NewID,MailsText : String;
  ProgressBar : TProgressBar;

implementation

{$R *.dfm}

uses UnitLetters;

constructor TFormLettersChange.Create();
begin
  FormLettersChange.Width := 352;
  FormLettersChange.Height := 301;

   if variant = 0 then
  begin
  AddContentView('��������� ������');
  LabeledEditTittle.ReadOnly := true;
  LabeledEditTittle.Text := NewID;
  end;

  if variant = 1 then
  begin
  AddContentView('�������� ������');
  LabeledEditTittle.ReadOnly := false;

  end;




end;



procedure TFormLettersChange.FormClose(Sender: TObject;
  var Action: TCloseAction);
var
   WND:HWND;
   Tip:integer;
begin
   WND:=FormLetters.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
   if Length(MemoContent.Text) = 0 then
   begin
     case MessageBox(Wnd,'�� ������������� ������ �������� ���� "����������" ������?',
     '����������',Tip) of
       IDYES:
         begin
         RequestAdd();
         MemoContent.Clear;


         end;
       IDNO : Action := caNone;
     end;
   end else ButtonChangeOnClick(Sender);


  FormLetters.ListOutGoingView();
  FormLetters.ListIncomingView();
end;

procedure TFormLettersChange.AddContentView(BoxCaption : String);
begin
  GroupBoxMain := TGroupBox.Create(FormLettersChange);
  GroupBoxMain.Parent := FormLettersChange;
   with GroupBoxMain do begin
  Left := 0;
  Top := 0;
  Width := 347;
  Height := 217;
  Align := alClient;
  Caption := BoxCaption;
  TabOrder := 0;
  Width := 345;
  Height := 241;
  end;

  GroupBoxTittle := TGroupBox.Create(GroupBoxMain);
  GroupBoxTittle.Parent := GroupBoxMain;
  with GroupBoxTittle do begin
  Left := 11;
  Top := 14;
  Width := 326;
  Height := 52;
  TabOrder := 1;
  end;

  LabeledEditTittle :=  TLabeledEdit.Create(GroupBoxTittle);
  LabeledEditTittle.Parent := GroupBoxTittle;
    with LabeledEditTittle do begin
    Left := 3;
    Top := 21;
    Width := 150;
    Height := 23;
    EditLabel.Width := 86;
    EditLabel.Height := 15;
    EditLabel.Caption := #1053#1086#1084#1077#1088' '#1087#1080#1089#1100#1084#1072;
    EditLabel.Font.Charset := RUSSIAN_CHARSET;
    EditLabel.Font.Color := clWindowText;
    EditLabel.Font.Height := -13;
    EditLabel.Font.Name := 'SF UI Display';
    EditLabel.Font.Style := [];
    EditLabel.ParentFont := False;
    Font.Charset := RUSSIAN_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'SF UI Display';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 0;
    end;


  GroupBoxContent :=  TGroupBox.Create(GroupBoxMain);
  GroupBoxContent.Parent := GroupBoxMain;
  with GroupBoxContent do begin
  Left := 11;
  Top := 69;
  Width := 326;
  Height := 188;
  TabOrder := 0;
  end;
  LabelContent :=  TLabel.Create(GroupBoxContent);
  LabelContent.Parent := GroupBoxContent;
   with LabelContent do begin
    Left := 3;
    Top := 3;
    Width := 83;
    Height := 15;
    Caption := #1057#1086#1076#1077#1088#1078#1072#1085#1080#1077': ';
    Font.Charset := RUSSIAN_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'SF UI Display';
    Font.Style := [];
    ParentFont := False;
  end;
  MemoContent := TMemo.Create(GroupBoxContent);
  MemoContent.Parent := GroupBoxContent;
  with MemoContent do begin

    Left := 3;
    Top := 24;
    Width := 320;
    Height := 100;
    Font.Charset := RUSSIAN_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'SF UI Display';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 0;
  end;

  ProgressBar := TProgressBar.Create(GroupBoxContent);
  ProgressBar.Parent := GroupBoxContent;
  with ProgressBar do begin
  Left := 3;
  Top := 128;
  Width := 320;
  Height := 25;
  TabOrder := 0;

  end;

  ButtonAttach := TButton.Create(GroupBoxContent);
  ButtonAttach.Parent := GroupBoxContent;
   with ButtonAttach do begin
    Left := 0;
    Top := 159;
    Width := 126;
    Height := 25;
    Caption := '���������� ����';
    Font.Charset := RUSSIAN_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'SF UI Display';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 1;
    OnClick :=  ButtonAttachOnClick;
  end;

  ButtonChange := TButton.Create(GroupBoxContent);
  ButtonChange.Parent := GroupBoxContent;
  with ButtonChange do begin
    Left := 237;
    Top := 159;
    Width := 81;
    Height := 25;
    Caption := '��������';
    Font.Charset := RUSSIAN_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'SF UI Display';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 2;
    OnClick := ButtonChangeOnClick;
  end;

end;


procedure TFormLettersChange.ButtonAttachOnClick(Sender: TObject);
var
openDialog : TOpenDialog; i:integer; Zip: TZipFile;
idFTP : TidFTP; lastAddID,NameFile,SQLText,SQLValues: String;
begin
   if Length(LabeledEditTittle.Text) > 0  then
  begin
  openDialog := TOpenDialog.Create(self);
  openDialog.InitialDir := GetCurrentDir;
  openDialog.Options := [ofFileMustExist];
  openDialog.Options := [ofAllowMultiSelect];
  openDialog.Execute;


    idFTP:=TidFTP.Create(nil);
    idFTP.Host:='135.181.40.238';
    idFTP.Username:='romashka';
    idFTP.Password:='romashka1234';

    ProgressBar.Position := 0;

    idFTP.Connect;
    SQLValues := '';
    SQLText := 'INSERT INTO `listfiles` (`FileID`, `FileName`, `FileType`, `TableID`, `Visible`) VALUES ';
    for i := 0 to OpenDialog.Files.Count - 1 do
      begin
        ProgressBar.Position := 50;
        NameFile := LabeledEditTittle.text+'_'+ExtractFileName(OpenDialog.Files.Strings[i]);
         if i = OpenDialog.Files.Count - 1 then
        SQLText := SQLtext + '(NULL, '''+NameFile+''', '''+inttostr(variant)+''', '''+newID+''', 1) ' else
        SQLText := SQLtext + '(NULL, '''+NameFile+''', '''+inttostr(variant)+''', '''+newID+''', 1), ';

       if idFTP.Connected then
        try
         idFTP.ReadTimeout := 2000;
         idFTP.Put(OpenDialog.Files.Strings[i],LabeledEditTittle.text+'_'
         +ExtractFileName(OpenDialog.Files.Strings[i]),true);
         ProgressBar.Position := 100;

        except
        on E : Exception do
          ShowMessage('������ �������� �����: '+E.Message);
        end;


      end;


     MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := SQLText;

     MySQLQueryLetters.ExecSQL;







   idFTP.Disconnect;

   openDialog.Free;
  end else showmessage('������� ����� ������');
end;


procedure TFormLettersChange.RequestAdd();
begin
  if variant = 0 then
     begin
     MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := 'UPDATE `listoutgoingmails` SET'+
     ' ShortEssence ='''+MemoContent.Text+''' WHERE `listoutgoingmails`.`ListOutgoingMailsID` = '+newID;
     MySQLQueryLetters.ExecSQL;
     end;

  if variant = 1 then
    begin
     MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := 'UPDATE `ListIncomingMails` SET'+
     ' NumberMails = '''+LabeledEditTittle.Text+''', ShortEssence ='''+MemoContent.Text+''' '+
    ' WHERE `ListIncomingMails`.`ListIncomingMailsID` = '+newID;
     MySQLQueryLetters.ExecSQL;
    end;

end;

procedure TFormLettersChange.ButtonChangeOnClick(Sender: TObject);
begin

   RequestAdd();
   FormLettersChange.Close;

end;


end.
