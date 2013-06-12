object MainFrm: TMainFrm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Change Version'
  ClientHeight = 224
  ClientWidth = 427
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 24
    Width = 59
    Height = 13
    Caption = 'New version'
  end
  object Label2: TLabel
    Left = 40
    Top = 80
    Width = 70
    Height = 13
    Caption = 'Packages path'
  end
  object Label3: TLabel
    Left = 40
    Top = 125
    Width = 63
    Height = 13
    Caption = 'Sources path'
  end
  object eMajor: TSpinEdit
    Left = 40
    Top = 43
    Width = 44
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 0
    Value = 0
  end
  object eMinor: TSpinEdit
    Left = 89
    Top = 43
    Width = 44
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 0
  end
  object eRelease: TSpinEdit
    Left = 138
    Top = 43
    Width = 44
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object eBuild: TSpinEdit
    Left = 188
    Top = 43
    Width = 44
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 0
  end
  object ePath: TEdit
    Left = 40
    Top = 96
    Width = 328
    Height = 21
    TabOrder = 4
  end
  object bOk: TButton
    Left = 40
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Apply'
    TabOrder = 5
    OnClick = bOkClick
  end
  object eSources: TEdit
    Left = 40
    Top = 141
    Width = 328
    Height = 21
    TabOrder = 6
  end
end
