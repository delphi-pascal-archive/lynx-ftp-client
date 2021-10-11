object FileAttributesForm: TFileAttributesForm
  Left = 320
  Top = 159
  BorderStyle = bsDialog
  Caption = #1040#1090#1088#1080#1073#1091#1090#1099' '#1092#1072#1081#1083#1072
  ClientHeight = 185
  ClientWidth = 337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object RzGroupBox1: TRzGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 41
    Caption = #1055#1088#1072#1074#1072' '#1074#1083#1072#1076#1077#1083#1100#1094#1072
    TabOrder = 0
    Transparent = True
    object CheckBox1: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = #1063#1090#1077#1085#1080#1077
      TabOrder = 0
      OnClick = CheckBoxClicked
    end
    object CheckBox2: TCheckBox
      Left = 112
      Top = 16
      Width = 97
      Height = 17
      Caption = #1047#1072#1087#1080#1089#1100
      TabOrder = 1
      OnClick = CheckBoxClicked
    end
    object CheckBox3: TCheckBox
      Left = 216
      Top = 16
      Width = 97
      Height = 17
      Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077
      TabOrder = 2
      OnClick = CheckBoxClicked
    end
  end
  object RzGroupBox2: TRzGroupBox
    Left = 8
    Top = 56
    Width = 321
    Height = 41
    Caption = #1055#1088#1072#1074#1072' '#1075#1088#1091#1087#1087#1099
    TabOrder = 1
    Transparent = True
    object CheckBox4: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = #1063#1090#1077#1085#1080#1077
      TabOrder = 0
      OnClick = CheckBoxClicked
    end
    object CheckBox5: TCheckBox
      Left = 112
      Top = 16
      Width = 97
      Height = 17
      Caption = #1047#1072#1087#1080#1089#1100
      TabOrder = 1
      OnClick = CheckBoxClicked
    end
    object CheckBox6: TCheckBox
      Left = 216
      Top = 16
      Width = 97
      Height = 17
      Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077
      TabOrder = 2
      OnClick = CheckBoxClicked
    end
  end
  object RzGroupBox3: TRzGroupBox
    Left = 8
    Top = 104
    Width = 321
    Height = 41
    Caption = #1055#1088#1072#1074#1072' '#1087#1086#1083#1100#1079#1086#1074#1072#1090#1077#1083#1077#1081
    TabOrder = 2
    Transparent = True
    object CheckBox7: TCheckBox
      Left = 8
      Top = 16
      Width = 97
      Height = 17
      Caption = #1063#1090#1077#1085#1080#1077
      TabOrder = 0
      OnClick = CheckBoxClicked
    end
    object CheckBox8: TCheckBox
      Left = 112
      Top = 16
      Width = 97
      Height = 17
      Caption = #1047#1072#1087#1080#1089#1100
      TabOrder = 1
      OnClick = CheckBoxClicked
    end
    object CheckBox9: TCheckBox
      Left = 216
      Top = 16
      Width = 97
      Height = 17
      Caption = #1042#1099#1087#1086#1083#1085#1077#1085#1080#1077
      TabOrder = 2
      OnClick = CheckBoxClicked
    end
  end
  object Button1: TButton
    Left = 176
    Top = 152
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 256
    Top = 152
    Width = 75
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 4
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 155
    Width = 121
    Height = 21
    MaxLength = 3
    ReadOnly = True
    TabOrder = 5
    Text = '000'
    OnChange = Edit1Change
  end
end
