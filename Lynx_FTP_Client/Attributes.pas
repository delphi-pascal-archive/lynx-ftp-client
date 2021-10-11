unit Attributes;

interface

uses
  Classes, Controls, Forms, SysUtils,
  RzPanel, StdCtrls, IdFTP, ExtCtrls;

type
  TFileAttributesForm = class(TForm)
    RzGroupBox1: TRzGroupBox;
    RzGroupBox2: TRzGroupBox;
    RzGroupBox3: TRzGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    procedure CheckBoxClicked(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    DontChangeCheckBoxes: Boolean;
    FName: String;
    FIdFTP: Pointer;
    procedure GetAttributes;
    procedure ExtractAttribetes(Owner, Group, User: String);
  end;

var
  FileAttributesForm: TFileAttributesForm;

implementation

{$R *.dfm}

{ TFileAttributesForm }

procedure TFileAttributesForm.CheckBoxClicked(Sender: TObject);
begin
  GetAttributes;
end;

procedure TFileAttributesForm.GetAttributes;
var
  Tmp: String;
begin
  if DontChangeCheckBoxes then
  Exit;
  Tmp:='000';
  if (not CheckBox1.Checked) and (not CheckBox2.Checked) and (not CheckBox3.Checked) then
  Tmp[1]:='0';
  if (not CheckBox1.Checked) and (not CheckBox2.Checked) and (CheckBox3.Checked) then
  Tmp[1]:='1';
  if (not CheckBox1.Checked) and (CheckBox2.Checked) and (not CheckBox3.Checked) then
  Tmp[1]:='2';
  if (not CheckBox1.Checked) and (CheckBox2.Checked) and (CheckBox3.Checked) then
  Tmp[1]:='3';
  if (CheckBox1.Checked) and (not CheckBox2.Checked) and (not CheckBox3.Checked) then
  Tmp[1]:='4';
  if (CheckBox1.Checked) and (not CheckBox2.Checked) and (CheckBox3.Checked) then
  Tmp[1]:='5';
  if (CheckBox1.Checked) and (CheckBox2.Checked) and (not CheckBox3.Checked) then
  Tmp[1]:='6';
  if (CheckBox1.Checked) and (CheckBox2.Checked) and (CheckBox3.Checked) then
  Tmp[1]:='7';
  if (not CheckBox4.Checked) and (not CheckBox5.Checked) and (not CheckBox6.Checked) then
  Tmp[2]:='0';
  if (not CheckBox4.Checked) and (not CheckBox5.Checked) and (CheckBox6.Checked) then
  Tmp[2]:='1';
  if (not CheckBox4.Checked) and (CheckBox5.Checked) and (not CheckBox6.Checked) then
  Tmp[2]:='2';
  if (not CheckBox4.Checked) and (CheckBox5.Checked) and (CheckBox6.Checked) then
  Tmp[2]:='3';
  if (CheckBox4.Checked) and (not CheckBox5.Checked) and (not CheckBox6.Checked) then
  Tmp[2]:='4';
  if (CheckBox4.Checked) and (not CheckBox5.Checked) and (CheckBox6.Checked) then
  Tmp[2]:='5';
  if (CheckBox4.Checked) and (CheckBox5.Checked) and (not CheckBox6.Checked) then
  Tmp[2]:='6';
  if (CheckBox4.Checked) and (CheckBox5.Checked) and (CheckBox6.Checked) then
  Tmp[2]:='7';
  if (not CheckBox7.Checked) and (not CheckBox8.Checked) and (not CheckBox9.Checked) then
  Tmp[3]:='0';
  if (not CheckBox7.Checked) and (not CheckBox8.Checked) and (CheckBox9.Checked) then
  Tmp[3]:='1';
  if (not CheckBox7.Checked) and (CheckBox8.Checked) and (not CheckBox9.Checked) then
  Tmp[3]:='2';
  if (not CheckBox7.Checked) and (CheckBox8.Checked) and (CheckBox9.Checked) then
  Tmp[3]:='3';
  if (CheckBox7.Checked) and (not CheckBox8.Checked) and (not CheckBox9.Checked) then
  Tmp[3]:='4';
  if (CheckBox7.Checked) and (not CheckBox8.Checked) and (CheckBox9.Checked) then
  Tmp[3]:='5';
  if (CheckBox7.Checked) and (CheckBox8.Checked) and (not CheckBox9.Checked) then
  Tmp[3]:='6';
  if (CheckBox7.Checked) and (CheckBox8.Checked) and (CheckBox9.Checked) then
  Tmp[3]:='7';
  Edit1.Text:=Tmp;
end;

procedure TFileAttributesForm.Edit1Change(Sender: TObject);
begin
  DontChangeCheckBoxes:=True;
  if Length(Edit1.Text) = 3 then
  begin
    CheckBox1.Checked:=(Edit1.Text[1] in ['4'..'7']);
    CheckBox2.Checked:=(Edit1.Text[1] in ['2', '3', '6', '7']);
    CheckBox3.Checked:=(Edit1.Text[1] in ['1', '3', '5', '7', '9']);
    CheckBox4.Checked:=(Edit1.Text[2] in ['4'..'7']);
    CheckBox5.Checked:=(Edit1.Text[2] in ['2', '3', '6', '7']);
    CheckBox6.Checked:=(Edit1.Text[2] in ['1', '3', '5', '7', '9']);
    CheckBox7.Checked:=(Edit1.Text[3] in ['4'..'7']);
    CheckBox8.Checked:=(Edit1.Text[3] in ['2', '3', '6', '7']);
    CheckBox9.Checked:=(Edit1.Text[3] in ['1', '3', '5', '7', '9']);
  end;
  if Length(Edit1.Text) = 2 then
  begin
    CheckBox1.Checked:=(Edit1.Text[1] in ['4'..'7']);
    CheckBox2.Checked:=(Edit1.Text[1] in ['2', '3', '6', '7']);
    CheckBox3.Checked:=(Edit1.Text[1] in ['1', '3', '5', '7', '9']);
    CheckBox4.Checked:=(Edit1.Text[2] in ['4'..'7']);
    CheckBox5.Checked:=(Edit1.Text[2] in ['2', '3', '6', '7']);
    CheckBox6.Checked:=(Edit1.Text[2] in ['1', '3', '5', '7', '9']);
  end;   
  if Length(Edit1.Text) = 1 then
  begin
    CheckBox1.Checked:=(Edit1.Text[1] in ['4'..'7']);
    CheckBox2.Checked:=(Edit1.Text[1] in ['2', '3', '6', '7']);
    CheckBox3.Checked:=(Edit1.Text[1] in ['1', '3', '5', '7', '9']);
  end;
  DontChangeCheckBoxes:=False;
end;

procedure TFileAttributesForm.ExtractAttribetes(Owner, Group,
  User: String);
var
  Tmp: String;
  Sum: Integer;
  i: Integer;
begin
  Tmp:='000';
  Sum:=0;
  for i:=1 to Length(Owner) do
  begin
    case Owner[i] of
    'r': Sum:=Sum + 4;
    'w': Sum:=Sum + 2;
    'x': Sum:=Sum + 1;
    end;
  end;
  Tmp[1]:=IntToStr(Sum)[1];
  Sum:=0;
  for i:=1 to Length(Group) do
  begin
    case Group[i] of
    'r': Sum:=Sum + 4;
    'w': Sum:=Sum + 2;
    'x': Sum:=Sum + 1;
    end;
  end;
  Tmp[2]:=IntToStr(Sum)[1];
  Sum:=0;
  for i:=1 to Length(User) do
  begin
    case User[i] of
    'r': Sum:=Sum + 4;
    'w': Sum:=Sum + 2;
    'x': Sum:=Sum + 1;
    end;
  end;
  Tmp[3]:=IntToStr(Sum)[1];
  Edit1.Text:=Tmp;
end;

procedure TFileAttributesForm.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TFileAttributesForm.Button1Click(Sender: TObject);
begin
  TIdFTP(FIdFTP^).SendCmd('SITE CHMOD ' + Edit1.Text + ' ' + FName);
  Close;
end;

end.
