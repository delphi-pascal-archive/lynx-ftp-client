unit FTPFrame;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, IdAntiFreezeBase, IdAntiFreeze,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdFTP{, FTPMainForm};

type
  TCurrentFTPFrame = class(TFrame)
    IdFTP1: TIdFTP;
    IdAntiFreeze1: TIdAntiFreeze;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

uses
  FTPMainForm;

{$R *.dfm}

end.
