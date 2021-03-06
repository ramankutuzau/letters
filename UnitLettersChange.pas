unit UnitLettersChange;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,Vcl.ExtCtrls, mySQLDbTables,System.Zip,idFTP,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,IdFTPCommon,System.IOUtils,
  IdExplicitTLSClientServerBase, GIFImg;


type
  TFormLettersChange = class(TForm)
    procedure AddContentView(BoxCaption : String);
    procedure ButtonAttachOnClick(Sender: TObject);
    procedure ButtonChangeOnClick(Sender: TObject);
    procedure RequestDelete();
    procedure RequestAdd();
    procedure RequestAddFile();
    procedure RequestUpdateFile();
    procedure idFTPConnet();
    procedure AttachFiles();
    procedure AddFileView();

    procedure StringGridSelectCell(Sender: TObject; ACol,ARow: Integer; var CanSelect: Boolean);
    constructor Create();
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
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
  idFTP : TidFTP;
  gif: TGifImage;
  StringGrid: TStringGrid;
  RowCount,StringCount,arrFilesCount : integer;
  ArrFiles,ArrFilesDes: array of String;
  change : Boolean;


implementation

{$R *.dfm}

uses UnitLetters;

constructor TFormLettersChange.Create();
begin
  FormLettersChange.Width := 352;
  FormLettersChange.Height := 420;

   if variant = 0 then
  begin
  AddContentView('????????? ??????');
  LabeledEditTittle.ReadOnly := true;
  LabeledEditTittle.Text := NewID;
  end;

  if variant = 1 then
  begin
  AddContentView('???????? ??????');
  LabeledEditTittle.ReadOnly := false;

  end;

   AddFileView();


end;

procedure TFormLettersChange.AddFileView();
var i:integer;
begin

StringGrid.RowCount := Length(ArrFiles) + 1;
 for i := 0 to Length(ArrFiles) - 1 do
  begin
  StringGrid.Cells[0,i + 1] := arrFiles[i];
  StringGrid.Cells[1,i + 1] := ArrFilesDes[i];
  end;

end;


procedure TFormLettersChange.idFTPConnet();
begin

    idFTP:=TidFTP.Create(nil);
    idFTP.Host:='135.181.40.238';
    idFTP.Username:='romashka';
    idFTP.Password:='romashka1234';
    idFTP.Passive := true;
    idFTP.Connect;

end;

procedure TFormLettersChange.RequestDelete();
begin
    if variant = 0  then
     begin
     MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := 'UPDATE `listoutgoingmails` SET'+
     ' Visible = 0 WHERE `listoutgoingmails`.`ListOutgoingMailsID` = '+newID;
     MySQLQueryLetters.ExecSQL;
     end;
    if variant = 1  then
     begin
     MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := 'UPDATE `ListIncomingMails` SET'+
     ' Visible = 0 WHERE `ListIncomingMails`.`ListIncomingmailsID` = '+newID;
     MySQLQueryLetters.ExecSQL;
     end;
end;


procedure TFormLettersChange.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     RequestUpdateFile();
     FormLetters.ListOutGoingView();
     FormLetters.ListIncomingView();
     ArrFiles := nil;
     ArrFilesDes := nil;
end;

procedure TFormLettersChange.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
   WND:HWND;
   Tip:integer;
begin

if Length(MemoContent.Text) = 0 then
   begin
   WND:=FormLetters.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
     case MessageBox(Wnd,'???? ?? ???????? ???? "??????????" ??????, ?????? ?? ??????????. ??????????? ',
     '??????????????',Tip) of
       IDYES:
         begin
             requestDelete();
             FormLetters.ListOutGoingView();
             FormLetters.ListIncomingView();
         end;
        IDNO:
         begin
         CanClose := false;
         end;

     end;

   end else
    begin
      RequestAdd();
    end;


end;

procedure TFormLettersChange.FormCreate(Sender: TObject);
begin
    idFTPConnet();
    StringCount := 0;
end;

procedure TFormLettersChange.AddContentView(BoxCaption : String);
var i:integer;
begin
  GroupBoxMain := TGroupBox.Create(FormLettersChange);
  GroupBoxMain.Parent := FormLettersChange;
   with GroupBoxMain do begin
  Left := 0;
  Top := 6;
  Width := 347;
  Height := 217;
  Align := alClient;
  Caption := BoxCaption;
  TabOrder := 0;
  Width := 345;
  Height := 241;
  Font.Charset := RUSSIAN_CHARSET;
  Font.Color := clWindowText;
  Font.Height := -13;
  Font.Name := 'SF UI Display';
  Font.Style := [];
  ParentFont := False;
  end;

  GroupBoxTittle := TGroupBox.Create(GroupBoxMain);
  GroupBoxTittle.Parent := GroupBoxMain;
  with GroupBoxTittle do begin
  Left := 11;
  Top := 18;
  Width := 326;
  Height := 49;
  TabOrder := 1;
  Font.Charset := RUSSIAN_CHARSET;
  Font.Color := clWindowText;
  Font.Height := -13;
  Font.Name := 'SF UI Display';
  Font.Style := [];
  ParentFont := False;
  end;

  LabeledEditTittle :=  TLabeledEdit.Create(GroupBoxTittle);
  LabeledEditTittle.Parent := GroupBoxTittle;
    with LabeledEditTittle do begin
    Left := 6;
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
  Height := 315;
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
    Left := 3;
    Top := 159;
    Width := 126;
    Height := 25;
    Caption := '?????????? ????';
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
    Caption := '????????';
    Font.Charset := RUSSIAN_CHARSET;
    Font.Color := clWindowText;
    Font.Height := -13;
    Font.Name := 'SF UI Display';
    Font.Style := [];
    ParentFont := False;
    TabOrder := 2;
    OnClick := ButtonChangeOnClick;
  end;

  StringGrid := TStringGrid.Create(GroupBoxContent);
  StringGrid.Parent := GroupBoxContent;
  with  StringGrid do begin
  Left := 3;
  Top := 190;
  Width := 320;
  Height := 120;
  Font.Charset := RUSSIAN_CHARSET;
  Font.Color := clWindowText;
  Font.Height := -13;
  Font.Name := 'SF UI Display';
  Font.Style := [];
  ParentFont := False;
  TabOrder := 0;
  Options:=StringGrid.Options + [goEditing];
  RowCount := Rowcount;
  ColCount := 2;
  Cells[0,0] := '??? ?????';
  Cells[1,0] := '???????? ?????';
  ColWidths[0]:= 160;
  ColWidths[1]:= 160;
  OnSelectCell := StringGridSelectCell;
  StringGrid.Options := StringGrid.Options - [goEditing];
  end;


end;




procedure TFormLettersChange.StringGridSelectCell(Sender: TObject; ACol,
 ARow: Integer; var CanSelect: Boolean);
begin
if (ACol = 1) and (ARow = 0) then
  StringGrid.Options := StringGrid.Options - [goEditing]
else
  StringGrid.Options := StringGrid.Options + [goEditing]
end;

procedure TFormLettersChange.ButtonAttachOnClick(Sender: TObject);
begin
AttachFiles();
end;

procedure TFormLettersChange.AttachFiles();
var
openDialog : TOpenDialog; i:integer;
 lastAddID,NameFile,SQLText,SQLFileText: String; today : TDateTime;

begin
   if Length(LabeledEditTittle.Text) > 0  then
  begin
      openDialog := TOpenDialog.Create(self);
      openDialog.InitialDir := GetCurrentDir;
      openDialog.Options := [ofFileMustExist];
      openDialog.Options := [ofAllowMultiSelect];


    today := Time;

   if openDialog.Execute then
     begin


      ProgressBar.Position := 25;

      StringGrid.RowCount := Length(ArrFiles) + OpenDialog.Files.Count + 1;

      ArrFilesCount := Length(ArrFiles);

      SetLength(arrFiles,OpenDialog.Files.Count);

      StringCount := 0;


      for i := 0 to OpenDialog.Files.Count - 1  do
        begin

          NameFile := LabeledEditTittle.text + '_' + TimeToStr(today) + '_' +
          ExtractFileName(OpenDialog.Files.Strings[i]);

          arrFiles[i] := NameFile;

          StringGrid.Cells[0, ArrFilesCount + i + 1] := ExtractFileName(OpenDialog.Files.Strings[i]);

         if idFTP.Connected then
          try

          idFTP.TransferType := ftBinary;
          idFTP.Put(OpenDialog.Files.Strings[StringCount],NameFile,true);


          except
          on E : Exception do
            ShowMessage('?????? ???????? ?????: ' + E.Message);
          end;
            ProgressBar.Position := 100;

            StringCount := StringCount + 1;

        end;

       if OpenDialog.Files.Count > 0 then
          begin
          RequestAddFile();
          end;

     end;




    end else showmessage('??????? ????? ??????');

end;

procedure  TFormLettersChange.RequestAddFile();
var i : integer; SQLtext : String;
begin



  SQLText := 'INSERT INTO `listfiles` (`FileID`, `FileName`, `FileType`, `TableID`,`Description`, `Visible` ) VALUES ';

    for i := 0 to  Length(ArrFiles) - 1 do
        begin
          if i = Length(ArrFiles) - 1  then
           SQLText := SQLtext + '(NULL, ''' + ArrFiles[i] + ''', ''' + inttostr(variant) + ''', '''+newID+''', '''+StringGrid.Cells[1,ArrFilesCount + i + 1]+''', 1) ' else

        SQLText := SQLtext + '(NULL, ''' + ArrFiles[i] + ''', ''' + inttostr(variant) + ''', '''+newID+''','''+StringGrid.Cells[1,ArrFilesCount + i + 1]+''', 1), ';
        end;

       MySQLQueryLetters := TMySQLQuery.Create(Application);
       MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
       MySQLQueryLetters.SQL.Text := SQLText;
       MySQLQueryLetters.ExecSQL;



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

   if StringGrid.RowCount > 1 then



end;

procedure TFormLettersChange.ButtonChangeOnClick(Sender: TObject);
begin

   RequestAdd();
   FormLettersChange.Close;

end;



procedure  TFormLettersChange.RequestUpdateFile();
var i,dif : integer; SQLtext : String; ArrFiles1 : array of String;
begin

//      Setlength(ArrFiles1,StringGrid.RowCount - 1);
//
//      dif := Length(ArrFiles1) - Length(ArrFiles) + 1; // 5 - 3 = 2
//                          // 5
//      for i := 0 to Length(ArrFiles1) do
//        begin
//           if i <= dif  then
//           arrFiles1[i] := StringGrid.Cells[0,i + 1]
//           else ArrFiles1[i] := ArrFiles[i];
//        end;

     if StringGrid.RowCount > 1 then
   begin

    SQLText := ' ';

   for i := 0 to ArrFilesCount  do
        begin
         SQLText :=  SQLText + ' UPDATE `listfiles` SET `FileName` = ''' + StringGrid.Cells[0,i + 1] +
         ''', `FileType` = ''' + inttostr(variant) + ''', `TableID` =  '''+newID+''', `Description` = '''+StringGrid.Cells[1,i + 1]+
         ''', `Visible` = 1 WHERE `listfiles`.`FileName` = ''' + StringGrid.Cells[0,i + 1] + '''; ' ;
        end;

    for i := 0 to Length(ArrFiles) - 1 do
      begin
          SQLText :=  SQLText + ' UPDATE `listfiles` SET `FileName` = ''' + ArrFiles[i] +
         ''', `FileType` = ''' + inttostr(variant) + ''', `TableID` =  '''+newID+''', `Description` = '''+StringGrid.Cells[1,ArrFilesCount + i + 1]+
         ''', `Visible` = 1 WHERE `listfiles`.`FileName` = ''' + ArrFiles[i] + '''; ' ;

      end;

       MySQLQueryLetters := TMySQLQuery.Create(Application);
       MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
       MySQLQueryLetters.SQL.Text := SQLText;
       MySQLQueryLetters.ExecSQL;




   end;
end;

end.

