object FormMails: TFormMails
  Left = 0
  Top = 0
  Caption = #1046#1091#1088#1085#1072#1083' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1080' '#1074#1093#1086#1076#1103#1097#1080#1093' '#1087#1080#1089#1077#1084
  ClientHeight = 661
  ClientWidth = 1284
  Color = clWindow
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'SF UI Display'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 15
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1284
    Height = 661
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1048#1089#1093#1086#1076#1103#1097#1080#1077' '#1087#1080#1089#1100#1084#1072
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 1276
        Height = 631
        Align = alClient
        TabOrder = 0
        object EditOutGoing: TEdit
          Left = 6
          Top = 13
          Width = 523
          Height = 23
          TabOrder = 0
          TextHint = #1055#1086#1080#1089#1082'...'
          OnKeyPress = EditOutGoingKeyPress
        end
        object ButtonOutGoingSearch: TButton
          Left = 543
          Top = 9
          Width = 90
          Height = 31
          Caption = #1053#1072#1081#1090#1080
          TabOrder = 1
          OnClick = ButtonOutGoingSearchClick
        end
        object Button2: TButton
          Left = 651
          Top = 9
          Width = 201
          Height = 31
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1089#1093#1086#1076#1103#1097#1077#1077' '#1087#1080#1089#1100#1084#1086
          TabOrder = 2
          OnClick = Button2Click
        end
        object StringGridOutGoing: TStringGrid
          Left = 6
          Top = 46
          Width = 845
          Height = 582
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
          PopupMenu = PopupMenuOutGoing
          TabOrder = 3
          OnDblClick = StringGridOutGoingDblClick
          OnMouseDown = StringGridOutGoingMouseDown
          OnSelectCell = StringGridOutGoingSelectCell
        end
        object GroupBoxOutGoingFile: TGroupBox
          Left = 857
          Top = 3
          Width = 420
          Height = 630
          Caption = #1047#1072#1075#1088#1091#1078#1077#1085#1085#1099#1077' '#1092#1072#1081#1083#1099' '#1082' '#1087#1080#1089#1100#1084#1091' #'
          TabOrder = 4
          object ButtonSaveAllOutGoing: TButton
            Left = 215
            Top = 23
            Width = 186
            Height = 31
            Caption = #1057#1082#1072#1095#1072#1090#1100' '#1074#1089#1077
            TabOrder = 0
            OnClick = ButtonSaveAllOutGoingClick
          end
          object ButtonOutGoingUpload: TButton
            Left = 16
            Top = 23
            Width = 186
            Height = 31
            Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1092#1072#1081#1083#1099
            TabOrder = 1
            OnClick = ButtonOutGoingUploadClick
          end
          object StringGridOutGoingFile: TStringGrid
            Left = 4
            Top = 69
            Width = 416
            Height = 559
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            PopupMenu = PopupMenuOutGoingFile
            TabOrder = 2
            OnDblClick = StringGridOutGoingFileDblClick
            RowHeights = (
              24
              24
              23
              24
              24)
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1042#1093#1086#1076#1103#1097#1080#1077' '#1087#1080#1089#1100#1084#1072
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox4: TGroupBox
        Left = 0
        Top = 0
        Width = 1276
        Height = 631
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 857
        object Editincoming: TEdit
          Left = 6
          Top = 13
          Width = 523
          Height = 23
          TabOrder = 0
          TextHint = #1055#1086#1080#1089#1082'...'
          OnKeyPress = EditincomingKeyPress
        end
        object ButtonIncomingSearch: TButton
          Left = 543
          Top = 9
          Width = 90
          Height = 31
          Caption = #1053#1072#1081#1090#1080
          TabOrder = 1
          OnClick = ButtonIncomingSearchClick
        end
        object Button4: TButton
          Left = 651
          Top = 9
          Width = 201
          Height = 31
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1080#1089#1093#1086#1076#1103#1097#1077#1077' '#1087#1080#1089#1100#1084#1086
          TabOrder = 2
          OnClick = Button4Click
        end
        object StringGridIncoming: TStringGrid
          Left = 6
          Top = 46
          Width = 845
          Height = 582
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
          PopupMenu = PopupMenuIncoming
          TabOrder = 3
          OnDblClick = StringGridIncomingDblClick
          OnMouseDown = StringGridIncomingMouseDown
          OnSelectCell = StringGridIncomingSelectCell
        end
        object GroupBoxIncomingFile: TGroupBox
          Left = 857
          Top = 9
          Width = 420
          Height = 630
          Caption = #1047#1072#1075#1088#1091#1078#1077#1085#1085#1099#1077' '#1092#1072#1081#1083#1099' '#1082' '#1087#1080#1089#1100#1084#1091' #'
          TabOrder = 4
          object StringGridIncomingFile: TStringGrid
            Left = 3
            Top = 60
            Width = 414
            Height = 559
            Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
            PopupMenu = PopupMenuIncomingFile
            TabOrder = 0
            OnDblClick = StringGridIncomingFileDblClick
          end
          object ButtonSaveAllIncoming: TButton
            Left = 215
            Top = 23
            Width = 186
            Height = 31
            Caption = #1057#1082#1072#1095#1072#1090#1100' '#1074#1089#1077
            TabOrder = 1
            OnClick = ButtonSaveAllIncomingClick
          end
          object ButtonIncomingUpload: TButton
            Left = 16
            Top = 23
            Width = 186
            Height = 31
            Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1092#1072#1081#1083#1099
            TabOrder = 2
            OnClick = ButtonIncomingUploadClick
          end
        end
      end
    end
  end
  object MySQLDatabaseLetters: TMySQLDatabase
    DatabaseName = 'romashka'
    UserName = 'romashka'
    UserPassword = 'romashka1234'
    Host = '135.181.40.238'
    ConnectOptions = [coCompress]
    Params.Strings = (
      'Port=3306'
      'TIMEOUT=30'
      'Host=135.181.40.238'
      'UID=romashka'
      'PWD=romashka1234'
      'DatabaseName=romashka')
    SSLProperties.TLSVersion = tlsAuto
    DatasetOptions = []
    Left = 268
    Top = 368
  end
  object PopupMenuOutGoingFile: TPopupMenu
    Left = 588
    Top = 290
    object N1: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1057#1082#1072#1095#1072#1090#1100
      OnClick = N2Click
    end
  end
  object PopupMenuOutGoing: TPopupMenu
    Left = 236
    Top = 290
    object N3: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N3Click
    end
  end
  object PopupMenuIncoming: TPopupMenu
    Left = 356
    Top = 290
    object N4: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N4Click
    end
  end
  object PopupMenuIncomingFile: TPopupMenu
    Left = 716
    Top = 290
    object N5: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N5Click
    end
    object N6: TMenuItem
      Caption = #1057#1082#1072#1095#1072#1090#1100
      OnClick = N6Click
    end
  end
end
