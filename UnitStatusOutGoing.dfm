object FormStatusOutGoing: TFormStatusOutGoing
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = #1057#1090#1072#1090#1091#1089
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
    Text = #1055#1080#1089#1100#1084#1086' '#1089#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1086
    OnChange = ComboBoxStatusChange
    Items.Strings = (
      #1055#1080#1089#1100#1084#1086' '#1089#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1086
      #1055#1080#1089#1100#1084#1086' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1086
      #1055#1080#1089#1100#1084#1086' '#1085#1077' '#1087#1086#1083#1091#1095#1077#1085#1086' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1077#1084)
  end
end
