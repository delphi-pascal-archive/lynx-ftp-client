unit Settings;

interface

uses
  Classes, Controls, Forms, SysUtils, Windows,
  RzGroupBar, RzPanel, StdCtrls, ExtCtrls;

type
  TSettingsForm = class(TForm)
    RzGroupBar1: TRzGroupBar;
    RzGroup1: TRzGroup;
    RzGroup2: TRzGroup;
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label5: TLabel;
    ComboBox2: TComboBox;
    Button1: TButton;
    Button2: TButton;
    procedure RzGroup2Items0Click(Sender: TObject);
    procedure RzGroup1Items0Click(Sender: TObject);
    procedure RzGroup1Items1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SettingsForm: TSettingsForm;

implementation

uses IniFiles, uEncrypt, FTPMainForm;

{$R *.dfm}

procedure TSettingsForm.RzGroup2Items0Click(Sender: TObject);
begin
  //
end;

procedure TSettingsForm.RzGroup1Items0Click(Sender: TObject);
begin
  RzGroupBox1.Show;
  RzGroupBox2.Hide;
end;

procedure TSettingsForm.RzGroup1Items1Click(Sender: TObject);
begin
  RzGroupBox1.Hide;
  RzGroupBox2.Show;
end;

procedure TSettingsForm.CheckBox1Click(Sender: TObject);
begin
  ComboBox1.Enabled:=CheckBox1.Checked;
  Edit1.Enabled:=CheckBox1.Checked;
  Edit2.Enabled:=CheckBox1.Checked;
  Edit3.Enabled:=CheckBox1.Checked;
  Edit4.Enabled:=CheckBox1.Checked;
end;

procedure TSettingsForm.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TSettingsForm.Button1Click(Sender: TObject);
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Settings.ini') do
  begin
    WriteBool('Main', 'ShowToolBar', CheckBox2.Checked);
    WriteInteger('Main', 'TabPos', ComboBox2.ItemIndex);
    WriteBool('Connection', 'UseProxy', CheckBox1.Checked);
    WriteInteger('Connection', 'ProxyType', ComboBox1.ItemIndex);
    WriteString('Connection', 'Host', Edit1.Text);          
    WriteString('Connection', 'Port', Edit2.Text);
    WriteString('Connection', 'Username', Edit3.Text);
    WriteString('Connection', 'Password', Encrypt(Edit4.Text, 3));
    Free;
  end;
  Application.MessageBox(PChar(ChangesWill), 'Lynx - FTP Client', MB_ICONINFORMATION or MB_OK);
  Close;
end;

procedure TSettingsForm.FormShow(Sender: TObject);
begin
  with TIniFile.Create(ExtractFilePath(Application.ExeName) + 'Settings.ini') do
  begin
    ComboBox2.ItemIndex:=ReadInteger('Main', 'TabPos', 0);
    CheckBox2.Checked:=ReadBool('Main', 'ShowToolBar', True);
    CheckBox1.Checked:=ReadBool('Connection', 'UseProxy', False);
    ComboBox1.ItemIndex:=ReadInteger('Connection', 'ProxyType', 0);
    Edit1.Text:=ReadString('Connection', 'Host', '');
    Edit2.Text:=ReadString('Connection', 'Port', '0');
    Edit3.Text:=ReadString('Connection', 'Username', '');
    Edit4.Text:=ReadString('Connection', 'Password', '');
    Free;
  end;
end;

end.
