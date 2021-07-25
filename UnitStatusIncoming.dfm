object FormStatusIncoming: TFormStatusIncoming
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormStatusIncoming'
  ClientHeight = 40
  ClientWidth = 250
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ComboBoxStatus: TComboBox
    Left = 6
    Top = 8
    Width = 236
    Height = 23
    Style = csDropDownList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'SF UI Display'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 0
    Text = #1055#1080#1089#1100#1084#1086' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1086
    OnChange = ComboBoxStatusChange
    Items.Strings = (
      #1055#1080#1089#1100#1084#1086' '#1079#1072#1088#1077#1075#1080#1089#1090#1088#1080#1088#1086#1074#1072#1085#1085#1086
      #1054#1090#1074#1077#1090' '#1086#1090#1087#1088#1072#1074#1083#1077#1085
      #1055#1080#1089#1100#1084#1086' '#1079#1072#1082#1088#1099#1090#1086)
  end
  object MySQLQueryStatus: TMySQLQuery
    Database = FormMails.MySQLDatabaseLetters
    Left = 184
    Top = 28
  end
end
