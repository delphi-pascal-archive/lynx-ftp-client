unit BugReport;

interface

uses
  Windows, Classes, Controls, Forms,
  StdCtrls, RzEdit, RzPanel, 
  IdSMTP,
  IdMessage, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdMessageClient, ExtCtrls;

type
  TBugReportForm = class(TForm)
    ErrorMessage: TRzMemo;
    RzGroupBox1: TRzGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Email: TEdit;
    RName: TEdit;
    Label3: TLabel;
    Comment: TRzMemo;
    Button1: TButton;
    Button2: TButton;
    IdSMTP1: TIdSMTP;
    IdMessage1: TIdMessage;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  BugReportForm: TBugReportForm;

implementation

uses FTPMainForm;

{$R *.dfm}

procedure TBugReportForm.Button2Click(Sender: TObject);
begin
  Close;
end;

procedure TBugReportForm.Button1Click(Sender: TObject);
begin
  try
    with IdSMTP1 do
    begin
      Host:='smtp.yandex.ru';
      Port:=25;
      Username:='lynxftpclient';
      Password:='eqasefjgm';
      AuthenticationType:=atLogin;
    end;
    IdMessage1.ContentType:='text/plain';
    IdMessage1.CharSet:='Windows 12-51';
    with IdMessage1.Body do
    begin
      Add(RName.Text + '(' + Email.Text + ')' + 'сообщает об ошибке:');
      AddStrings(ErrorMessage.Lines);
      Add('');
      Add('Комментарий:');
      AddStrings(Comment.Lines);
    end;
    with IdMessage1 do
    begin
      From.Name:='Lynx FTP Client';
      From.Text:='lynxftpclient@yandex.ru';
      Recipients.EMailAddresses:='aidarufa92@mail.ru';
      Subject:='Сообщение об ошибке Lynx - FTP Client';
      Priority:=mpHighest;
    end;
    IdSMTP1.Connect;
    try
      //IdSMTP1.Authenticate;
      IdSMTP1.Send(IdMessage1);
    finally
      IdSMTP1.Disconnect;
    end;
    Close;
  except
    Application.MessageBox(PChar(CheckInternetConnection), 'Lynx - FTP Client', MB_ICONERROR or MB_OK);
  end;
end;

end.
