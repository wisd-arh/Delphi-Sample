unit uGrPremiere;

interface
uses
  Classes, Graphics, utxtPremiere;
type
  TGrPremiere = class(txtPremiere)
  private
    FBitmap: TBitmap;
    FWidth: Integer;
    FHeigth: integer;
    FBgColor: integer;
    FFont: TFont;
    procedure SetWidth(const Value: Integer);
    procedure SetHeigth(const Value: integer);
    procedure SetBgColor(const Value: integer);
    procedure SetFont(const Value: TFont);
  public
    constructor Create(AOwner: TComponent);
    destructor Destroy; override;
    property Width: Integer read FWidth write SetWidth;
    property Heigth: integer read FHeigth write SetHeigth;
    property BgColor: integer read FBgColor write SetBgColor;
    property Font: TFont read FFont write SetFont;
    
  end;
implementation

{ TGrPremiere }

constructor TGrPremiere.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FBitmap:=TBitmap.Create;
  Width:=0;
  Height:=0;
end;

destructor TGrPremiere.Destroy;
begin
  try
    FBitmap.Free;
  finally
    FBitmap:=nil;
  end;
  inherited Destroy;
end;

procedure TGrPremiere.SetBgColor(const Value: integer);
begin
  FBgColor := Value;
end;

procedure TGrPremiere.SetFont(const Value: TFont);
begin
  FFont := Value;
end;

procedure TGrPremiere.SetHeigth(const Value: integer);
begin
  FHeigth := Value;
  FBitmap.Height :=FHeigth;
end;

procedure TGrPremiere.SetWidth(const Value: Integer);
begin
  FWidth := Value;
  FBitmap.Width :=FWidth;
end;

end.
