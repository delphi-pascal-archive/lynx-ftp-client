unit About;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms,
  StdCtrls, ExtCtrls, ShellAPI, Registry, RzLabel, jpeg, Graphics;

type
  TAboutLynx = class(TForm)
    Image1: TImage;
    ProgrammName: TLabel;
    ProgrammVersion: TLabel;
    ProgrammAuthor: TLabel;
    Bevel1: TBevel;
    ProgrammUser: TLabel;
    ProgrammOS: TLabel;
    ProgrammMemory: TLabel;
    ProgrammOSName: TLabel;
    ProgrammInfo: TLabel;
    RzURLLabel1: TRzURLLabel;
    RzURLLabel2: TRzURLLabel;
    Image2: TImage;
    procedure FormCreate(Sender: TObject);
    procedure ProgrammSiteClick(Sender: TObject);
    procedure ProgrammEmailClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  VersionPostfix: String = 'Beta 2';

var
  AboutLynx: TAboutLynx;

implementation

uses FTPMainForm;

{$R *.dfm}

procedure TAboutLynx.FormCreate(Sender: TObject);
function CurrentFileInfo(NameApp, Key, DefaultVal: String): string;
var
  dump: DWORD;
  size: integer;
  buffer: PChar;
  VersionPointer, TransBuffer: PChar;
  Temp: integer;
  CalcLangCharSet: string;
begin
  size := GetFileVersionInfoSize(PChar(NameApp), dump);
  buffer := StrAlloc(size+1);
  try
    GetFileVersionInfo(PChar(NameApp), 0, size, buffer);
    VerQueryValue(buffer, '\VarFileInfo\Translation', pointer(TransBuffer),
    dump);
    if dump >= 4 then
    begin
      temp:=0;
      StrLCopy(@temp, TransBuffer, 2);
      CalcLangCharSet:=IntToHex(temp, 4);
      StrLCopy(@temp, TransBuffer+2, 2);
      CalcLangCharSet := CalcLangCharSet+IntToHex(temp, 4);
    end;
    VerQueryValue(buffer, pchar('\StringFileInfo\'+CalcLangCharSet+
    '\'+Key), pointer(VersionPointer), dump);
    if (dump > 1) then
    begin
      SetLength(Result, dump);
      StrLCopy(Pchar(Result), VersionPointer, dump);
    end
    else
      Result:=DefaultVal;
  finally
    StrDispose(Buffer);
  end;
end;
function GetCurrentUserName: string;
const
  cnMaxUserNameLen = 254;
var
  sUserName: string;
  dwUserNameLen: DWORD;
begin
  dwUserNameLen := cnMaxUserNameLen - 1;
  SetLength(sUserName, cnMaxUserNameLen);
  GetUserName(PChar(sUserName), dwUserNameLen);
  SetLength(sUserName, dwUserNameLen);
  Result := sUserName;
end;
procedure GetOSInfo;
var
  Platform: String;
  BuildNumber: Integer;
begin
  case Win32Platform of
    VER_PLATFORM_WIN32_WINDOWS:
    begin
      Platform:='Windows 95';
      BuildNumber:=Win32BuildNumber and $0000FFFF;
    end;
    VER_PLATFORM_WIN32_NT:
    begin
      Platform:='Windows NT';
      BuildNumber:=Win32BuildNumber;
    end;
    else
    begin
      Platform:='Windows';
      BuildNumber:=0;
    end;
  end;
  if (Win32Platform = VER_PLATFORM_WIN32_WINDOWS) or (Win32Platform = VER_PLATFORM_WIN32_NT) then
  begin
    if Win32CSDVersion = '' then
      ProgrammOS.Caption:=Format('%s %d.%d (' + BuildCaption + ' %d)', [Platform, Win32MajorVersion, Win32MinorVersion, BuildNumber])
    else
      ProgrammOS.Caption:=Format('%s %d.%d (' + BuildCaption + ' %d: %s)', [Platform, Win32MajorVersion, Win32MinorVersion, BuildNumber, Win32CSDVersion]);
  end
  else
    ProgrammOS.Caption:=Format('%s %d.%d', [Platform, Win32MajorVersion, Win32MinorVersion])
end;
procedure ExtendedOSInfo;
begin
  with TRegistry.Create do
  begin
    try
      RootKey:=HKEY_LOCAL_MACHINE;
      if OpenKey('SOFTWARE\Microsoft\Windows NT\CurrentVersion', False) then
      ProgrammOSName.Caption:=ReadString('ProductName');
    finally
      Free;
    end;
  end;
end;
procedure GetMemoryInfo;
var
  MS: TMemoryStatus;
begin
  GetOSInfo;
  MS.dwLength:=SizeOf(TMemoryStatus);
  GlobalMemoryStatus(MS);
  ProgrammMemory.Caption:=FormatFloat(MemoryCaption, MS.dwTotalPhys div 1024);
end;
function GetVersionAndBild(FullVersion: String): String;
var
  i, j, DotPos, LastDot: Integer;
begin
  Result:=FullVersion;
  j:=0;
  LastDot:=0;
  DotPos:=0;
  for i:=1 to Length(FullVersion) do
  if FullVersion[i] = '.' then
  begin
    Inc(j);
    if j = 2 then
    DotPos:=i;
    if j = 3 then
    LastDot:=i;
  end;
  Result:=VersionCaption + ' ' + Copy(FullVersion, 1, DotPos - 1) + ' (' + BuildCaption + ' ' + Copy(FullVersion, LastDot + 1, Length(FullVersion) - LastDot - 1) + ')';
end;
begin
  Icon:=Application.Icon;
  ProgrammName.Caption:=CurrentFileInfo(Application.ExeName, 'ProductName', 'Lynx - File Manager');
  ProgrammVersion.Caption:=GetVersionAndBild(CurrentFileInfo(Application.ExeName, 'FileVersion', '1.0.0.0'));
  if VersionPostfix <> '' then
  ProgrammVersion.Caption:=ProgrammVersion.Caption + ' ' + VersionPostfix;
  ProgrammAuthor.Caption:=Author + ' ' + CurrentFileInfo(Application.ExeName, 'CompanyName', 'Ѕиктимиров јйдар');
  ProgrammUser.Caption:=User + ' ' + GetCurrentUserName;
  GetOSInfo;
  ExtendedOSInfo;
  GetMemoryInfo;
  ProgrammName.Left:=ClientWidth - ProgrammName.Width   - 12; 
  ProgrammAuthor.Left:=ClientWidth - ProgrammAuthor.Width   - 12;
  ProgrammVersion.Left:=ClientWidth - ProgrammVersion.Width   - 12;
end;

procedure TAboutLynx.ProgrammSiteClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'http://aidar.3dn.ru/', '', '', SW_SHOW);
end;

procedure TAboutLynx.ProgrammEmailClick(Sender: TObject);
begin
  ShellExecute(0, 'open', 'mailto:aidarufa92@mail.ru', '', '', SW_SHOW);
end;

end.
