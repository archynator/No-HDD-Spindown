object Form2: TForm2
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Options'
  ClientHeight = 126
  ClientWidth = 280
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 100
    Width = 109
    Height = 13
    Caption = 'Idle timeout (minutes):'
  end
  object Button1: TButton
    Left = 197
    Top = 8
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 197
    Top = 39
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 1
    OnClick = Button2Click
  end
  object CB_StartMinimized: TCheckBox
    Left = 8
    Top = 8
    Width = 97
    Height = 17
    Caption = 'Start minimized'
    TabOrder = 2
  end
  object CB_MinimizeToTray: TCheckBox
    Left = 8
    Top = 31
    Width = 137
    Height = 17
    Caption = 'Minimize to system tray'
    TabOrder = 3
  end
  object CB_CloseToTray: TCheckBox
    Left = 8
    Top = 54
    Width = 121
    Height = 17
    Caption = 'Close to system tray'
    TabOrder = 4
  end
  object CB_Startup: TCheckBox
    Left = 8
    Top = 77
    Width = 121
    Height = 17
    Caption = 'Start with Windows'
    TabOrder = 5
  end
  object CB_IdleTime: TComboBox
    Left = 119
    Top = 97
    Width = 41
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    ItemIndex = 9
    TabOrder = 6
    Text = '10'
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
      '30')
  end
end
