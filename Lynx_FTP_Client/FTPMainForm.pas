unit FTPMainForm;

interface

uses
  Windows, Classes, Controls, Forms, SysUtils, Menus, IdAntiFreeze,
  IdFTP, ShellAPI,
  ComCtrls, StdCtrls, RzEdit, RzTabs, RzButton, ExtCtrls,
  FTPContainer, Dialogs, 
  XMLIntf, XMLDoc, xmldom, msxmldom, IdBaseComponent, IdAntiFreezeBase,
  Mask, Buttons, RzGroupBar;

type
  TFTP = record
    IdFTP: TIdFTP;
    TopPanel: TPanel;
    CurrentDirLabel: TLabel;
    CurrentDirEdit: TEdit;
    FTPFiles: TListView;
  end;

  TFTPFavourite = record
    Serv, Prt, User, Pass: String;
  end;
  
  TLynxFTPForm = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N14: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RzToolbarButton1: TRzToolbarButton;
    Server: TComboBox;
    Port: TRzNumericEdit;
    UserName: TEdit;
    Password: TEdit;
    Panel1: TPanel;
    FavouritesButton: TRzToolbarButton;
    RzPageControl2: TRzPageControl;
    TabSheet3: TRzTabSheet;
    IdAntiFreeze1: TIdAntiFreeze;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    DownloadButton: TRzToolbarButton;
    UploadButton: TRzToolbarButton;
    AttributesButton: TRzToolbarButton;
    SettingsButton: TRzToolbarButton;
    AboutButton: TRzToolbarButton;
    OpenDialog1: TOpenDialog;
    LanguageXML: TXMLDocument;
    procedure RzToolbarButton1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ServerSelect(Sender: TObject);
    procedure MainMenu1Change(Sender: TObject; Source: TMenuItem;
      Rebuild: Boolean);
    procedure N24Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure FavouritesButtonClick(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure UploadButtonClick(Sender: TObject);
    procedure DownloadButtonClick(Sender: TObject);
    procedure AttributesButtonClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure SettingsButtonClick(Sender: TObject);
    procedure AboutButtonClick(Sender: TObject);
    procedure OnExceptions(Sender: TObject; E: Exception);
    procedure N22Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    procedure SaveServer(Serv, Prt, User, Pass: String);
  public
    procedure GetFavourites;
    procedure LoadLanguage(Language: String);
    procedure GetLanguages;
  end;

var
  LynxFTPForm: TLynxFTPForm;
  Favourites: Array of TFTPFavourite;
  FTPs: Array of TCurrentFTP;
  NotConnected: String = 'Не соединен';
  FieldsAreFilledIncorrectly: String = 'Поля заполнены неверно';
  ErrorMessage: String = 'Ошибка';
  FavouritesItem: String = 'Избранное...';
  DirectoryCaption: String = 'Папка';
  ChangesWill: String = 'Изменения вступят в силу после перезапуска приложения';
  User: String = 'Пользователь';
  Author: String = 'Автор';
  VersionCaption: String = 'Версия';
  BuildCaption: String = 'Сборка';
  MemoryCaption: String = 'Оперативная память #,### Kб';
  CheckInternetConnection: String = 'Проверьте соединение с Интернетом';
  Completed: String = 'Завершено';
  UploadingCaption: String = 'Загрузка';
  DownloadingCaption: String = 'Скачивание';
  BytesCaption: String = 'байт';
  NewFolderCaption: String = 'Новая папка';
  EnterNewFolder: String = 'Введите имя новой папки:';
  ContinueUploading: String = 'Продолжить загрузку?';  
  ContinueDownloading: String = 'Продолжить закачку?';
  WaitCaption: String = 'Дождитесь завершения предыдущей операции';
  FileCaption: String = 'Файл';

implementation

uses uEncrypt, FavouritesSettingsForm, About, BugReport, 
  Settings, IniFiles, Attributes;

{$R *.dfm}

{$R WindowsXP.res}

procedure TLynxFTPForm.RzToolbarButton1Click(Sender: TObject);
var
  NewTabSheet: TRzTabSheet;
  VisibleCount, i: Integer;
begin
  if (Server.Text = '') or (Port.Text = '') or (UserName.Text = '') or (Password.Text = '') then
  begin
    Application.MessageBox(PChar(FieldsAreFilledIncorrectly), PChar(ErrorMessage), MB_ICONERROR or MB_OK);
    Exit;
  end;
  if FTPs[RzPageControl2.Pages[RzPageControl2.TabIndex].Tag].IdFTP1.Connected then
  begin
    NewTabSheet:=TRzTabSheet.Create(Self);
    NewTabSheet.Tag:=Length(FTPs);
    NewTabSheet.PageControl:=RzPageControl2;
    NewTabSheet.Caption:=NotConnected;
    SetLength(FTPs, Length(FTPs) + 1);
    VisibleCount:=0;
    for i:=0 to RzPageControl2.PageCount - 1 do
    if RzPageControl2.Pages[i].TabVisible then
    VisibleCount:=VisibleCount + 1;
    RzPageControl2.TabIndex:=VisibleCount - 1;
    FTPs[RzPageControl2.ActivePage.Tag]:=TCurrentFTP.CreateParented(NewTabSheet.Handle);
    FTPs[RzPageControl2.ActivePage.Tag].Parent:=NewTabSheet;
    FTPs[RzPageControl2.ActivePage.Tag].ParentWindow:=NewTabSheet.Handle;
    FTPs[RzPageControl2.ActivePage.Tag].Align:=alClient;
    FTPs[RzPageControl2.ActivePage.Tag].Show;
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Host:=Server.Text;
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Port:=Port.IntValue;
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Username:=UserName.Text;
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Password:=Password.Text;
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Connect;
    with FTPs[RzPageControl2.ActivePage.Tag] do
    begin
      Label5.Caption:=CurrentFTP.Label5.Caption;
      Files.Columns.Assign(CurrentFTP.Files.Columns);
      Tasks.Columns.Assign(CurrentFTP.Tasks.Columns);
    end;
  end
  else
  begin
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Host:=Server.Text;
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Port:=Port.IntValue;
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Username:=UserName.Text;
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Password:=Password.Text;
    FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Connect;
  end;
end;

procedure TLynxFTPForm.N3Click(Sender: TObject);
begin
  RzToolbarButton1Click(Sender);
end;

procedure TLynxFTPForm.N23Click(Sender: TObject);
begin
  try
    FTPs[RzPageControl2.Pages[RzPageControl2.TabIndex].Tag].IdFTP1.Disconnect;
  except

  end;
end;

procedure TLynxFTPForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  i: Integer;
begin
  CurrentFTP.Free;
  for i:=0 to Length(FTPs) - 1 do
  begin
    try                      
      if FTPs[i].IdFTP1.Connected then
      FTPs[i].IdFTP1.Abort;
      if FTPs[i].IdFTP1.Connected then
      FTPs[i].IdFTP1.Disconnect;
      FTPs[i].Free;
    except
    end;
  end;
  SetLength(FTPs, 0);
  RzPageControl2.ParentWindow:=Handle;
end;

procedure TLynxFTPForm.SaveServer(Serv, Prt, User, Pass: String);
var
  f: TextFile;
begin
  AssignFile(f, ExtractFilePath(Application.ExeName) + 'Favourites.lynxftpfav');
  if not FileExists(ExtractFilePath(Application.ExeName) + 'Favourites.lynxftpfav') then
  Rewrite(f)
  else
  Append(f);
  Writeln(f, Encrypt(Serv, 13));
  Writeln(f, Encrypt(Prt, 6));
  Writeln(f, Encrypt(User, 25));
  Writeln(f, Encrypt(Pass, 13631));
  CloseFile(f);
  GetFavourites;
end;

procedure TLynxFTPForm.N2Click(Sender: TObject);
begin
  if (Server.Text = '') or (Port.Text = '') or (UserName.Text = '') or (Password.Text = '') then
  begin
    Application.MessageBox(PChar(FieldsAreFilledIncorrectly), PChar(ErrorMessage), MB_ICONERROR or MB_OK);
    Exit;
  end;
  SaveServer(Server.Text, Port.Text, UserName.Text, Password.Text);
end;

procedure TLynxFTPForm.FormCreate(Sender: TObject);
begin
  GetFavourites;
  CurrentFTP:=TCurrentFTP.Create(Application);
  SetLength(FTPs, 1);
  FTPs[0]:=TCurrentFTP.CreateParented(TabSheet3.Handle);
  FTPs[0].Parent:=TabSheet3;
  FTPs[0].Align:=alClient;
  FTPs[0].Show;
  with FTPs[0] do
  begin
    Label5.Caption:=CurrentFTP.Label5.Caption;
    Files.Columns.Assign(CurrentFTP.Files.Columns);
    Tasks.Columns.Assign(CurrentFTP.Tasks.Columns);
  end;
  with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Settings.ini') do
  begin
    Panel1.Visible:=ReadBool('Main', 'ShowToolBar', True);
    case ReadInteger('Main', 'TabPos', 0) of
      0: RzPageControl2.TabOrientation:=toTop;
      1: RzPageControl2.TabOrientation:=toBottom;
      2: RzPageControl2.TabOrientation:=toRight;
      3: RzPageControl2.TabOrientation:=toLeft;
    end;
    if ReadString('Main', 'Language', 'Русский') <> 'Русский' then
    if FileExists(ExtractFilePath(Application.ExeName) + 'Languages\' + ReadString('Main', 'Language', 'Русский') + '.lynxlang') then
    LoadLanguage(ReadString('Main', 'Language', 'Русский'));    
    Free;
  end;
end;

procedure TLynxFTPForm.GetFavourites;
var
  f: TextFile;
  tmp: TFTPFavourite;
begin
  SetLength(Favourites, 0);
  Server.Items.Clear;
  if not FileExists(ExtractFilePath(Application.ExeName) + 'Favourites.lynxftpfav') then
  Exit;
  AssignFile(f, ExtractFilePath(Application.ExeName) + 'Favourites.lynxftpfav');
  Reset(f);
  while not Eof(f) do
  try
    Readln(f, tmp.Serv);
    Readln(f, tmp.Prt);
    Readln(f, tmp.User);
    Readln(f, tmp.Pass);
    Server.Items.Add(Decrypt(tmp.Serv, 13));
    SetLength(Favourites, Length(Favourites) + 1);
    Favourites[Length(Favourites) - 1]:=tmp;
  except

  end;
  CloseFile(f);
  Server.Items.Add(FavouritesItem{'Избранное...'});
end;

procedure TLynxFTPForm.ServerSelect(Sender: TObject);
begin
  if Server.ItemIndex = -1 then
  begin
    Server.Text:='';
    Port.Text:='21';
    UserName.Text:='';
    Password.Text:='';
    Exit;
  end;
  if (Server.ItemIndex = Server.Items.Count - 1) and (Server.Items.Count > 0) then
  begin
    Server.ItemIndex:=-1;
    ServerSelect(Sender);
    FavouritesSettings.ShowModal;
  end
  else
  begin
    Server.Text:=Decrypt(Favourites[Server.ItemIndex].Serv, 13);
    Port.Text:=Decrypt(Favourites[Server.ItemIndex].Prt, 6);
    UserName.Text:=Decrypt(Favourites[Server.ItemIndex].User, 25);
    Password.Text:=Decrypt(Favourites[Server.ItemIndex].Pass, 13631);
  end;
end;

procedure TLynxFTPForm.MainMenu1Change(Sender: TObject; Source: TMenuItem;
  Rebuild: Boolean);
begin
  if Length(FTPs) = 0 then
  Exit;
  if FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Connected then
  begin
    N3.Enabled:=False;
    N23.Enabled:=True;
    //RzPageControl2.ActivePage.Caption:=FTPs[RzPageControl2.Pages[RzPageControl2.TabIndex].Tag].IdFTP1.Username + '@' + FTPs[RzPageControl2.Pages[RzPageControl2.TabIndex].Tag].IdFTP1.Host;
  end
  else
  begin
    N3.Enabled:=True;
    N23.Enabled:=False;
  end;
end;

procedure TLynxFTPForm.N24Click(Sender: TObject);
begin
  if RzPageControl2.PageCount = 1 then
  Exit;                    
  if FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Connected then
  FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Abort;
  if FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Connected then
  FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Disconnect;
  FTPs[RzPageControl2.ActivePage.Tag].Hide;
  RzPageControl2.Pages[RzPageControl2.ActivePage.PageIndex].TabVisible:=False;
  RzPageControl2.TabIndex:=0;
end;

procedure TLynxFTPForm.N5Click(Sender: TObject);
begin
  if FTPs[RzPageControl2.ActivePage.Tag].Files.ItemIndex <> -1 then
  if FTPs[RzPageControl2.ActivePage.Tag].Files.Selected.SubItems.Strings[0] <> DirectoryCaption then 
  FTPs[RzPageControl2.ActivePage.Tag].DownloadFile(FTPs[RzPageControl2.ActivePage.Tag].Files.Selected.Caption{, FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.RetrieveCurrentDir});
end;

procedure TLynxFTPForm.FavouritesButtonClick(Sender: TObject);
begin
  FavouritesSettings.ShowModal;
end;

procedure TLynxFTPForm.N21Click(Sender: TObject);
begin
  AboutLynx.ShowModal;
end;

procedure TLynxFTPForm.N18Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://aidar.3dn.ru/', '', '', SW_SHOW);
end;

procedure TLynxFTPForm.N19Click(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://aidar.3dn.ru/forum/14-57-1', '', '', SW_SHOW);
end;

procedure TLynxFTPForm.N7Click(Sender: TObject);
begin
  FTPs[RzPageControl2.ActivePage.Tag].DeleteFTPFileClick(Sender);
end;

procedure TLynxFTPForm.N28Click(Sender: TObject);
begin
  FTPs[RzPageControl2.ActivePage.Tag].CreateFTPDirClick(Sender);
end;

procedure TLynxFTPForm.N26Click(Sender: TObject);
begin
  BugReportForm.ErrorMessage.Lines.Text:='';     
  BugReportForm.Comment.Lines.Text:='';
  BugReportForm.ShowModal;
end;

procedure TLynxFTPForm.N6Click(Sender: TObject);
begin
  if FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.Connected then
  if OpenDialog1.Execute then
  if FileExists(OpenDialog1.FileName) then
  FTPs[RzPageControl2.ActivePage.Tag].UploadFile(OpenDialog1.FileName);
end;

procedure TLynxFTPForm.UploadButtonClick(Sender: TObject);
begin
  N6Click(Sender);
end;

procedure TLynxFTPForm.DownloadButtonClick(Sender: TObject);
begin
  N5Click(Sender);
end;

procedure TLynxFTPForm.AttributesButtonClick(Sender: TObject);
begin
  N9Click(Sender);
end;

procedure TLynxFTPForm.N9Click(Sender: TObject);
var
  Attr: TFileAttributesForm;
  i, Index: Integer;
begin
  Index:=-1;
  if FTPs[RzPageControl2.ActivePage.Tag].Files.ItemIndex = -1 then
  Exit;
  Attr:=TFileAttributesForm.Create(Application);
  for i:=0 to FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.DirectoryListing.Count - 1 do
  if FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.DirectoryListing.Items[i].FileName = FTPs[RzPageControl2.ActivePage.Tag].Files.Selected.Caption then
  Index:=i;
  Attr.Caption:=FileAttributesForm.Caption;
  Attr.RzGroupBox1.Caption:=FileAttributesForm.RzGroupBox1.Caption;
  Attr.RzGroupBox2.Caption:=FileAttributesForm.RzGroupBox2.Caption;
  Attr.RzGroupBox3.Caption:=FileAttributesForm.RzGroupBox3.Caption;
  Attr.CheckBox1.Caption:=FileAttributesForm.CheckBox1.Caption;
  Attr.CheckBox4.Caption:=FileAttributesForm.CheckBox4.Caption;
  Attr.CheckBox7.Caption:=FileAttributesForm.CheckBox7.Caption;
  Attr.CheckBox2.Caption:=FileAttributesForm.CheckBox2.Caption;
  Attr.CheckBox5.Caption:=FileAttributesForm.CheckBox5.Caption;
  Attr.CheckBox8.Caption:=FileAttributesForm.CheckBox8.Caption;
  Attr.CheckBox3.Caption:=FileAttributesForm.CheckBox3.Caption;
  Attr.CheckBox6.Caption:=FileAttributesForm.CheckBox6.Caption;
  Attr.CheckBox9.Caption:=FileAttributesForm.CheckBox9.Caption;
  Attr.Button1.Caption:=FileAttributesForm.Button1.Caption;
  Attr.Button2.Caption:=FileAttributesForm.Button2.Caption;
  Attr.ExtractAttribetes(FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.DirectoryListing.Items[Index].OwnerPermissions, FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.DirectoryListing.Items[Index].GroupPermissions, FTPs[RzPageControl2.ActivePage.Tag].IdFTP1.DirectoryListing.Items[Index].UserPermissions);
  Attr.FIdFTP:=@FTPs[RzPageControl2.ActivePage.Tag].IdFTP1;
  Attr.FName:=FTPs[RzPageControl2.ActivePage.Tag].Files.Selected.Caption;
  Attr.ShowModal;
  Attr.Free;
end;

procedure TLynxFTPForm.N11Click(Sender: TObject);
begin
  SettingsForm.RzGroup1Items0Click(Sender);
  SettingsForm.ShowModal;
end;

procedure TLynxFTPForm.N12Click(Sender: TObject);
begin
  SettingsForm.RzGroup1Items1Click(Sender);
  SettingsForm.ShowModal;
end;

procedure TLynxFTPForm.SettingsButtonClick(Sender: TObject);
begin
  SettingsForm.RzGroup1Items0Click(Sender);
  SettingsForm.ShowModal;
end;

procedure TLynxFTPForm.AboutButtonClick(Sender: TObject);
begin
  AboutLynx.ShowModal;
end;

procedure TLynxFTPForm.OnExceptions(Sender: TObject; E: Exception);
begin
  BugReportForm.ErrorMessage.Lines.Text:=E.Message;
  BugReportForm.Comment.Lines.Text:='';
  BugReportForm.ShowModal;
end;

procedure TLynxFTPForm.N22Click(Sender: TObject);
begin
  if Sender.ClassName = 'TMenuItem'  then
  begin
    with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Settings.ini') do
    begin
      if Pos('&', TMenuItem(Sender).Caption) <> 0 then
      WriteString('Main', 'Language', Copy(TMenuItem(Sender).Caption, 2, Length(TMenuItem(Sender).Caption) - 1))
      else
      WriteString('Main', 'Language', TMenuItem(Sender).Caption);
      Free;
    end;
  end
  else
  begin
    with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Settings.ini') do
    begin
      if Pos('&', TRzGroupItem(Sender).Caption) <> 0 then
      WriteString('Main', 'Language', Copy(TRzGroupItem(Sender).Caption, 2, Length(TMenuItem(Sender).Caption) - 1))
      else
      WriteString('Main', 'Language', TRzGroupItem(Sender).Caption);
      Free;
    end;
  end;
  Application.MessageBox(PChar(ChangesWill), 'Lynx - FTP Client', MB_ICONINFORMATION);
end;

procedure TLynxFTPForm.LoadLanguage(Language: String);
begin
  if not FileExists(ExtractFilePath(Application.ExeName) + 'Languages\' + Language + '.lynxlang') then
  Exit;
  LanguageXML.XML.Clear;
  LanguageXML.LoadFromFile(ExtractFilePath(Application.ExeName) + 'Languages\' + Language + '.lynxlang');
  LanguageXML.Active:=True;
  if LanguageXML.ChildNodes.Nodes['LynxLanguage'].Attributes['Programm'] <> 'LynxFTPClient' then
  Exit;
  with LanguageXML.ChildNodes.Nodes['LynxLanguage'].ChildNodes do
  begin
    with Nodes['MainMenu'].ChildNodes do
    begin
      with Nodes['Server'] do
      begin
        N1.Caption:=Attributes['Caption'];
        N2.Caption:=ChildNodes.Nodes['AddToFavourites'].Text;
        N3.Caption:=ChildNodes.Nodes['Connect'].Text;
        N23.Caption:=ChildNodes.Nodes['Disconnect'].Text;
        N24.Caption:=ChildNodes.Nodes['CloseTab'].Text;
      end;
      with Nodes['File'] do
      begin
        N4.Caption:=Attributes['Caption'];
        N5.Caption:=ChildNodes.Nodes['Download'].Text;
        N6.Caption:=ChildNodes.Nodes['Upload'].Text;
        N28.Caption:=ChildNodes.Nodes['NewFolder'].Text;
        N7.Caption:=ChildNodes.Nodes['Delete'].Text;
        N9.Caption:=ChildNodes.Nodes['Attributes'].Text;
      end;
      with Nodes['Settings'] do
      begin
        N10.Caption:=Attributes['Caption'];
        N11.Caption:=ChildNodes.Nodes['Main'].Text;
        N12.Caption:=ChildNodes.Nodes['Connection'].Text;
        N14.Caption:=ChildNodes.Nodes['Language'].Text;
      end;
      with Nodes['Help'] do
      begin
        N15.Caption:=Attributes['Caption'];
        //N16.Caption:=ChildNodes.Nodes['Help'].Text;
        N18.Caption:=ChildNodes.Nodes['GoToSite'].Text;
        N19.Caption:=ChildNodes.Nodes['GoToForum'].Text;
        N25.Caption:=ChildNodes.Nodes['CheckUpdates'].Text;
        N26.Caption:=ChildNodes.Nodes['Report'].Text;
        N21.Caption:=ChildNodes.Nodes['About'].Text;
      end;
    end;
    with Nodes['Labels'].ChildNodes do
    begin
      NotConnected:=Nodes['NotConnected'].Text;    
      FavouritesItem:=Nodes['Favourites'].Text;
      DirectoryCaption:=Nodes['Folder'].Text;
      User:=Nodes['User'].Text;
      Author:=Nodes['Author'].Text;
      VersionCaption:=Nodes['Version'].Text;
      BuildCaption:=Nodes['Build'].Text;
      MemoryCaption:=Nodes['Memory'].Text;
      Completed:=Nodes['Completed'].Text;
      UploadingCaption:=Nodes['Uploading'].Text;
      DownloadingCaption:=Nodes['Downloading'].Text;
      BytesCaption:=Nodes['Bytes'].Text;
      FileCaption:=Nodes['File'].Text;
      Label1.Caption:=Nodes['Server'].Text;
      Label2.Caption:=Nodes['Port'].Text;
      Label3.Caption:=Nodes['UserName'].Text;
      Nodes['Password'].Text;
      AboutLynx.Caption:=Nodes['About'].Text;
      with Nodes['BugReportLabels'].ChildNodes do
      begin
        BugReportForm.Caption:=Nodes['Caption'].Text;
        BugReportForm.RzGroupBox1.Caption:=Nodes['AdditionalInformation'].Text;
        BugReportForm.Label1.Caption:=Nodes['YourName'].Text;
        BugReportForm.Label2.Caption:=Nodes['Email'].Text;
        BugReportForm.Caption:=Nodes['Comment'].Text;
        BugReportForm.Button1.Caption:=Nodes['SendReport'].Text;
        BugReportForm.Button2.Caption:=Nodes['Cancel'].Text;
      end;
      with Nodes['FTPLabels'].ChildNodes do
      begin
        CurrentFTP.Label5.Caption:=Nodes['CurrentFolder'].Text;
        CurrentFTP.Files.Column[0].Caption:=Nodes['FileFolder'].Text;
        CurrentFTP.Files.Column[1].Caption:=Nodes['FileType'].Text;
        CurrentFTP.Files.Column[2].Caption:=Nodes['FileSize'].Text;
        CurrentFTP.Files.Column[3].Caption:=Nodes['FileChanged'].Text;
        CurrentFTP.Files.Column[4].Caption:=Nodes['Attributes'].Text;
        CurrentFTP.Tasks.Column[0].Caption:=Nodes['Operation'].Text;
        CurrentFTP.Tasks.Column[1].Caption:=Nodes['FileName'].Text;
        CurrentFTP.Tasks.Column[2].Caption:=Nodes['State'].Text;
      end;
      with Nodes['FavouritesLabels'].ChildNodes do
      begin
        FavouritesSettings.Caption:=Nodes['Caption'].Text;
        FavouritesSettings.Label1.Caption:=Nodes['ServerList'].Text;
        FavouritesSettings.Label2.Caption:=Nodes['Server'].Text;
        FavouritesSettings.Label3.Caption:=Nodes['Port'].Text;
        FavouritesSettings.Label4.Caption:=Nodes['UserName'].Text;
        FavouritesSettings.Label5.Caption:=Nodes['Password'].Text;
        FavouritesSettings.Button1.Caption:=Nodes['OK'].Text;
        FavouritesSettings.Button2.Caption:=Nodes['Cancel'].Text;
        FavouritesSettings.Button3.Caption:=Nodes['Delete'].Text;
      end;
      with Nodes['AttributesLabels'].ChildNodes do
      begin
        FileAttributesForm.Caption:=Nodes['Caption'].Text;
        FileAttributesForm.RzGroupBox1.Caption:=Nodes['Owner'].Text;
        FileAttributesForm.RzGroupBox2.Caption:=Nodes['Group'].Text;
        FileAttributesForm.RzGroupBox3.Caption:=Nodes['User'].Text;
        FileAttributesForm.CheckBox1.Caption:=Nodes['Read'].Text;
        FileAttributesForm.CheckBox4.Caption:=Nodes['Read'].Text;
        FileAttributesForm.CheckBox7.Caption:=Nodes['Read'].Text; 
        FileAttributesForm.CheckBox2.Caption:=Nodes['Write'].Text;
        FileAttributesForm.CheckBox5.Caption:=Nodes['Write'].Text;
        FileAttributesForm.CheckBox8.Caption:=Nodes['Write'].Text;
        FileAttributesForm.CheckBox3.Caption:=Nodes['Execute'].Text;
        FileAttributesForm.CheckBox6.Caption:=Nodes['Execute'].Text;
        FileAttributesForm.CheckBox9.Caption:=Nodes['Execute'].Text;
        FileAttributesForm.Button1.Caption:=Nodes['OK'].Text;
        FileAttributesForm.Button2.Caption:=Nodes['Cancel'].Text;
      end;
      with Nodes['SettingsLabels'].ChildNodes do
      begin
        SettingsForm.Caption:=Nodes['Caption'].Text;
        SettingsForm.RzGroup1.Caption:=Nodes['Settings'].Text;
        SettingsForm.RzGroup2.Caption:=Nodes['Language'].Text;
        SettingsForm.RzGroup1.Items.Items[0].Caption:=Nodes['Main'].Text;
        SettingsForm.RzGroup1.Items.Items[1].Caption:=Nodes['Connection'].Text;
        SettingsForm.RzGroupBox1.Caption:=Nodes['Main'].Text;
        SettingsForm.RzGroupBox2.Caption:=Nodes['Connection'].Text;
        SettingsForm.CheckBox1.Caption:=Nodes['UseProxy'].Text;
        SettingsForm.Label1.Caption:=Nodes['Server'].Text;
        SettingsForm.Label2.Caption:=Nodes['Port'].Text;
        SettingsForm.Label3.Caption:=Nodes['UserName'].Text;
        SettingsForm.Label4.Caption:=Nodes['Password'].Text;
        SettingsForm.ComboBox1.Items.Strings[0]:=Nodes['HTTPFTP'].Text; 
        SettingsForm.ComboBox1.Items.Strings[1]:=Nodes['Site'].Text;
        SettingsForm.ComboBox1.Items.Strings[2]:=Nodes['Invisible'].Text;
        SettingsForm.ComboBox1.Items.Strings[3]:=Nodes['Autorization'].Text;
        SettingsForm.ComboBox2.Items.Strings[0]:=Nodes['Top'].Text;        
        SettingsForm.ComboBox2.Items.Strings[1]:=Nodes['Bottom'].Text;
        SettingsForm.ComboBox2.Items.Strings[2]:=Nodes['Right'].Text;
        SettingsForm.ComboBox2.Items.Strings[3]:=Nodes['Left'].Text;
        SettingsForm.Label5.Caption:=Nodes['Tabs'].Text;
        SettingsForm.CheckBox2.Caption:=Nodes['ToolBar'].Text;
      end;
    end;
    with Nodes['Messages'].ChildNodes do
    begin
      FieldsAreFilledIncorrectly:=Nodes['FieldsAreFilledIncorrectly'].Text;
      ErrorMessage:=Nodes['ErrorMessage'].Text;
      ChangesWill:=Nodes['Changes'].Text;
      WaitCaption:=Nodes['Wait'].Text;
      EnterNewFolder:=Nodes['EnterNewFolderName'].Text;
      ContinueUploading:=Nodes['ContinueUpload'].Text;
      ContinueDownloading:=Nodes['ContinueDownload'].Text;
      CheckInternetConnection:=Nodes['CheckInternet'].Text;
      NewFolderCaption:=Nodes['NewFolder'].Text;
    end;
  end;
end;

procedure TLynxFTPForm.GetLanguages;
var
  SR: TSearchRec;
  LanguageMenuItem: TMenuItem;
begin
  if FindFirst(ExtractFilePath(Application.ExeName) + 'Languages\*.lynxlang', faAnyFile, SR) = 0 then
  repeat
    LanguageMenuItem:=TMenuItem.Create(N22);
    LanguageMenuItem.Caption:=Copy(SR.Name, 1, Pos('.', SR.Name) - 1);
    LanguageMenuItem.OnClick:=N22Click;
    LanguageMenuItem.RadioItem:=True;
    N14.Add(LanguageMenuItem);
    with SettingsForm.RzGroup2.Items.Add do
    begin
      Caption:=Copy(SR.Name, 1, Pos('.', SR.Name) - 1);
      OnClick:=N22Click;
    end;
  until FindNext(SR) <> 0;
end;

procedure TLynxFTPForm.FormShow(Sender: TObject);
begin
  GetLanguages;
end;

end.
