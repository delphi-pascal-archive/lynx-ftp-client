unit FavouritesSettingsForm;

interface

uses
  SysUtils, Classes, Controls, Forms,
  StdCtrls, RzEdit, FTPMainForm, Buttons, Mask;

type
  TFavouritesSettings = class(TForm)
    Label1: TLabel;
    Servers: TListBox;
    Label2: TLabel;
    Server: TEdit;
    Label3: TLabel;
    UserName: TEdit;
    Label4: TLabel;
    Port: TRzNumericEdit;
    Label5: TLabel;
    Password: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    BitBtn1: TBitBtn;
    procedure FormShow(Sender: TObject);
    procedure ServersClick(Sender: TObject);
    procedure ServerChange(Sender: TObject);
    procedure PortChange(Sender: TObject);
    procedure UserNameChange(Sender: TObject);
    procedure PasswordChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FavouritesSettings: TFavouritesSettings;
  FavouritesEditing: Array of TFTPFavourite;

implementation

uses uEncrypt;

{$R *.dfm}

procedure TFavouritesSettings.FormShow(Sender: TObject);
var
  f: TextFile;
  tmp: TFTPFavourite;
begin
  Servers.Items.Clear;
  SetLength(FavouritesEditing, 0);
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
    Servers.Items.Add(Decrypt(tmp.User, 25) + '@' + Decrypt(tmp.Serv, 13));
    SetLength(FavouritesEditing, Length(FavouritesEditing) + 1);
    FavouritesEditing[Length(FavouritesEditing) - 1]:=tmp;
  except

  end;
  CloseFile(f);
  //
end;

procedure TFavouritesSettings.ServersClick(Sender: TObject);
begin
  if Servers.ItemIndex = -1 then
  Exit;
  Server.Text:=Decrypt(FavouritesEditing[Servers.ItemIndex].Serv, 13);
  Port.Text:=Decrypt(FavouritesEditing[Servers.ItemIndex].Prt, 6);
  UserName.Text:=Decrypt(FavouritesEditing[Servers.ItemIndex].User, 25);
  Password.Text:=Decrypt(FavouritesEditing[Servers.ItemIndex].Pass, 13631);
end;

procedure TFavouritesSettings.ServerChange(Sender: TObject);
begin
  if Servers.ItemIndex = -1 then
  Exit;
  FavouritesEditing[Servers.ItemIndex].Serv:=Encrypt(Server.Text, 13);
end;

procedure TFavouritesSettings.PortChange(Sender: TObject);
begin
  if Servers.ItemIndex = -1 then
  Exit;
  FavouritesEditing[Servers.ItemIndex].Prt:=Encrypt(Port.Text, 6);
end;

procedure TFavouritesSettings.UserNameChange(Sender: TObject);
begin
  if Servers.ItemIndex = -1 then
  Exit;
  FavouritesEditing[Servers.ItemIndex].User:=Encrypt(UserName.Text, 25);
end;

procedure TFavouritesSettings.PasswordChange(Sender: TObject);
begin
  if Servers.ItemIndex = -1 then
  Exit;
  FavouritesEditing[Servers.ItemIndex].Pass:=Encrypt(Password.Text, 13631);
end;

procedure TFavouritesSettings.Button3Click(Sender: TObject);
var
  i: Integer;
begin
  if Servers.ItemIndex = -1 then
  Exit;
  for i:=Servers.ItemIndex to Length(FavouritesEditing) - 2 do
  FavouritesEditing[i]:=FavouritesEditing[i + 1];
  SetLength(FavouritesEditing, Length(FavouritesEditing) - 1);
  Servers.Items.Delete(Servers.ItemIndex);
end;

procedure TFavouritesSettings.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFavouritesSettings.Button1Click(Sender: TObject);
var
  i: Integer;
  f: TextFile;
begin
  AssignFile(f, ExtractFilePath(Application.ExeName) + 'Favourites.lynxftpfav');
  Rewrite(f);
  for i:=0 to Length(FavouritesEditing) - 1 do
  begin
    Writeln(f, FavouritesEditing[i].Serv);     
    Writeln(f, FavouritesEditing[i].Prt);
    Writeln(f, FavouritesEditing[i].User);
    Writeln(f, FavouritesEditing[i].Pass);
  end;
  CloseFile(f);
  LynxFTPForm.GetFavourites;
  Close;
end;

procedure TFavouritesSettings.BitBtn1Click(Sender: TObject);
begin
  Servers.Items.Add('');
  SetLength(FavouritesEditing, Length(FavouritesEditing) + 1);
  Servers.ItemIndex:=Servers.Items.Count - 1;
end;

end.
