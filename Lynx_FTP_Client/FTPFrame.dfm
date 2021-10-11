object CurrentFTPFrame: TCurrentFTPFrame
  Left = 0
  Top = 0
  Width = 810
  Height = 268
  Align = alClient
  TabOrder = 0
  object IdFTP1: TIdFTP
    MaxLineAction = maException
    ReadTimeout = 0
    Host = 'aidar.3dn.ru'
    Passive = True
    Password = 'eqasefum'
    TransferType = ftASCII
    Username = '4aidar'
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 8
    Top = 440
  end
  object IdAntiFreeze1: TIdAntiFreeze
    IdleTimeOut = 1
    Left = 40
    Top = 440
  end
end
