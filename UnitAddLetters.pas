unit UnitAddLetters;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,UnitMails, Vcl.ComCtrls,
  Data.DB, mySQLDbTables;

type
  TFormAddLetters = class(TForm)
    GroupBox1: TGroupBox;
    procedure FormCreate(Sender: TObject);
    procedure RequestAdd(Sender : TObject);
    procedure EditNumberKeyPress(Sender: TObject; var Key: Char);
    procedure EditEssenceKeyPress(Sender: TObject; var Key: Char);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAddLetters : TFormAddLetters;
  LabelNumber : TLabel;
  LabelEssence : TLabel;
  LabelDate : TLabel;
  EditNumber : TEdit;
  EditEssence : TEdit;
  DateTimePicker1 : TDateTimePicker;
  ButtonAdd : TButton;


implementation

{$R *.dfm}

procedure TFormAddLetters.FormCreate(Sender: TObject);
begin
  with FormAddLetters do
    begin
      Left := 0;
      Top := 0;
      BorderStyle := bsDialog;
      Caption := #1056#1077#1075#1080#1089#1090#1088#1072#1094#1080#1103' '#1074#1093#1086#1076#1103#1097#1077#1075#1086' '#1087#1080#1089#1100#1084#1072;
      ClientHeight := 142;
      ClientWidth := 401;
      Color := clWindow;
      Font.Charset := RUSSIAN_CHARSET;
      Font.Color := clWindowText;
      Font.Height := -13;
      Font.Name := 'SF UI Display';
      Font.Style := [];
      OldCreateOrder := False;
      Position := poScreenCenter;
      PixelsPerInch := 96;
    end;
  GroupBox1 := GroupBox1.Create(FormAddLetters);
  GroupBox1.Parent := FormAddLetters;
  with GroupBox1 do
    begin
    Left := 0;
    Top := 0;
    Width := 401;
    Height := 142;
    Align := alClient;
    TabOrder := 0;
    Left := 176;
    Top := 168;
    Width := 185;
    Height := 105;
    end;
  LabelNumber := TLabel.Create(GroupBox1);
  LabelNumber.Parent := GroupBox1;
   with LabelNumber do
   begin
      Left := 16;
      Top := 16;
      Width := 157;
      Height := 15;
      Caption := #1053#1086#1084#1077#1088' '#1074#1093#1086#1076#1103#1097#1077#1075#1086' '#1087#1080#1089#1100#1084#1072':';
   end;
  LabelEssence := TLabel.Create(GroupBox1);
  LabelEssence.Parent := GroupBox1;
  with LabelEssence do
  begin
      Left := 16;
      Top := 45;
      Width := 127;
      Height := 15;
      Caption := #1050#1088#1072#1090#1085#1072#1103' '#1089#1091#1090#1100' '#1087#1080#1089#1100#1084#1072':';
  end;
  LabelDate := TLabel.Create(GroupBox1);
  LabelDate.Parent := GroupBox1;
  with LabelDate do
  begin
      Left := 16;
      Top := 76;
      Width := 32;
      Height := 15;
      Caption := #1044#1072#1090#1072':';
  end;
  EditNumber := TEdit.Create(GroupBox1);
  EditNumber.Parent := GroupBox1;
  with EditNumber do
  begin
      Left := 180;
      Top := 13;
      Width := 201;
      Height := 23;
      TabOrder := 0;
      OnKeyPress := EditNumberKeyPress;
  end;
  EditEssence := TEdit.Create(GroupBox1);
  EditEssence.Parent := GroupBox1;
  with EditEssence do
  begin
      Left := 180;
      Top := 42;
      Width := 201;
      Height := 23;
      TabOrder := 1;
      OnKeyPress := EditEssenceKeyPress;
  end;
  DateTimePicker1 := TDateTimePicker.Create(GroupBox1);
  DateTimePicker1.Parent := GroupBox1;
  with DateTimePicker1 do
  begin
      Left := 180;
      Top := 71;
      Width := 201;
      Height := 23;
      Date := 44396.000000000000000000;
      Time := 0.479172071762150200;
      TabOrder := 2;
  end;
  ButtonAdd := TButton.Create(GroupBox1);
  ButtonAdd.Parent := GroupBox1;
  with ButtonAdd do
  begin
      Left := 128;
      Top := 100;
      Width := 169;
      Height := 34;
      Caption := #1044#1086#1073#1072#1074#1080#1090#1100;
      TabOrder := 3;
      OnClick := RequestAdd;
  end;


end;

procedure TFormAddLetters.RequestAdd(Sender : TObject);
var Date,Time: String;
begin

  if Length(EditNumber.Text)> 0 then
    begin
    Date := FormatDateTime('yyyy-mm-dd',DateTimePicker1.Date);
    Time := FormatDateTime('hh:mm',Now);
    MySQLQueryLetters := TMySQLQuery.Create(Application);
     MySQLQueryLetters.Database := FormMails.MySQLDatabaseLetters;
     MySQLQueryLetters.SQL.Text := 'INSERT INTO `ListIncomingMails` ' +
     '(`ListIncomingMailsID`, `NumberMails`, `ShortEssence`, `DateAdd`,' +
     ' `TimeAdd`, `StatusMailsID`, `Visible`) VALUES ' +
     '(NULL, '''+EditNumber.Text+''', '''+EditEssence.Text+''', '''+Date+''',' +
     ' '''+Time+''', 4, 1);';
     MySQLQueryLetters.ExecSQL;
     FormAddLetters.Close;
     FormMails.ListIncomingView;
    end else showmessage('???? "????? ????????? ??????" ??????????? ??? ??????????.');
end;


procedure TFormAddLetters.EditNumberKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) then EditEssence.SetFocus;
end;

procedure TFormAddLetters.EditEssenceKeyPress(Sender: TObject; var Key: Char);
begin
if (key=#13) then ButtonAdd.SetFocus;
end;



end.
