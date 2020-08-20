unit utxtPremiere;

interface
uses
  utxtParser, DateUtils, Dialogs, Windows, Messages, SysUtils, Graphics, ExtCtrls, Classes, Forms
  , uiGrFilters;

const
  WM_STARTPREMIERE = WM_USER + 1;
  InitCharDelay: double = 120;
  CharDelayStep: double = 0.5;
type
  TRunMode = (rmIdle, rmPremiere, rmPause);

  txtPremiere = class(txtParser)
  private
    FCharDelay: double;
    FCurMode: TRunMode;
    PrimaryBuf, SecondaryBuf: Graphics.TBitmap;
    FBgColor: TColor;
    FFont: TFont;
    FHeight: Integer;
    FWidth: Integer;
    FOwner: TComponent;
    FInitWordsAmount: SmallInt;
    FRunning: boolean;
    FCurLen: Integer;
    FPrPosition: Integer;
    FText: string;

    procedure SetCharDelay(const Value: double);
    procedure SetBgColor(const Value: TColor);
    procedure SetFont(const Value: TFont);
    procedure SetHeight(const Value: Integer);
    procedure SetWidth(const Value: Integer);
    procedure SetInitWordsAmount(const Value: SmallInt);
    procedure SetRunning(const Value: boolean);

    procedure SetFilter(const Rect: TRect);

    function GetPrPosition(): Integer;
    procedure SetPrPosition(const Value: Integer);
  public
    procedure OnTimer; overload;
    procedure StartTimer(const Delay: integer);
    procedure StopTimer;
    procedure ResetTimer;
    procedure IncCharDelay();
    procedure DecCharDelay();
    procedure IncWordsAmount();
    procedure DecWordsAmount();

    procedure Run;
    procedure TimeEvent;
    procedure StepOver;
    procedure Draw;

    property CharDelay: double read FCharDelay write SetCharDelay;
    property Bitmap: Graphics.TBitmap read PrimaryBuf;
    property Width: Integer read FWidth write SetWidth;
    property Height: Integer read FHeight write SetHeight;
    property BgColor: TColor read FBgColor write SetBgColor;
    property Font: TFont read FFont write SetFont;
    property InitWordsAmount: SmallInt read FInitWordsAmount write SetInitWordsAmount;
    property Running: boolean read FRunning write SetRunning;
    property CurLen: Integer read FCurLen;
    property PrPosition: Integer read GetPrPosition write SetPrPosition;
    property Text: string read FText;

    constructor Create(AOwner: TComponent);
    destructor Destroy(); override;
  end;

implementation

{ txtPremiere }
constructor txtPremiere.Create(AOwner: TComponent);
//var
//  lp: procedure(var Msg: TMsg) of object;
begin
  inherited Create;
  FCurMode:=rmIdle;
  FCharDelay:=InitCharDelay;
  PrimaryBuf:=TBitmap.Create;
  SecondaryBuf:=TBitmap.Create;
  FWidth:=0;
  FHeight:=0;
  FPrPosition:=0;
  FOwner:=AOwner;
  FText:='';

  InitWordsAmount:=1;
  FBgColor:=clWhite;
  FFont:=TFont.Create;
  FFont.Name:='Times New Roman';
  FFont.Size:=16;
  FFont.Color:=clBlack;
  Width:=100;
  Height:=100;
  FRunning:=false;
//  lp:=Self.OnTimer;

//  StartTimer;
end;

procedure txtPremiere.DecCharDelay;
begin
  FCharDelay:=FCharDelay - CharDelayStep;
end;

procedure txtPremiere.DecWordsAmount;
begin
  InitWordsAmount:=InitWordsAmount-1;
end;

destructor txtPremiere.Destroy;
begin
  PrimaryBuf.Free;
  SecondaryBuf.Free;
  FFont.Free;
  inherited Destroy;
end;

procedure txtPremiere.Draw;
begin
//
  with PrimaryBuf.Canvas do
    begin
      Brush.Color:=FBgColor;
      PrimaryBuf.Canvas.Font:=FFont;
      FillRect(Rect(0, 0, PrimaryBuf.Width, PrimaryBuf.Height));
      TextOut(PrimaryBuf.Width div 2 - TextWidth(FText) div 2, PrimaryBuf.Height div 2 - TextHeight(FText) div 2, FText);
      SetFilter(Rect(PrimaryBuf.Width div 2 - TextWidth(FText) div 2 - 1,
        PrimaryBuf.Height div 2 - TextHeight(FText) div 2 - 1,
        PrimaryBuf.Width div 2 + TextWidth(FText) div 2 + 1,
        PrimaryBuf.Height div 2 + TextHeight(FText) div 2 + 1));
    end;
  FCurLen:=Length(FText);
end;

function txtPremiere.GetPrPosition: Integer;
begin
//
  result:=GetFPosition() - CurLen;
end;

procedure txtPremiere.IncCharDelay;
begin
  FCharDelay:=FCharDelay + CharDelayStep;
end;

procedure txtPremiere.IncWordsAmount;
begin
  InitWordsAmount:=InitWordsAmount+1;
end;

procedure txtPremiere.OnTimer;
var
  s: string;
begin
  if FileProcessor = nil then
    exit;
  if FileProcessor.FileName = '' then
    exit;
  if not EOF then
    s:=NextWords(InitWordsAmount)
  else
    s:='Конец текста';

  FText:=s;

  Draw();

  StartTimer(trunc(CharDelay*sqrt(FCurLen)));

end;

procedure txtPremiere.ResetTimer;
begin
//
end;

procedure txtPremiere.Run;
begin
  StartTimer(trunc(CharDelay));
  Running:=true;
end;

procedure txtPremiere.SetBgColor(const Value: TColor);
begin
  FBgColor := Value;
end;

procedure txtPremiere.SetCharDelay(const Value: double);
begin
  if Value > 0 then
    FCharDelay := Value;
end;

procedure txtPremiere.SetFilter(const Rect: TRect);
begin
//  Blur(PrimaryBuf, Rect);
end;

procedure txtPremiere.SetFont(const Value: TFont);
begin
  FFont.Assign(Value);
end;

procedure txtPremiere.SetHeight(const Value: Integer);
begin
  FHeight := Value;
  if PrimaryBuf <> nil then
    PrimaryBuf.Height:=FHeight;
  if SecondaryBuf <> nil then
    SecondaryBuf.Height:=FHeight;
end;

procedure txtPremiere.SetInitWordsAmount(const Value: SmallInt);
begin
  if Value > 0 then
    FInitWordsAmount := Value;
end;

procedure txtPremiere.SetPrPosition(const Value: Integer);
begin
//
  SetFPosition(Value);
end;

procedure txtPremiere.SetRunning(const Value: boolean);
begin
  FRunning := Value;
end;

procedure txtPremiere.SetWidth(const Value: Integer);
begin
  FWidth := Value;
  if PrimaryBuf <> nil then
    PrimaryBuf.Width:=FWidth;
  if SecondaryBuf <> nil then
    SecondaryBuf.Width:=FWidth;
end;

procedure txtPremiere.StartTimer(const Delay: Integer);
begin
  if Delay > 0 then
    SetTimer((FOwner as TForm).Handle, 1, Delay, nil);
end;

procedure txtPremiere.StepOver;
begin
  PreviousWord();
end;

procedure txtPremiere.StopTimer;
begin
  KillTimer((FOwner as TForm).Handle, 1);
  Running:=false;
end;

procedure txtPremiere.TimeEvent;
begin
//
end;

end.
