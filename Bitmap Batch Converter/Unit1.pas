unit Unit1;

interface

uses
   Windows, Winapi.Messages, System.SysUtils, System.Variants,
   System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
   Vcl.ComCtrls, ImgList, ExtCtrls, Filectrl, Buttons, Menus,
   ShellApi, Jpeg, GIFImg, PngImage, GraphicEx,
   IniFiles, Spin, System.ImageList, PCXImage, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    ListView1: TListView; 
    ImageList1: TImageList;
    StatusBar1: TStatusBar;
    FontDialog1: TFontDialog;
    Panel1: TPanel;
    ProgressBar1: TProgressBar;
    Image1: TImage;
    PopupMenu1: TPopupMenu;
    R1: TMenuItem;
    C1: TMenuItem;
    SaveDialog1: TSaveDialog;
    V1: TMenuItem;
    N1: TMenuItem;
    C2: TMenuItem;
    F1: TMenuItem;
    Image2: TImage;
    N2: TMenuItem;
    N3: TMenuItem;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton7: TSpeedButton;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    Image3: TImage;
    Panel2: TPanel;
    Label1: TLabel;
    Bevel1: TBevel;
    Grid1: TMenuItem;
    CheckBox4: TCheckBox;
    Bitmap1: TMenuItem;
    Output1: TMenuItem;
    Label2: TLabel;
    Options1: TMenuItem;
    ConvertBatch1: TMenuItem;
    ClearDestinationfolder1: TMenuItem;
    View1: TMenuItem;
    List1: TMenuItem;
    Report1: TMenuItem;
    Panel3: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure V1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure C2Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure Grid1Click(Sender: TObject);
    procedure Bitmap1Click(Sender: TObject);
    procedure Output1Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure ConvertBatch1Click(Sender: TObject);
    procedure ClearDestinationfolder1Click(Sender: TObject);
    procedure List1Click(Sender: TObject);
    procedure Report1Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }

    mono : boolean;
    Picsize : integer;
    PicsizeOn : boolean;
    DisableScaledDrawer : boolean;
    IgnorePalette : boolean;
    Transparent : boolean;
    Modified : boolean;
    pixel : integer;
    jpegCompress : integer;
    jpegGrayscale : boolean;
    jpegSmoothing : boolean;
    jpegModified : boolean;
    jpegProgressiveDisplay : boolean;
    IconSize : integer;
    IconMod : boolean;
    IconTrz : boolean;
    IconSPT : boolean;
    GIFTrz : boolean;
    GIFColorReduction : integer;
    GIFDitherMode : integer;
    GIFCompress : boolean;
    PNGCompressionLevel : integer;
    PNGTrz : boolean;
    PNGModified : boolean;

    procedure WriteOptions;
    procedure ReadOptions;
  end;

type
  TStringDynArray = array of string;

var
  Form1: TForm1;
  FileCount: Cardinal = 0;
  Files : TStringDynArray = nil;
  TIF : TIniFile;

type
 TWindowPos = packed record
   hwnd: HWND; 
   hwndInsertAfter: HWND;
   x: Integer;
   y: Integer;
   cx: Integer;
   cy: Integer;
   flags: UINT;
end;

const
  COLOR_NUM = 15;
  ColorConst: array [0..COLOR_NUM] of TColor = (clBlack,
    clMaroon, clGreen, clOlive, clNavy,
    clPurple, clTeal, clGray, clSilver, clRed,
    clLime, clYellow, clBlue, clFuchsia,
    clAqua, clWhite);
  ColorNames: array [0..COLOR_NUM] of string = ('Black',
    'Maroon', 'Green', 'Olive', 'Navy',
    'Purple', 'Teal', 'Gray', 'Silver', 'Red',
    'Lime', 'Yellow', 'Blue', 'Fuchsia',
    'Aqua', 'White');

implementation

uses Unit2, Unit3;

{$R *.dfm}
function MainDir: string;
begin
  Result := ExtractFilePath(ParamStr(0));
end;

procedure TForm1.WriteOptions;    // ################### Options Write
var OPT :string;
begin
   OPT := 'Options';

   if not DirectoryExists(MainDir + 'Data\Options\')
   then ForceDirectories(MainDir + 'Data\Options\');

   TIF := TIniFile.Create(MainDir + 'Data\Options\Options.ini');
   with TIF do
   begin
   WriteInteger(OPT,'Formats',ComboBox1.ItemIndex);
   WriteBool(OPT,'Path',CheckBox4.Checked);
   WriteBool(OPT,'Panel',Panel3.Checked);
   WriteBool(OPT,'List',List1.Checked);
   WriteBool(OPT,'Report',Report1.Checked);

   WriteBool(OPT,'Grid',Grid1.Checked);

   if CheckBox4.Checked = true then begin
   WriteString(OPT,'OutPath', Edit1.Text);
   end;

   Free;
   end;
end;

procedure TForm1.ReadOptions;    // ################### Options Read
var OPT:string;
begin
  OPT := 'Options';
  if FileExists(MainDir + 'Data\Options\Options.ini') then
  begin
  TIF:=TIniFile.Create(MainDir + 'Data\Options\Options.ini');
  with TIF do
  begin
  ComboBox1.ItemIndex:=ReadInteger(OPT,'Formats', ComboBox1.ItemIndex);
  CheckBox4.Checked:=ReadBool(OPT,'Path', CheckBox4.Checked);
  Panel3.Checked:=ReadBool(OPT,'Panel', Panel3.Checked);
  List1.Checked:=ReadBool(OPT,'List', List1.Checked);
  Report1.Checked:=ReadBool(OPT,'Report', Report1.Checked);

  Grid1.Checked:=ReadBool(OPT,'Grid', Grid1.Checked);

  if CheckBox4.Checked = true then begin
  Edit1.Text := ReadString(OPT,'OutPath',Edit1.Text);
  end;


  Free;
  end;
  end;
end;

procedure TForm1.Report1Click(Sender: TObject);
begin
  ListView1.ViewStyle := vsReport;
end;

Procedure SW(const bmp: TBitmap);
var
 color,grayScale : longint;
 r,g,b           : byte;
 h,w             : integer;
begin
  //bitmap musst be 24bit or pcx failed
  bmp.PixelFormat:=pf24bit;
  for h := 0 to bmp.height do
  begin
   for w := 0 to bmp.width do
   begin
    color:=colortorgb(bmp.Canvas.pixels[w,h]);
    if color = clBlack then
      color := clWhite
    else
      color := clBlack;
    bmp.canvas.Pixels[w,h]:=color;
   end;
  end;
end;

function CreateIconFromBmp(Bmp: TBitmap): TIcon;
begin
  with TImageList.CreateSize(Bmp.Width, Bmp.Height) do
  try
    {$IFDEF VER90}
    with Bmp do AddMasked(Bmp, Canvas.Pixels[Width-1, Height-1]);
    {$ELSE}
    bmp.TransparentColor := clBlack;
    bmp.Transparent := true;
    AddMasked(Bmp, Bmp.TransparentColor);
    {$ENDIF}
    Result := TIcon.Create;
    GetIcon(0, Result);
  finally
    Free;
  end;
end;

procedure StretchGraphic(const src, dest: TGraphic;
  DestWidth, DestHeight: integer; Smooth: Boolean = true);
var
  temp, aCopy: TBitmap;
  faktor: double;
begin
  Assert(Assigned(src) and Assigned(dest));
  if (src.Width = 0) or (src.Height = 0) then
    raise Exception.CreateFmt('Invalid source dimensions: %d x %d',[src.Width, src.Height]);
  if src.Width > DestWidth then
    begin
      faktor := DestWidth / src.Width;
      if (src.Height * faktor) > DestHeight then
        faktor := DestHeight / src.Height;
    end
  else
    begin
      faktor := DestHeight / src.Height;
      if (src.Width * faktor) > DestWidth then
        faktor := DestWidth / src.Width;
    end;
  try
    aCopy := TBitmap.Create;
    try
      aCopy.PixelFormat := pf24Bit;
      aCopy.Assign(src);
      temp := TBitmap.Create;
      try
        temp.Width := round(src.Width * faktor);
        temp.Height := round(src.Height * faktor);
        if Smooth then
          SetStretchBltMode(temp.Canvas.Handle, HALFTONE);
        StretchBlt(temp.Canvas.Handle, 0, 0, temp.Width, temp.Height,
          aCopy.Canvas.Handle, 0, 0, aCopy.Width, aCopy.Height, SRCCOPY);
        dest.Assign(temp);
      finally
        temp.Free;
      end;
    finally
      aCopy.Free;
    end;
  except
    on E: Exception do
      MessageBox(0, PChar(E.Message), nil, MB_OK or MB_ICONERROR);
  end;
end;

procedure ListFileDir(Path: string; FileList: TStrings);
var
  SR: TSearchRec;
begin
  if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        FileList.Add(path + SR.Name);
      end;
    until
    FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure BitmapFileToPNG(const Source, Dest: String);
var
  Bitmap: TBitmap;
  PNG: TPNGObject;
begin
  Bitmap := TBitmap.Create;
  PNG := TPNGObject.Create;
  try
    Bitmap.LoadFromFile(Source);

    if Form1.mono = true then Bitmap.Monochrome := true;
    if Form1.IgnorePalette = true then Bitmap.IgnorePalette := true;
    if Form1.DisableScaledDrawer = true then Bitmap.DisableScaledDrawer;
    if Form1.Modified = true then Bitmap.Modified := true;
    if Form1.PicsizeOn = true then StretchGraphic(Bitmap, Bitmap, Form1.Picsize,
                                                      Form1.Picsize,  true);

    if Form1.pixel = 4 then Bitmap.PixelFormat := pf4bit;
    if Form1.pixel = 8 then Bitmap.PixelFormat := pf8bit;
    if Form1.pixel = 16 then Bitmap.PixelFormat := pf16bit;
    if Form1.pixel = 24 then Bitmap.PixelFormat := pf24bit;
    if Form1.pixel = 32 then Bitmap.PixelFormat := pf32bit;

    PNG.Assign(Bitmap);
    if Form1.PNGModified = true then PNG.Modified := true;
    PNG.CompressionLevel := Form1.PNGCompressionLevel;

    if Form1.PNGTrz = true then begin
      PNG.Transparent := true;
      PNG.TransparentColor := clBlack;
    end;

    PNG.SaveToFile(Dest);
  finally
  Bitmap.Free;
  PNG.Free;
  end
end;

procedure Bmp2Jpeg(const BmpFileName, JpgFileName: string);
var
  Bmp: TBitmap;
  Jpg: TJPEGImage;
begin
  Bmp := TBitmap.Create;
  Jpg := TJPEGImage.Create;

  try
    Bmp.LoadFromFile(BmpFileName);

    if Form1.mono = true then BMP.Monochrome := true;
    if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
    if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
    if Form1.Modified = true then BMP.Modified := true;
    if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                              Form1.Picsize,  true);

    if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
    if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
    if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
    if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
    if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

    if Form1.jpegGrayscale = true then jpg.Grayscale := true;
    if Form1.jpegSmoothing = true then jpg.Smoothing := true;
    if Form1.jpegModified = true then jpg.Modified := true;
    if Form1.jpegProgressiveDisplay = true then jpg.ProgressiveDisplay := true;

    jpg.CompressionQuality := Form1.jpegCompress;
    jpg.Compress;
    Jpg.Assign(Bmp);
    Jpg.SaveToFile(JpgFileName);
  finally
    Jpg.Free;
    Bmp.Free;
  end;
end;

function DeleteFile(const AFile: string): boolean;
var
  sh: SHFileOpStruct;
begin
 ZeroMemory(@sh, sizeof(sh)); with sh do
 begin
   Wnd := Application.Handle;
   wFunc := fo_Delete;
   pFrom := PChar(AFile +#0);
   fFlags := fof_Silent or fof_NoConfirmation;
 end;
 result := SHFileOperation(sh) = 0;
end;

procedure FileCopy(von,nach:string);
var
  src,dest : tFilestream;
begin
  src := tFilestream.create(von,fmShareDenyNone or fmOpenRead);
  try
  dest := tFilestream.create(nach,fmCreate);
    try
      dest.copyfrom(src,src.size);
    finally
      dest.free;
    end;
  finally
    src.free;
  end;
end;

function bmp2emf(const SourceFileName: TFileName): Boolean;
var
  Metafile: TMetafile;
  MetaCanvas: TMetafileCanvas;
  Bitmap: TBitmap;
begin
  Metafile := TMetaFile.Create;
  try
  Bitmap := TBitmap.Create;
    try
      Bitmap.LoadFromFile(SourceFileName);

      if Form1.mono = true then Bitmap.Monochrome := true;
      if Form1.IgnorePalette = true then Bitmap.IgnorePalette := true;
      if Form1.DisableScaledDrawer = true then Bitmap.DisableScaledDrawer;
      if Form1.Modified = true then Bitmap.Modified := true;
      if Form1.PicsizeOn = true then StretchGraphic(Bitmap, Bitmap, Form1.Picsize,
                                                      Form1.Picsize,  true);
      if Form1.Transparent = true then begin
        Bitmap.TransparentColor := clBlack;
        Bitmap.Transparent := true;
      end;

      if Form1.pixel = 4 then Bitmap.PixelFormat := pf4bit;
      if Form1.pixel = 8 then Bitmap.PixelFormat := pf8bit;
      if Form1.pixel = 16 then Bitmap.PixelFormat := pf16bit;
      if Form1.pixel = 24 then Bitmap.PixelFormat := pf24bit;
      if Form1.pixel = 32 then Bitmap.PixelFormat := pf32bit;

      Metafile.Height := Bitmap.Height;
      Metafile.Width  := Bitmap.Width;
      MetaCanvas := TMetafileCanvas.Create(Metafile, 0);
      try
        MetaCanvas.Draw(0, 0, Bitmap);
      finally
        MetaCanvas.Free;
      end;
      finally
        Bitmap.Free;
    end;
    Metafile.SaveToFile(ChangeFileExt(SourceFileName, '.emf'));
  finally
  Metafile.Free;
  end;
end;

function Get_File_Size4(const S: string): Int64;
var
  FD: TWin32FindData;
  FH: THandle;
begin
  FH := FindFirstFile(PChar(S), FD);
  if FH = INVALID_HANDLE_VALUE then Result := 0
  else
    try
      Result := FD.nFileSizeHigh;
      Result := Result shl 32;
      Result := Result + FD.nFileSizeLow;
    finally
      //CloseHandle(FH);
    end;
end;

procedure ResizeTBitmap(Bmp: TBitmap; NewWidth, NewHeight: Integer);
var
  BmpTemp: TBitmap;
begin
  SetStretchBltMode(Bmp.Canvas.Handle, STRETCH_HALFTONE);
  SetBrushOrgEx(Bmp.Canvas.Handle, 0, 0, nil);
  StretchBlt(Bmp.Canvas.Handle, 0, 0, NewWidth, NewHeight,
             Bmp.Canvas.Handle, 0, 0,
             Bmp.Width, Bmp.Height, SRCCOPY);

  Bmp.Width := NewWidth;
  Bmp.Height := NewHeight;
end;

procedure BmpToWmf(BmpFile, WmfFile: string);
var
  MetaFile: TMetaFile;
  MFCanvas: TMetaFileCanvas;
  BMP: TBitmap;
begin
  MetaFile := TMetaFile.Create;
  try
    BMP := TBitmap.Create;
    try
      BMP.LoadFromFile(BmpFile);

      if Form1.mono = true then BMP.Monochrome := true;
      if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
      if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
      if Form1.Modified = true then BMP.Modified := true;
      if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                      Form1.Picsize,  true);
      if Form1.Transparent = true then begin
        BMP.TransparentColor := clBlack;
        BMP.Transparent := true;
      end;

      if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
      if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
      if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
      if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
      if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

      MetaFile.Height := BMP.Height;
      MetaFile.Width  := BMP.Width;
      MFCanvas := TMetafileCanvas.Create(MetaFile, 0);
      try
        MFCanvas.Draw(0, 0, BMP);
        finally
        MFCanvas.Free;
        end;
      finally
      BMP.Free;
    end;
    MetaFile.SaveToFile(WmfFile);
  finally
  MetaFile.Free;
  end;
end;

function FindAllFiles(RootFolder: string; Mask: string = '*.*'; Recurse: Boolean
  = True): TStringDynArray;
var
  wfd : TWin32FindData;
  hFile : THandle;
begin
  if AnsiLastChar(RootFolder)^ <> '\' then
    RootFolder := RootFolder + '\';
  if Recurse then
  begin
    hFile := FindFirstFile(PChar(RootFolder + '*.*'), wfd);
    if hFile <> INVALID_HANDLE_VALUE then
    try
      repeat
        if wfd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY =
          FILE_ATTRIBUTE_DIRECTORY then
          if (string(wfd.cFileName) <> '.') and (string(wfd.cFileName) <> '..')
            then
            FindAllFiles(RootFolder + wfd.cFileName, Mask, Recurse);
      until FindNextFile(hFile, wfd) = False;
    finally
      windows.FindClose(hFile);
    end;
  end;
  hFile := FindFirstFile(PChar(RootFolder + '*.bmp'), wfd);
  if hFile <> INVALID_HANDLE_VALUE then
  try
    repeat
      if wfd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY <>
        FILE_ATTRIBUTE_DIRECTORY then
      begin
        FileCount := length(Files)+1;
        Setlength(Files, FileCount);
        Files[FileCount - 1] := RootFolder + String(wfd.cFileName);
      end;
    until FindNextFile(hFile, wfd) = False;
  finally
    Windows.FindClose(hFile);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Form1.DoubleBuffered := true;
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
var
  i, ii : Integer;
  Dir, f : String;
  item : TListItem;
  Bmp: TBitmap;
  fileheader: TBitmapfileheader;
  infoheader: TBitmapinfoheader;
  s: TFilestream;
begin
  if SelectDirectory('Select a directory', '', Dir) = true then
  begin
    Screen.Cursor := crHourGlass;
    Files := nil;
    ProgressBar1.Position := 0;
    ListView1.Clear;
    ImageList1.Clear;
    FindAllFiles(Dir, '*.*', True);
    ListView1.SmallImages := ImageList1;
    Bmp := TBitmap.Create;

    for i := 0 to length(Files) - 1 do
    begin
      s := TFileStream.Create(Files[i], fmOpenRead);
        try
          s.Read(fileheader, SizeOf(fileheader));
          s.Read(infoheader, SizeOf(infoheader));
        finally
          s.Free;
        end;

      Item := ListView1.Items.Add;
      Bmp.LoadFromFile(Files[i]);
      ResizeTBitmap(Bmp, 16, 16);
      Item.ImageIndex := i;
      ImageList1.Add(Bmp, Bmp);

      f :=  IntToStr(Get_File_Size4(Files[i]) div 1000);
      ii := StrToInt(f);

        if ii < 1 then
          begin
            ii := 1;
            f := IntToStr(ii);
          end;

      Item.Caption := Files[i];
      Item.SubItems.Add(ExtractFileName(Files[i]));
      Item.SubItems.Add('BMP');
      Item.SubItems.Add(f + ' Kb');
      Item.SubItems.Add(IntToStr(infoheader.biBitCount));
      Item.SubItems.Add(IntToStr(infoheader.biWidth));
      Item.SubItems.Add(IntToStr(infoheader.biHeight));
      StatusBar1.Panels[1].Text := IntToStr(ListView1.Items.Count);
      Application.ProcessMessages;
    end;
  bmp.Free;
  end;
  Screen.Cursor := crDefault;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
var
  i, k : integer;
  BMP : TBitmap;
  Targa: TTargaGraphic;
  FS: TFileStream;
  png: TPngObject;
  jpeg : TJpegImage;
  Icon : TIcon;
  tmpInt: Integer;
  pcx : TPCXImage;
  GIF : TGIFImage;
begin
  if Edit1.Text = '' then
  begin
    Beep;
    ShowMessage('No Output Folder loaded !');
    Exit;
  end;

  if not DirectoryExists(Edit1.Text) then
  BEGIN
  Beep;
  if MessageBox(Handle,'Destination folder not exists, do you want to create it?',
                        'Destination folder not found!',MB_YESNO) = IDYES then
   begin
    ForceDirectories(Edit1.Text);
   end else begin
    Exit;
   end;
  END;

   if ListView1.Items.Count = 0 then
   begin
     Beep;
     ShowMessage('No Bitmaps Folder loaded !');
     Exit;
   end;

   if Edit1.Text = '' then
   begin
     Beep;
     ShowMessage('No Output Folder found !');
     Exit;
   end;

   if ComboBox1.ItemIndex = -1 then
   begin
     Beep;
     ShowMessage('No Output Format loaded !');
     Exit;
   end;

   Screen.Cursor := crHourGlass;
   ProgressBar1.Position := 0;
   ProgressBar1.Max := StrToInt(StatusBar1.Panels[1].Text);
   Image1.Picture.Graphic := nil;

   if ComboBox1.ItemIndex = 0 then begin              // wmf
    for i := 0 to ListView1.Items.Count -1 do
    begin
     try
       Image3.Picture.Bitmap.LoadFromFile(Files[i]);
       BmpToWmf( Files[i], Edit1.Text + ExtractFileName(Files[i]) + '.wmf');
       ProgressBar1.Position := i;
       StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
       StatusBar1.Panels[5].Text := Files[i];
       Application.ProcessMessages;
     finally
     end;
    end;
    StatusBar1.Panels[5].Text := 'finish.';
   end;

   if ComboBox1.ItemIndex = 1 then
   begin                                                // emf
    for i := 0 to ListView1.Items.Count -1 do
    begin
     try
       Image3.Picture.Bitmap.LoadFromFile(Files[i]);
       FileCopy(Files[i], Edit1.Text + ExtractFileName(Files[i]));
       bmp2emf(Edit1.Text + ExtractFileName(Files[i]));
       ProgressBar1.Position := i;
       StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
       StatusBar1.Panels[5].Text := Files[i];
       Application.ProcessMessages;
       DeleteFile(Edit1.Text + '*.bmp');
     finally
     end;
    end;
   end;

   if ComboBox1.ItemIndex = 2 then                            // jpeg
   begin
    jpeg := TjpegImage.Create;
    BMP := TBitmap.Create;
    for i := 0 to ListView1.Items.Count -1 do begin
       Image3.Picture.Bitmap.LoadFromFile(Files[i]);
       Bmp2Jpeg(Files[i], MainDir + 'Data\BackUp\' + ExtractFileName(Files[i]) +'.jpeg');
       ProgressBar1.Position := i;
       StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
       StatusBar1.Panels[5].Text := Files[i];
       Application.ProcessMessages;
    end;

    try
      for i := 0 to ListView1.Items.Count -1 do
      begin
        jpeg.LoadFromFile( MainDir + 'Data\BackUp\' + ExtractFileName(Files[i]) + '.jpeg');
        Image3.Picture.Bitmap.LoadFromFile(Files[i]);
        bmp.Assign(jpeg);

        if Form1.mono = true then BMP.Monochrome := true;
        if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
        if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
        if Form1.Modified = true then BMP.Modified := true;
        if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                              Form1.Picsize,  true);
        if Form1.Transparent = true then begin
          BMP.TransparentColor := clBlack;
          BMP.Transparent := true;
        end;

        if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
        if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
        if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
        if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
        if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

        jpeg.Assign(bmp);

        if Form1.jpegGrayscale = true then jpeg.Grayscale := true;
        if Form1.jpegSmoothing = true then jpeg.Smoothing := true;
        if Form1.jpegModified = true then jpeg.Modified := true;
        if Form1.jpegProgressiveDisplay = true then jpeg.ProgressiveDisplay := true;

        jpeg.CompressionQuality := Form1.jpegCompress;
        jpeg.Compress;
        jpeg.SaveToFile(Edit1.Text + ExtractFileName(Files[i]) + '.jpeg');
      end;
      finally
       DeleteFile(MainDir + 'Data\BackUp\*.*');
       jpeg.Free;
       BMP.Free;
    end;
   end;                                               // jpeg end

   if ComboBox1.ItemIndex = 3 then                    //////// jpg
   begin
   jpeg := TjpegImage.Create;
   BMP := TBitmap.Create;
     for i := 0 to ListView1.Items.Count -1 do begin
       Image3.Picture.Bitmap.LoadFromFile(Files[i]);
       Bmp2Jpeg(Files[i], MainDir + 'Data\BackUp\' + ExtractFileName(Files[i]) +'.jpg');
       ProgressBar1.Position := i;
       StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
       StatusBar1.Panels[5].Text := Files[i];
       Application.ProcessMessages;
     end;

     try
       for i := 0 to ListView1.Items.Count -1 do begin
         jpeg.LoadFromFile( MainDir + 'Data\BackUp\' + ExtractFileName(Files[i]) + '.jpg');
         Image3.Picture.Bitmap.LoadFromFile(Files[i]);
         bmp.Assign(jpeg);

         if Form1.mono = true then BMP.Monochrome := true;
         if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
         if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
         if Form1.Modified = true then BMP.Modified := true;
         if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                              Form1.Picsize,  true);
         if Form1.Transparent = true then begin
          BMP.TransparentColor := clBlack;
          BMP.Transparent := true;
         end;

         if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
         if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
         if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
         if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
         if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

         jpeg.Assign(bmp);

         if Form1.jpegGrayscale = true then jpeg.Grayscale := true;
         if Form1.jpegSmoothing = true then jpeg.Smoothing := true;
         if Form1.jpegModified = true then jpeg.Modified := true;
         if Form1.jpegProgressiveDisplay = true then jpeg.ProgressiveDisplay := true;

         jpeg.CompressionQuality := Form1.jpegCompress;
         jpeg.Compress;
         jpeg.SaveToFile(Edit1.Text + ExtractFileName(Files[i]) + '.jpg');
       end;
     finally
         DeleteFile(MainDir + 'Data\BackUp\*.*');
         jpeg.Free;
         BMP.Free;
     end;
   end;                                                  //////// jpg end

   if ComboBox1.ItemIndex = 4 then                       // ico
   begin
    try
       for i := 0 to ListView1.Items.Count -1 do begin
       BMP := TBitmap.Create;
         Image3.Picture.Bitmap.LoadFromFile(Files[i]);
         BMP.LoadFromFile(Files[i]);

         if Form1.mono = true then BMP.Monochrome := true;
         if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
         if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
         if Form1.Modified = true then BMP.Modified := true;
         if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                        Form1.Picsize,  true);

         if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
         if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
         if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
         if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
         if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

         Image1.Picture.Bitmap.Assign(BMP);

         StretchGraphic(Image1.Picture.Bitmap, Image2.Picture.Bitmap,
                        Form1.IconSize, Form1.IconSize,  true);

         Icon := CreateIconFromBmp(Image2.Picture.Bitmap);
         if Form1.IconTrz = true then Icon.Transparent := true;
         if Form1.IconSPT = true then Icon.SupportsPartialTransparency;
         if Form1.IconMod = true then Icon.Modified := true;
         Icon.SaveToFile(Edit1.Text + ExtractFileName(Files[i]) + '.ico');
         ProgressBar1.Position := i;
         StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
         StatusBar1.Panels[5].Text := Files[i];
         Application.ProcessMessages;
       end;
    finally
    Icon.Free;
    BMP.Free;
    end;
   end;

   if ComboBox1.ItemIndex = 5 then                  // pcx
   begin
     for i := 0 to ListView1.Items.Count -1 do
     begin
       try
         Image3.Picture.Bitmap.LoadFromFile(Files[i]);
         BMP := TBitmap.Create;
         BMP.LoadFromFile(Files[i]);

         if Form1.mono = true then BMP.Monochrome := true;
         if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
         if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
         if Form1.Modified = true then BMP.Modified := true;
         if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                              Form1.Picsize,  true);
         if Form1.Transparent = true then begin
          BMP.TransparentColor := clBlack;
          BMP.Transparent := true;
         end;

         if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
         if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
         if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
         if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
         if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

         Image2.Picture.Bitmap.Assign(BMP);
         pcx := TPCXImage.Create;
         pcx.Assign(bmp);
         pcx.SaveToFile(Edit1.Text + ExtractFileName(Files[i]) + '.pcx');
         ProgressBar1.Position := i;
         StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
         StatusBar1.Panels[5].Text := Files[i];
         Application.ProcessMessages;
       finally
        BMP.Free;
        end;
     end;
   end;

   if ComboBox1.ItemIndex = 6 then                    // gif
   begin
   {$R-}
    try
     for i := 0 to ListView1.Items.Count -1 do
     begin
        Image3.Picture.Bitmap.LoadFromFile(Files[i]);
        BMP := TBitmap.Create;
        GIF := TGIFImage.Create;
        BMP.LoadFromFile(Files[i]);

        if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
        if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
        if Form1.Modified = true then BMP.Modified := true;
        if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                            Form1.Picsize,  true);
        if Form1.Transparent = true then begin
          BMP.TransparentColor := clBlack;
          BMP.Transparent := true;
        end;

        if GIFColorReduction = 0 then GIF.ColorReduction := rmWindows20;
        if GIFColorReduction = 1 then GIF.ColorReduction := rmWindows256;
        if GIFColorReduction = 2 then GIF.ColorReduction := rmWindowsGray;
        if GIFColorReduction = 3 then GIF.ColorReduction := rmMonochrome;
        if GIFColorReduction = 4 then GIF.ColorReduction := rmGrayScale;
        if GIFColorReduction = 5 then GIF.ColorReduction := rmNetscape;
        if GIFColorReduction = 6 then GIF.ColorReduction := rmQuantize;
        if GIFColorReduction = 7 then GIF.ColorReduction := rmQuantizeWindows;
        if GIFColorReduction = 8 then GIF.ColorReduction := rmPalette;

        if Form1.GIFTrz = true then begin
          GIF.Transparent := true;
          GIF.IsTransparent;
        end;

        if GIFCompress = true then GIF.Pack;
        if GIFDitherMode = 0 then GIF.DitherMode := dmNearest;
        if GIFDitherMode = 1 then GIF.DitherMode := dmSierra;
        if GIFDitherMode = 2 then GIF.DitherMode := dmStucki;
        if GIFDitherMode = 3 then GIF.DitherMode := dmBurkes;
        if GIFDitherMode = 4 then GIF.DitherMode := dmSteveArche;
        GIF.Assign(bmp);

        GIF.SaveToFile(Edit1.Text + ExtractFileName(Files[i]) + '.gif');
        ProgressBar1.Position := i;
        StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
        StatusBar1.Panels[5].Text := Files[i];
        Application.ProcessMessages;
     end;
     finally
       GIF.Free;
       BMP.Free;
     end;
     StatusBar1.Panels[5].Text := 'finish.';
     {$R+}
   end;

   if ComboBox1.ItemIndex = 7 then                   // png
   begin
     for i := 0 to ListView1.Items.Count -1 do
     begin
       Image3.Picture.Bitmap.LoadFromFile(Files[i]);
       BitmapFileToPNG(Files[i], Edit1.Text + ExtractFileName(Files[i]) + '.png');
       ProgressBar1.Position := i;
       StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
       StatusBar1.Panels[5].Text := Files[i];
       Application.ProcessMessages;
     end;
   end;                                               // png end

   if ComboBox1.ItemIndex = 8 then                   // tga
   begin
       for i := 0 to ListView1.Items.Count -1 do
       begin
        try
          Image3.Picture.Bitmap.LoadFromFile(Files[i]);
          BMP := TBitmap.Create;
          Image1.Picture.Bitmap.LoadFromFile(Files[i]);
          FS := TFileStream.Create(Edit1.Text + ExtractFileName(Files[i]) + '.tga',
          fmCreate or fmShareDenyWrite);
          BMP := Image1.Picture.Bitmap;

          if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
          if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
          if Form1.Modified = true then BMP.Modified := true;
          if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                      Form1.Picsize,  true);
          if Form1.Transparent = true then begin
           BMP.TransparentColor := clBlack;
           BMP.Transparent := true;
          end;

          Targa := TTargaGraphic.Create;
          Targa.Assign(BMP);
          Targa.SaveToStream(FS, true);
          ProgressBar1.Position := i;
          StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
          StatusBar1.Panels[5].Text := Files[i];
          Application.ProcessMessages;
        finally
          FS.Free;
          Targa.Free;
          //BMP.Free;  // Exception Error do not intigrate
         end;
       end;
   end;

   if ComboBox1.ItemIndex = 9 then                   // bmp
   begin
     for i := 0 to ListView1.Items.Count -1 do
     begin
       try
         BMP := TBitmap.Create;
         BMP.LoadFromFile(Files[i]);
         Image3.Picture.Bitmap.LoadFromFile(Files[i]);

         if Form1.mono = true then BMP.Monochrome := true;
         if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
         if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
         if Form1.Modified = true then BMP.Modified := true;
         if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                      Form1.Picsize,  true);
         if Form1.Transparent = true then begin
           BMP.TransparentColor := clBlack;
           BMP.Transparent := true;
         end;

         if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
         if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
         if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
         if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
         if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

         BMP.SaveToFile(Edit1.Text + ExtractFileName(Files[i]));
         ProgressBar1.Position := i;
         StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
         StatusBar1.Panels[5].Text := Files[i];
         Application.ProcessMessages;
       finally
        BMP.Free;
       end;
     end;
   end;                                               // bmp end                                       // tga end

   ProgressBar1.Position := ProgressBar1.Max;
   StatusBar1.Panels[3].Text := IntToStr(ProgressBar1.Position);
   StatusBar1.Panels[5].Text := 'finish.';
   Image3.Picture.Graphic := nil;
   Screen.Cursor := crDefault;
   Beep;
   ShowMessage('Batch Convert finish!');
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
var Dir : string;
begin
  if SelectDirectory('Select a directory', '', Dir) = true then
  begin
    Edit1.Text := Dir + '\';
  end;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
  ListView1.Clear;
  StatusBar1.Panels[1].Text := IntToStr(ListView1.Items.Count);
  StatusBar1.Panels[3].Text := '';
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
  if FontDialog1.Execute then
  begin
    ListView1.Font := FontDialog1.Font;
  end;
end;

procedure TForm1.R1Click(Sender: TObject);
begin
   ListView1.DeleteSelected;
   StatusBar1.Panels[1].Text := IntToStr(ListView1.Items.Count);
end;

procedure TForm1.Bitmap1Click(Sender: TObject);
begin
  SpeedButton1.Click;
end;

procedure TForm1.C1Click(Sender: TObject);
var
  BMP : TBitmap;
  Targa: TTargaGraphic;
  FS: TFileStream;
  tmpInt: Integer;
  pcx : TPCXImage;
  Image : TImage;
  GIF : TGIFImage;
begin
  if ListView1.Items.Count = 0 then Exit;
   Image1.Picture.Graphic := nil;

 if SaveDialog1.Execute then begin

   if SaveDialog1.FilterIndex = 1 then          // to wmf
   begin
    BmpToWmf( ListView1.Selected.Caption, SaveDialog1.FileName + '.wmf');
   end;

   if SaveDialog1.FilterIndex = 2 then          // to emf
   begin
     FileCopy(ListView1.Selected.Caption, SaveDialog1.FileName);
     bmp2emf(SaveDialog1.FileName);
     DeleteFile(SaveDialog1.FileName);
   end;

   if SaveDialog1.FilterIndex = 3 then          // to jpeg
   begin
      Bmp2Jpeg(ListView1.Selected.Caption, SaveDialog1.FileName + '.jpeg');
   end;

   if SaveDialog1.FilterIndex = 4 then begin   // to jpg
     Bmp2Jpeg(ListView1.Selected.Caption, SaveDialog1.FileName + '.jpg');
   end;

   if SaveDialog1.FilterIndex = 5 then begin   // to ico
     try
      BMP := TBitmap.Create;
      BMP.LoadFromFile(ListView1.Selected.Caption);

      if Form1.mono = true then BMP.Monochrome := true;
      if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
      if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
      if Form1.Modified = true then BMP.Modified := true;
      if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                        Form1.Picsize,  true);

      if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
      if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
      if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
      if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
      if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

      Image1.Picture.Bitmap.Assign(BMP);

      StretchGraphic(Image1.Picture.Bitmap, Image2.Picture.Bitmap,
                        Form1.IconSize, Form1.IconSize,  true);

      Icon := CreateIconFromBmp(Image2.Picture.Bitmap);
      if Form1.IconTrz = true then Icon.Transparent := true;
      if Form1.IconSPT = true then Icon.SupportsPartialTransparency;
      if Form1.IconMod = true then Icon.Modified := true;

      Icon.SaveToFile(SaveDialog1.FileName + '.ico');
     finally
      BMP.Free;
     end;
   end;

   if SaveDialog1.FilterIndex = 6 then begin  // to pcx
     try
      BMP := TBitmap.Create;
      BMP.LoadFromFile(ListView1.Selected.Caption);
      Image1.Picture.Bitmap.Assign(BMP);

      if Form1.mono = true then BMP.Monochrome := true;
      if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
      if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
      if Form1.Modified = true then BMP.Modified := true;
      if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                              Form1.Picsize,  true);

      if Form1.Transparent = true then begin
      BMP.TransparentColor := clBlack;
      BMP.Transparent := true;
      end;

      if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
      if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
      if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
      if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
      if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

      pcx := TPCXImage.Create;
      pcx.Assign(bmp);
      pcx.SaveToFile(SaveDialog1.FileName + '.pcx');
     finally
      pcx.Free;
      BMP.Free;
     end;
   end;

   if SaveDialog1.FilterIndex = 7 then begin  // to png
    BitmapFileToPNG(ListView1.Selected.Caption, SaveDialog1.FileName + '.png');
   end;

   if SaveDialog1.FilterIndex = 8 then begin  // to tga
     try
      BMP := TBitmap.Create;
      Image1.Picture.Bitmap.LoadFromFile(ListView1.Selected.Caption);
      FS := TFileStream.Create(SaveDialog1.FileName + '.tga',
      fmCreate or fmShareDenyWrite);
      BMP := Image1.Picture.Bitmap;

      if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
      if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
      if Form1.Modified = true then BMP.Modified := true;
      if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                      Form1.Picsize,  true);
      if Form1.Transparent = true then begin
      BMP.TransparentColor := clBlack;
      BMP.Transparent := true;
      end;

      Targa := TTargaGraphic.Create;
      Targa.Assign(BMP);
      Targa.SaveToStream(FS, true);
     finally
      FS.Free;
      Targa.Free;
      //BMP.Free; // do not intigrate
     end;
   end;

   if SaveDialog1.FilterIndex = 9 then begin    // to bmp
     try
      BMP := TBitmap.Create;
      BMP.LoadFromFile(ListView1.Selected.Caption);

      if Form1.mono = true then BMP.Monochrome := true;
      if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
      if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
      if Form1.Modified = true then BMP.Modified := true;
      if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                      Form1.Picsize,  true);
      if Form1.Transparent = true then begin
      BMP.TransparentColor := clBlack;
      BMP.Transparent := true;
      end;

      if Form1.pixel = 4 then BMP.PixelFormat := pf4bit;
      if Form1.pixel = 8 then BMP.PixelFormat := pf8bit;
      if Form1.pixel = 16 then BMP.PixelFormat := pf16bit;
      if Form1.pixel = 24 then BMP.PixelFormat := pf24bit;
      if Form1.pixel = 32 then BMP.PixelFormat := pf32bit;

      BMP.SaveToFile(SaveDialog1.FileName + '.bmp');
     finally
      BMP.Free;
     end;
   end;

   if SaveDialog1.FilterIndex = 10 then      // to gif
   begin
     try
      BMP := TBitmap.Create;
      GIF := TGIFImage.Create;
      Image := TImage.Create(self);
      BMP.LoadFromFile(ListView1.Selected.Caption);

      if Form1.IgnorePalette = true then BMP.IgnorePalette := true;
      if Form1.DisableScaledDrawer = true then BMP.DisableScaledDrawer;
      if Form1.Modified = true then BMP.Modified := true;
      if Form1.PicsizeOn = true then StretchGraphic(BMP, BMP, Form1.Picsize,
                                                            Form1.Picsize,  true);
      if Form1.Transparent = true then begin
      BMP.TransparentColor := clBlack;
      BMP.Transparent := true;
      end;

      if GIFColorReduction = 0 then GIF.ColorReduction := rmWindows20;
      if GIFColorReduction = 1 then GIF.ColorReduction := rmWindows256;
      if GIFColorReduction = 2 then GIF.ColorReduction := rmWindowsGray;
      if GIFColorReduction = 3 then GIF.ColorReduction := rmMonochrome;
      if GIFColorReduction = 4 then GIF.ColorReduction := rmGrayScale;
      if GIFColorReduction = 5 then GIF.ColorReduction := rmNetscape;
      if GIFColorReduction = 6 then GIF.ColorReduction := rmQuantize;
      if GIFColorReduction = 7 then GIF.ColorReduction := rmQuantizeWindows;
      if GIFColorReduction = 8 then GIF.ColorReduction := rmPalette;

      if Form1.GIFTrz = true then begin
      GIF.Transparent := true;
      GIF.IsTransparent;
      end;

      if GIFCompress = true then GIF.Pack;
      if GIFDitherMode = 0 then GIF.DitherMode := dmNearest;
      if GIFDitherMode = 1 then GIF.DitherMode := dmSierra;
      if GIFDitherMode = 2 then GIF.DitherMode := dmStucki;
      if GIFDitherMode = 3 then GIF.DitherMode := dmBurkes;
      if GIFDitherMode = 4 then GIF.DitherMode := dmSteveArche;

      GIF.Assign(bmp);
      GIF.SaveToFile(SaveDialog1.FileName + '.gif');
     finally
      GIF.Free;
      BMP.Free;
      Image.Free;
     end;
   end;
 end;
end;

procedure TForm1.List1Click(Sender: TObject);
begin
  ListView1.ViewStyle := vsList;
end;

procedure TForm1.ListView1DblClick(Sender: TObject);
var fm: TForm2;
begin
 if ListView1.Items.Count = 0 then Exit;
 fm:=TForm2.Create(nil);
 fm.FormStyle:=FormStyle;
 fm.showmodal;
 fm.Free;
end;

procedure TForm1.Options1Click(Sender: TObject);
begin
  SpeedButton7.Click;
end;

procedure TForm1.Output1Click(Sender: TObject);
begin
  SpeedButton2.Click;
end;

procedure TForm1.Panel3Click(Sender: TObject);
begin
  if Panel3.Checked = true then begin
  Panel1.Visible := true;
  end else begin
  Panel1.Visible := false;
  end;
end;

procedure TForm1.V1Click(Sender: TObject);
var fm: TForm2;
begin
 if ListView1.Items.Count = 0 then Exit;
 fm:=TForm2.Create(nil);
 fm.FormStyle:=FormStyle;
 fm.showmodal;
 fm.Free;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  WriteOptions;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  ReadOptions;

  Form3.FormShow(self);
  Form3.ComboBox1.OnChange(sender);
  Form3.ComboBox2.OnChange(sender);
  Form3.ComboBox3.OnChange(sender);
  Form3.Close();

  Panel3.OnClick(sender);
  if List1.Checked = true then List1.OnClick(sender);
  if Report1.Checked = true then Report1.OnClick(sender);
  if Grid1.Checked = true then Grid1.OnClick(sender);
end;

procedure TForm1.Grid1Click(Sender: TObject);
begin
  if Grid1.Checked = true then
  begin
    ListView1.GridLines := true;
  end else begin
    ListView1.GridLines := false;
  end;
end;

procedure TForm1.SpeedButton7Click(Sender: TObject);
var fm: TForm3;
begin
 fm:=TForm3.Create(nil);
 fm.FormStyle := FormStyle;
 fm.ShowModal;
 fm.Free;
end;

procedure TForm1.C2Click(Sender: TObject);
begin
  SpeedButton4.Click;
end;

procedure TForm1.F1Click(Sender: TObject);
begin
  SpeedButton5.Click;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.ConvertBatch1Click(Sender: TObject);
begin
  SpeedButton3.Click;
end;

procedure TForm1.CheckBox11Click(Sender: TObject);
begin
  StatusBar1.SetFocus;
end;

procedure TForm1.CheckBox4Click(Sender: TObject);
begin
   StatusBar1.SetFocus;
end;

procedure TForm1.ClearDestinationfolder1Click(Sender: TObject);
begin
  if not DirectoryExists(Edit1.Text) then
  BEGIN
    Beep;
    ShowMessage('Folder not exists!');
    Exit;
  END;


  if MessageBox(Handle,'Clear Destination folder?',
                        'Confirm',MB_YESNO) = IDYES then
  BEGIN
    DeleteFile(Edit1.Text + '*.*');
    ShowMessage('Folder cleared.');
  END;
end;

end.
