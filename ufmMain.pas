unit ufmMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, StdCtrls, ExtCtrls, StrUtils, DateUtils, ImgList, Word2000,
  OleServer, Menus, ComCtrls, ToolWin, Forms,
  utxtBufs, utxtParser, utxtPremiere, utrLoad, uConfig, uGrPremiere;


type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Timer1: TTimer;
    ProgressBar1: TProgressBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    FontDialog1: TFontDialog;
    N4: TMenuItem;
    N5: TMenuItem;
    ColorDialog1: TColorDialog;
    N6: TMenuItem;
    WordDocument1: TWordDocument;
    WordLetterContent1: TWordLetterContent;
    WordApplication1: TWordApplication;
    StatusBar1: TStatusBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    StatTimer: TTimer;
    Panel1: TPanel;
    Label1: TLabel;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Label2: TLabel;
    Image1: TImage;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure StatTimerTimer(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
  private
    { Private declarations }
    procedure CreateNewPremiere(); overload;
    procedure CreateNewPremiere(FileName: String); overload;
    procedure DestroyPremiere();
    procedure DrawScene();

    procedure AssignFont;
    procedure AssignBgColor;

    procedure SetFromPosition(Value: string);
    procedure SetBgColor(Value: string);
    procedure SaveConfig();
    procedure SetDefFileName(Value: string);
    procedure FileLoad();

    procedure DropBookmark();
    procedure ClearBookmark();
    procedure GotoBookMark();
    procedure StepOver();
    procedure StepIn();
    procedure OpenWordDoc();
    procedure NewStatTimer();
    procedure KillStatTimer();

    procedure PlayPausePremiere();
    procedure StartPremiere();
    procedure StopPremiere();
    procedure ClearImage();
    procedure FullScreen();
    procedure HideFullScreen();
    procedure ShowFullScreen();
  public

    { Public declarations }
    procedure ResendMessage(var Message: TMessage); message WM_STARTPREMIERE;
    procedure OnTimer(var Msg: TMsg); message WM_TIMER;
    procedure paintword;
    procedure KeyPressTo(var Msg: TMsg); message WM_CHAR;
    procedure InitTimer;
    procedure StopTimer;

  end;

var
  Form1: TForm1;
  TimerSpeed: Integer;
implementation
{$R *.dfm}

const
  InitTimerSpeed = 200;
  TimerStep = 2;
  TempFileName = '$%temp.txt';
var
  MainBuf: txtBuf;
  MainParser: txtParser;
//  MainGrPremiere: TGrPremiere;
  MainPr: txtPremiere;
//  ctrLoad: trLoad;
//  InitWordsAmount: SmallInt;
  spC, spP: Integer;
  rdrCfg: rdrConfig;
  PrBgColor: integer;
  cfName: string;
  stReadTime: TDateTime;
  stReadSize: integer;
  cWordsNumber: integer;
  cCharDelay: double;
  cTextColor: integer;
  TopForm: TForm;

procedure TForm1.Button3Click(Sender: TObject);
begin
//
  FileLoad();
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  s: string;
begin
  MainBuf:=nil;
  MainParser:=nil;
  MainPr:=nil;
  cfName:='';
{
  FBitmap:=TBitmap.Create();
  FBitmap.Width:=Image1.Width;
  FBitmap.Height:=Image1.Height;
  with FBitmap.Canvas do
    begin
      Brush.Color:=clWhite;
      Pen.Color:=clBlack;
      Font.Name:='Times New Roman';
      Font.Size:=12;
      Font.Color:=clBlack;
    end;
}
  TimerSpeed := InitTimerSpeed;
  ProgressBar1.Position:=0;
//  InitWordsAmount:=1;
  rdrCfg := rdrConfig.Create();
  s:=rdrCfg.ReadKey(rckFormPosition);
  SetFromPosition(s);
  s:=rdrCfg.ReadKey(rckBgColor);
  SetBgColor(s);
  s:=rdrCfg.ReadKey(rckFileName);
  SetDefFileName(s);

  s:=rdrCfg.ReadKey(rckCharDelay);
  cCharDelay:=StrToFloat(s);
  s:=rdrCfg.ReadKey(rckWordsNumber);
  cWordsNumber:=StrToInt(s);

  s:=rdrCfg.ReadKey(rckTextColor);
  cTextColor:=StrToInt(s);

  ClearImage();
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  SendMessage(HInstance , WM_STARTPREMIERE, 0, 0);
end;

procedure TForm1.ResendMessage(var Message: TMessage);
begin
//  MainPr.StarTimer(Message);
end;

procedure TForm1.OnTimer(var Msg: TMsg);
begin
  MainPr.OnTimer;
  DrawScene();
  
  spC:= trunc(60000/((MainPr.CharDelay*sqrt(MainPr.CurLen))/MainPr.CurLen));
  StatusBar1.Panels[1].Text:=IntToStr(trunc((spC+spP)/2.0));
  spP:= spC;

  Inc(stReadSize, MainPr.CurLen);
  Label2.Caption:=IntToStr(stReadSize)+ ' /' + IntToStr(trunc(100*stReadSize/MainPr.FileProcessor.FileSize))+'%';
  ProgressBar1.Position:=MainPr.PrPosition;


//  paintword;
//  Image1.Picture.Assign(FBitmap);
end;

procedure TForm1.paintword;
//var
//  s: string;
begin

{
  if MainParser = nil then
    exit;
  if not MainParser.EOF then
    s:=MainParser.NextWords(InitWordsAmount)
  else
    s:='Конец текста';
{
  with FBitmap.Canvas do
    begin
      FillRect(Rect(0, 0, FBitmap.Width, FBitmap.Height));
      TextOut(FBitmap.Width div 2 - TextWidth(s) div 2, FBitmap.Height div 2 - Font.Size div 2, S);
    end;
}
end;


procedure TForm1.KeyPressTo(var Msg: TMsg);
begin
//  DispatchMessage(Msg);
end;

procedure TForm1.InitTimer;
begin
  SetTimer(Handle, 1, TimerSpeed, nil);
  ProgressBar1.Position:=ProgressBar1.Max - TimerSpeed;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not Assigned(MainPr) then begin
    case Key of
      113: StartPremiere();//F2
      70: FullScreen(); //'F'
    end;
    exit;
  end;
  case Key of
    32: PlayPausePremiere();
    33: StepIn(); // PageUp;
    34: StepOver(); // PageDown;
    37: Dec(TimerSpeed, TimerStep); // Left
    38: MainPr.IncWordsAmount; // Up
    39: Inc(TimerSpeed, TimerStep); // Right
    40: MainPr.DecWordsAmount; // Down;

    70: FullScreen(); //'F'

    107: MainPr.DecCharDelay; // +
    109: MainPr.IncCharDelay;  // -
    187: MainPr.DecCharDelay; // =(+)
    189: MainPr.IncCharDelay;  // -

    114: PlayPausePremiere();//F3
    115: StopPremiere();//F4
    117: DropBookmark();// F6
    120: GotoBookmark();// F9
    123: ClearBookmark(); //F12
  end;
//  InitTimer;
end;

procedure TForm1.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if not Assigned(MainPr) then
    exit;
  case Button of
    mbLeft: MainPr.Run;
    mbRight: MainPr.StopTimer;
  end;
end;

procedure TForm1.StopTimer;
begin
  KillTimer(Handle, 1);
end;

procedure TForm1.N3Click(Sender: TObject);
begin
  Form1.Close;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
  if Assigned(MainPr) then begin
    if (cfName = '') then
      FileLoad();
    if (cfName <> '') then begin
      MainPr.StopTimer;
      MainPr.LoadFile(cfName);
      MainPr.Run;
    end;
  end else
    CreateNewPremiere;
end;

procedure TForm1.CreateNewPremiere;
var
  ex: string;
begin
  if not Assigned(MainPr) then
    begin
      if cfName = '' then
        FileLoad();
      if cfName <> '' then begin
//
        ex:=UpperCase(ExtractFileExt(cfName));
        if ex = '.DOC' then begin
          OpenWordDoc();
//          exit;
        end;
        MainPr:=txtPremiere.Create(Form1);
        MainPr.Width:=Form1.ClientWidth - 10;
        MainPr.Height:=180;
        MainPr.LoadFile(cfName);
        MainPr.Font:=FontDialog1.Font;
        MainPr.InitWordsAmount:=cWordsNumber;
        MainPr.CharDelay:=cCharDelay;
        MainPr.Font.Color:=cTextColor;
        
        MainPr.Run;
        ProgressBar1.Min:=1;
        ProgressBar1.Position:=1;
        ProgressBar1.Max:=MainPr.FileProcessor.FileSize;

        StatusBar1.Panels[2].Text:=IntToStr(MainPr.FileProcessor.FileSize);
        NewStatTimer();
      end;
    end;
end;

procedure TForm1.DestroyPremiere;
begin
  if Assigned(MainPr) then
    begin
      rdrCfg.UpdateKey(rckWordsNumber, IntToStr(MainPr.InitWordsAmount));
      rdrCfg.UpdateKey(rckCharDelay, FloatToStr(MainPr.CharDelay));
      MainPr.StopTimer;
      MainPr.Free;
      MainPr:=nil;
      KillStatTimer();
    end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);

begin
{  if FileExists(TempFileName) then
    try
      DeleteFile(TempFileName);
    except
    end;}
  DestroyPremiere();
  SaveConfig();
end;

procedure TForm1.N5Click(Sender: TObject);
begin
  AssignFont;
end;

procedure TForm1.AssignFont;
begin
  if FontDialog1.Execute then
    if Assigned(MainPr) then
      begin
        MainPr.StopTimer;
        MainPr.Font:=FontDialog1.Font;
        cTextColor:=FontDialog1.Font.Color;
      end;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  AssignBgColor;
end;

procedure TForm1.AssignBgColor;
begin
  if ColorDialog1.Execute then begin
    PrBgColor:=ColorDialog1.Color;
    if Assigned(MainPr) then
      begin
        MainPr.StopTimer;
        MainPr.BgColor:=PrBgColor;
      end;

  end;
end;

procedure TForm1.CreateNewPremiere(FileName: String);
begin
  cfName:=FileName;
  StatusBar1.Panels[0].Text:=cfName;
  CreateNewPremiere();
(*  if not Assigned(MainPr) then
    begin
      ex:=UpperCase(ExtractFileExt(cfName));
      if ex = '.DOC' then begin
        OpenWordDoc();
        exit;
      end;

      MainPr:=txtPremiere.Create(Form1);
      MainPr.Width:=Form1.ClientWidth - 10;
      MainPr.Height:=180;
      MainPr.LoadFile(FileName);
      MainPr.Font:=FontDialog1.Font;
      MainPr.Run;

        ProgressBar1.Min:=1;
        ProgressBar1.Position:=1;
        ProgressBar1.Max:=MainPr.FileProcessor.FileSize;

    end;
*)
end;

procedure TForm1.SetFromPosition(Value: string);
var
  s: string;
  k: integer;
begin
//
  if (Length(Value) = 0) then
    exit;
  k:=Pos(',', Value);
  s:=LeftStr(Value, k-1);
  s:=Trim(s);
  Form1.Left:=StrToInt(s);
  s:=RightStr(Value, Length(Value) - k - 1);
  s:=Trim(s);
  Form1.Top:=StrToInt(s);

end;

procedure TForm1.SaveConfig;
var
  s: string;
begin
  s:=IntToStr(Left) + ', ' + IntToStr(Top);
  rdrCfg.UpdateKey(rckFormPosition, s);
  rdrCfg.UpdateKey(rckBgColor, IntToStr(PrBgColor));
  rdrCfg.UpdateKey(rckFileName, cfName);
  rdrCfg.UpdateKey(rckTextColor, IntToStr(cTextColor));
  rdrCfg.WriteAll();
end;

procedure TForm1.SetBgColor(Value: string);
begin
//
  if (Length(Value) = 0) then
    exit;
  PrBgColor:=StrToInt(Value);
end;

procedure TForm1.FormActivate(Sender: TObject);
begin


  if Assigned(MainPr) then begin
//    MainPr.OnTimer;
    Form1.Canvas.Draw(5, 40, MainPr.Bitmap)
  end

end;

procedure TForm1.SetDefFileName(Value: string);
begin
//
  cfName:=Value;
  StatusBar1.Panels[0].Text:=cfName;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
  FileLoad();
end;

procedure TForm1.FileLoad;
begin
  if OpenDialog1.Execute then begin
    cfName:=OpenDialog1.FileName;
    StatusBar1.Panels[0].Text:=cfName;
  end;
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
  StartPremiere();
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  StopPremiere();
end;

procedure TForm1.ClearBookmark;
begin
//
  rdrCfg.WriteKey(rckBookmark, '');
end;

procedure TForm1.DropBookmark;
begin
//
  rdrCfg.WriteKey(rckBookmark, IntToStr(MainPr.PrPosition));
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
  DropBookmark();
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
  ClearBookmark();
end;

procedure TForm1.GotoBookMark;
var
  s: string;
begin
  if Assigned(MainPr) then begin
    s:=rdrCfg.ReadKey(rckBookmark);
    if s <> '' then begin
      MainPr.PrPosition:=StrToInt(s);
      MainPr.OnTimer();
      DrawScene();
      MainPr.StopTimer();
    end;
  end;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
//
  PlayPausePremiere();
end;

procedure TForm1.DrawScene;
begin
//
  if Assigned(TopForm) then
    TopForm.Canvas.Draw(TopForm.Width div 2 - MainPr.Bitmap.Width div 2, TopForm.Height div 2 - MainPr.Bitmap.Height div 2, MainPr.Bitmap)
  else
    Image1.Picture.Bitmap.Canvas.Draw(5, 40, MainPr.Bitmap);
end;

procedure TForm1.StepOver;
begin
//
  MainPr.StepOver;
  MainPr.Draw;
  DrawScene;

end;

procedure TForm1.StepIn;
begin
//
  MainPr.OnTimer();
  DrawScene;
end;

procedure TForm1.OpenWordDoc();
var

  FileName: OleVariant;
  ConfirmConversions: OleVariant;
  ReadOnly: OleVariant;
  AddToRecentFiles: OleVariant;
  PasswordDocument: OleVariant;
  PasswordTemplate: OleVariant;
  Revert: OleVariant;
  WritePasswordDocument: OleVariant;
  WritePasswordTemplate: OleVariant;
  Format: OleVariant;
  Encoding: OleVariant;
  Visible: OleVariant;
  Convert: Olevariant;
  Index: Olevariant;

  SaveChanges: OleVariant;
  OriginalFormat: OleVariant;
  RouteDocument: OleVariant;

  LockComments: OleVariant;
  Password: OleVariant;
//  AddToRecentFiles: OleVariant;
  WritePassword: OleVariant;
  ReadOnlyRecommended: OleVariant;
  EmbedTrueTypeFonts: OleVariant;
  SaveNativePictureFormat: OleVariant;
  SaveFormsData: OleVariant;
  SaveAsAOCELetter: OleVariant;
begin
//
  if cfName = '' then
    FileLoad();
  if cfName = '' then exit;

  FileName:=OleVariant(cfName);
  ConfirmConversions:= false;
  ReadOnly:= false;
  AddToRecentFiles:= false;
  PasswordDocument:= '';
  PasswordTemplate:= '';
  Revert:= false;
  WritePasswordDocument:='';
  WritePasswordTemplate:='';
  Format:=wdOpenFormatAuto;
  Encoding:= wdFormatDocument ;
  Visible:= false;
//WordDocument1.ConnectTo(
  WordApplication1.Documents.Open(FileName, ConfirmConversions,
                   ReadOnly, AddToRecentFiles,
                   PasswordDocument, PasswordTemplate,
                   Revert, WritePasswordDocument,
                   WritePasswordTemplate, Format,
                   Encoding, Visible);

  Convert:=wdFormatText;
  FileName:=ExtractFileDir(Application.ExeName)+'\' + TempFileName;
{
  WordDocument1.SaveAs(FileName,  Convert);
  WordDocument1.Close;
}

  Index:=1;
//  WordDocument1:=TWordDocument(WordApplication1.Documents.Item(Index));
//  WordDocument1.SaveAs(FileName,  Convert);
//  WordDocument1.Close;

  SaveChanges:=wdDoNotSaveChanges;
  OriginalFormat:=wdOriginalDocumentFormat;
  RouteDocument:=false;
  LockComments:=true;
  Password:='';
  AddToRecentFiles:=false;
  WritePassword:='';
  ReadOnlyRecommended:=false;
  EmbedTrueTypeFonts:=false;
  SaveNativePictureFormat:=true;
  SaveFormsData:=false;
  SaveAsAOCELetter:=false;

  WordApplication1.Documents.Item(Index).SaveAs(FileName,  Convert,
  LockComments,
  Password,
  AddToRecentFiles,
  WritePassword,
  ReadOnlyRecommended,
  EmbedTrueTypeFonts,
  SaveNativePictureFormat,
  SaveFormsData,
  SaveAsAOCELetter
  );

  WordApplication1.Documents.Item(Index).Close(SaveChanges, OriginalFormat, RouteDocument);
  WordApplication1.Quit;

//  CreateNewPremiere(String(FileName));
  cfName:=String(FileName);

//  WordDocument1.SaveAs(Name);
//    WordDocument1.ConnectTo();
//  D.Merge(Edit1.Text);

//  WordDocument1.Connect;

end;

procedure TForm1.NewStatTimer;
var
  s: string;
begin
  stReadTime:=0;
  stReadSize:=0;
  DateTimeToString(s, 'hh:mm:ss', stReadTime);
  Label1.Caption:=s;
  StatTimer.Enabled:=true;
end;

procedure TForm1.StatTimerTimer(Sender: TObject);
var
  s: string;
begin
  stReadTime:=IncMilliSecond(stReadTime, StatTimer.Interval);
  DateTimeToString(s, 'hh:mm:ss', stReadTime);
  Label1.Caption:=s;
end;

procedure TForm1.PlayPausePremiere;
begin
//
  if Assigned(MainPr) then
    if MainPr.Running then begin
      MainPr.StopTimer();
      StatTimer.Enabled:=false;
    end else begin
      MainPr.Run();
      StatTimer.Enabled:=true;
    end;
end;

procedure TForm1.KillStatTimer;
begin
//
  StatTimer.Enabled:=false;
end;

procedure TForm1.ToolButton9Click(Sender: TObject);
begin
//
  GotoBookMark();
end;

procedure TForm1.StartPremiere;
begin
//
  CreateNewPremiere();
  MainPr.BgColor:=PrBgColor;
  ToolButton8.Enabled:=true;
  ToolButton4.Enabled:=true;
  ToolButton2.Enabled:=false;
end;

procedure TForm1.StopPremiere;
begin
  DestroyPremiere;
  ToolButton8.Enabled:=false;
  ToolButton4.Enabled:=false;
  ToolButton2.Enabled:=true;

  ClearImage();
  {
  ctrLoad.Terminate;
//  while not ctrLoad.Terminated do;
  ctrLoad.Free;
}
end;

procedure TForm1.ClearImage;
var
  bm: TBitmap;
begin
  bm:=TBitmap.Create();
  bm.Width:=Image1.Width;
  bm.Height:=Image1.Height;
  bm.Canvas.Brush.Color:=Form1.Color;
  bm.Canvas.FillRect(Rect(0, 0, bm.Width, bm.Height));
  Image1.Picture.Bitmap.Assign(bm);
  bm.Free();

end;

procedure TForm1.FullScreen;
begin
//
  if Assigned(TopForm) then
    HideFullScreen
  else
    ShowFullScreen;
end;

procedure TForm1.HideFullScreen;
begin
  if Assigned(TopForm) then begin
    TopForm.Close;
    TopForm:=nil;
    Form1.Show();
    Form1.SetFocus();
  end;
end;

procedure TForm1.ShowFullScreen;
var
  Screen: TScreen;
begin
  
  Screen:=TScreen.Create(self);
  TopForm:=TForm.Create(self);
  TopForm.Top:=0;
  TopForm.Left:=0;
  TopForm.Width:=Screen.DesktopWidth;
  TopForm.Height:=Screen.DesktopHeight;
  TopForm.BorderStyle:=bsNone;
  TopForm.Color:=clBlack;
  TopForm.FormStyle:=fsStayOnTop;
  TopForm.OnKeyDown:=Form1.FormKeyDown;
  Screen.Free();
  self.Hide();
  TopForm.Show;
end;

end.
