unit UnitMails;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls,
  Vcl.Grids, Data.DB, mySQLDbTables, Vcl.Menus,idFTP,IdFTPCommon,Vcl.FileCtrl;

type
  THackStringGrid = class(TStringGrid);
   Letters = record
    ID: String;
    NumberMails: String;
    ShortEssence: String;
    Date : String;
    Time : String;
    Status : String;
  end;
   Files = record
      ID : String;
      Name : String;
      Description : String;
   end;

  TFormMails = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    EditOutGoing: TEdit;
    ButtonOutGoingSearch: TButton;
    Button2: TButton;
    StringGridOutGoing: TStringGrid;
    GroupBoxOutGoingFile: TGroupBox;
    ButtonSaveAllOutGoing: TButton;
    ButtonOutGoingUpload: TButton;
    MySQLDatabaseLetters: TMySQLDatabase;
    GroupBox4: TGroupBox;
    Editincoming: TEdit;
    ButtonIncomingSearch: TButton;
    Button4: TButton;
    StringGridIncoming: TStringGrid;
    GroupBoxIncomingFile: TGroupBox;
    StringGridIncomingFile: TStringGrid;
    ButtonSaveAllIncoming: TButton;
    ButtonIncomingUpload: TButton;
    PopupMenuOutGoingFile: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    PopupMenuOutGoing: TPopupMenu;
    N3: TMenuItem;
    PopupMenuIncoming: TPopupMenu;
    N4: TMenuItem;
    PopupMenuIncomingFile: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    StringGridOutGoingFile: TStringGrid;

    procedure ListOutGoingView();
    procedure OutGoingFileView();
    procedure ListIncomingView();
    procedure IncomingFileView();
    procedure RequestOutGoingAdd();
    procedure FormCreate(Sender: TObject);
    procedure StringGridOutGoingSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGridOutGoingDblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StringGridOutGoingFileDblClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure StringGridOutGoingMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N3Click(Sender: TObject);
    procedure ButtonOutGoingSearchClick(Sender: TObject);
    procedure EditOutGoingKeyPress(Sender: TObject; var Key: Char);
    procedure idFTPConnet();
    procedure UploadOutGoingFiles();
    procedure UploadIncomingFiles();
    procedure SaveAllOutGoingFile();
    procedure SaveAllIncomingFile();
    procedure RequestAddFile(variant : integer);
    procedure StringGridView(StringGrid : TStringGrid);
    procedure StringGridFileView(StringGrid : TStringGrid);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ButtonOutGoingUploadClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ButtonSaveAllIncomingClick(Sender: TObject);
    procedure ButtonSaveAllOutGoingClick(Sender: TObject);
    procedure StringGridIncomingSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure N4Click(Sender: TObject);
    procedure StringGridIncomingMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StringGridIncomingDblClick(Sender: TObject);
    procedure ButtonIncomingUploadClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure StringGridIncomingFileDblClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure EditincomingKeyPress(Sender: TObject; var Key: Char);
    procedure ButtonIncomingSearchClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormResize(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TMyThreadUpload = class(TThread)
    private
    { Private declarations }
    protected
    procedure Execute; override;
  end;

  TMyThreadSave = class(TThread)
    private
    { Private declarations }
    protected
    procedure Execute; override;
  end;





var
   FormMails: TFormMails;
   MySQLQueryLetters : TMySQLQuery;
   Incoming : array of Letters;
   OutGoing : array of Letters;
   OutGoingFile : array of Files;
   IncomingFile : array of Files;
   OutGoing_ID,directory,Incoming_ID : String;
   idFTP : TidFTP;
   OpenDialog : TOpenDialog;
   ArrFiles,ArrFilesPath,ArrFilesSave,ArrFilesNameSave : Array of String;
   filecount : integer;

   MyThreadUpload : TMyThreadUpload;
   MyThreadSave : TMyThreadSave;
   ThreadExecute : Boolean;
   width,heigth : integer;


implementation

{$R *.dfm}

uses UnitAddLetters, UnitStatusChange;


procedure TMyThreadSave.Execute;
var
   i : integer;
begin
    ThreadExecute := true;

     ThreadExecute := true;
      Screen.Cursor := -11;

     for i := 0 to Length(ArrFilesNameSave) - 1 do

       if idFTP.Connected then
        try
          idFTP.TransferType := ftBinary;
          idFTP.Get(ArrFilesNameSave[i],directory+'\'+ArrFilesSave[i],true);

        except on E : Exception do
         ShowMessage('?????? ???????? ?????: '+E.Message);
        end;

      Screen.Cursor := 0;
      MyThreadSave.Terminate;
      MyThreadSave := nil;
     ThreadExecute := false;


end;

procedure TMyThreadUpload.Execute;
var i:integer;
begin

    ThreadExecute := true;
    Screen.Cursor := -11;

        for i := 0 to Length(arrFiles) - 1  do
        begin


         if idFTP.Connected then
          try

          idFTP.TransferType := ftBinary;
          idFTP.Put(arrFilesPath[i],arrFiles[i],true);


          except
          on E : Exception do
            ShowMessage('?????? ???????? ?????: ' + E.Message);
          end;

        end;

      Screen.Cursor := 0;
      MyThreadUpload.Terminate;
      MyThreadUpload := nil;

      ThreadExecute := false;
end;


procedure TFormMails.UploadOutGoingFiles();
var
 i,Row:integer;
 lastAddID,NameFile: String; today : TDateTime;
begin
     OpenDialog := TOpenDialog.Create(self);
      OpenDialog.InitialDir := GetCurrentDir;
      OpenDialog.Options := [ofFileMustExist];
      OpenDialog.Options := [ofAllowMultiSelect];

    today := Time;
    Row := StringGridOutGoing.Row;

   if OpenDialog.Execute then
     begin

       SetLength(ArrFiles,OpenDialog.Files.Count);
       SetLength(ArrFilesPath,OpenDialog.Files.Count);

       for i := 0 to OpenDialog.Files.Count - 1 do
       begin

       NameFile := OutGoing[row - 1].ID + '_' + TimeToStr(today) + '_' +
       ExtractFileName(OpenDialog.Files.Strings[i]);

       ArrFiles[i] := NameFile;
       ArrFilesPath[i] := OpenDialog.Files.Strings[i];

      end;


        if not ThreadExecute then
      begin
      MyThreadUpload:=TMyThreadUpload.Create(False);
      MyThreadUpload.Priority:=tpNormal;
      RequestAddFile(0);
      end else showmessage('????????? ???????? ??????');


     end;







end;


procedure TFormMails.UploadIncomingFiles();
var
 i,Row:integer;
 lastAddID,NameFile: String; today : TDateTime;
begin
      OpenDialog := TOpenDialog.Create(self);
      OpenDialog.InitialDir := GetCurrentDir;
      OpenDialog.Options := [ofFileMustExist];
      OpenDialog.Options := [ofAllowMultiSelect];

    today := Time;
    Row := StringGridIncoming.Row;

   if OpenDialog.Execute then
     begin

       SetLength(ArrFiles,OpenDialog.Files.Count);
       SetLength(ArrFilesPath,OpenDialog.Files.Count);

       for i := 0 to OpenDialog.Files.Count - 1 do
       begin

       NameFile := Incoming[row - 1].NumberMails + '_' + TimeToStr(today) + '_' +
       ExtractFileName(OpenDialog.Files.Strings[i]);

       ArrFiles[i] := NameFile;
       ArrFilesPath[i] := OpenDialog.Files.Strings[i];

      end;


        if not ThreadExecute then
      begin
      MyThreadUpload:=TMyThreadUpload.Create(False);
      MyThreadUpload.Priority:=tpNormal;
      RequestAddFile(1);
      end else showmessage('????????? ???????? ??????');



     end;




end;



procedure TFormMails.SaveAllOutGoingFile();
var
  SaveFile,FileName: String;
  i : integer;
begin

 if StringGridOutGoingFile.RowCount > 1 then
   begin


    if not SelectDirectory ('???????? ?????', '', directory, [sdNewFolder, sdNewUI]) then Exit;

        SetLength(ArrFilesNameSave,StringGridOutGoingFile.RowCount -1 );
        SetLength(ArrFilesSave,StringGridOutGoingFile.RowCount -1 );

        for i := 0 to Length(ArrFilesSave) - 1 do begin


           FileName := StringReplace(StringGridOutGoingFile.Cells[1,i + 1],
           ':', ' ',[rfReplaceAll, rfIgnoreCase]);

           ArrFilesNameSave[i] := StringGridOutGoingFile.Cells[1,i + 1];
           ArrFilesSave[i] := FileName;


        end;


      if not ThreadExecute then
      begin
      MyThreadSave:=TMyThreadSave.Create(False);
      MyThreadSave.Priority:=tpNormal;
      end else showmessage('????????? ???????? ??????');

   end else showmessage('??? ????????? ??????');


end;

procedure TFormMails.SaveAllIncomingFile();
var
  SaveFile,FileName: String;
  i : integer;
begin

 if StringGridIncomingFile.RowCount > 1 then
   begin


    if not SelectDirectory ('???????? ?????', '', directory, [sdNewFolder, sdNewUI]) then Exit;

        SetLength(ArrFilesNameSave,StringGridIncomingFile.RowCount -1 );
        SetLength(ArrFilesSave,StringGridIncomingFile.RowCount -1 );

        for i := 0 to Length(ArrFilesSave) - 1 do begin


           FileName := StringReplace(StringGridIncomingFile.Cells[1,i + 1],
           ':', ' ',[rfReplaceAll, rfIgnoreCase]);

           ArrFilesNameSave[i] := StringGridIncomingFile.Cells[1,i + 1];
           ArrFilesSave[i] := FileName;


        end;

       if not ThreadExecute then
      begin
      MyThreadSave:=TMyThreadSave.Create(False);
      MyThreadSave.Priority:=tpNormal;
      end else showmessage('????????? ???????? ??????');


   end else showmessage('??? ????????? ??????');

end;

procedure  TFormMails.RequestAddFile(variant : integer);
var i, Row : integer; SQLtext : String;
begin



    SQLText := 'INSERT INTO `listfiles` (`FileID`, `FileName`, `FileType`,'+
    '`TableID`, `Visible` ) VALUES ';

      if variant = 0  then
    begin
    Row := StringGridOutGoing.Row;
    for i := 0 to  Length(ArrFiles) - 1 do
        begin

        SQLText := SQLtext + '(NULL, ''' + ArrFiles[i] + ''', ''' + inttostr(variant) + ''', '''+OutGoing[row - 1].ID+''', 1), ';
        end;

       Delete(SQLtext, Length(SQLText)-1, 1);

    end;
      if variant = 1 then
    begin
    Row := StringGridIncoming.Row;
    for i := 0 to  Length(ArrFiles) - 1 do
        begin

        SQLText := SQLtext + '(NULL, ''' + ArrFiles[i] + ''', ''' + inttostr(variant) + ''', '''+Incoming[row - 1].ID+''', 1), ';
        end;

       Delete(SQLtext, Length(SQLText)-1, 1);

    end;

       MySQLQueryLetters := TMySQLQuery.Create(Application);
       MySQLQueryLetters.Database := MySQLDatabaseLetters;
       MySQLQueryLetters.SQL.Text := SQLText;
       MySQLQueryLetters.ExecSQL;

       if variant = 0 then OutGoingFileView();
       if variant = 1 then IncomingFileView();

end;



procedure TFormMails.ButtonOutGoingUploadClick(Sender: TObject);
begin

  UploadOutGoingFiles();
end;

procedure TFormMails.ButtonSaveAllOutGoingClick(Sender: TObject);
begin
  SaveAllOutGoingFile();
end;

procedure TFormMails.ButtonSaveAllIncomingClick(Sender: TObject);
begin
  SaveAllIncomingFile();
end;

procedure TFormMails.Button4Click(Sender: TObject);
begin
  FormAddLetters.ShowModal;
end;

procedure TFormMails.ButtonIncomingSearchClick(Sender: TObject);
begin
   ListIncomingView;
end;

procedure TFormMails.ButtonIncomingUploadClick(Sender: TObject);
begin

  UploadIncomingFiles();

end;

procedure TFormMails.ButtonOutGoingSearchClick(Sender: TObject);
begin
  ListOutGoingView();
end;

procedure TFormMails.Button2Click(Sender: TObject);
begin
  RequestOutGoingAdd();
end;

procedure TFormMails.EditincomingKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then ListIncomingView;
end;

procedure TFormMails.EditOutGoingKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then ListOutGoingView;
end;

procedure TFormMails.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  idFTP.Disconnect;
end;

procedure TFormMails.FormCreate(Sender: TObject);
begin

    ListOutGoingView();
    ListIncomingView();
    StringGridFileView(StringGridOutGoingFile);
    StringGridFileView(StringGridIncomingFile);
    idFTPConnet();
    StringGridOutGoingFile.RowCount := 1;
    StringGridIncomingFile.RowCount := 1;

end;

procedure TFormMails.FormResize(Sender: TObject);
begin
    if FormMails.Width < 1300 then FormMails.Width := 1300;
    if FormMails.Height < 700 then FormMails.Height := 700;

    StringGridIncoming.Width := FormMails.Width - 455;
    StringGridIncoming.Height := FormMails.Height - 118;
    GroupBoxIncomingFile.Left := FormMails.Width - 443;
    GroupBoxIncomingFile.Height := FormMails.Height - 70;
    StringGridIncomingFile.Height := FormMails.Height - 141;
    StringGridIncoming.ColWidths[2] := StringGridIncoming.Width - 435;

    StringGridOutGoing.Width := FormMails.Width - 455;
    StringGridOutGoing.Height := FormMails.Height - 118;
    GroupBoxOutGoingFile.Left := FormMails.Width - 443;
    GroupBoxOutGoingFile.Height := FormMails.Height - 70;
    StringGridOutGoingFile.Height := FormMails.Height - 141;
    StringGridOutGoing.ColWidths[2] := StringGridIncoming.Width - 435;


end;

procedure TFormMails.idFTPConnet();
begin
    idFTP:=TidFTP.Create(nil);
    idFTP.Host:='135.181.40.238';
    idFTP.Username:='romashka';
    idFTP.Password:='romashka1234';
    idFTP.Passive := true;
    idFTP.Connect;
end;

procedure TFormMails.ListOutGoingView();
var i:integer;
begin

     MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := 'SELECT ListOutgoingMailsID, ShortEssence, ' +
     ' DateAdd, TimeAdd, StatusMails FROM listoutgoingmails '+
     ' INNER JOIN ListStatusMails ON StatusMailsID = ' +
     ' ListStatusMails.ListStatusMailsID ' +
     ' WHERE listoutgoingmails.Visible = 1 AND '+
     ' ShortEssence LIKE '+#39+'%'+EditOutGoing.Text+'%'+#39+
     ' ORDER BY ListOutgoingMailsID DESC';
     MySQLQueryLetters.Active := true;

     finalize(OutGoing);
     MySQLQueryLetters.Last;
     SetLength(OutGoing,MySQLQueryLetters.RecNo);
     StringGridOutGoing.RowCount := MySQLQueryLetters.RecNo + 1;
     MySQLQueryLetters.First;

     i := 0;
      StringGridView(StringGridOutGoing);

     while not MySQLQueryLetters.Eof do
     begin
        OutGoing[i].ID := MySQLQueryLetters.FieldByName('ListOutgoingMailsID').AsString;
        OutGoing[i].ShortEssence := MySQLQueryLetters.FieldByName('ShortEssence').AsString;
        OutGoing[i].Date := MySQLQueryLetters.FieldByName('DateAdd').AsString;
        OutGoing[i].Time := MySQLQueryLetters.FieldByName('TimeAdd').AsString;
        OutGoing[i].Status := MySQLQueryLetters.FieldByName('StatusMails').AsString;

        StringGridOutGoing.Cells[1,i + 1] := OutGoing[i].ID;
        StringGridOutGoing.Cells[2,i + 1] := OutGoing[i].ShortEssence;
        StringGridOutGoing.Cells[3,i + 1] := OutGoing[i].Date;
        StringGridOutGoing.Cells[4,i + 1] := OutGoing[i].Time;
        StringGridOutGoing.Cells[5,i + 1] := OutGoing[i].Status;
        MySQLQueryLetters.Next;
        i := i + 1;
     end;



end;

procedure TFormMails.ListIncomingView();
var i:integer;
begin

     MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := 'SELECT ListIncomingMailsID,NumberMails, ShortEssence, ' +
     ' DateAdd, TimeAdd, StatusMails FROM ListIncomingMails '+
     ' INNER JOIN ListStatusMails ON StatusMailsID = ' +
     ' ListStatusMails.ListStatusMailsID ' +
     ' WHERE ListIncomingMails.Visible = 1 AND '+
     ' ShortEssence LIKE '+#39+'%'+EditIncoming.Text+'%'+#39+
     ' ORDER BY ListIncomingMailsID DESC';
     MySQLQueryLetters.Active := true;


     MySQLQueryLetters.Last;
     SetLength(Incoming,MySQLQueryLetters.RecNo);
     StringGridIncoming.RowCount := MySQLQueryLetters.RecNo + 1;
     MySQLQueryLetters.First;

     i := 0;
     while not MySQLQueryLetters.Eof do
     begin
        Incoming[i].ID := MySQLQueryLetters.FieldByName('ListIncomingMailsID').AsString;
        Incoming[i].NumberMails := MySQLQueryLetters.FieldByName('NumberMails').AsString;
        Incoming[i].ShortEssence := MySQLQueryLetters.FieldByName('ShortEssence').AsString;
        Incoming[i].Date := MySQLQueryLetters.FieldByName('DateAdd').AsString;
        Incoming[i].Time := MySQLQueryLetters.FieldByName('TimeAdd').AsString;
        Incoming[i].Status := MySQLQueryLetters.FieldByName('StatusMails').AsString;

        StringGridIncoming.Cells[1,i + 1] := Incoming[i].NumberMails;
        StringGridIncoming.Cells[2,i + 1] := Incoming[i].ShortEssence;
        StringGridIncoming.Cells[3,i + 1] := Incoming[i].Date;
        StringGridIncoming.Cells[4,i + 1] := Incoming[i].Time;
        StringGridIncoming.Cells[5,i + 1] := Incoming[i].Status;
        MySQLQueryLetters.Next;
        i := i + 1;
     end;

     StringGridView(StringGridIncoming);

end;


procedure TFormMails.N1Click(Sender: TObject);
var
   Row,Tip : integer;
   WND:HWND;
   str : String;
begin
   Row := StringGridOutGoingFile.Row;

if Row <> 0 then
   begin
   WND:=FormMails.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
     str := '?? ????????????? ?????? ??????? : ' + OutGoingFile[Row-1].Name + ' ?';
     case MessageBox(Wnd,PChar(str),
     '??????????????',Tip) of
       IDYES:
       begin

        MySQLQueryLetters := TMySQLQuery.Create(Application);
        MySQLQueryLetters.Database := MySQLDatabaseLetters;
        MySQLQueryLetters.SQL.Text := 'UPDATE `listfiles` SET ' +
        ' Visible = 0 WHERE `listfiles`.`FileID` = '''+OutGoingFile[Row - 1].ID +''' ';
        MySQLQueryLetters.ExecSQL;

       end;

     end;

   end;

    OutGoingFileView();
end;

procedure TFormMails.N2Click(Sender: TObject);
var
  Row,i: integer;
  SaveDialog : TSaveDialog;
  FileName,Filename1 : String;
begin

         Row := StringGridOutGoingFile.Row;
        if Row <> 0 then
        begin
        if not SelectDirectory ('???????? ?????', '', directory,
         [sdNewFolder, sdNewUI]) then Exit;

         SetLength(ArrFilesNameSave,1 );
         SetLength(ArrFilesSave,1);

         FileName := StringReplace(StringGridOutGoingFile.Cells[1,Row],
         ':', ' ',[rfReplaceAll, rfIgnoreCase]);

         ArrFilesNameSave[0] := StringGridOutGoingFile.Cells[1,Row];
         ArrFilesSave[0] := FileName;


          if not ThreadExecute then
        begin
        MyThreadSave:=TMyThreadSave.Create(False);
        MyThreadSave.Priority:=tpNormal;
        end else showmessage('????????? ???????? ??????');

        end;

end;

procedure TFormMails.N3Click(Sender: TObject);

var
   Row,Tip : integer;
   WND:HWND;
   str : String;
begin
   Row := StringGridOutGoing.Row;

if Row <> 0 then
   begin
   WND:=FormMails.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
     str := '?? ????????????? ?????? ??????? ?????? ? ' + OutGoing[Row-1].ID + ' ?';
     case MessageBox(Wnd,PChar(str),
     '??????????????',Tip) of
       IDYES:
       begin

        MySQLQueryLetters := TMySQLQuery.Create(Application);
        MySQLQueryLetters.Database := MySQLDatabaseLetters;
        MySQLQueryLetters.SQL.Text := 'UPDATE `listoutgoingmails` SET `Visible` = 0 WHERE '+
        ' `listoutgoingmails`.`ListOutgoingMailsID` = '''+OutGoing[Row - 1].ID +''' ';

        MySQLQueryLetters.ExecSQL;
        THackStringGrid(StringGridOutGoing).DeleteRow(Row);
       end;

     end;

   end;

   // ListOutGoingView();

end;

procedure TFormMails.N4Click(Sender: TObject);
var
   Row,Tip : integer;
   WND:HWND;
   str : String;
begin
   Row := StringGridIncoming.Row;

if Row <> 0 then
   begin
   WND:=FormMails.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
     str := '?? ????????????? ?????? ??????? ?????? ? ' + Incoming[Row-1].NumberMails + ' ?';
     case MessageBox(Wnd,PChar(str),
     '??????????????',Tip) of
       IDYES:
       begin

        MySQLQueryLetters := TMySQLQuery.Create(Application);
        MySQLQueryLetters.Database := MySQLDatabaseLetters;
        MySQLQueryLetters.SQL.Text := 'UPDATE `ListIncomingMails` SET `Visible` = 0 WHERE '+
        ' `ListIncomingMails`.`ListIncomingMailsID` = '''+Incoming[Row - 1].ID +''' ';

        MySQLQueryLetters.ExecSQL;
       THackStringGrid(StringGridIncoming).DeleteRow(Row);
       end;

     end;

   end;

   // ListIncomingView();
end;

procedure TFormMails.N5Click(Sender: TObject);
var
   Row,Tip : integer;
   WND:HWND;
   str : String;
begin
   Row := StringGridIncomingFile.Row;

if Row <> 0 then
   begin
   WND:=FormMails.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
     str := '?? ????????????? ?????? ??????? : ' + IncomingFile[Row-1].Name + ' ?';
     case MessageBox(Wnd,PChar(str),
     '??????????????',Tip) of
       IDYES:
       begin

        MySQLQueryLetters := TMySQLQuery.Create(Application);
        MySQLQueryLetters.Database := MySQLDatabaseLetters;
        MySQLQueryLetters.SQL.Text := 'UPDATE `listfiles` SET ' +
        ' Visible = 0 WHERE `listfiles`.`FileID` = '''+IncomingFile[Row - 1].ID +''' ';
        MySQLQueryLetters.ExecSQL;

       end;

     end;

   end;

    IncomingFileView();
end;

procedure TFormMails.N6Click(Sender: TObject);
var
  Row,i: integer;
  SaveDialog : TSaveDialog;
  FileName,Filename1 : String;
begin

         Row := StringGridIncomingFile.Row;
         if Row <> 0 then
         begin
         if not SelectDirectory ('???????? ?????', '', directory,
          [sdNewFolder, sdNewUI]) then Exit;

         SetLength(ArrFilesNameSave,1 );
         SetLength(ArrFilesSave,1);

         FileName := StringReplace(StringGridIncomingFile.Cells[1,Row],
         ':', ' ',[rfReplaceAll, rfIgnoreCase]);

         ArrFilesNameSave[0] := StringGridIncomingFile.Cells[1,Row];
         ArrFilesSave[0] := FileName;


         MyThreadSave:=TMyThreadSave.Create(false);
         MyThreadSave.Priority:=tpNormal;

         end;

end;

procedure TFormMails.StringGridIncomingDblClick(Sender: TObject);
var str: string; Row,Col : integer;
begin
 Row := StringGridIncoming.Row;

   if Row <> 0 then
   begin
      Col := StringGridIncoming.Col;

    if StringGridIncoming.Col = 1 then
      begin
      Str:= InputBox('???? ??????',' ',StringGridIncoming.Cells[1,row]);

      MySQLQueryLetters := TMySQLQuery.Create(Application);
      MySQLQueryLetters.Database := MySQLDatabaseLetters;
      MySQLQueryLetters.SQL.Text := 'UPDATE `ListIncomingMails` SET `NumberMails` = '''+str+''' '+
      ' WHERE `ListIncomingMailsID` = '''+ Incoming[row - 1].ID +''' ';
      MySQLQueryLetters.ExecSQL;

      ListIncomingView();

      end;

    if StringGridIncoming.Col = 2 then
      begin
      Str:= InputBox('???? ????????',' ',StringGridIncoming.Cells[2,row]);

      MySQLQueryLetters := TMySQLQuery.Create(Application);
      MySQLQueryLetters.Database := MySQLDatabaseLetters;
      MySQLQueryLetters.SQL.Text := 'UPDATE `ListIncomingMails` SET `ShortEssence` = '''+str+''' '+
      ' WHERE `ListIncomingMailsID` = '''+ Incoming[row - 1].ID +''' ';
      MySQLQueryLetters.ExecSQL;

      ListIncomingView();

      end;


    if StringGridIncoming.Col = 5 then
      begin
         UnitStatusChange.Status := StringGridIncoming.Cells[Col,Row];
         UnitStatusChange.ID := Incoming[Row-1].ID;
         UnitStatusChange.StatusType := 1;
         FormStatusChange.Create();
         FormStatusChange.Showmodal;
      end;

   end;
end;

procedure TFormMails.StringGridIncomingFileDblClick(Sender: TObject);
var str: string; Row,Col : integer;
begin
    Row := StringGridIncomingFile.Row;
    Col := StringGridIncomingFile.Col;
    if Row <> 0 then
    begin
    Str:= InputBox('???? ???????? ?????',' ',StringGridIncomingFile.Cells[2,row]);

    MySQLQueryLetters := TMySQLQuery.Create(Application);
    MySQLQueryLetters.Database := MySQLDatabaseLetters;
    MySQLQueryLetters.SQL.Text := 'UPDATE `listfiles` SET ' +
    ' Description = '''+Str+''' WHERE `listfiles`.`FileID` = '''+IncomingFile[row - 1].ID +''' ';
    MySQLQueryLetters.ExecSQL;

    IncomingFileView();
    end;


end;

procedure TFormMails.StringGridIncomingMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Row : integer;
begin
   Row := StringGridIncoming.Row;
   GroupBoxIncomingFile.Caption := '??????????? ????? ? ?????? # '+ StringGridIncoming.Cells[1,Row];

   if Row <> 0 then
   begin
     if Button = mbRight then
     begin
       StringGridIncoming.Options:= StringGridOutGoing.Options + [goRowSelect];
     end else
     begin
       StringGridIncoming.Options:= StringGridOutGoing.Options - [goRowSelect];
     end;
   end;

end;

procedure TFormMails.StringGridIncomingSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
 if ARow <> 0 then
   begin
   Incoming_ID := Incoming[Arow - 1].ID;
   IncomingFileView();
   end;

end;

procedure TFormMails.StringGridOutGoingDblClick(Sender: TObject);
var str: string; Row,Col : integer;
begin
 Row := StringGridOutGoing.Row;

   if Row <> 0 then
   begin
      Col := StringGridOutGoing.Col;
    if StringGridOutGoing.Col = 2 then
      begin
      Str:= InputBox('???? ????????',' ',StringGridOutGoing.Cells[2,row]);

      MySQLQueryLetters := TMySQLQuery.Create(Application);
      MySQLQueryLetters.Database := MySQLDatabaseLetters;
      MySQLQueryLetters.SQL.Text := 'UPDATE `listoutgoingmails` SET `ShortEssence` = '''+str+''' '+
      ' WHERE `listoutgoingmails`.`ListOutgoingMailsID` = '''+ OutGoing[row - 1].ID +''' ';
      MySQLQueryLetters.ExecSQL;

      ListOutGoingView();

      end;


    if StringGridOutGoing.Col = 5 then
      begin
         UnitStatusChange.Status := StringGridOutGoing.Cells[Col,Row];
         UnitStatusChange.ID := StringGridOutGoing.Cells[1,Row];
         UnitStatusChange.StatusType := 0;
         FormStatusChange.Create();
         FormStatusChange.Showmodal;
      end;

   end;
end;

procedure TFormMails.StringGridOutGoingFileDblClick(Sender: TObject);
var str: string; Row,Col : integer;
begin
    Row := StringGridOutGoingFile.Row;
    Col := StringGridOutGoingFile.Col;
    if Row <> 0 then
    begin
    Str:= InputBox('???? ???????? ?????',' ',StringGridOutGoingFile.Cells[2,row]);
    if Length(Str) > 0 then
      begin
      MySQLQueryLetters := TMySQLQuery.Create(Application);
      MySQLQueryLetters.Database := MySQLDatabaseLetters;
      MySQLQueryLetters.SQL.Text := 'UPDATE `listfiles` SET ' +
      ' Description = '''+Str+''' WHERE `listfiles`.`FileID` = '''+OutGoingFile[row - 1].ID +''' ';
      MySQLQueryLetters.ExecSQL;

      OutGoingFileView();
      end;
    end;


end;

procedure TFormMails.StringGridOutGoingMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Row : integer;
begin
 Row := StringGridOutGoing.Row;
 GroupBoxOutGoingFile.Caption := '??????????? ????? ? ?????? # '+ StringGridOutGoing.Cells[1,Row];
   if Row <> 0 then
   begin
     if Button = mbRight then
     begin
       StringGridOutGoing.Options:= StringGridOutGoing.Options + [goRowSelect];
     end else
     begin
       StringGridOutGoing.Options:= StringGridOutGoing.Options - [goRowSelect];
     end;
   end;

end;

procedure TFormMails.StringGridOutGoingSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin

   if ARow <> 0 then
   begin
   OutGoing_ID := OutGoing[Arow - 1].ID;
   OutGoingFileView();
   end;

end;


procedure TFormMails.StringGridView(StringGrid : TStringGrid);
begin
    StringGrid.ColCount := 6;
    StringGrid.Cells[1,0] := '?????';
    StringGrid.Cells[2,0] := '??????? ???? ??????';
    StringGrid.Cells[3,0] := '????';
    StringGrid.Cells[4,0] := '?????';
    StringGrid.Cells[5,0] := '??????';
    StringGrid.ColWidths[0] := 0;
    StringGrid.ColWidths[1] := 80;
    StringGrid.ColWidths[2] := 410;
    StringGrid.ColWidths[3] := 75;
    StringGrid.ColWidths[4] := 50;
    StringGrid.ColWidths[5] := 221;
end;

procedure TFormMails.OutGoingFileView();
var i,Row : integer;
begin



   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT FileID,FileName, Description FROM listfiles WHERE '+
   ' TableID = '''+ OutGoing_ID +''' AND FileTypE = 0 AND Visible = 1';
   MySQLQueryLetters.Active := true;

   MySQLQueryLetters.Last;
   StringGridOutGoingFile.RowCount := MySQLQueryLetters.RecNo + 1;
   SetLength(OutGoingFile,MySQLQueryLetters.RecNo);
   MySQLQueryLetters.First;

   i := 0;
   while not MySQLQueryLetters.Eof do
     begin
        OutGoingFile[i].ID := MySQLQueryLetters.FieldByName('FileID').AsString;
        OutGoingFile[i].Name := MySQLQueryLetters.FieldByName('FileName').AsString;
        OutGoingFile[i].Description := MySQLQueryLetters.FieldByName('Description').AsString;

        StringGridOutGoingFile.Cells[1,i + 1] := OutGoingFile[i].Name;
        StringGridOutGoingFile.Cells[2,i + 1] := OutGoingFile[i].Description;
        i := i + 1;
        MySQLQUeryLetters.Next;
     end;


     StringGridFileView(StringGridOutGoingFile);


end;

procedure TFormMails.StringGridFileView(StringGrid : TStringGrid);
begin
    StringGrid.ColCount := 3;
    StringGrid.ColWidths[0] := 0;
    StringGrid.Cells[1,0] := '??? ?????';
    StringGrid.Cells[2,0] := '????????';
    StringGrid.ColWidths[1] := 230;
    StringGrid.ColWidths[2] := 178;
end;

procedure TFormMails.IncomingFileView();
var i : integer;
begin

   MySQLQueryLetters := TMySQLQuery.Create(Application);
   MySQLQueryLetters.Database := MySQLDatabaseLetters;
   MySQLQueryLetters.SQL.Text := 'SELECT FileID,FileName, Description FROM listfiles WHERE '+
   ' TableID = '+ Incoming_ID +' AND FileType = 1 AND Visible = 1';
   MySQLQueryLetters.Active := true;

   MySQLQueryLetters.Last;
   StringGridIncomingFile.RowCount := MySQLQueryLetters.RecNo + 1;
   SetLength(IncomingFile,MySQLQueryLetters.RecNo);
   MySQLQueryLetters.First;

   i := 0;
   while not MySQLQueryLetters.Eof do
     begin
        IncomingFile[i].ID := MySQLQueryLetters.FieldByName('FileID').AsString;
        IncomingFile[i].Name := MySQLQueryLetters.FieldByName('FileName').AsString;
        IncomingFile[i].Description := MySQLQueryLetters.FieldByName('Description').AsString;

        StringGridIncomingFile.Cells[1,i + 1] := IncomingFile[i].Name;
        StringGridIncomingFile.Cells[2,i + 1] := IncomingFile[i].Description;
        i := i + 1;
        MySQLQUeryLetters.Next;
     end;


     StringGridFileView(StringGridIncomingFile);


end;



procedure TFormMails.RequestOutGoingAdd;
var
   WND:HWND;
   Tip:integer;
   strDate,strTime,str : String;
begin
   WND:=FormMails.Handle;
   Tip:=MB_YESNO+MB_ICONINFORMATION+MB_DEFBUTTON1;
   case MessageBox(Wnd,'?? ????????????? ?????? ???????? ????? ???????','???? ??????????????',Tip) of
     IDYES:
     begin
     Str:= InputBox('???? ????????',' ','');
     if Length(Str) > 0 then
       begin
       strTime := FormatDateTime('hh:mm',Now);
       strDate := FormatDateTime('yyyy-mm-dd', Now);
       MySQLQueryLetters := TMySQLQuery.Create(Application);
       MySQLQueryLetters.Database := MySQLDatabaseLetters;
       MySQLQueryLetters.SQL.Text := 'INSERT INTO `listoutgoingmails` '+
       ' ( ListOutgoingMailsID,ShortEssence,DateAdd,TimeAdd,StatusMailsID,Visible ) VALUES '+
       ' (NULL, '''+str+''','''+StrDate+''','''+StrTime+''', 1, 1)';
       MySQLQueryLetters.ExecSQL;

       ListOutGoingView();
       end;

     end;

   end;

end;




end.
