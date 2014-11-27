object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'No HDD Spindown'
  ClientHeight = 239
  ClientWidth = 510
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ExtBtn: TBitBtn
    Left = 455
    Top = 31
    Width = 50
    Height = 25
    Caption = 'Exit'
    DoubleBuffered = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    ParentDoubleBuffered = False
    TabOrder = 1
    OnClick = ExitApplication1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 60
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 34
      Width = 61
      Height = 13
      Caption = 'Select Drive:'
      Enabled = False
    end
    object Label2: TLabel
      Left = 128
      Top = 10
      Width = 79
      Height = 13
      Caption = 'Activity interval:'
      Enabled = False
    end
    object Bevel1: TBevel
      Left = 120
      Top = 0
      Width = 9
      Height = 60
      Shape = bsLeftLine
    end
    object Bevel2: TBevel
      Left = 331
      Top = 0
      Width = 10
      Height = 60
      Shape = bsLeftLine
    end
    object HDD1Time: TLabel
      Left = 340
      Top = 32
      Width = 94
      Height = 13
      Caption = 'HDD access in: --:--'
      Enabled = False
    end
    object DriveList1: TComboBox
      Left = 74
      Top = 30
      Width = 38
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      TabOrder = 0
      OnChange = DriveList1Change
      Items.Strings = (
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G'
        'H'
        'I'
        'J'
        'K'
        'L'
        'M'
        'N'
        'O'
        'P'
        'Q'
        'R'
        'S'
        'T'
        'U'
        'V'
        'W'
        'X'
        'Y'
        'Z')
    end
    object CB_interv1: TComboBox
      Left = 209
      Top = 6
      Width = 38
      Height = 21
      Style = csDropDownList
      Enabled = False
      ItemHeight = 13
      ItemIndex = 4
      TabOrder = 1
      Text = '5'
      OnChange = CB_interv1Change
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50'
        '55'
        '60')
    end
    object RB_min1: TRadioButton
      Left = 253
      Top = 8
      Width = 35
      Height = 17
      Caption = 'min'
      Checked = True
      Enabled = False
      TabOrder = 2
      TabStop = True
      OnClick = RB_sec1Click
    end
    object RB_sec1: TRadioButton
      Left = 291
      Top = 8
      Width = 36
      Height = 17
      Caption = 'sec'
      Enabled = False
      TabOrder = 3
      OnClick = RB_sec1Click
    end
    object Button1: TButton
      Left = 353
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Start'
      Enabled = False
      TabOrder = 4
      OnClick = Button1Click
    end
    object ProgressBar1: TProgressBar
      Left = 331
      Top = 47
      Width = 118
      Height = 13
      Enabled = False
      TabOrder = 5
    end
    object CB_idle1: TCheckBox
      Left = 128
      Top = 32
      Width = 121
      Height = 17
      Caption = 'Stop while PC is idle'
      Enabled = False
      TabOrder = 6
      OnClick = CB_idle1Click
    end
    object CB_auto1: TCheckBox
      Left = 253
      Top = 32
      Width = 65
      Height = 17
      Caption = 'Autostart'
      Enabled = False
      TabOrder = 7
      OnClick = CB_auto1Click
    end
  end
  object OptBtn: TBitBtn
    Left = 455
    Top = 3
    Width = 50
    Height = 25
    Caption = 'Options'
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 0
    OnClick = OptBtnClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 60
    Width = 449
    Height = 60
    TabOrder = 3
    Visible = False
    object Label3: TLabel
      Left = 8
      Top = 34
      Width = 61
      Height = 13
      Caption = 'Select Drive:'
    end
    object Label4: TLabel
      Left = 128
      Top = 10
      Width = 79
      Height = 13
      Caption = 'Activity interval:'
    end
    object Bevel3: TBevel
      Left = 120
      Top = 0
      Width = 9
      Height = 60
      Shape = bsLeftLine
    end
    object Bevel4: TBevel
      Left = 331
      Top = 0
      Width = 10
      Height = 60
      Shape = bsLeftLine
    end
    object HDD2Time: TLabel
      Left = 340
      Top = 32
      Width = 94
      Height = 13
      Caption = 'HDD access in: --:--'
    end
    object DriveList2: TComboBox
      Left = 74
      Top = 30
      Width = 38
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = DriveList2Change
      Items.Strings = (
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G'
        'H'
        'I'
        'J'
        'K'
        'L'
        'M'
        'N'
        'O'
        'P'
        'Q'
        'R'
        'S'
        'T'
        'U'
        'V'
        'W'
        'X'
        'Y'
        'Z')
    end
    object CB_interv2: TComboBox
      Left = 209
      Top = 6
      Width = 38
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 4
      TabOrder = 1
      Text = '5'
      OnChange = CB_interv2Change
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50'
        '55'
        '60')
    end
    object RB_min2: TRadioButton
      Left = 253
      Top = 8
      Width = 35
      Height = 17
      Caption = 'min'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = RB_sec2Click
    end
    object RB_sec2: TRadioButton
      Left = 291
      Top = 8
      Width = 36
      Height = 17
      Caption = 'sec'
      TabOrder = 3
    end
    object Button2: TButton
      Left = 353
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 4
      OnClick = Button2Click
    end
    object ProgressBar2: TProgressBar
      Left = 331
      Top = 47
      Width = 118
      Height = 13
      TabOrder = 5
    end
    object CB_idle2: TCheckBox
      Left = 128
      Top = 32
      Width = 121
      Height = 17
      Caption = 'Stop while PC is idle'
      TabOrder = 6
      OnClick = CB_idle2Click
    end
    object CB_auto2: TCheckBox
      Left = 253
      Top = 32
      Width = 65
      Height = 17
      Caption = 'Autostart'
      TabOrder = 7
      OnClick = CB_auto2Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 120
    Width = 449
    Height = 60
    TabOrder = 4
    Visible = False
    object Label5: TLabel
      Left = 8
      Top = 34
      Width = 61
      Height = 13
      Caption = 'Select Drive:'
    end
    object Label6: TLabel
      Left = 128
      Top = 10
      Width = 79
      Height = 13
      Caption = 'Activity interval:'
    end
    object Bevel5: TBevel
      Left = 120
      Top = 0
      Width = 9
      Height = 60
      Shape = bsLeftLine
    end
    object Bevel6: TBevel
      Left = 331
      Top = 0
      Width = 10
      Height = 60
      Shape = bsLeftLine
    end
    object HDD3Time: TLabel
      Left = 340
      Top = 32
      Width = 94
      Height = 13
      Caption = 'HDD access in: --:--'
    end
    object DriveList3: TComboBox
      Left = 74
      Top = 30
      Width = 38
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = DriveList3Change
      Items.Strings = (
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G'
        'H'
        'I'
        'J'
        'K'
        'L'
        'M'
        'N'
        'O'
        'P'
        'Q'
        'R'
        'S'
        'T'
        'U'
        'V'
        'W'
        'X'
        'Y'
        'Z')
    end
    object CB_interv3: TComboBox
      Left = 209
      Top = 6
      Width = 38
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 4
      TabOrder = 1
      Text = '5'
      OnChange = CB_interv3Change
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50'
        '55'
        '60')
    end
    object RB_min3: TRadioButton
      Left = 253
      Top = 8
      Width = 35
      Height = 17
      Caption = 'min'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = RB_sec3Click
    end
    object RB_sec3: TRadioButton
      Left = 291
      Top = 8
      Width = 36
      Height = 17
      Caption = 'sec'
      TabOrder = 3
    end
    object Button3: TButton
      Left = 353
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 4
      OnClick = Button3Click
    end
    object ProgressBar3: TProgressBar
      Left = 331
      Top = 47
      Width = 118
      Height = 13
      TabOrder = 5
    end
    object CB_idle3: TCheckBox
      Left = 128
      Top = 32
      Width = 121
      Height = 17
      Caption = 'Stop while PC is idle'
      TabOrder = 6
      OnClick = CB_idle3Click
    end
    object CB_auto3: TCheckBox
      Left = 253
      Top = 32
      Width = 65
      Height = 17
      Caption = 'Autostart'
      TabOrder = 7
      OnClick = CB_auto3Click
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 180
    Width = 449
    Height = 60
    TabOrder = 5
    Visible = False
    object Label7: TLabel
      Left = 8
      Top = 34
      Width = 61
      Height = 13
      Caption = 'Select Drive:'
    end
    object Label8: TLabel
      Left = 128
      Top = 10
      Width = 79
      Height = 13
      Caption = 'Activity interval:'
    end
    object Bevel7: TBevel
      Left = 120
      Top = 0
      Width = 9
      Height = 60
      Shape = bsLeftLine
    end
    object Bevel8: TBevel
      Left = 331
      Top = 0
      Width = 10
      Height = 60
      Shape = bsLeftLine
    end
    object HDD4Time: TLabel
      Left = 340
      Top = 32
      Width = 94
      Height = 13
      Caption = 'HDD access in: --:--'
    end
    object DriveList4: TComboBox
      Left = 74
      Top = 30
      Width = 38
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      TabOrder = 0
      OnChange = DriveList4Change
      Items.Strings = (
        'A'
        'B'
        'C'
        'D'
        'E'
        'F'
        'G'
        'H'
        'I'
        'J'
        'K'
        'L'
        'M'
        'N'
        'O'
        'P'
        'Q'
        'R'
        'S'
        'T'
        'U'
        'V'
        'W'
        'X'
        'Y'
        'Z')
    end
    object CB_interv4: TComboBox
      Left = 209
      Top = 6
      Width = 38
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 4
      TabOrder = 1
      Text = '5'
      OnChange = CB_interv4Change
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '15'
        '20'
        '25'
        '30'
        '35'
        '40'
        '45'
        '50'
        '55'
        '60')
    end
    object RB_min4: TRadioButton
      Left = 253
      Top = 9
      Width = 35
      Height = 17
      Caption = 'min'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = RB_sec4Click
    end
    object RB_sec4: TRadioButton
      Left = 291
      Top = 8
      Width = 36
      Height = 17
      Caption = 'sec'
      TabOrder = 3
    end
    object Button4: TButton
      Left = 353
      Top = 4
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 4
      OnClick = Button4Click
    end
    object ProgressBar4: TProgressBar
      Left = 331
      Top = 47
      Width = 118
      Height = 13
      TabOrder = 5
    end
    object CB_idle4: TCheckBox
      Left = 128
      Top = 32
      Width = 121
      Height = 17
      Caption = 'Stop while PC is idle'
      TabOrder = 6
      OnClick = CB_idle4Click
    end
    object CB_auto4: TCheckBox
      Left = 253
      Top = 32
      Width = 65
      Height = 17
      Caption = 'Autostart'
      TabOrder = 7
      OnClick = CB_auto4Click
    end
  end
  object EnableHDD1: TCheckBox
    Left = 8
    Top = 7
    Width = 89
    Height = 17
    Caption = 'Enable Drive 1'
    TabOrder = 6
    OnClick = EnableHDD1Click
  end
  object EnableHDD2: TCheckBox
    Left = 8
    Top = 67
    Width = 89
    Height = 17
    Caption = 'Enable Drive 2'
    TabOrder = 7
    OnClick = EnableHDD2Click
  end
  object EnableHDD3: TCheckBox
    Left = 8
    Top = 127
    Width = 89
    Height = 17
    Caption = 'Enable Drive 3'
    TabOrder = 8
    OnClick = EnableHDD3Click
  end
  object EnableHDD4: TCheckBox
    Left = 8
    Top = 187
    Width = 89
    Height = 17
    Caption = 'Enable Drive 4'
    TabOrder = 9
    OnClick = EnableHDD4Click
  end
  object PopupMenu1: TPopupMenu
    Left = 464
    Top = 64
    object ShowMainForm1: TMenuItem
      Caption = 'Show'
      OnClick = ShowMainForm1Click
    end
    object Settings1: TMenuItem
      Caption = 'Settings'
      OnClick = Settings1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object ExitApplication1: TMenuItem
      Caption = 'Exit'
      OnClick = ExitApplication1Click
    end
  end
  object Timer1: TTimer
    Enabled = False
    OnTimer = Timer1Timer
    Left = 416
  end
  object Timer2: TTimer
    Enabled = False
    OnTimer = Timer2Timer
    Left = 416
    Top = 60
  end
  object TrayIcon1: TTrayIcon
    PopupMenu = PopupMenu1
    OnDblClick = ShowMainForm1Click
    Left = 464
    Top = 168
  end
  object Timer3: TTimer
    Enabled = False
    OnTimer = Timer3Timer
    Left = 416
    Top = 120
  end
  object Timer4: TTimer
    Enabled = False
    OnTimer = Timer4Timer
    Left = 416
    Top = 180
  end
  object IdleTimer: TTimer
    OnTimer = IdleTimerTimer
    Left = 464
    Top = 112
  end
end
