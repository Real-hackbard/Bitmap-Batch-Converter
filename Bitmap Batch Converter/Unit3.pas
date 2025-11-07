unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Samples.Spin, IniFiles, Vcl.ExtCtrls;

type
  TForm3 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    CheckBox1: TCheckBox;
    SpinEdit1: TSpinEdit;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    RadioGroup1: TRadioGroup;
    ScrollBar1: TScrollBar;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    Label6: TLabel;
    ScrollBar2: TScrollBar;
    Label7: TLabel;
    TabSheet5: TTabSheet;
    Label3: TLabel;
    ComboBox1: TComboBox;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox17: TCheckBox;
    Button1: TButton;
    Button2: TButton;
    procedure CheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure CheckBox7Click(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure CheckBox9Click(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure CheckBox12Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure CheckBox13Click(Sender: TObject);
    procedure CheckBox14Click(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure CheckBox15Click(Sender: TObject);
    procedure CheckBox16Click(Sender: TObject);
    procedure CheckBox17Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure WriteOptions;
    procedure ReadOptions;
  end;

var
  Form3: TForm3;
  TIF : TInifile;


implementation

uses Unit1;

{$R *.dfm}
function MainDir: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm3.WriteOptions;    // ################### Options Write
var OPT :string;
begin
   OPT := 'Options';
   TIF := TIniFile.Create(MainDir + 'Data\Options\Picture_Options.ini');
   with TIF do
   begin
    WriteBool(OPT,'MonoBMP',CheckBox1.Checked);
    WriteInteger(OPT,'PicSize', SpinEdit1.Value);
    WriteBool(OPT,'PicsizeOn',CheckBox2.Checked);
    WriteBool(OPT,'IgnorePalette',CheckBox3.Checked);
    WriteBool(OPT,'DisableScaledDrawer',CheckBox4.Checked);
    WriteBool(OPT,'Modified',CheckBox5.Checked);
    WriteBool(OPT,'Tranzparent',CheckBox6.Checked);
    WriteInteger(OPT,'Pixel', RadioGroup1.ItemIndex);
    WriteInteger(OPT,'JPEGCompress', ScrollBar1.Position);
    WriteBool(OPT,'JPEGray',CheckBox7.Checked);
    WriteBool(OPT,'JPEGSmooth',CheckBox8.Checked);
    WriteBool(OPT,'JPEGMod',CheckBox9.Checked);
    WriteBool(OPT,'JPEGProgress',CheckBox10.Checked);
    WriteInteger(OPT,'ICOSize',ComboBox1.ItemIndex);
    WriteBool(OPT,'GIFTrz',CheckBox11.Checked);
    WriteInteger(OPT,'GIFColor',ComboBox2.ItemIndex);
    WriteBool(OPT,'GIFCompress',CheckBox12.Checked);
    WriteInteger(OPT,'GIFDither',ComboBox3.ItemIndex);
    WriteBool(OPT,'PNGTrz',CheckBox13.Checked);
    WriteBool(OPT,'PNGModified',CheckBox14.Checked);
    WriteInteger(OPT,'PNGCompress', ScrollBar2.Position);

    WriteBool(OPT,'IconTrz',CheckBox15.Checked);
    WriteBool(OPT,'IconSPT',CheckBox16.Checked);
    WriteBool(OPT,'IconMod',CheckBox17.Checked);
   Free;
   end;
end;

procedure TForm3.ReadOptions;    // ################### Options Read
var OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Picture_Options.ini') then
  begin
  TIF:=TIniFile.Create(MainDir + 'Data\Options\Picture_Options.ini');
  with TIF do
  begin
  CheckBox1.Checked:=ReadBool(OPT,'MonoBMP',CheckBox1.Checked);
  SpinEdit1.Value:=ReadInteger(OPT,'Picsize', SpinEdit1.Value);
  CheckBox2.Checked:=ReadBool(OPT,'PicsizeOn',CheckBox2.Checked);
  CheckBox3.Checked:=ReadBool(OPT,'IgnorePalette',CheckBox3.Checked);
  CheckBox4.Checked:=ReadBool(OPT,'DisableScaledDrawer',CheckBox4.Checked);
  CheckBox5.Checked:=ReadBool(OPT,'Modified',CheckBox5.Checked);
  CheckBox6.Checked:=ReadBool(OPT,'Tranzparent',CheckBox6.Checked);
  RadioGroup1.ItemIndex:=ReadInteger(OPT,'Pixel',RadioGroup1.ItemIndex);
  ScrollBar1.Position:=ReadInteger(OPT,'JPEGCompress',ScrollBar1.Position);
  CheckBox7.Checked:=ReadBool(OPT,'JPEGray',CheckBox7.Checked);
  CheckBox8.Checked:=ReadBool(OPT,'JPEGSmooth',CheckBox8.Checked);
  CheckBox9.Checked:=ReadBool(OPT,'JPEGMod',CheckBox9.Checked);
  CheckBox10.Checked:=ReadBool(OPT,'JPEGProgress',CheckBox10.Checked);
  ComboBox1.ItemIndex:=ReadInteger(OPT,'ICOSize',ComboBox1.ItemIndex);
  CheckBox11.Checked:=ReadBool(OPT,'GIFTrz',CheckBox11.Checked);
  ComboBox2.ItemIndex:=ReadInteger(OPT,'GIFColor',ComboBox2.ItemIndex);
  CheckBox12.Checked:=ReadBool(OPT,'GIFCompress',CheckBox12.Checked);
  ComboBox3.ItemIndex:=ReadInteger(OPT,'GIFDither',ComboBox3.ItemIndex);
  CheckBox13.Checked:=ReadBool(OPT,'PNGTrz',CheckBox13.Checked);
  CheckBox14.Checked:=ReadBool(OPT,'PNGModified',CheckBox14.Checked);
  ScrollBar2.Position:=ReadInteger(OPT,'PNGCompress',ScrollBar2.Position);

  CheckBox15.Checked:=ReadBool(OPT,'IconTrz',CheckBox15.Checked);
  CheckBox16.Checked:=ReadBool(OPT,'IconSPT',CheckBox16.Checked);
  CheckBox17.Checked:=ReadBool(OPT,'IconMod',CheckBox17.Checked);
  Free;
  end;
  end;
end;

procedure TForm3.RadioGroup1Click(Sender: TObject);
begin
  case RadioGroup1.ItemIndex of
  0 : Form1.pixel := 4;
  1 : Form1.pixel := 8;
  2 : Form1.pixel := 16;
  3 : Form1.pixel := 24;
  4 : Form1.pixel := 32;
  end;
end;

procedure TForm3.ScrollBar1Change(Sender: TObject);
begin
  Form1.jpegCompress := ScrollBar1.Position;
  Label2.Caption := IntToStr(Scrollbar1.Position) + ' %';
end;

procedure TForm3.ScrollBar2Change(Sender: TObject);
begin
  Form1.PNGCompressionLevel := ScrollBar2.Position;
  Label7.Caption := IntToStr(Scrollbar2.Position*10) + ' %';
end;

procedure TForm3.SpinEdit1Change(Sender: TObject);
begin
  Form1.Picsize := SpinEdit1.Value;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
  Close();
end;

procedure TForm3.Button2Click(Sender: TObject);
begin
  WriteOptions;
end;

procedure TForm3.CheckBox10Click(Sender: TObject);
begin
  if CheckBox10.Checked = true then
  begin
  Form1.jpegProgressiveDisplay := true;
  end else begin
  Form1.jpegProgressiveDisplay := false;
  end;
end;

procedure TForm3.CheckBox11Click(Sender: TObject);
begin
  if CheckBox11.Checked = true then
  begin
  Form1.GIFTrz := true;
  end else begin
  Form1.GIFTrz := false;
  end;
end;

procedure TForm3.CheckBox12Click(Sender: TObject);
begin
  if CheckBox12.Checked = true then
  begin
  Form1.GIFCompress := true;
  end else begin
  Form1.GIFCompress := false;
  end;
end;

procedure TForm3.CheckBox13Click(Sender: TObject);
begin
  if CheckBox13.Checked = true then
  begin
  Form1.PNGTrz := true;
  end else begin
  Form1.PNGTrz := false;
  end;
end;

procedure TForm3.CheckBox14Click(Sender: TObject);
begin
  if CheckBox14.Checked = true then
  begin
  Form1.PNGModified := true;
  end else begin
  Form1.PNGModified := false;
  end;
end;

procedure TForm3.CheckBox15Click(Sender: TObject);
begin
  if CheckBox15.Checked = true then
  begin
  Form1.IconTrz := true;
  end else begin
  Form1.IconTrz := false;
  end;
end;

procedure TForm3.CheckBox16Click(Sender: TObject);
begin
  if CheckBox16.Checked = true then
  begin
  Form1.IconSPT := true;
  end else begin
  Form1.IconSPT := false;
  end;
end;

procedure TForm3.CheckBox17Click(Sender: TObject);
begin
  if CheckBox17.Checked = true then
  begin
  Form1.IconMod := true;
  end else begin
  Form1.IconMod := false;
  end;
end;

procedure TForm3.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked = true then
  begin
  Form1.mono := true;
  end else begin
  Form1.mono := false;
  end;
end;

procedure TForm3.CheckBox2Click(Sender: TObject);
begin
  if CheckBox2.Checked = true then
  begin
  Form1.PicsizeOn := true;
  end else begin
  Form1.PicsizeOn := false;
  end;
end;

procedure TForm3.CheckBox3Click(Sender: TObject);
begin
  if CheckBox3.Checked = true then
  begin
  Form1.IgnorePalette := true;
  end else begin
  Form1.IgnorePalette := false;
  end;
end;

procedure TForm3.CheckBox4Click(Sender: TObject);
begin
  if CheckBox4.Checked = true then
  begin
  Form1.DisableScaledDrawer := true;
  end else begin
  Form1.DisableScaledDrawer := false;
  end;
end;

procedure TForm3.CheckBox5Click(Sender: TObject);
begin
  if CheckBox5.Checked = true then
  begin
  Form1.Modified := true;
  end else begin
  Form1.Modified := false;
  end;
end;

procedure TForm3.CheckBox6Click(Sender: TObject);
begin
  if CheckBox6.Checked = true then
  begin
  Form1.Transparent := true;
  end else begin
  Form1.Transparent := false;
  end;
end;

procedure TForm3.CheckBox7Click(Sender: TObject);
begin
  if CheckBox7.Checked = true then
  begin
  Form1.jpegGrayscale := true;
  end else begin
  Form1.jpegGrayscale := false;
  end;
end;

procedure TForm3.CheckBox8Click(Sender: TObject);
begin
  if CheckBox8.Checked = true then
  begin
  Form1.jpegSmoothing := true;
  end else begin
  Form1.jpegSmoothing := false;
  end;
end;

procedure TForm3.CheckBox9Click(Sender: TObject);
begin
  if CheckBox9.Checked = true then
  begin
  Form1.jpegModified := true;
  end else begin
  Form1.jpegModified := false;
  end;
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0 : Form1.IconSize := 8;
    1 : Form1.IconSize := 16;
    2 : Form1.IconSize := 32;
    3 : Form1.IconSize := 48;
    4 : Form1.IconSize := 64;
    5 : Form1.IconSize := 128;
    6 : Form1.IconSize := 256;
  end;
end;

procedure TForm3.ComboBox2Change(Sender: TObject);
begin
  case ComboBox2.ItemIndex of
  0 : Form1.GIFColorReduction := 0;
  1 : Form1.GIFColorReduction := 1;
  2 : Form1.GIFColorReduction := 2;
  3 : Form1.GIFColorReduction := 3;
  4 : Form1.GIFColorReduction := 4;
  5 : Form1.GIFColorReduction := 5;
  6 : Form1.GIFColorReduction := 6;
  7 : Form1.GIFColorReduction := 7;
  8 : Form1.GIFColorReduction := 8;
  end;

end;

procedure TForm3.ComboBox3Change(Sender: TObject);
begin
  case ComboBox3.ItemIndex of
    0 : Form1.GIFDitherMode := 0;
    1 : Form1.GIFDitherMode := 1;
    2 : Form1.GIFDitherMode := 2;
    3 : Form1.GIFDitherMode := 3;
    4 : Form1.GIFDitherMode := 4;
    end;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  ReadOptions;
end;

end.
