unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls;

type
  TForm2 = class(TForm)
    StatusBar1: TStatusBar;
    Image1: TImage;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.dfm}


procedure TForm2.FormShow(Sender: TObject);
var
  fileheader: TBitmapfileheader;
  infoheader: TBitmapinfoheader;
  s: TFilestream;
begin
  Image1.Picture.Bitmap.LoadFromFile(Form1.ListView1.Selected.Caption);
  Image1.Picture.LoadFromFile(Form1.ListView1.Selected.Caption);
  s := TFileStream.Create(Form1.ListView1.Selected.Caption, fmOpenRead);

    try
      s.Read(fileheader, SizeOf(fileheader));
      s.Read(infoheader, SizeOf(infoheader));
    finally
      s.Free;
    end;

  StatusBar1.Panels[1].Text := IntToStr(infoheader.biWidth);
  StatusBar1.Panels[3].Text := IntToStr(infoheader.biHeight);
  StatusBar1.Panels[5].Text := IntToStr(infoheader.biBitCount);
  StatusBar1.Panels[7].Text := IntToStr(infoheader.biClrUsed);

  SetBounds(Left, Top, Image1.ClientWidth+25, Image1.ClientHeight+50);
end;

end.
