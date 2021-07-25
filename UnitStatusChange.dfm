object FormStatusChange: TFormStatusChange
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'FormStatusChange'
  ClientHeight = 41
  ClientWidth = 236
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object DBLookupComboBoxStatus: TDBLookupComboBox
    Left = 8
    Top = 8
    Width = 217
    Height = 23
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'SF UI Display'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = DBLookupComboBoxStatusClick
  end
end
