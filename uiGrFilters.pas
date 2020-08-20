unit uiGrFilters;

interface
  uses Graphics, Types;

const
  Blur_m: array [0..2, 0..2] of double = ((0, 1, 0),(1, 0.5, 1),(0, 1, 0));
  Blur_s: double = 1/4.5;

type
  PInteger = ^Integer;
  procedure Blur(var Bm: TBitmap; Rect: TRect);
implementation
var
  AWidth, AHeight: Integer;

function RPixSum(const i, j: integer; const Bm: TBitmap): double;
begin
  with Bm.Canvas do
  result:=(Pixels[i-1, j-1]and $FF)*Blur_m[0, 0] +
          (Pixels[i-1, j  ]and $FF)*Blur_m[0, 1] +
          (Pixels[i-1, j+1]and $FF)*Blur_m[0, 2] +
          (Pixels[i  , j-1]and $FF)*Blur_m[1, 0] +
          (Pixels[i  , j  ]and $FF)*Blur_m[1, 1] +
          (Pixels[i  , j+1]and $FF)*Blur_m[1, 2] +
          (Pixels[i+1, j-1]and $FF)*Blur_m[2, 0] +
          (Pixels[i+1, j  ]and $FF)*Blur_m[2, 1] +
          (Pixels[i+1, j+1]and $FF)*Blur_m[2, 2];
end;

function GPixSum(const i, j: integer; const Bm: TBitmap): double;
begin
  with Bm.Canvas do
  result:=(Pixels[i-1, j-1] and $FF00)*Blur_m[0, 0] +
          (Pixels[i-1, j  ] and $FF00)*Blur_m[0, 1] +
          (Pixels[i-1, j+1] and $FF00)*Blur_m[0, 2] +
          (Pixels[i  , j-1] and $FF00)*Blur_m[1, 0] +
          (Pixels[i  , j  ] and $FF00)*Blur_m[1, 1] +
          (Pixels[i  , j+1] and $FF00)*Blur_m[1, 2] +
          (Pixels[i+1, j-1] and $FF00)*Blur_m[2, 0] +
          (Pixels[i+1, j  ] and $FF00)*Blur_m[2, 1] +
          (Pixels[i+1, j+1] and $FF00)*Blur_m[2, 2];
end;

function BPixSum(const i, j: integer; const Bm: TBitmap): double;
begin
  with Bm.Canvas do
  result:=(Pixels[i-1, j-1] and $FF0000)*Blur_m[0, 0] +
          (Pixels[i-1, j  ] and $FF0000)*Blur_m[0, 1] +
          (Pixels[i-1, j+1] and $FF0000)*Blur_m[0, 2] +
          (Pixels[i  , j-1] and $FF0000)*Blur_m[1, 0] +
          (Pixels[i  , j  ] and $FF0000)*Blur_m[1, 1] +
          (Pixels[i  , j+1] and $FF0000)*Blur_m[1, 2] +
          (Pixels[i+1, j-1] and $FF0000)*Blur_m[2, 0] +
          (Pixels[i+1, j  ] and $FF0000)*Blur_m[2, 1] +
          (Pixels[i+1, j+1] and $FF0000)*Blur_m[2, 2];
end;

function SumComp(const i, j: integer; const Bm: TBitmap): integer;
begin
  result:=($00FF0000 and trunc(Blur_s*BPixSum(i, j, Bm))) or
          ($0000FF00 and trunc(Blur_s*GPixSum(i, j, Bm))) or
          ($000000FF and trunc(Blur_s*RPixSum(i, j, Bm)));
end;
//********************************************
function GetPixs(const Pixs: PInteger; const i, j: integer): Integer;
begin
  result:=Integer((Pointer(PChar(Pixs) + AHeight*i*sizeof(Integer) + j*sizeof(Integer)))^)
end;

function _RPixSum(const i, j: integer; const Pixs: PInteger): double;
begin
  result:=(GetPixs(Pixs, i-1, j-1) and $FF)*Blur_m[0, 0] +
          (GetPixs(Pixs, i-1, j  ) and $FF)*Blur_m[0, 1] +
          (GetPixs(Pixs, i-1, j+1) and $FF)*Blur_m[0, 2] +
          (GetPixs(Pixs, i  , j-1) and $FF)*Blur_m[1, 0] +
          (GetPixs(Pixs, i  , j  ) and $FF)*Blur_m[1, 1] +
          (GetPixs(Pixs, i  , j+1) and $FF)*Blur_m[1, 2] +
          (GetPixs(Pixs, i+1, j-1) and $FF)*Blur_m[2, 0] +
          (GetPixs(Pixs, i+1, j  ) and $FF)*Blur_m[2, 1] +
          (GetPixs(Pixs, i+1, j+1) and $FF)*Blur_m[2, 2];
end;

function _GPixSum(const i, j: integer; const Pixs: PInteger): double;
begin
  result:=(GetPixs(Pixs, i-1, j-1) and $FF00)*Blur_m[0, 0] +
          (GetPixs(Pixs, i-1, j  ) and $FF00)*Blur_m[0, 1] +
          (GetPixs(Pixs, i-1, j+1) and $FF00)*Blur_m[0, 2] +
          (GetPixs(Pixs, i  , j-1) and $FF00)*Blur_m[1, 0] +
          (GetPixs(Pixs, i  , j  ) and $FF00)*Blur_m[1, 1] +
          (GetPixs(Pixs, i  , j+1) and $FF00)*Blur_m[1, 2] +
          (GetPixs(Pixs, i+1, j-1) and $FF00)*Blur_m[2, 0] +
          (GetPixs(Pixs, i+1, j  ) and $FF00)*Blur_m[2, 1] +
          (GetPixs(Pixs, i+1, j+1) and $FF00)*Blur_m[2, 2];
end;

function _BPixSum(const i, j: integer; const Pixs: PInteger): double;
begin
  result:=(GetPixs(Pixs, i-1, j-1) and $FF0000)*Blur_m[0, 0] +
          (GetPixs(Pixs, i-1, j  ) and $FF0000)*Blur_m[0, 1] +
          (GetPixs(Pixs, i-1, j+1) and $FF0000)*Blur_m[0, 2] +
          (GetPixs(Pixs, i  , j-1) and $FF0000)*Blur_m[1, 0] +
          (GetPixs(Pixs, i  , j  ) and $FF0000)*Blur_m[1, 1] +
          (GetPixs(Pixs, i  , j+1) and $FF0000)*Blur_m[1, 2] +
          (GetPixs(Pixs, i+1, j-1) and $FF0000)*Blur_m[2, 0] +
          (GetPixs(Pixs, i+1, j  ) and $FF0000)*Blur_m[2, 1] +
          (GetPixs(Pixs, i+1, j+1) and $FF0000)*Blur_m[2, 2];
end;

function _SumComp(const i, j: integer; const Pixs: PInteger): integer;
begin
  result:=($00FF0000 and trunc(Blur_s*_BPixSum(i, j, Pixs))) or
          ($0000FF00 and trunc(Blur_s*_GPixSum(i, j, Pixs))) or
          ($000000FF and trunc(Blur_s*_RPixSum(i, j, Pixs)));
end;

procedure ExtractPixs(const Bm: TBitmap; const Rect: TRect; var Pixs: PInteger);
var
  i, j: integer;
  p1  : PInteger;
begin
  for i:=0 to AWidth-1 do
    for j:=0 to AHeight-1 do
      begin
        p1:=Pointer(PChar(Pixs) + AHeight*i*sizeof(Integer) + j*sizeof(Integer));
//        p2:=Pointer(j);
        p1^:=Bm.Canvas.Pixels[Rect.Left+i, Rect.Top+j];
      end;
end;

procedure Blur(var Bm: TBitmap; Rect: TRect);
var
  i, j: integer;
  T: TBitmap;
  Pixs: PInteger;
begin
  with Rect do
    begin
      if Left < 1 then Left:=1;
      if Top < 1 then Top:=1;
      if Right >= Bm.Width-1 then Right:=Bm.Width-2;
      if Bottom >= Bm.Height-1 then Bottom:=Bm.Height-2;
    end;

  AWidth:=(Rect.Right-Rect.Left+1+2);
  AHeight:=(Rect.Bottom-Rect.Top+1+2);

  GetMem(Pixs, AWidth*AHeight*sizeof(integer));
  ExtractPixs(Bm, Rect, Pixs);
  T:=TBitmap.Create;
  T.Assign(Bm);
  for i:=1 to AWidth-2 do
    for j:=1 to AHeight-2 do
      with T.Canvas do
        Pixels[Rect.Left+i, Rect.Top+j]:=_SumComp(i, j, Pixs);
//        GetPixs(Pixs, i, j);



  FreeMem(Pixs);
  Bm.Free;
  Bm:=T;
end;

end.
