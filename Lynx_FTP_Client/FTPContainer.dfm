object CurrentFTP: TCurrentFTP
  Left = 473
  Top = 157
  BorderStyle = bsNone
  Caption = 'CurrentFTP'
  ClientHeight = 398
  ClientWidth = 819
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 819
    Height = 33
    Align = alTop
    BevelOuter = bvNone
    FullRepaint = False
    TabOrder = 0
    DesignSize = (
      819
      33)
    object Label5: TLabel
      Left = 8
      Top = 9
      Width = 81
      Height = 13
      Caption = #1058#1077#1082#1091#1097#1072#1103' '#1087#1072#1087#1082#1072':'
    end
    object CreateFTPDir: TRzToolbarButton
      Left = 721
      Top = 5
      Width = 21
      Height = 21
      Anchors = [akTop, akRight]
      Glyph.Data = {
        06030000424D06030000000000003600000028000000100000000F0000000100
        180000000000D0020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9E66139E66139E66139E66
        13FFFFFFFFFFFFFFFFFFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCC9E6613E5E9F0E5E9F09E6613C0C0C0CCCCCCCCCCCC8C8C8C8C8C8C
        8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C9E6613E2E4E8E2E4E89E66
        138C8C8C8C8C8C8C8C8C8C8C8CB8B8B8C4C4C4C6C6C6C6C6C6C6C6C69E66139E
        66139E66139E6613E3E5E8E3E5E89E66139E66139E66139E66138C8C8CBEBEBE
        CCCCCCCDCDCDCDCDCDCDCDCD9E6613EBF1FBE6E8EBE5E7E9E3E3E3E3E3E3E5E7
        E9E6E8EBE9EEF69E66138C8C8CB3B3B3C5C5C5C7C7C7C7C7C7C7C7C79E6613F4
        FAFFEFF1F5EDEFF2EAEAEAEAEAEAEDEFF2EFF1F5F2F7FF9E66138C8C8CCCCCCC
        DCDCDCDCDCDCDBDBDBD9D9D99E66139E66139E66139E6613F1F3F6F1F3F69E66
        139E66139E66139E66138C8C8CD0D0D0DDDDDDDBDBDBDADADAD8D8D8D6D6D6D4
        D4D4D2D2D29E6613F6F8FCF6F8FC9E6613D1D1D1BEBEBE8C8C8C8C8C8CDEDEDE
        ECECECECECECEBEBEBEAEAEAE9E9E9E8E8E8E6E6E69E6613FCFFFFFCFFFF9E66
        13E3E3E3CFCFCF8C8C8C8C8C8CD8D8D8E5E5E5E5E5E5E5E5E5E4E4E4E2E2E2E0
        E0E0E0E0E09E66139E66139E66139E6613DDDDDDCCCCCC8C8C8C8C8C8CEFEFEF
        F4F4F4F3F3F3F3F3F3F2F2F2F8F8F8F8F8F8F1F1F1F1F1F1F1F1F1F0F0F0F0F0
        F0EFEFEFDCDCDC8C8C8C9A9A9A8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8CFA
        FAFAFFFFFFFEFEFEFEFEFEFEFEFEFEFEFEFDFDFDF2F2F28C8C8CFFFFFF707070
        E5E5E5EFEFEFEDEDEDEFEFEFD5D5D58C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C8C
        8C8C8C8C8C8C8C8C8C8CFFFFFF717171EAEAEAF4F4F4F2F2F2F2F2F2F5F5F5EC
        ECECBABABA9D9D9DA0A0A0A0A0A0A0A0A09C9C9C686868000000FFFFFF6D6D6D
        A7A7A7ADADADACACACACACACACACACAAAAAA6C6C6C4F4F4F6666666666666666
        66666666FFFFFFFFFFFF}
      OnClick = CreateFTPDirClick
      HotNumGlyphs = 0
    end
    object UpFolder: TRzToolbarButton
      Left = 745
      Top = 5
      Width = 21
      Height = 21
      Anchors = [akTop, akRight]
      Glyph.Data = {
        06030000424D06030000000000003600000028000000100000000F0000000100
        180000000000D0020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFF0C72111B7C1D2A8E2B309430258725117311036803006100FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF003B00177D1D2C973155BE5871D27378
        D77A6ECE6D50B850288E270A6C0A006500FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        147D1E2E9E3662D0667FDF827EDE827BDB7D83DD8586DE866BD06B36A3360B6F
        0B006200FFFFFFFFFFFFFFFFFF07661520962D47C5515FD3674FC7574EC25453
        C6594EC4525ECA6078D67A66D0662A9B2A056804006000FFFFFFFFFFFF127F22
        27AA3740CC503ACB4B11A32281B283EFF8EF9CE29F1CAF2343BE4664CD6547BD
        46107B10006100FFFFFFFFFFFF0E8F233DBF503ACE5030D54C0EAE27549857FD
        FFFCC1F4C504AC1211A91941BC444AC24B1B901B006300FFFFFFFFFFFF079623
        5ACF6D49DD641CAF3556AC60ACCDAEEEFFEED8FBD96ED4773CBF4523B02839BB
        3B1B991C016801FFFFFFFFFFFF01951D6CD37F53E67329C84B419649E5ECE2F8
        FFF8ECFFEBD8FED93CC44914AC1C24B227129614026B03FFFFFFFFFFFF007D00
        6BD08177F09240EE6E37DA614AA355E7F2E3ECFFEC61DA7212B82814AE1F11AB
        18098E0E036A06FFFFFFFFFFFF001C0035BC58ACF1BB5BF4884BFA8039DA6375
        C37E8BEF9E24CC421DBD311AB32613AB1A06810C036907FFFFFFFFFFFFFFFFFF
        00A52C67D787C7FFD769FE9845F37937E3642DD85427CC4530C5443EC7490E9B
        1806780E037503FFFFFFFFFFFFFFFFFFFFFFFF0DB74274DE94C1F8D0A3FCBB77
        F09563E57F75E6856BDB761DA92D09841508770EFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF00AC303DCA6773D78D93DFA383DD9351C66418A02D0B861C0E7D
        1AFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF00000000981500
        A323029F26048E210F7D24FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF}
      OnClick = UpFolderClick
      HotNumGlyphs = 0
    end
    object DeleteFTPFile: TRzToolbarButton
      Left = 769
      Top = 5
      Width = 21
      Height = 21
      Anchors = [akTop, akRight]
      Glyph.Data = {
        06030000424D06030000000000003600000028000000100000000F0000000100
        180000000000D0020000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFF00006706057F09088008078006058002007D00007700006FFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF04007D09088A1518972026A923
        2CB11D23A310128F05058200007A000078FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        0000710E0E952129B63E4FDC4A60E85267EA4B60E63646D52028B10B0C8B0201
        7C000079FFFFFFFFFFFFFFFFFFFFFFFF080A952129BF455AEB485FE94459E142
        56DD455CDF586DE84358E72B36CA0D0E8F00007BFFFFFFFFFFFFFFFFFF00006F
        1E26B6374BE8354BE33344D97A87E53643D14550CFB2BFF17B8EEA4456E5232A
        C406058300007AFFFFFFFFFFFF0000942733CD3348EB192BD7929CE6F4FFFFB0
        BDF5B5C0F3EDF9FFBFCAF43E4ED2303DDB0F129E010078FFFFFFFFFFFF0000A6
        2B3AD62E46EA182DD97880D7DFE7FAEDF7FFE7F4FFBDCAF8454ECD1D28C02E3A
        D31418B203017CFFFFFFFFFFFF0000A94351DA3855EF2545EB5464DCDBE0F5FE
        FFFFEBF5FFC2CDF93642D10F19BC2029C81113B4030181FFFFFFFFFFFF000098
        4D57D75071F91F3FE3BABDE9FFFFFFCFD1EBE5EAFAFCFFFF7E8BE70A15BF1219
        C4090BAD02007FFFFFFFFFFFFF000059292FCA8DA0F82D56F24C5BD0A5A9E347
        5CE0666CCD8B96E82738D70F18C50E16C704049C01007AFFFFFFFFFFFFFFFFFF
        0000B45E67E1A8C1FF3B68F52A52EE234AF11D39E2192FDF1528D82432D80B10
        BA01008A00017CFFFFFFFFFFFFFFFFFFFFFFFF1215C37079E5A7BAFD7E9FFF59
        7AF94563F3475FEF4054E81620C601029900007FFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFF0000801719BE333AD55C66DF6C77E35969E23442D51017B902039B0000
        88FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000A80D0DAA0B
        0BB50808B30405A200008A000080FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF}
      OnClick = DeleteFTPFileClick
      HotNumGlyphs = 0
    end
    object DisconnectFTP: TRzToolbarButton
      Left = 793
      Top = 5
      Width = 21
      Height = 21
      Anchors = [akTop, akRight]
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000120B0000120B00000000000000000000FFFFFFFFFFFF
        FFFFFFF9F9FDEAEAF9E2E2F7D5D5F4C8C8F1C5C5F0D2D2F3E2E2F7ECECFAF9F9
        FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3FCA3A3E75757D43232C033
        33C43C3CCD4545CF6262D6A5A5E8F4F4FCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        F9F9FDA5A5E84949D02D2DAC2626922B2BA43333C53D3DCD3939CC4545CFA6A6
        E8FCFCFEFFFFFFFFFFFFFFFFFFFEFEFF9A9AE53D3DCD3232C229299D27279625
        258E2B2BA43A3ACC3C3CCD3939CC3434C89B9BE5FFFFFFFFFFFFFFFFFFC1C1EF
        4F4FD24F4FD22A2AA125258C2828993232C24F4FD25454D34444CF3C3CCD3A3A
        CC3A3ACCC6C6F0FFFFFFF8F8FD8080DE6262D65D5DD52B2BA42E2EB25858D480
        80DE7D7DDD6F6FDA5D5DD54444CF3434CA3535CB7474DBF8F8FDE2E2F76868D8
        6F6FDA4949D06F6FDA8F8FE29898E49292E38787E08080DE7474DB3333C52A2A
        A12D2DAC3232C2E1E1F7D7D7F46262D66767D88080DEAEAEEAAEAEEAABABE9A5
        A5E89A9AE59090E27D7DDD3131BC25258F27279429299FD3D3F3D9D9F55D5DD5
        4F4FD28383DF9E9EE6D0D0F3CDCDF2C1C1EFB5B5ECA5A5E89E9EE65858D42727
        942626912A2AA1D3D3F3E2E2F76A6AD93333C43131BC3F3FCDA0A0E6ECECFADB
        DBF6CDCDF2C0C0EFB2B2EB8282DF6262D62F2FB43030B9DFDFF6F4F4FC8A8AE1
        4444CF2F2FB43333C54242CE7D7DDDD5D5F4F0F0FBDBDBF6B8B8ED4F4FD26F6F
        DA3434C75A5AD4F6F6FDFFFFFFBABAED7575DB4C4CD13333C53C3CCD5757D4B8
        B8EDCBCBF1E9E9F9C9C9F13A3ACC2B2BA42C2CA9B0B0EBFFFFFFFFFFFFF6F6FD
        A0A0E69090E25151D23535CB6464D78888E04949D0D6D6F4AEAEEA3030BA2C2C
        AA8080DEFCFCFEFFFFFFFFFFFFFFFFFFF0F0FBA6A6E85757D43232C27575DB93
        93E39D9DE6D1D1F36565D73232C28787E0F6F6FDFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF8F8FDB3B3EB7B7BDD9898E4B2B2EBA5A5E86F6FDA7070DABBBBEDFCFC
        FEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF8F8FDDFDFF6DA
        DAF5D7D7F4DCDCF6F8F8FDFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      OnClick = DisconnectFTPClick
      HotNumGlyphs = 0
    end
    object CurrentFTPDir: TEdit
      Left = 96
      Top = 5
      Width = 618
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
      Text = '/'
      OnKeyPress = CurrentFTPDirKeyPress
    end
  end
  object Files: TListView
    Left = 0
    Top = 33
    Width = 819
    Height = 263
    Align = alClient
    Columns = <
      item
        Caption = #1060#1072#1081#1083'/'#1055#1072#1087#1082#1072
        Width = 250
      end
      item
        Caption = #1058#1080#1087' '#1092#1072#1081#1083#1072
        Width = 150
      end
      item
        Caption = #1056#1072#1079#1084#1077#1088' '#1092#1072#1081#1083#1072
        Width = 100
      end
      item
        Caption = #1048#1079#1084#1077#1085#1077#1085
        Width = 200
      end
      item
        Caption = #1040#1090#1088#1080#1073#1091#1090#1099
        Width = 100
      end>
    GridLines = True
    RowSelect = True
    SmallImages = Icons
    SortType = stText
    TabOrder = 1
    ViewStyle = vsReport
    OnCompare = FilesCompare
    OnDblClick = FilesDblClick
    OnEdited = FilesEdited
  end
  object Panel1: TPanel
    Left = 0
    Top = 296
    Width = 819
    Height = 102
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object Log: TRzMemo
      Left = 0
      Top = 0
      Width = 409
      Height = 102
      Align = alLeft
      BevelInner = bvNone
      BevelOuter = bvNone
      Color = clInfoBk
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      FocusColor = clWhite
    end
    object Tasks: TListView
      Left = 409
      Top = 0
      Width = 410
      Height = 102
      Align = alClient
      Columns = <
        item
          Caption = #1054#1087#1077#1088#1072#1094#1080#1103
          Width = 100
        end
        item
          Caption = #1060#1072#1081#1083
          Width = 150
        end
        item
          Caption = #1057#1086#1089#1090#1086#1103#1085#1080#1077
          Width = 150
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 1
      ViewStyle = vsReport
    end
  end
  object Icons: TImageList
    Left = 8
    Top = 64
  end
  object IdLogEvent1: TIdLogEvent
    Active = True
    LogTime = False
    ReplaceCRLF = False
    OnReceived = IdLogEvent1Received
    OnSent = IdLogEvent1Sent
    Left = 104
    Top = 440
  end
  object DownloadFTP: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    OnWork = DownloadFTPWork
    OnWorkBegin = DownloadFTPWorkBegin
    OnWorkEnd = DownloadFTPWorkEnd
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 40
    Top = 64
  end
  object UploadFTP: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    OnWork = UploadFTPWork
    OnWorkBegin = UploadFTPWorkBegin
    OnWorkEnd = UploadFTPWorkEnd
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 72
    Top = 64
  end
  object DropFileSource1: TDropFileSource
    DragTypes = [dtCopy]
    AllowAsyncTransfer = True
    Left = 104
    Top = 64
  end
  object DropFileTarget1: TDropFileTarget
    DragTypes = [dtCopy]
    OnDrop = DropFileTarget1Drop
    Target = Files
    OptimizedMove = True
    AllowAsyncTransfer = True
    Left = 136
    Top = 64
  end
  object IdFTP1: TIdFTP
    OnStatus = IdFTP1Status
    Intercept = IdLogEvent1
    MaxLineAction = maException
    ReadTimeout = 0
    OnDisconnected = IdFTP1Disconnected
    OnConnected = IdFTP1Connected
    Passive = True
    TransferType = ftASCII
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    OnAfterClientLogin = IdFTP1AfterClientLogin
    Left = 8
    Top = 440
  end
end
