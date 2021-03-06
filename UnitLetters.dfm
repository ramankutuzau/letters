object FormLetters: TFormLetters
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1050#1085#1080#1075#1072' '#1080#1089#1093#1086#1076#1103#1097#1080#1093' '#1080' '#1074#1093#1086#1076#1103#1097#1080#1093' '#1087#1080#1089#1077#1084
  ClientHeight = 670
  ClientWidth = 1310
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 1310
    Height = 670
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #1042#1093#1086#1076#1103#1097#1080#1077
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 1302
        Height = 642
        Align = alClient
        Caption = #1042#1093#1086#1076#1103#1097#1080#1077' '#1087#1080#1089#1100#1084#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'SF UI Display'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object ComboBoxIncoming: TComboBox
          Left = 11
          Top = 19
          Width = 62
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
          Text = '50'
          OnChange = ComboBoxOutGoingChange
          Items.Strings = (
            '50'
            '100'
            '150'
            '200'
            '250'
            #1042#1089#1077)
        end
        object DBGridIncoming: TDBGrid
          Left = 11
          Top = 48
          Width = 886
          Height = 537
          DataSource = DataSourceIncoming
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = PopupMenuIncoming
          ReadOnly = True
          TabOrder = 1
          TitleFont.Charset = RUSSIAN_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'SF UI Display'
          TitleFont.Style = []
          OnCellClick = DBGridIncomingCellClick
        end
        object ButtonIncoming: TButton
          Left = 439
          Top = 17
          Width = 105
          Height = 25
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 2
          OnClick = ButtonIncomingClick
        end
        object GroupBox4: TGroupBox
          Left = 903
          Top = 48
          Width = 386
          Height = 417
          Caption = #1060#1072#1081#1083#1099
          TabOrder = 3
          object DBGridIncomingFile: TDBGrid
            Left = 16
            Top = 24
            Width = 353
            Height = 329
            DataSource = DataSourceIncomingFile
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            PopupMenu = PopupMenuIncomingFile
            TabOrder = 0
            TitleFont.Charset = RUSSIAN_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -13
            TitleFont.Name = 'SF UI Display'
            TitleFont.Style = []
          end
          object ButtonSaveAllIncoming: TButton
            Left = 16
            Top = 373
            Width = 129
            Height = 25
            Caption = #1057#1082#1072#1095#1072#1090#1100' '#1074#1089#1077' '#1092#1072#1081#1083#1099
            TabOrder = 1
            OnClick = ButtonSaveAllIncomingClick
          end
        end
        object EditIncomingSearch: TEdit
          Left = 88
          Top = 19
          Width = 345
          Height = 23
          TabOrder = 4
          OnChange = EditIncomingSearchChange
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = #1048#1089#1093#1086#1076#1103#1097#1080#1077
      ImageIndex = 1
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 1302
        Height = 642
        Align = alClient
        Caption = #1048#1089#1093#1086#1076#1103#1097#1080#1077' '#1087#1080#1089#1100#1084#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'SF UI Display'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object ComboBoxOutGoing: TComboBox
          Left = 11
          Top = 19
          Width = 62
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
          Text = '50'
          OnChange = ComboBoxOutGoingChange
          Items.Strings = (
            '50'
            '100'
            '150'
            '200'
            '250'
            #1042#1089#1077)
        end
        object DBGridOutgoing: TDBGrid
          Left = 11
          Top = 48
          Width = 886
          Height = 537
          DataSource = DataSourceOutGoing
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
          PopupMenu = PopupMenuOutGoing
          TabOrder = 1
          TitleFont.Charset = RUSSIAN_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = 'SF UI Display'
          TitleFont.Style = []
          OnCellClick = DBGridOutgoingCellClick
        end
        object ButtonOutGoing: TButton
          Left = 439
          Top = 17
          Width = 105
          Height = 25
          Caption = #1044#1086#1073#1072#1074#1080#1090#1100
          TabOrder = 2
          OnClick = ButtonOutGoingClick
        end
        object GroupBox3: TGroupBox
          Left = 903
          Top = 48
          Width = 386
          Height = 417
          Caption = #1060#1072#1081#1083#1099
          TabOrder = 3
          object DBGridOutGoingFile: TDBGrid
            Left = 16
            Top = 24
            Width = 353
            Height = 329
            DataSource = DataSourceOutGoingFile
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
            PopupMenu = PopupMenuOutGoingFile
            TabOrder = 0
            TitleFont.Charset = RUSSIAN_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -13
            TitleFont.Name = 'SF UI Display'
            TitleFont.Style = []
          end
          object ButtonSaveAllOutGoing: TButton
            Left = 16
            Top = 373
            Width = 129
            Height = 25
            Caption = #1057#1082#1072#1095#1072#1090#1100' '#1074#1089#1077' '#1092#1072#1081#1083#1099
            TabOrder = 1
            OnClick = ButtonSaveAllOutGoingClick
          end
        end
        object EditoutGoingSearch: TEdit
          Left = 88
          Top = 19
          Width = 345
          Height = 23
          TabOrder = 4
          OnChange = EditoutGoingSearchChange
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
    Left = 228
    Top = 448
  end
  object DataSourceOutGoing: TDataSource
    Left = 436
    Top = 440
  end
  object DataSourceOutGoingFile: TDataSource
    Left = 556
    Top = 368
  end
  object PopupMenuOutGoing: TPopupMenu
    Left = 420
    Top = 184
    object N1: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = N2Click
    end
    object N5: TMenuItem
      Caption = #1057#1090#1072#1090#1091#1089
      object N6: TMenuItem
        Caption = #1055#1080#1089#1100#1084#1086' '#1089#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1086
        OnClick = N6Click
      end
      object N7: TMenuItem
        Caption = #1055#1080#1089#1100#1084#1086' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1086
        OnClick = N7Click
      end
      object N8: TMenuItem
        Caption = #1055#1080#1089#1100#1084#1086' '#1085#1077' '#1087#1086#1083#1091#1095#1077#1085#1086' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1077#1084
        OnClick = N8Click
      end
    end
  end
  object PopupMenuOutGoingFile: TPopupMenu
    Left = 420
    Top = 240
    object N3: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1092#1072#1081#1083
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #1057#1082#1072#1095#1072#1090#1100' '#1092#1072#1081#1083
      OnClick = N4Click
    end
  end
  object DataSourceIncoming: TDataSource
    Left = 436
    Top = 368
  end
  object DataSourceIncomingFile: TDataSource
    Left = 556
    Top = 432
  end
  object PopupMenuIncoming: TPopupMenu
    Left = 244
    Top = 184
    object N9: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100
      OnClick = N9Click
    end
    object N10: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = N10Click
    end
    object N11: TMenuItem
      Caption = #1057#1090#1072#1090#1091#1089
      object N12: TMenuItem
        Caption = #1055#1080#1089#1100#1084#1086' '#1089#1092#1086#1088#1084#1080#1088#1086#1074#1072#1085#1086
        OnClick = N12Click
      end
      object N13: TMenuItem
        Caption = #1055#1080#1089#1100#1084#1086' '#1086#1090#1087#1088#1072#1074#1083#1077#1085#1086
        OnClick = N13Click
      end
      object N14: TMenuItem
        Caption = #1055#1080#1089#1100#1084#1086' '#1085#1077' '#1087#1086#1083#1091#1095#1077#1085#1086' '#1087#1086#1083#1091#1095#1072#1090#1077#1083#1077#1084
        OnClick = N14Click
      end
    end
  end
  object PopupMenuIncomingFile: TPopupMenu
    Left = 244
    Top = 240
    object N15: TMenuItem
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1092#1072#1081#1083
      OnClick = N15Click
    end
    object N16: TMenuItem
      Caption = #1057#1082#1072#1095#1072#1090#1100' '#1092#1072#1081#1083
      OnClick = N16Click
    end
  end
end
