object Form1: TForm1
  Left = 193
  Top = 103
  Width = 696
  Height = 480
  Caption = 'Reader'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  OnMouseDown = FormMouseDown
  DesignSize = (
    688
    434)
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 40
    Width = 687
    Height = 217
    Anchors = [akLeft, akTop, akRight]
    Stretch = True
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 415
    Width = 688
    Height = 19
    Panels = <
      item
        Width = 450
      end
      item
        Width = 100
      end
      item
        Width = 50
      end>
    SimplePanel = False
  end
  object ToolBar1: TToolBar
    Left = 0
    Top = 0
    Width = 688
    Height = 33
    ButtonWidth = 25
    Caption = 'ToolBar1'
    Images = ImageList1
    TabOrder = 2
    object ToolButton1: TToolButton
      Left = 0
      Top = 2
      Caption = 'ToolButton1'
      ImageIndex = 0
      OnClick = ToolButton1Click
    end
    object ToolButton3: TToolButton
      Left = 25
      Top = 2
      Width = 8
      Caption = 'ToolButton3'
      ImageIndex = 2
      Style = tbsSeparator
    end
    object ToolButton2: TToolButton
      Left = 33
      Top = 2
      Caption = 'ToolButton2'
      ImageIndex = 1
      OnClick = ToolButton2Click
    end
    object ToolButton8: TToolButton
      Left = 58
      Top = 2
      Caption = 'ToolButton8'
      Enabled = False
      ImageIndex = 2
      OnClick = ToolButton8Click
    end
    object ToolButton4: TToolButton
      Left = 83
      Top = 2
      Caption = 'ToolButton4'
      Enabled = False
      ImageIndex = 3
      OnClick = ToolButton4Click
    end
    object ToolButton5: TToolButton
      Left = 108
      Top = 2
      Width = 8
      Caption = 'ToolButton5'
      ImageIndex = 3
      Style = tbsSeparator
    end
    object ToolButton6: TToolButton
      Left = 116
      Top = 2
      Caption = 'ToolButton6'
      ImageIndex = 4
      OnClick = ToolButton6Click
    end
    object ToolButton9: TToolButton
      Left = 141
      Top = 2
      Caption = 'ToolButton9'
      ImageIndex = 5
      OnClick = ToolButton9Click
    end
    object ToolButton10: TToolButton
      Left = 166
      Top = 2
      Width = 8
      Caption = 'ToolButton10'
      ImageIndex = 6
      Style = tbsSeparator
    end
    object ToolButton7: TToolButton
      Left = 174
      Top = 2
      Caption = 'ToolButton7'
      ImageIndex = 6
      OnClick = ToolButton7Click
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 373
    Width = 688
    Height = 41
    Anchors = [akLeft, akRight, akBottom]
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 3
    object Label1: TLabel
      Left = 90
      Top = 6
      Width = 3
      Height = 13
    end
    object Label2: TLabel
      Left = 270
      Top = 6
      Width = 3
      Height = 13
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 5
      Width = 77
      Height = 17
      Caption = #1042#1088#1077#1084#1103' '#1095#1090#1077#1085#1080#1103':'
      TabOrder = 0
    end
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 397
    Width = 329
    Height = 9
    Min = 0
    Max = 400
    Smooth = True
    Step = 2
    TabOrder = 0
  end
  object StaticText2: TStaticText
    Left = 198
    Top = 378
    Width = 61
    Height = 17
    Caption = #1055#1088#1086#1095#1080#1090#1072#1085#1086':'
    TabOrder = 4
  end
  object OpenDialog1: TOpenDialog
    Filter = 
      'All supported files|*.txt; *.doc; *.rtf|Word documents (*.doc; *' +
      '.rtf)|*.doc; *.rtf|Text files (*.txt)|*.txt'
    Left = 640
    Top = 64
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 640
    Top = 96
  end
  object MainMenu1: TMainMenu
    Left = 608
    Top = 64
    object File1: TMenuItem
      Caption = '&'#1060#1072#1081#1083
      object N1: TMenuItem
        Caption = '&'#1054#1090#1082#1088#1099#1090#1100
        OnClick = N1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object N3: TMenuItem
        Caption = '&'#1042#1099#1093#1086#1076
        OnClick = N3Click
      end
    end
    object N4: TMenuItem
      Caption = '&'#1053#1072#1089#1090#1088#1086#1081#1082#1080
      object N5: TMenuItem
        Caption = '&'#1064#1088#1080#1092#1090
        OnClick = N5Click
      end
      object N6: TMenuItem
        Caption = '&'#1062#1074#1077#1090' '#1092#1086#1085#1072
        OnClick = N6Click
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Times New Roman'
    Font.Style = []
    MinFontSize = 0
    MaxFontSize = 0
    Left = 576
    Top = 64
  end
  object ColorDialog1: TColorDialog
    Ctl3D = True
    Left = 608
    Top = 96
  end
  object WordDocument1: TWordDocument
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 304
    Top = 64
  end
  object WordLetterContent1: TWordLetterContent
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 336
    Top = 64
  end
  object WordApplication1: TWordApplication
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    AutoQuit = False
    Left = 272
    Top = 64
  end
  object ImageList1: TImageList
    Left = 16
    Top = 64
    Bitmap = {
      494C010107000900040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000003000000001002000000000000030
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000000000D9000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      D900000000000000000000000000000000000000D9000000D900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000D9000000D9000000D9000000D9000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005F5F5F00000000005F5F5F00C5C5C50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005F5F5F00000000005F5F5F00C5C5C50000000000000000000000
      00000000000000000000000000000000000000000000000000000000D9000000
      D900000000005F5F5F000000D9005F5F5F00C5C5C50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C5C5
      C500000000005F5F5F005F5F5F000000000000000000C5C5C5005F5F5F000000
      000000000000000000000000000000000000000000000000000000000000C5C5
      C500000000005F5F5F005F5F5F000000000000000000C5C5C5005F5F5F000000
      000000000000000000000000000000000000000000000000000000000000C5C5
      C500000000005F5F5F005F5F5F000000D90000000000C5C5C5005F5F5F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C5C5C500C5C5C5005F5F5F00C5C5C500C5C5C50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C5C5C500C5C5C5005F5F5F00C5C5C500C5C5C50000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000C5C5C500C5C5C5005F5F5F00C5C5C5000000D90000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000C5C5
      C5005F5F5F0000000000C5C5C50000000000C5C5C500C5C5C5005F5F5F005F5F
      5F005F5F5F00000000000000000000000000000000000000000000000000C5C5
      C5005F5F5F0000000000C5C5C50000000000C5C5C500C5C5C5005F5F5F005F5F
      5F005F5F5F00000000000000000000000000000000000000000000000000C5C5
      C5005F5F5F0000000000C5C5C50000000000C5C5C500C5C5C5005F5F5F005F5F
      5F005F5F5F000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005F5F
      5F00000000005F5F5F00C5C5C500C5C5C5005F5F5F00C5C5C500000000000000
      0000000000000000000000000000000000000000000000000000000000005F5F
      5F00000000005F5F5F00C5C5C500C5C5C5005F5F5F00C5C5C500000000000000
      0000000000000000000000000000000000000000000000000000000000005F5F
      5F00000000005F5F5F00C5C5C500C5C5C5005F5F5F00C5C5C500000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000005F5F
      5F0000000000C5C5C50000000000C5C5C5000000000000000000C5C5C5005F5F
      5F005F5F5F005F5F5F0000000000000000000000000000000000000000005F5F
      5F0000000000C5C5C50000000000C5C5C5000000000000000000C5C5C5005F5F
      5F005F5F5F005F5F5F0000000000000000000000000000000000000000005F5F
      5F0000000000C5C5C50000000000C5C5C5000000000000000000C5C5C5005F5F
      5F005F5F5F005F5F5F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000005F5F5F00000000005F5F5F00C5C5C500C5C5C500C5C5C5005F5F
      5F005F5F5F005F5F5F00C5C5C500C5C5C5000000000000000000000000000000
      0000000000005F5F5F00000000005F5F5F00C5C5C500C5C5C500C5C5C5005F5F
      5F005F5F5F005F5F5F00C5C5C500C5C5C5000000000000000000000000000000
      0000000000005F5F5F00000000005F5F5F00C5C5C500C5C5C500C5C5C5005F5F
      5F005F5F5F005F5F5F00C5C5C500C5C5C5000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005F5F5F0000000000C5C5C50000000000000000005F5F5F00000000000000
      0000000000005F5F5F00C5C5C500000000000000000000000000000000000000
      00005F5F5F0000000000C5C5C50000000000000000005F5F5F00000000000000
      0000000000005F5F5F00C5C5C500000000000000000000000000000000000000
      00005F5F5F0000000000C5C5C50000000000000000005F5F5F00000000000000
      0000000000005F5F5F00C5C5C500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000005F5F5F0000000000000000005F5F5F00C5C5C500C5C5
      C500C5C5C500000000005F5F5F005F5F5F00DC809D00BA003C00000000000000
      000000000000000000005F5F5F0000000000000000005F5F5F00C5C5C500C5C5
      C500C5C5C500000000005F5F5F005F5F5F000000000000000000000000000000
      000000000000000000005F5F5F0000000000000000005F5F5F00C5C5C500C5C5
      C500C5C5C500000000005F5F5F005F5F5F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C5C5C500000000005F5F5F00C5C5C50000000000C5C5
      C500000000005F5F5F000000000000000000DC809D00BA003C00BA003C000000
      00000000000000000000C5C5C500000000005F5F5F00C5C5C50000000000C5C5
      C500000000005F5F5F0000000000000000000000000000000000000000000000
      00000000000000000000C5C5C500000000005F5F5F00C5C5C50000000000C5C5
      C500000000005F5F5F0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000005F5F5F00C5C5C500000000005F5F
      5F00C5C5C5005F5F5F00000000005F5F5F00DC809D00BA003C00BA003C00BA00
      3C00000000000000000000000000000000005F5F5F00C5C5C500000000005F5F
      5F00C5C5C5005F5F5F00000000005F5F5F000000000000000000000000000000
      0000000000000000000000000000000000005F5F5F00C5C5C500000000005F5F
      5F00C5C5C5005F5F5F00000000005F5F5F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005F5F5F000000
      0000C5C5C5005F5F5F00C5C5C50000000000DC809D00BA003C00BA003C000000
      00000000000000000000000000000000000000000000000000005F5F5F000000
      0000C5C5C5005F5F5F00C5C5C500000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000005F5F5F000000
      0000C5C5C5005F5F5F00C5C5C500000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005F5F5F00000000005F5F5F0000000000DC809D00BA003C00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005F5F5F00000000005F5F5F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00005F5F5F00000000005F5F5F00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000660000796F
      6600000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006600000066
      0000385E2A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006600000D90
      1A00026F0400155D0D0063644E00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000AFAFAF00AFAFAF00AFAFAF000000000000000000AFAFAF00AFAFAF00AFAF
      AF00FFFFFF000000000000000000000000000000000000000000000000000000
      00000000000006060E0002020A00010108000101090007060F00000000000000
      000000000000000000000000000000000000000000000C72A5000C72A5000C72
      A5000C72A5000C72A5000C72A5000C72A5000C72A5000C72A5000C72A5000C72
      A5000C72A50000000000000000000000000000000000000000000066000014A0
      270016AB2B0007840F000463020042582F000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF00FFFFFF000000000000000000000000000000000000000000000000000808
      0F004552B8001A2EC3000D23C4000A1DAE003F4AA50000010600010108000000
      000000000000000000000000000000000000189AC6001B9CC7009CFFFF006BD7
      FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7FF006BD7
      FF002899BF000C72A500000000000000000000000000000000000066000019A5
      32001CB5360017B02D000C951700016A02001A5B100000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF00FFFFFF0000000000000000000000000000000000000000005E6CC500112A
      E400142DEF00142EF500142EF500142EF500132CEA000D23C400000106000101
      080000000000000000000000000000000000189AC600199AC60079E4F0009CFF
      FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BE3FF007BDF
      FF0042B2DE00197A9D0000000000000000000000000000000000006600001FAB
      3D0022BB44001CB5360017B02D000FA51E0003790600086004004A5C37000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF00FFFFFF00000000000000000000000000000000008279E200142DEF00142E
      F500213AF5006474F0007483F2003047F500142EF500142DEF000E25CE000001
      060002010A00000000000000000000000000189AC60025A2CF003FB8D7009CFF
      FF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084EBFF0084E7
      FF0042BAEF00189AC600000000000000000000000000000000000066000023B0
      460029C2520022BB44001CB5360017B02D000FA91F0005880B00016A01002759
      1A00000000000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF00FFFFFF0000000000000000000000000000000000142DF000142EF5006C7C
      F800000000000000000000000000D1D5F2002039EF00142EF500142DEF000C20
      BD0001010700000000000000000000000000189AC60042B3E20020A0C900A5FF
      FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7FF0094F7
      FF0052BEE7005BBCCE000C72A5000000000000000000000000000066000026B3
      4D0030C9600029C2520022BB44001CB5360017B02D000FA91F00089B10000271
      030010600A000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF00FFFFFF000000000000000000000000007574F800142DEF004E60F2000000
      00000000000000000000D1D5F2002038EB00142EF500142EF500142EF500112A
      E4000001060006060E000000000000000000189AC6006FD5FD00189AC60089F0
      F7009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFFFF009CFF
      FF005AC7FF0096F9FB00187A9B000000000000000000000000000066000027B3
      4D0033CC660030C9600029C2520022BB44001CB5360017B02D000EA41D00037D
      0600056303000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF00000000000000000000000000000000002939F500142EF500858FDF000000
      000000000000D1D5F2002038EB00142EF500223BF500D2D7FD00223AF500142D
      EF00424FB10006060E000000000000000000189AC60084D7FF00189AC6006BBF
      DA00FFFFFF00FFFFFF00F7FBFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF0084E7FF00FFFFFF00187DA100000000000000000000000000006600002DB9
      530035CE680033CC660030C9600029C2520022BB440015A12800036F0500155D
      0D00000000000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF00000000000000000000000000000000001A2DF500142EF500828BD0000000
      0000D1D5F2002038EB00142EF500223BF500D2D7FD00000000004C5FF400142E
      F5004351B7000A0911000000000000000000189AC60084EBFF004FC1E200189A
      C600189AC600189AC600189AC600189AC600189AC600189AC600189AC600189A
      C600189AC600189AC6001889B1000000000000000000000000000066000032BE
      58003CD56F0035CE680033CC660030C960001494280004630200335823000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF00000000000000000000000000000000001A2DF500142EF5004655C300D1D5
      F2002038EB00142EF500223BF500D2D7FD0000000000000000002F46F500142D
      EF005A64B200000000000000000000000000189AC6009CF3FF008CF3FF008CF3
      FF008CF3FF008CF3FF008CF3FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00189AC600197A9D00000000000000000000000000000000000066000036C2
      5C0043DC76003CD56F002BBB55000A7913000E5E080000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF00000000000000000000000000000000006669F8001A2DF5000E25D1002038
      EB00142EF500223BF500D2D7FD000000000000000000C4CAFC00142EF500132C
      EA0008081000000000000000000000000000189AC600FFDFFF009CFFFF009CFF
      FF009CFFFF009CFFFF00E3E2E300189AC600189AC600189AC600189AC600189A
      C600189AC6000000000000000000000000000000000000000000006600003DC9
      630049E27C0025A84200046D07002C581D000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF0000000000000000000000000000000000000000001A2DF500142EF500142E
      F500132DF000C3C9F7000000000000000000949DE500223BF500142DEF005E6B
      D400000000000000000000000000000000000000000021A2CE00FFDFFF00FFFF
      FF00FFFFFF00DFDFDF00189AC600000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006600003CC5
      5F0015872100086004004A5C3700000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00007EBA00007EBA0000AFAFAF0000000000000000007EBA00007EBA0000AFAF
      AF0000000000000000000000000000000000000000007574F8001A2DF500142E
      F500122AE5000D22C6000C21C1000F26D600142EF500142DEF00394DE8000000
      000000000000000000000000000000000000000000000000000021A2CE0021A2
      CE0021A2CE0021A2CE0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000006600000066
      0000235D18000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000847FF9001A2D
      F5001A2DF500142EF500142EF500142DEF00142DF000565DF700000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000660000536C
      4400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00009F96FA005D6FF8004E62F700928AF9000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000300000000100010000000000800100000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFFDFFF0000FBFFFBFFEB3F0000
      FBFFFBFFF0FF0000F87FF87FC87F0000E99FE99FE89F0000F07FF07FF07F0000
      E407E407E4070000E83FE83FE83F0000EA43EA43EA430000FA00FA00FA000000
      F599F599F5990000FD843D84FD840000FD231D23FD230000FF220F22FF220000
      FFD11FD1FFD10000FFF43FF4FFF40000FFFFCFFFFFFFFFFFFFFFC7FFFFFFFFFF
      C003C1FFF187F83F8001C0FFF187E01F0001C07FF187C00F0001C01FF1878007
      0000C00FF1878E070000C007F1871C030000C007F18F18030000C00FF18F1043
      0001C01FF18F00C70003C07FF18F01870007C0FFF18F830F81FFC1FFF18F801F
      C3FFC7FFFFFFC03FFFFFCFFFFFFFF0FF00000000000000000000000000000000
      000000000000}
  end
  object StatTimer: TTimer
    Enabled = False
    OnTimer = StatTimerTimer
    Left = 544
    Top = 64
  end
end