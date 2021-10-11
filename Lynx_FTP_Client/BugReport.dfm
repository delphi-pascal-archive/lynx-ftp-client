object BugReportForm: TBugReportForm
  Left = 984
  Top = 196
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1057#1086#1086#1073#1097#1080#1090#1100' '#1086#1073' '#1086#1096#1080#1073#1082#1077
  ClientHeight = 337
  ClientWidth = 393
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
  object ErrorMessage: TRzMemo
    Left = 8
    Top = 8
    Width = 377
    Height = 89
    Color = clInfoBk
    TabOrder = 0
  end
  object RzGroupBox1: TRzGroupBox
    Left = 8
    Top = 104
    Width = 377
    Height = 193
    BorderInner = fsFlatRounded
    BorderOuter = fsFlatRounded
    Caption = #1044#1086#1087#1086#1083#1085#1080#1090#1077#1083#1100#1085#1072#1103' '#1080#1085#1092#1086#1088#1084#1072#1094#1080#1103
    TabOrder = 1
    Transparent = True
    object Label1: TLabel
      Left = 8
      Top = 20
      Width = 53
      Height = 13
      Caption = #1042#1072#1096#1077' '#1080#1084#1103':'
      Transparent = True
    end
    object Label2: TLabel
      Left = 8
      Top = 44
      Width = 173
      Height = 13
      Caption = #1042#1072#1096' e-mail ('#1076#1083#1103' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1086#1090#1074#1077#1090#1072'):'
      Transparent = True
    end
    object Label3: TLabel
      Left = 8
      Top = 68
      Width = 289
      Height = 13
      Caption = #1050#1086#1084#1084#1077#1085#1090#1072#1088#1080#1081' ('#1095#1090#1086' '#1074#1099' '#1076#1077#1083#1072#1083#1080', '#1082#1086#1075#1076#1072' '#1087#1088#1086#1080#1079#1086#1096#1083#1072' '#1086#1096#1080#1073#1082#1072'):'
      Transparent = True
    end
    object RName: TEdit
      Left = 192
      Top = 16
      Width = 177
      Height = 21
      TabOrder = 0
    end
    object Email: TEdit
      Left = 192
      Top = 40
      Width = 177
      Height = 21
      TabOrder = 1
    end
    object Comment: TRzMemo
      Left = 8
      Top = 88
      Width = 361
      Height = 97
      TabOrder = 2
    end
  end
  object Button1: TButton
    Left = 168
    Top = 304
    Width = 105
    Height = 25
    Caption = #1054#1090#1087#1088#1072#1074#1080#1090#1100' '#1086#1090#1095#1077#1090
    Default = True
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 280
    Top = 304
    Width = 107
    Height = 25
    Caption = #1054#1090#1084#1077#1085#1072
    TabOrder = 3
    OnClick = Button2Click
  end
  object IdSMTP1: TIdSMTP
    MaxLineAction = maException
    ReadTimeout = 0
    Host = ''
    Port = 25
    AuthenticationType = atLogin
    Password = ''
    Username = ''
    Left = 16
    Top = 16
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'MIME'
    BccList = <>
    CCList = <>
    Encoding = meMIME
    Recipients = <>
    ReplyTo = <>
    Left = 48
    Top = 16
  end
end
