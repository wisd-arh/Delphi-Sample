unit uConfig;

interface
uses
  Forms, SysUtils, Dialogs,
  uTxtPremiere; // const InitCharDelay

const
  rckFormPosition = 'FormPosition';
  rckBgColor = 'BackgroundColor';
  rckFileName = 'FileName';
  rckBookmark = 'Bookmark';
  rckCharDelay = 'CharDelay';
  rckWordsNumber = 'WordsNumber';
  rckTextColor = 'TextColor';

type
  confStr = record
    Key: string;
    Value: string;
  end;

  rdrConfig = class

  private
    FconfFileName: string;
    FcfgFileHandle: integer;
    cfgKeySet: array of confStr;

    procedure OpenCfgFile;
    procedure CloseCfgFile;
    procedure CreateDefaultConfig();
    procedure ReadKeySet();
    procedure WriteKeySet();
    procedure ParseFileBuffer(buf: array of byte; size: integer);
    procedure OpenEmptyCfgFile();
    procedure CreateDefaultKeySet();
    function GetConfFileName(): string;
  public
    property confFileName: string read GetConfFileName;
    function ReadKey(Key: string): string;
    procedure WriteKey(Key: string; Value: string);
    procedure UpdateKey(Key: string; Value: string);
    procedure WriteAll();

    constructor Create;
    destructor Destroy; override;
  end;
{ rdrConfig }

implementation
const
  defconfFileName = 'reader.ini';
  cchEqu: char = '=';
  cchDelimeter: char = ';';
  cchStrEnd = [' ', #$A, #$D];

procedure rdrConfig.CloseCfgFile;
begin
  if (FcfgFileHandle >= 0) then
    FileClose(FcfgFileHandle);
  FcfgFileHandle:=-1;
end;

constructor rdrConfig.Create;
begin
  FconfFileName:=defconfFileName;
  FcfgFileHandle:=-1;
  cfgKeySet:=nil;
end;

procedure rdrConfig.CreateDefaultConfig;
begin
  //
  OpenEmptyCfgFile();
// todo
  CreateDefaultKeySet();
  WriteKeySet();
  CloseCfgFile();
end;

procedure rdrConfig.CreateDefaultKeySet;

begin
//
  SetLength(cfgKeySet, 7);
  cfgKeySet[0].Key:=rckFormPosition;
  cfgKeySet[0].Value:='10, 10';

  cfgKeySet[1].Key:=rckBgColor;
  cfgKeySet[1].Value:=IntToStr($FFFFFF);

  cfgKeySet[2].Key:=rckFileName;
  cfgKeySet[2].Value:='';

  cfgKeySet[3].Key:=rckBookmark;
  cfgKeySet[3].Value:='';

  cfgKeySet[4].Key:=rckCharDelay;
  cfgKeySet[4].Value:=FloatToStr(InitCharDelay);

  cfgKeySet[5].Key:=rckWordsNumber;
  cfgKeySet[5].Value:='1';

  cfgKeySet[6].Key:=rckTextColor;
  cfgKeySet[6].Value:='0';
end;

destructor rdrConfig.Destroy;
begin
//
  inherited;
end;

function rdrConfig.GetConfFileName: string;
begin
//
  result:=ExtractFilePath(Application.ExeName) + FconfFileName;
end;

procedure rdrConfig.OpenCfgFile;
begin
  if (not FileExists(confFileName)) then
    CreateDefaultConfig();

  FcfgFileHandle:=FileOpen(confFileName, fmOpenReadWrite);
  if (FcfgFileHandle<0) then begin
    ShowMessage('Unable open config file.');
    exit;
  end;
end;

procedure rdrConfig.OpenEmptyCfgFile;
begin
//
  if FcfgFileHandle > 0 then
    CloseCfgFile();
  FcfgFileHandle:=FileCreate(confFileName);
  if (FcfgFileHandle < 0) then begin
    ShowMessage('Unable to create default config file.');
    exit;
  end;
end;

procedure rdrConfig.ParseFileBuffer(buf: array of byte; size: integer);
var
  i, j: integer;
  tkey, tvalue: string;
begin
//
  i:=0;
  j:=0;
  SetLength(cfgKeySet, 0);
  while (i < size) do begin
    tkey:='';
    while ((i < size) and (buf[i] <> byte(cchEqu))) do begin
      tkey:=tkey + char(buf[i]);
      inc(i);
    end;
    inc(i); // '='
    while ((i < size) and (char(buf[i]) in cchStrEnd)) do
      inc(i);

    tvalue:='';
    while ((i < size) and (buf[i] <> byte(cchDelimeter))) do begin
      tvalue:=tvalue + char(buf[i]);
      inc(i);
    end;
    inc(i); // ';'
    while ((i < size) and (char(buf[i]) in cchStrEnd)) do
      inc(i);

    tkey := Trim(tkey);
    tvalue := Trim(tvalue);
    inc(j);
    SetLength(cfgKeySet, j);
    cfgKeySet[High(cfgKeySet)].Key:=tKey;
    cfgKeySet[High(cfgKeySet)].Value:=tValue;
  end;
end;

function rdrConfig.ReadKey(Key: string): string;
var
  i: integer;
begin
//
  result:='';
  if Length(cfgKeySet) = 0 then begin
    OpenCfgFile();
    ReadKeySet();
    CloseCfgFile();
  end;
  for i:=0 to High(cfgKeySet) do begin
    if (Key = cfgKeySet[i].Key) then begin
      result:= cfgKeySet[i].Value;
      break;
    end;
  end;
end;

procedure rdrConfig.ReadKeySet;
var
  buf: array of byte;
  size: integer;
  n: integer;
begin
//
  if (FcfgFileHandle = -1) then
    OpenCfgFile();

  size:= FileSeek(FcfgFileHandle, 0, 2);
  FileSeek(FcfgFileHandle, 0, 0);
  if size <= 0 then begin
    ShowMessage('Wrong config file.');
    CreateDefaultConfig();
    exit;
  end;
  SetLength(buf, size);
  n:=FileRead(FcfgFileHandle, buf[0], size);
  if (n <> size) then begin
    ShowMessage('Config file read error.');
    exit;
  end;

  ParseFileBuffer(buf, size);
  SetLength(buf, 0);
end;

procedure rdrConfig.UpdateKey(Key, Value: string);
var
  i: integer;
begin
//
  i:=0;
  while (i<= High(cfgKeySet)) do begin
    if (Key = cfgKeySet[i].Key) then begin
      cfgKeySet[i].Value:=Value;
      break;
    end;
    inc(i);
  end;
  if (i > High(cfgKeySet)) then begin
    SetLength(cfgKeySet, Length(cfgKeySet) + 1);
    cfgKeySet[High(cfgKeySet)].Key := Key;
    cfgKeySet[High(cfgKeySet)].Value:=Value;
  end;
end;

procedure rdrConfig.WriteAll;
begin
//
  OpenEmptyCfgFile();
  WriteKeySet();
  CloseCfgFile();
end;

procedure rdrConfig.WriteKey(Key, Value: string);
begin
//
  UpdateKey(Key, Value);
  WriteAll();
end;

procedure rdrConfig.WriteKeySet;
var
  s: string;
  i, k: integer;
begin
//
  for i:=0 to High(cfgKeySet) do begin
    s:=cfgKeyset[i].Key + ' ' +  cchEqu  + ' ' + cfgKeySet[i].Value + cchDelimeter + #$D + #$A;
    k := FileWrite(FcfgFileHandle, s[1], Length(s));
    if (k <> Length(s)) then begin
      ShowMessage('Config file write error.');
      exit;
    end;
  end;
end;

end.
