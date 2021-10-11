unit FTPContainer;

interface

uses
  SysUtils, Classes, Controls, Forms,
  ComCtrls, StdCtrls, ExtCtrls, 
  IdFTP, IdComponent, 
  ImgList, Graphics, Windows, ShellAPI, IdFTPList, 
  IdLogEvent, RzEdit, RzTabs, IdFTPCommon, RzButton, Dialogs,
  DragDropFile, DropTarget, DragDrop, DropSource, IdTCPConnection,
  IdTCPClient, IdBaseComponent, IdIntercept, IdLogBase, Buttons;

type
  TCurrentFTP = class(TForm)
    Panel4: TPanel;
    Label5: TLabel;
    CurrentFTPDir: TEdit;
    Files: TListView;
    Icons: TImageList;
    IdLogEvent1: TIdLogEvent;
    DownloadFTP: TIdFTP;
    UploadFTP: TIdFTP;
    CreateFTPDir: TRzToolbarButton;
    UpFolder: TRzToolbarButton;
    DeleteFTPFile: TRzToolbarButton;
    DisconnectFTP: TRzToolbarButton;
    DropFileSource1: TDropFileSource;
    DropFileTarget1: TDropFileTarget;
    Panel1: TPanel;
    Log: TRzMemo;
    Tasks: TListView;
    IdFTP1: TIdFTP;
    procedure IdLogEvent1Received(ASender: TComponent; const AText,
      AData: String);
    procedure IdLogEvent1Sent(ASender: TComponent; const AText,
      AData: String);
    procedure IdFTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure CurrentFTPDirKeyPress(Sender: TObject; var Key: Char);
    procedure IdFTP1AfterClientLogin(Sender: TObject);
    procedure IdFTP1Connected(Sender: TObject);
    procedure IdFTP1Disconnected(Sender: TObject);
    procedure FilesCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FilesDblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DownloadFTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure DownloadFTPWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure DownloadFTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure CreateFTPDirClick(Sender: TObject);
    procedure UpFolderClick(Sender: TObject);
    procedure DeleteFTPFileClick(Sender: TObject);
    procedure DisconnectFTPClick(Sender: TObject);
    procedure DropFileTarget1Drop(Sender: TObject; ShiftState: TShiftState;
      APoint: TPoint; var Effect: Integer);
    procedure UploadFTPWorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure UploadFTPWork(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCount: Integer);
    procedure UploadFTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure FormResize(Sender: TObject);
    procedure FilesEdited(Sender: TObject; Item: TListItem; var S: String);
  private
    Downloading: Boolean;
    Uploading: Boolean;
    //DownloadingFileNames: TStringList;
    //UploadingFileNames: TStringList;
    DownloadingFileName: String;
    UploadingFileName: String;
    //DownloadIndex: Integer;
    //UploadIndex: Integer;
  public
    procedure OpenDir(Dir: String);
    procedure DownloadFile(FN: String{; FTPDir: String});
    procedure UploadFile(FN: String);
  end;

var
  CurrentFTP: TCurrentFTP;

implementation

uses FTPMainForm, IniFiles, uEncrypt;

{$R *.dfm}

{ TCurrentFTP }

procedure TCurrentFTP.OpenDir(Dir: String);
function GetIcon(FN: String; IsDir: Boolean): TIcon;
var
  f: file;
  IconIndex: Word;
begin
  Result:=TIcon.Create;
  if IsDir then
  begin
    IconIndex:=0;
    CreateDir(ExtractFilePath(Application.ExeName) + 'temp\');
    Result.Handle:=ExtractAssociatedIcon(HInstance, PChar(ExtractFilePath(Application.ExeName) + 'temp\'), IconIndex);
    RemoveDir(ExtractFilePath(Application.ExeName) + 'temp\');
  end
  else
  begin
    IconIndex:=0;
    AssignFile(f, 'temp' + ExtractFileExt(FN));
    Rewrite(f);
    CloseFile(f);
    Result.Handle:=ExtractAssociatedIcon(HInstance, PChar('temp' + ExtractFileExt(FN)), IconIndex);
    DeleteFile(PChar('temp' + ExtractFileExt(FN)));
  end;
end;
var
  FL: TStringList;
  i: Integer;
begin
  if not IdFTP1.Connected then
  Exit;
  Files.Clear;
  FL:=TStringList.Create;
  try
    IdFTP1.ChangeDir(Dir);
    IdFTP1.List(FL);
    CurrentFTPDir.Text:=IdFTP1.RetrieveCurrentDir;
    Files.Items.BeginUpdate;
    for i:=0 to FL.Count - 1 do
    with Files.Items.Add do
    begin
      if IdFTP1.DirectoryListing.Items[i].ItemType = ditDirectory then
      ImageIndex:=Icons.AddIcon(GetIcon('', True))
      else
      ImageIndex:=Icons.AddIcon(GetIcon(IdFTP1.DirectoryListing.Items[i].FileName, False));
      Caption:=IdFTP1.DirectoryListing.Items[i].FileName;
      if IdFTP1.DirectoryListing.Items[i].ItemType = ditDirectory then
      SubItems.Add(DirectoryCaption)
      else
      SubItems.Add(FileCaption + ' ' + ExtractFileExt(IdFTP1.DirectoryListing.Items[i].FileName));
      if IdFTP1.DirectoryListing.Items[i].ItemType = ditDirectory then
      SubItems.Add('')
      else
      SubItems.Add(IntToStr(IdFTP1.DirectoryListing.Items[i].Size));
      SubItems.Add(DateTimeToStr(IdFTP1.DirectoryListing.Items[i].ModifiedDate));
      SubItems.Add(IdFTP1.DirectoryListing.Items[i].OwnerPermissions + IdFTP1.DirectoryListing.Items[i].GroupPermissions + IdFTP1.DirectoryListing.Items[i].UserPermissions);
    end;
    Files.Items.EndUpdate;
  finally
    FL.Free;
  end;
end;

procedure TCurrentFTP.IdLogEvent1Received(ASender: TComponent; const AText,
  AData: String);
var
  ResultData: String;
begin
  if AData = '' then
  Exit;
  ResultData:=AData;
  ResultData:=StringReplace(ResultData, #10#13, #0, [rfReplaceAll, rfIgnoreCase]);
  if Pos('PASS', AData) = 1 then
  ResultData:='PASS ' + StringOfChar('*', Length(AData) - 5);
  Log.Lines.Add(ResultData);
end;

procedure TCurrentFTP.IdLogEvent1Sent(ASender: TComponent; const AText,
  AData: String);
var
  ResultData: String;
begin
  if AData = '' then
  Exit;
  ResultData:=AData;
  ResultData:=StringReplace(ResultData, #$D#$A, #0, [rfReplaceAll, rfIgnoreCase]);
  if Pos('PASS', AData) = 1 then
  ResultData:='PASS ' + StringOfChar('*', Length(AData) - 5);
  Log.Lines.Add(ResultData);
end;

procedure TCurrentFTP.IdFTP1Status(ASender: TObject;
  const AStatus: TIdStatus; const AStatusText: String);
begin
  Log.Lines.Add(AStatusText);
end;

procedure TCurrentFTP.CurrentFTPDirKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  OpenDir(CurrentFTPDir.Text);
end;

procedure TCurrentFTP.IdFTP1AfterClientLogin(Sender: TObject);
begin
  OpenDir('/');
end;

procedure TCurrentFTP.IdFTP1Connected(Sender: TObject);
begin
  if IdFTP1.Connected then
  begin
    LynxFTPForm.N3.Enabled:=False;
    LynxFTPForm.N23.Enabled:=True;
    TRzTabSheet(Parent).Caption:=IdFTP1.Username + '@' + IdFTP1.Host;
  end
  else
  begin
    LynxFTPForm.N3.Enabled:=True;
    LynxFTPForm.N23.Enabled:=False;
  end;
end;

procedure TCurrentFTP.IdFTP1Disconnected(Sender: TObject);
begin
  if IdFTP1.Connected then
  begin
    LynxFTPForm.N3.Enabled:=False;
    LynxFTPForm.N23.Enabled:=True;
  end
  else
  begin
    LynxFTPForm.N3.Enabled:=True;
    LynxFTPForm.N23.Enabled:=False;
    Downloading:=False;
    Uploading:=False;
    Files.Clear;      
    TRzTabSheet(Parent).Caption:=NotConnected;
  end;
end;

procedure TCurrentFTP.FilesCompare(Sender: TObject; Item1,
  Item2: TListItem; Data: Integer; var Compare: Integer);
begin
  if (Item1.SubItems.Strings[0] = DirectoryCaption) and (Item2.SubItems.Strings[0] <> DirectoryCaption) then
  Compare:=-1
  else
  if (Item2.SubItems.Strings[0] = DirectoryCaption) and (Item1.SubItems.Strings[0] <> DirectoryCaption) then
  Compare:=1
  else
  Compare:=0;
end;

procedure TCurrentFTP.FilesDblClick(Sender: TObject);
begin
  if Files.ItemIndex = -1 then
  Exit;
  if Files.Selected.SubItems.Strings[0] = 'Папка' then
  begin
    if Pos('/', IdFTP1.RetrieveCurrentDir) = Length(IdFTP1.RetrieveCurrentDir) then
    OpenDir(IdFTP1.RetrieveCurrentDir + Files.Selected.Caption)
    else
    OpenDir(IdFTP1.RetrieveCurrentDir + '/' + Files.Selected.Caption);
  end
  else
  DownloadFile(Files.Selected.Caption);
end;

procedure TCurrentFTP.DownloadFile(FN: String{; FTPDir: String});
var
  f: TFileStream;
begin        
  if not IdFTP1.Connected then Exit;
  DownloadingFileName:=FN;//s.AddObject(FN, Pointer(PChar(FTPDir)));
  if Downloading then
  begin
    Application.MessageBox(PChar(WaitCaption), 'Lynx - FTP Client', MB_ICONINFORMATION);
    Exit;
  end;
  {if Uploading then
  begin
    Uploading.AddObject(FN, Pointer(PChar(DownloadFTP.RetrieveCurrentDir)));
    Exit;
  end;}
  try
    if DownloadFTP.Connected then
    DownloadFTP.Disconnect;
    DownloadFTP.Host:=IdFTP1.Host;
    DownloadFTP.Port:=IdFTP1.Port;
    DownloadFTP.Username:=IdFTP1.Username;
    DownloadFTP.Password:=IdFTP1.Password;
    DownloadFTP.Passive:=True;
    DownloadFTP.TransferType:=ftBinary;
    DownloadFTP.Connect;
    DownloadFTP.ChangeDir(IdFTP1.RetrieveCurrentDir);
    Downloading:=True;
    if FileExists(ExtractFilePath(Application.ExeName) + 'Downloads\' + FN) then
    begin
      f:=TFileStream.Create(ExtractFilePath(Application.ExeName) + 'Downloads\' + FN, fmOpenWrite);
      DownloadFTP.Get(FN, f, Application.MessageBox(PChar(ContinueDownloading), 'Lynx - FTP Client', MB_YESNO) = mrYes);
    end
    else
    begin
      f:=TFileStream.Create(ExtractFilePath(Application.ExeName) + 'Downloads\' + FN, fmCreate);
      DownloadFTP.Get(FN, f);
    end;
  finally
    Downloading:=False;
    f.Free;
    DownloadFTP.Disconnect;
  end;
end;

procedure TCurrentFTP.FormCreate(Sender: TObject);
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Settings.ini') do
  begin
    if ReadBool('Connection', 'UseProxy', False) then
    begin
      case ReadInteger('Connection', 'ProxyType', 0) of
      0: IdFTP1.ProxySettings.ProxyType:=fpcmHttpProxyWithFtp;
      1: IdFTP1.ProxySettings.ProxyType:=fpcmSite;
      2: IdFTP1.ProxySettings.ProxyType:=fpcmTransparent;
      3: IdFTP1.ProxySettings.ProxyType:=fpcmUserPass;
      end;
      IdFTP1.ProxySettings.Host:=ReadString('Connection', 'Host', '');
      IdFTP1.ProxySettings.Port:=ReadInteger('Connection', 'Port', 0);
      IdFTP1.ProxySettings.UserName:=ReadString('Connection', 'Username', '');
      IdFTP1.ProxySettings.Password:=Decrypt(ReadString('Connection', 'Password', ''), 3);
    end;
    Free;
  end;
  Downloading:=False;
  Uploading:=False;
  DragAcceptFiles(Files.Handle, True);
end;

procedure TCurrentFTP.FormDestroy(Sender: TObject);
begin      
  DragAcceptFiles(Files.Handle, True);
end;

procedure TCurrentFTP.DownloadFTPWorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  if not Downloading then
  Exit;
  //if RzPageControl1.Pages[0].TabVisible and RzPageControl1.Pages[1].TabVisible then
  //RzPageControl1.TabIndex:=1;
  with Tasks.Items.Insert(0) do
  begin
    Caption:=DownloadingCaption;
    SubItems.Add(DownloadingFileName);
    SubItems.Add('0 байт');
  end;
end;

procedure TCurrentFTP.DownloadFTPWork(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCount: Integer);
begin
  if not Downloading then
  Exit;
  if Tasks.Items.Item[0].Caption = DownloadingCaption then
  Tasks.Items.Item[0].SubItems.Strings[1]:=IntToStr(AWorkCount) + ' байт'
  else
  Tasks.Items.Item[1].SubItems.Strings[1]:=IntToStr(AWorkCount) + ' байт'
end;

procedure TCurrentFTP.DownloadFTPWorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  if not Downloading then
  Exit;
  //if RzPageControl1.Pages[0].TabVisible and RzPageControl1.Pages[1].TabVisible then
  //RzPageControl1.TabIndex:=1;
  if Tasks.Items.Item[0].Caption = DownloadingCaption then
  Tasks.Items.Item[0].SubItems.Strings[1]:=Completed
  else
  Tasks.Items.Item[1].SubItems.Strings[1]:=Completed;
end;

procedure TCurrentFTP.UploadFile(FN: String);
var
  Tmp: TStringList;
  i: Integer;
  FTPFileExists: Boolean;
begin
  if not IdFTP1.Connected then Exit;
  UploadingFileName:=FN;//s.AddObject(FN, Pointer(PChar(FTPDir)));
  if Downloading then
  begin
    Application.MessageBox(PChar(WaitCaption), 'Lynx - FTP Client', MB_ICONINFORMATION);
    Exit;
  end;
  {if Uploading then
  begin
    Uploading.AddObject(FN, Pointer(PChar(DownloadFTP.RetrieveCurrentDir)));
    Exit;
  end;}
  try
    if UploadFTP.Connected then
    UploadFTP.Disconnect;
    UploadFTP.Host:=IdFTP1.Host;
    UploadFTP.Port:=IdFTP1.Port;
    UploadFTP.Username:=IdFTP1.Username;
    UploadFTP.Password:=IdFTP1.Password;
    UploadFTP.Passive:=True;
    UploadFTP.TransferType:=ftASCII;
    UploadFTP.Connect;
    UploadFTP.ChangeDir(IdFTP1.RetrieveCurrentDir);
    Tmp:=TStringList.Create;
    UploadFTP.List(Tmp);
    FTPFileExists:=False;
    for i:=0 to Tmp.Count - 1 do
    if Tmp.Strings[i] = FN then
    FTPFileExists:=True;
    Tmp.Free;
    UploadFTP.TransferType:=ftBinary;
    Uploading:=True;
    if FTPFileExists then
    UploadFTP.Put(FN, ExtractFileName(FN), Application.MessageBox(PChar(ContinueUploading), 'Lynx - FTP Client', MB_ICONQUESTION or MB_YESNO) = mrYes)
    else
    UploadFTP.Put(FN, ExtractFileName(FN));
    //if FileExists(ExtractFilePath(Application.ExeName) + 'Downloads\' + FN) then
    //begin
      //f:=TFileStream.Create(ExtractFilePath(Application.ExeName) + 'Downloads\' + FN, fmOpenWrite);
      //DownloadFTP.Get(FN, f, Application.MessageBox('Продолжить закачку?', 'Lynx - FTP Client', MB_YESNO) = mrYes);
    //end
    //else
    //begin
      //f:=TFileStream.Create(ExtractFilePath(Application.ExeName) + 'Downloads\' + FN, fmCreate);
      //DownloadFTP.Get(FN, f);
    //end;
  finally
    Uploading:=False;
    UploadFTP.Disconnect;
    OpenDir(IdFTP1.RetrieveCurrentDir);
  end;
end;

procedure TCurrentFTP.CreateFTPDirClick(Sender: TObject);
var
  DN: String;
begin
  if not IdFTP1.Connected then
  Exit;
  if InputQuery(PChar(NewFolderCaption), PChar(EnterNewFolder), DN) then
  IdFTP1.MakeDir(DN);   
  OpenDir(IdFTP1.RetrieveCurrentDir);
end;

procedure TCurrentFTP.UpFolderClick(Sender: TObject);
begin
  if not IdFTP1.Connected then
  Exit;
  IdFTP1.ChangeDirUp;
  OpenDir(IdFTP1.RetrieveCurrentDir);
end;

procedure TCurrentFTP.DeleteFTPFileClick(Sender: TObject);
begin               
  if not IdFTP1.Connected then
  Exit;
  if Files.Selected <> nil then
  if Files.Selected.SubItems.Strings[0] <> DirectoryCaption then
  IdFTP1.Delete(Files.Selected.Caption)
  else
  IdFTP1.RemoveDir(Files.Selected.Caption);
  OpenDir(IdFTP1.RetrieveCurrentDir);
end;

procedure TCurrentFTP.DisconnectFTPClick(Sender: TObject);
begin
  if IdFTP1.Connected then
  IdFTP1.Disconnect;
end;

procedure TCurrentFTP.DropFileTarget1Drop(Sender: TObject;
  ShiftState: TShiftState; APoint: TPoint; var Effect: Integer);
begin
  if DropFileTarget1.Files.Count > 0 then
  if FileExists(DropFileTarget1.Files.Strings[0]) then
  UploadFile(DropFileTarget1.Files.Strings[0]);
  //
end;

procedure TCurrentFTP.UploadFTPWorkBegin(Sender: TObject;
  AWorkMode: TWorkMode; const AWorkCountMax: Integer);
begin
  if not Uploading then
  Exit;
  //if  RzPageControl1.Pages[2].TabVisible then
  //RzPageControl1.TabIndex:=2;
  //RzPageControl1.ActivePageIndex:=1;
  with Tasks.Items.Insert(0) do
  begin
    Caption:=UploadingCaption;
    SubItems.Add(UploadingFileName);
    SubItems.Add('0 ' + BytesCaption);
  end;
end;

procedure TCurrentFTP.UploadFTPWork(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCount: Integer);
begin
  if not Uploading then
  Exit;
  if Tasks.Items.Item[0].Caption = UploadingCaption then
  Tasks.Items.Item[0].SubItems.Strings[1]:=IntToStr(AWorkCount) + ' ' + BytesCaption
  else
  Tasks.Items.Item[1].SubItems.Strings[1]:=IntToStr(AWorkCount) + ' ' + BytesCaption;
end;

procedure TCurrentFTP.UploadFTPWorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  if not Uploading then
  Exit;
  //if RzPageControl1.Pages[2].TabVisible then
  //RzPageControl1.TabIndex:=2;    
  if Tasks.Items.Item[0].Caption = UploadingCaption then
  Tasks.Items.Item[0].SubItems.Strings[1]:=Completed
  else                                                     
  Tasks.Items.Item[1].SubItems.Strings[1]:=Completed;
end;

procedure TCurrentFTP.FormResize(Sender: TObject);
begin
  Log.Width:=Panel1.Width div 2;
end;

procedure TCurrentFTP.FilesEdited(Sender: TObject; Item: TListItem;
  var S: String);
begin
  if Trim(S) <> '' then
  IdFTP1.Rename(Item.Caption, S);
end;

end.
