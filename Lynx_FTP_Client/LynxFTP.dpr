program LynxFTP;

uses
  Forms,
  uEncrypt in '..\..\POP3MailCheck\uEncrypt.pas',
  FTPMainForm in 'FTPMainForm.pas' {LynxFTPForm},
  FavouritesSettingsForm in 'FavouritesSettingsForm.pas' {FavouritesSettings},
  FTPContainer in 'FTPContainer.pas' {CurrentFTP},
  About in 'About.pas' {AboutLynx},
  BugReport in 'BugReport.pas' {BugReportForm},
  Settings in 'Settings.pas' {SettingsForm},
  Attributes in 'Attributes.pas' {FileAttributesForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='Lynx - FTP Manager';
  Application.CreateForm(TLynxFTPForm, LynxFTPForm);
  Application.CreateForm(TFavouritesSettings, FavouritesSettings);
  Application.CreateForm(TAboutLynx, AboutLynx);
  Application.CreateForm(TBugReportForm, BugReportForm);
  Application.CreateForm(TSettingsForm, SettingsForm);
  Application.OnException:=LynxFTPForm.OnExceptions;
  Application.Run;
end.
