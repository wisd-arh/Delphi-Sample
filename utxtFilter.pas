unit utxtFilter;

interface
uses SysUtils;

type
  FilterPair = record
    From: Char;
    To_: Char;
  end;


  txtFilter = class
  private
    FilterArr : array of FilterPair;
  public
    procedure Filter(Buf: PChar; Size: Integer);
    constructor Create();
    destructor Destroy(); override;
  end;

implementation


{ txtFilter }

constructor txtFilter.Create;
begin
  SetLength(FilterArr, 1);
  FilterArr[0].From := #$09;
  FilterArr[0].To_ := #$20;
end;

destructor txtFilter.Destroy;
begin

  inherited;
end;

procedure txtFilter.Filter(Buf: PChar; Size: Integer);
var
  i: Integer;
  k, l: PChar;

begin
  GetMem(l, 2);
  l[1]:=#0;
  for i:=0 to High(FilterArr) do begin
    repeat
      l[0]:=FilterArr[i].From;
      k:=StrPos(Buf, l);
      if (k <> nil) then begin
        k^:=FilterArr[i].To_;
      end;
    until (k = nil);
  end;
  FreeMem(l);
end;

end.
