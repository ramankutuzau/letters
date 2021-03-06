unit UnitLetters;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.DBCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Mask,Vcl.ExtCtrls, mySQLDbTables,System.Zip,idFTP,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,IdFTPCommon,System.IOUtils,
  IdExplicitTLSClientServerBase,FileCtrl,Vcl.Menus,UnitLettersChange;

type
  TFormLetters = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ComboBoxOutGoing: TComboBox;
    GroupBox1: TGroupBox;
    DBGridOutgoing: TDBGrid;
    MySQLDatabaseLetters: TMySQLDatabase;
    GroupBox2: TGroupBox;
    ComboBoxIncoming: TComboBox;
    DBGridIncoming: TDBGrid;
    ButtonIncoming: TButton;
    ButtonOutGoing: TButton;
    GroupBox3: TGroupBox;
    DBGridOutGoingFile: TDBGrid;
    GroupBox4: TGroupBox;
    DBGridIncomingFile: TDBGrid;
    DataSourceOutGoing: TDataSource;
    DataSourceOutGoingFile: TDataSource;
    PopupMenuOutGoing: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    EditoutGoingSearch: TEdit;
    PopupMenuOutGoingFile: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    DataSourceIncoming: TDataSource;
    DataSourceIncomingFile: TDataSource;
    EditIncomingSearch: TEdit;
    PopupMenuIncoming: TPopupMenu;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    PopupMenuIncomingFile: TPopupMenu;
    N15: TMenuItem;
    N16: TMenuItem;
    ButtonSaveAllIncoming: TButton;
    ButtonSaveAllOutGoing: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ListOutGoingView();
    procedure ListIncomingView();
    procedure IncomingRequestAdd();
    procedure OuTgoingRequestAdd();
    procedure SaveAllFilesIncoming();
    procedure SaveAllFilesOutGoing();
    procedure ButtonOutGoingClick(Sender: TObject);
    procedure ComboBoxOutGoingChange(Sender: TObject);
    procedure ButtonIncomingClick(Sender: TObject);
    procedure DBGridOutgoingCellClick(Column: TColumn);
    procedure OutGoingChangeStatus(number : integer);
    procedure OutGoingFileView();
    procedure IncomingFileView();
    procedure IncomingChangeStatus(number : integer);
    procedure EditoutGoingSearchChange(Sender: TObject);
    procedure idFTPConnected();
    procedure DBGridIncomingView();
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure DBGridOutGoingView();
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure DBGridIncomingCellClick(Column: TColumn);
    procedure EditIncomingSearchChange(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure ButtonSaveAllIncomingClick(Sender: TObject);
    procedure ButtonSaveAllOutGoingClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormLetters: TFormLetters;
  MySQLQueryLetters: TMySQLQuery;
  DataSourceOutGoing : TDataSource;
  Count,CountIn,SelectRowOutGoing,SelectRowOutGoingFile,
  SelectRowIncoming,SelectRowIncomingFile : String;
  idFTP : TidFTP;

implementation

{$R *.dfm}


procedure TFormLetters.ButtonSaveAllIncomingClick(Sender: TObject);
begin

   SaveAllFilesIncoming();
end;

procedure TFormLetters.SaveAllFilesIncoming();
var
SaveFile,dir, FileName: String;
begin

 if (DBGridIncomingFile.DataSource.Dataset.Fields.Fields[0].Value <> null ) then
   begin

      if not SelectDirectory ('???????? ?????', '', dir, [sdNewFolder, sdNewUI]) then Exit;

        DBGridIncomingFile.DataSource.Dataset.First;

        While not DBGridIncomingFile.DataSource.Dataset.eof do begin

           SaveFile := DBGridIncomingFile.DataSource.DataSet.Fields.Fields[0].Value;
           FileName := StringReplace(SaveFile, ':', ' ',[rfReplaceAll, rfIgnoreCase]);

            if idFTP.Connected then
            try
             idFTP.TransferType := ftBinary;
             idFTP.Get(SaveFile,dir+'\'+FileName,true);


            except on E : Exception do
            ShowMessage('?????? ???????? ?????: '+E.Message);
            end;

           DBGridIncomingFile.DataSource.Dataset.Next;

        end;

        DBGridIncomingFile.DataSource.Dataset.First;


   end else showmessage('??? ????????? ??????');

end;

procedure TFormLetters.ButtonSaveAllOutGoingClick(Sender: TObject);
begin
SaveAllFilesOutGoing();
end;

procedure TFormLetters.SaveAllFilesOutgoing();
var SaveFile,dir,FileName: String;
begin

 if (DBGridOutGoingFile.DataSource.Dataset.Fields.Fields[0].Value <> null ) then
   begin


    if not SelectDirectory ('???????? ?????', '', dir, [sdNewFolder, sdNewUI]) then Exit;

        DBGridOutGoingFile.DataSource.Dataset.First;
        While not DBGridOutGoingFile.DataSource.Dataset.eof do begin

           SaveFile := DBGridOutgoingFile.DataSource.DataSet.Fields.Fields[0].Value;
           FileName := StringReplace(SaveFile, ':', ' ',[rfReplaceAll, rfIgnoreCase]);

            if idFTP.Connected then
            try
             idFTP.TransferType := ftBinary;
             idFTP.Get(SaveFile,dir+'\'+FileName,true);

            except on E : Exception do
            ShowMessage('?????? ???????? ?????: '+E.Message);
            end;

           DBGridOutGoingFile.DataSource.Dataset.Next;

        end;

        DBGridOutGoingFile.DataSource.Dataset.First;


   end else showmessage('??? ????????? ??????');
end;

procedure TFormLetters.ButtonIncomingClick(Sender: TObject);
begin
     IncomingRequestAdd();
end;

procedure TFormLetters.IncomingRequestAdd();
 var
   WND:HWND;
   Tip:integer;
   strDate,strTime : String;
begin
   WND:=FormLetters.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
   case MessageBox(Wnd,'?? ????????????? ?????? ???????? ????? ???????','???? ??????????????',Tip) of
     IDYES:
     begin
     strTime := FormatDateTime('hh:mm',Now);
     strDate := FormatDateTime('yyyy-mm-dd', Now);
     MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := 'INSERT INTO `ListIncomingMails` '+
     ' ( ListIncomingMailsID,ShortEssence,DateAdd,TimeAdd,StatusMailsID,Visible ) VALUES '+
     ' (NULL, 1,'''+StrDate+''','''+StrTime+''', 1, 1); SELECT LAST_INSERT_ID()';
     MySQLQueryLetters.Open;
     UnitLettersChange.NewID := MySQLQueryLetters.Fields[0].AsString;



     UnitLettersChange.Variant := 1;
     FormLettersChange.Create;
     FormLettersChange.ShowModal;
     end;

   end;

end;

procedure TFormLetters.OuTgoingRequestAdd();
var
   WND:HWND;
   Tip:integer;
   strDate,strTime : String;
begin
   WND:=FormLetters.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
   case MessageBox(Wnd,'?? ????????????? ?????? ???????? ????? ???????','???? ??????????????',Tip) of
     IDYES:
     begin
     strTime := FormatDateTime('hh:mm',Now);
     strDate := FormatDateTime('yyyy-mm-dd', Now);
     MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := 'INSERT INTO `listoutgoingmails` '+
     ' ( ListOutgoingMailsID,ShortEssence,DateAdd,TimeAdd,StatusMailsID,Visible ) VALUES '+
     ' (NULL, 1,'''+StrDate+''','''+StrTime+''', 1, 1); SELECT LAST_INSERT_ID()';
     MySQLQueryLetters.Open;
     UnitLettersChange.NewID := MySQLQueryLetters.Fields[0].AsString;




     UnitLettersChange.Variant := 0;
     FormLettersChange.Create;
     FormLettersChange.ShowModal;
     end;

   end;


end;

procedure TFormLetters.ButtonOutGoingClick(Sender: TObject);
begin
OutGoingRequestAdd();
end;



procedure TFormLetters.ComboBoxOutGoingChange(Sender: TObject);
begin
    ListOutGoingView();
end;

procedure TFormLetters.DBGridOutgoingCellClick(Column: TColumn);
begin
    OutGoingFileView();
end;


procedure TFormLetters.OutGoingFileView();
begin
if DBGridOutGoing.DataSource.DataSet.Fields.Fields[0].Value <> null then
  begin
   SelectRowOutGoing := DBGridOutGoing.DataSource.DataSet.FieldByName('ListOutGoingMailsID').AsString;
   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT FileName, Description FROM listfiles WHERE '+
   ' TableID = '+SelectRowOutGoing +' AND Visible = 1 AND FileType = 0 ';
   MySQLQueryLetters.Active := true;

   DataSourceOutGoingFile.DataSet := MySQLQueryLetters;
   DbGridOutGoingFile.Columns[0].Width := 210;
   DbGridOutGoingFile.Columns[0].Title.Caption := '??? ?????';
   DbGridOutGoingFile.Columns[1].Width := 200;
   DbGridOutGoingFile.Columns[1].Title.Caption := '????????';
  end;
end;

procedure TFormLetters.IncomingFileView();
begin
if DBGridIncoming.DataSource.DataSet.Fields.Fields[0].Value <> null then
   begin
   SelectRowIncoming := DBGridIncoming.DataSource.DataSet.FieldByName('ListIncomingMailsID').AsString;
   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT FileName, Description FROM listfiles WHERE '+
   ' TableID = '+SelectRowIncoming +' AND Visible = 1 AND FileType = 1 ';
   MySQLQueryLetters.Active := true;

   DataSourceIncomingFile.DataSet := MySQLQueryLetters;
   DbGridIncomingFile.Columns[0].Width := 210;
   DbGridIncomingFile.Columns[0].Title.Caption := '??? ?????';
   DbGridIncomingFile.Columns[1].Width := 200;
   DbGridIncomingFile.Columns[1].Title.Caption := '????????';
   end;
end;


procedure TFormLetters.EditIncomingSearchChange(Sender: TObject);
begin
   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT ListIncomingMails.ListIncomingMailsID,NumberMails, ShortEssence, ' +
   ' DateAdd, TimeAdd, StatusMails FROM ListIncomingMails '+
   ' INNER JOIN ListStatusMails ON StatusMailsID = ' +
   ' ListStatusMails.ListStatusMailsID  ' +
   ' WHERE ListIncomingMails.Visible = 1 AND ShortEssence LIKE '+#39+EditIncomingSearch.Text+'%'+#39+
   ' ORDER BY ListIncomingMailsID DESC '+count+' ';
   MySQLQueryLetters.Active := true;
   DataSourceIncoming.DataSet := MySQLQueryLetters;
   DBGridIncomingView();
end;

procedure TFormLetters.EditoutGoingSearchChange(Sender: TObject);
begin
     MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT listoutgoingmails.ListOutgoingMailsID, ShortEssence, ' +
   ' DateAdd, TimeAdd, StatusMails FROM listoutgoingmails '+
   ' INNER JOIN ListStatusMails ON StatusMailsID = ' +
   ' ListStatusMails.ListStatusMailsID  ' +
   ' WHERE listoutgoingmails.Visible = 1 AND ShortEssence LIKE '+#39+EditOutGoingSearch.Text+'%'+#39+
   ' ORDER BY ListOutgoingMailsID DESC '+count+' ';
   MySQLQueryLetters.Active := true;
   DataSourceOutGoing.DataSet := MySQLQueryLetters;
   DBGridOutgoingView();
end;

procedure TFormLetters.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    idFTP.Disconnect;
end;

procedure TFormLetters.FormCreate(Sender: TObject);
var Column : TColumn;
begin

    ListOutGoingView();
    ListIncomingView();
    DBGridIncomingCellClick(Column);
    DBGridOutGoingCellClick(Column);
    idFTPConnected();

end;



procedure TFormLetters.DBGridOutGoingView();
begin
   DbGridOutGoing.Columns[0].Title.Caption := '?????';
   DbGridOutGoing.Columns[0].Width := 50;
   DbGridOutGoing.Columns[1].Title.Caption := '??????? ???? ??????';
   DbGridOutGoing.Columns[1].Width := 300;
   DbGridOutGoing.Columns[2].Title.Caption := '????';
   DbGridOutGoing.Columns[2].Width := 70;
   DbGridOutGoing.Columns[3].Title.Caption := '?????';
   DbGridOutGoing.Columns[3].Width := 70;
   DbGridOutGoing.Columns[4].Title.Caption := '??????';
   DbGridOutGoing.Columns[4].Width := 220;
end;

procedure TFormLetters.ListOutGoingView();
begin
   if ComboBoxOutGoing.Text <> '???' then Count := 'LIMIT '+ComboBoxOutGoing.Text
   else count := '';

   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT listoutgoingmails.ListOutgoingMailsID, ShortEssence, ' +
   ' DateAdd, TimeAdd, StatusMails FROM listoutgoingmails '+
   ' INNER JOIN ListStatusMails ON StatusMailsID = ' +
   ' ListStatusMails.ListStatusMailsID ' +
   ' WHERE listoutgoingmails.Visible = 1 ' +
   ' ORDER BY ListOutgoingMailsID DESC '+count+' ';
   MySQLQueryLetters.Active := true;

   DataSourceOutGoing.DataSet := MySQLQueryLetters;
   DBGridOutGoingView();


end;

procedure TFormLetters.ListIncomingView();
begin
   if ComboBoxIncoming.Text <> '???' then Count := 'LIMIT '+ComboBoxIncoming.Text
   else countIn := '';

   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT ListIncomingMailsID,NumberMails, ShortEssence, ' +
   ' DateAdd, TimeAdd, StatusMails FROM ListIncomingMails '+
   ' INNER JOIN ListStatusMails ON StatusMailsID = ' +
   ' ListStatusMails.ListStatusMailsID ' +
   ' WHERE ListIncomingMails.Visible = 1 ' +
   ' ORDER BY ListIncomingMailsID DESC '+countIn+' ';
   MySQLQueryLetters.Active := true;

   DBGridIncoming.DataSource.DataSet := MySQLQueryLetters;
   DBGridIncomingView();

end;

procedure TFormLetters.DBGridIncomingCellClick(Column: TColumn);
begin
IncomingFileView();

end;

procedure TFormLetters.DBGridIncomingView();
begin
   DbGridIncoming.Columns[0].Width := 0;
   DbGridIncoming.Columns[1].Title.Caption := '????? ??????';
   DbGridIncoming.Columns[1].Width := 90;
   DbGridIncoming.Columns[2].Title.Caption := '??????? ???? ??????';
   DbGridIncoming.Columns[2].Width := 300;
   DbGridIncoming.Columns[3].Title.Caption := '????';
   DbGridIncoming.Columns[3].Width := 70;
   DbGridIncoming.Columns[4].Title.Caption := '?????';
   DbGridIncoming.Columns[4].Width := 70;
   DbGridIncoming.Columns[5].Title.Caption := '??????';
   DbGridIncoming.Columns[5].Width := 220;
end;


procedure TFormLetters.N10Click(Sender: TObject);
var i,count:integer;
begin

   SelectRowIncoming := DBGridIncoming.DataSource.DataSet.FieldByName('ListIncomingMailsID').AsString;

   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT FileName, Description ' +
   ' FROM listfiles WHERE TableID = '+SelectRowIncoming+' AND FileType = 1 '+
   ' AND Visible = 1 ';
   MySQLQueryLetters.Active := true;


   MySQLQueryLetters.Last;
   SetLength(UnitLettersChange.ArrFiles,MySQLQueryLetters.RecNo);
   Setlength(unitLettersChange.ArrFilesDes,MySQLQueryLetters.RecNo);
   MySQLQueryLetters.First;
   i := 0;

   while not MySQLQueryLetters.EOF do
   begin
     UnitLettersChange.ArrFiles[i] := MySQLQueryLetters.FieldByName('FileName').AsString;
     UnitLettersChange.ArrFilesDes[i] := MySQLQueryLetters.FieldByName('Description').AsString;
     i := i + 1;
     MySQLQueryLetters.Next;
   end;


   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT NumberMails, ShortEssence ' +
   ' FROM `ListIncomingMails` WHERE ListIncomingMailsID = '+SelectRowIncoming;
   MySQLQueryLetters.Active := true;

   UnitLettersChange.Variant := 1;
   UnitLettersChange.NewID := SelectRowIncoming;
   FormLettersChange.Create();
   UnitLettersChange.LabeledEditTittle.Text :=    MySQLQueryLetters.FieldByName('NumberMails').AsString;
   UnitLettersChange.MemoContent.Text :=    MySQLQueryLetters.FieldByName('ShortEssence').AsString;
   UnitLettersChange.change := true;


   FormLettersChange.ShowModal;

end;

procedure TFormLetters.N12Click(Sender: TObject);
begin
  IncomingChangeStatus(1);
end;

procedure TFormLetters.N13Click(Sender: TObject);
begin
IncomingChangeStatus(2);
end;

procedure TFormLetters.N14Click(Sender: TObject);
begin
IncomingChangeStatus(3);
end;

procedure TFormLetters.N15Click(Sender: TObject);
var
   WND:HWND;
   Tip,id:integer;
begin

   id := TStringGrid(DBGridIncomingFile).Row;

   SelectRowIncoming := DBGridIncoming.DataSource.DataSet.FieldByName('ListIncomingMailsID').AsString;
   WND:=FormLetters.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
     case MessageBox(Wnd,'?? ????????????? ?????? ??????? ???? ?',
     '??????????????',Tip) of
       IDYES:
         begin
         SelectRowIncomingFile := DBGridIncomingFile.DataSource.DataSet.Fields.Fields[0].Value;

         MySQLQueryLetters := TMySQLQuery.Create(Application);
         MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
         MySQLQueryLetters.SQL.Text := 'UPDATE `listfiles` SET `Visible` = 0 WHERE' +
         ' FileName = '''+SelectRowIncomingFile+''' ';
         MySQLQueryLetters.ExecSQL;
         end;


     end;
     IncomingFileView();

     DBGridIncomingFile.DataSource.DataSet.RecNo := id;

end;

procedure TFormLetters.idFTPConnected();
begin
    idFTP:=TidFTP.Create(nil);
    idFTP.Host:='135.181.40.238';
    idFTP.Username:='romashka';
    idFTP.Password:='romashka1234';
    idFTP.Passive := true;
    idFTP.Connect;
end;

procedure TFormLetters.N16Click(Sender: TObject);
var
SaveDialog : TSaveDialog; FileName : String;
begin

      SelectRowIncomingFile := DBGridIncomingFile.DataSource.DataSet.Fields.Fields[0].Value;

      FileName := StringReplace(SelectRowIncomingFile, ':', ' ',[rfReplaceAll, rfIgnoreCase]);
      SaveDialog := TSaveDialog.Create(self);
      SaveDialog.FileName := FileName;
      if not SaveDialog.Execute then Exit;


     if idFTP.Connected then
      try


       idFTP.Get(SelectRowIncomingFile,SaveDialog.Files.Strings[0],true);

      except

      end;



end;

procedure TFormLetters.N1Click(Sender: TObject);
var
   WND:HWND;
   Tip:integer;
begin
   SelectRowOutGoing:= DBGridOutGoing.DataSource.DataSet.Fields.Fields[0].Value;
   WND:=FormLetters.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;

     case MessageBox(Wnd,'?? ????????????? ?????? ??????? ?????? ?',
     '??????????????',Tip) of
       IDYES:
         begin
           MySQLQueryLetters := TMySQLQuery.Create(Application);
           MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
           MySQLQueryLetters.SQL.Text := 'UPDATE `listoutgoingmails` SET `Visible` = 0 WHERE'+
           ' `listoutgoingmails`.`listoutgoingmailsID` = '''+SelectRowOutGoing+''' ';
           MySQLQueryLetters.ExecSQL;
           ListOutGoingView();

         end;
     end;




end;

procedure TFormLetters.N2Click(Sender: TObject);
var i:integer;
begin

SelectRowOutGoing := DBGridOutGoing.DataSource.DataSet.Fields.Fields[0].Value;

   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT FileName, Description ' +
   ' FROM listfiles WHERE TableID = '+SelectRowOutgoing+' AND FileType = 0 '+
   ' AND Visible = 1 ';
   MySQLQueryLetters.Active := true;


   MySQLQueryLetters.Last;
   SetLength(UnitLettersChange.ArrFiles,MySQLQueryLetters.RecNo);
   Setlength(unitLettersChange.ArrFilesDes,MySQLQueryLetters.RecNo);
   MySQLQueryLetters.First;

   i := 0;

   while not MySQLQueryLetters.EOF do
   begin
     UnitLettersChange.ArrFiles[i] := MySQLQueryLetters.FieldByName('FileName').AsString;
     UnitLettersChange.ArrFilesDes[i] := MySQLQueryLetters.FieldByName('Description').AsString;
     i := i + 1;
     MySQLQueryLetters.Next;
   end;



   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := ' SELECT ListOutgoingMailsID,ShortEssence ' +
   ' FROM `listoutgoingmails` WHERE ListOutgoingMailsID = '+SelectRowOutGoing;
   MySQLQueryLetters.Active := true;


   UnitLettersChange.Variant := 0;
   UnitLettersChange.NewID := SelectRowOutGoing;
   FormLettersChange.Create();
   UnitLettersChange.LabeledEditTittle.Text :=
   MySQLQueryLetters.FieldByName('ListOutgoingMailsID').AsString;
   UnitLettersChange.MemoContent.Text :=
   MySQLQueryLetters.FieldByName('ShortEssence').AsString;
   UnitLettersChange.change := true;


   FormLettersChange.ShowModal;

end;

procedure TFormLetters.N3Click(Sender: TObject);
var
   WND:HWND;
   Tip,id:integer;
begin

    id := TStringGrid(DBGridOutGoingFile).Row;

   SelectRowOutGoing := DBGridOutGoing.DataSource.DataSet.Fields.Fields[0].Value;
   WND:=FormLetters.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
     case MessageBox(Wnd,'?? ????????????? ?????? ??????? ???? ?',
     '??????????????',Tip) of
       IDYES:
         begin
         SelectRowOutGoingFile := DBGridOutGoingFile.DataSource.DataSet.Fields.Fields[0].Value;

         MySQLQueryLetters := TMySQLQuery.Create(Application);
         MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
         MySQLQueryLetters.SQL.Text := 'UPDATE `listfiles` SET `Visible` = 0 WHERE' +
         ' FileName = '''+SelectRowOutGoingFile+''' ';
         MySQLQueryLetters.ExecSQL;
         end;


     end;
     OutGoingFileView();
     DBGridOutGoingFile.DataSource.DataSet.RecNo := id;

end;

procedure TFormLetters.N4Click(Sender: TObject);
var
SaveDialog : TSaveDialog; FileName : String;
begin



    SelectRowOutGoingFile := DBGridOutGoingFile.DataSource.DataSet.Fields.Fields[0].Value;

      FileName := StringReplace(SelectRowOutGoingFile, ':', ' ',[rfReplaceAll, rfIgnoreCase]);
      SaveDialog := TSaveDialog.Create(self);
      SaveDialog.FileName := FileName;

      if not SaveDialog.Execute then Exit;





     if idFTP.Connected then
      try
       idFTP.Get(SelectRowOutGoingFile,SaveDialog.Files.Strings[0],true);

      except

      end;



end;

procedure TFormLetters.N6Click(Sender: TObject);
begin
OutGoingChangeStatus(1);
end;

procedure TFormLetters.N7Click(Sender: TObject);
begin
OutGoingChangeStatus(2);
end;

procedure TFormLetters.N8Click(Sender: TObject);
begin
OutGoingChangeStatus(3);
end;

procedure TFormLetters.N9Click(Sender: TObject);
var
   WND:HWND;
   Tip:integer;
begin
   SelectRowIncoming:= DBGridIncoming.DataSource.DataSet.FieldByName('ListIncomingMailsID').AsString;
   WND:=FormLetters.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;

     case MessageBox(Wnd,'?? ????????????? ?????? ??????? ?????? ?',
     '??????????????',Tip) of
       IDYES:
         begin
           MySQLQueryLetters := TMySQLQuery.Create(Application);
           MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
           MySQLQueryLetters.SQL.Text := 'UPDATE `ListIncomingMails` SET `Visible` = 0 WHERE'+
           ' `ListIncomingMails`.`ListIncomingMailsID` = '''+SelectRowIncoming+''' ';
           MySQLQueryLetters.ExecSQL;
           ListIncomingView();

         end;
     end;



end;

procedure  TFormLetters.OutGoingChangeStatus(number : integer);
var id : integer;
begin

   SelectRowOutGoing := DBGridOutGoing.DataSource.DataSet.Fields.Fields[0].Value;

   id := TStringGrid(DBGridOutGoing).Row;

   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'UPDATE `listoutgoingmails` SET '+
   '`StatusMailsID` =  ''' + IntToStr(number) + ''' ' +
   ' WHERE `ListOutgoingMailsID` = ''' + SelectRowOutGoing + ''' ';
   MySQLQueryLetters.ExecSQL;

   ListOutGoingView();
   DBGridOutGoing.DataSource.DataSet.RecNo := id;

end;

procedure  TFormLetters.IncomingChangeStatus(number : integer);
var id:integer;
begin

   SelectRowIncoming := DBGridIncoming.DataSource.DataSet.FieldByName('ListIncomingMailsID').AsString;

   id := TStringGrid(DBGridIncoming).Row;

   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := FormLetters.MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'UPDATE `ListIncomingMails` SET '+
   '`StatusMailsID` =  ''' + IntToStr(number) + ''' ' +
   ' WHERE `ListIncomingMailsID` = ''' + SelectRowIncoming + ''' ';
   MySQLQueryLetters.ExecSQL;

   ListIncomingView();

   DBGridIncoming.DataSource.DataSet.RecNo := id;

end;


end.
