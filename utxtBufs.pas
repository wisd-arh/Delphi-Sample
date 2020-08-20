unit utxtBufs;

interface
uses
  SysUtils, Dialogs, utxtFilter;

const
  InitBlockSize = 65536;
type
  PByte = PChar;

  txtBuf = class(TObject)
  private
    PrimaryBuf: Pbyte;
    SecondaryBuf: Pbyte;

    PrimaryBufSize, SecondaryBufSize: integer;
    FFileName: string;
    fhandle: integer;
    FFileSize: Integer;
    fPosition: Integer;
    FBlockSize: Integer;
    FDataSize: Integer;
    SecDataSize: Integer;
    FEOF: boolean;
    FFilter: txtFilter;
    procedure SetFileName(const Value: string);
    procedure SetFileSize(const Value: Integer);
    procedure SetBlockSize(const Value: Integer);
    procedure ReadBlock();
    procedure FreeBufs();
    procedure AllocBufs();
    procedure SetDataSize(const Value: Integer);
    function GetText: String;
  public
    property FileSize: Integer read FFileSize write SetFileSize;
    property FileName: string read FFileName write SetFileName;
    property BlockSize: Integer read FBlockSize write SetBlockSize;
    property DataSize: Integer read FDataSize write SetDataSize;
    property EOF: boolean read FEOF;
    property Text: String read GetText;
    property Buffer: PByte read PrimaryBuf;
    procedure SwapBuffers();
    procedure LoadFile(VFileName: String);
    procedure CloseFile();
    procedure Read();
    procedure ReadNSwap();

    procedure SetFilePosition(const Value: integer);
    function GetFilePosition(): integer;

    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ txtBuf }

procedure txtBuf.AllocBufs;
begin
  FreeBufs();
  try
    GetMem(PrimaryBuf, BlockSize);
  except
    on E: Exception do
      begin
        ShowMessage('Error allocation memory.'+#13+E.Message);
        PrimaryBuf:=nil;
      end;
  end;
  try
    GetMem(SecondaryBuf, BlockSize);
  except
    on E: Exception do
      begin
        ShowMessage('Error allocation memory.'+#13+E.Message);
        SecondaryBuf:=nil;
      end;
  end;
end;

procedure txtBuf.CloseFile;
begin
  if fhandle > 0 then
    try
      FileClose(fhandle);
    finally
      fhandle:=-1;
      FileSize:=-1;
      fPosition:=0;
      FileName:='';
    end;
end;

constructor txtBuf.Create;
begin
  inherited;
  FileSize:=-1;
  fPosition:=0;
  FileName:='';
  PrimaryBuf:=nil;
  SecondaryBuf:=nil;
  PrimaryBufSize:=0;
  SecondaryBufSize:=0;
  fhandle:=-1;
  BlockSize:=InitBlockSize;
  FEOF:=false;

  FFilter:=txtFilter.Create();
end;

destructor txtBuf.Destroy;
begin
  CloseFile();
  FreeBufs();
  FFilter.Free();
  inherited Destroy;
end;

procedure txtBuf.FreeBufs;
begin
  if PrimaryBuf <> nil then
    try
      FreeMem(PrimaryBuf);
    finally
      PrimaryBuf:=nil;
    end;
  if SecondaryBuf <> nil then
    try
      FreeMem(SecondaryBuf);
    finally
      SecondaryBuf:=nil;
    end;
end;

function txtBuf.GetFilePosition: integer;
begin
  result:=fPosition;
end;

function txtBuf.GetText: String;
var
  s: string;
begin
  if DataSize <> 0 then
    begin
      SetLength(s, DataSize);
      Move(PrimaryBuf^, S[1], DataSize);
      result:=S;
    end
  else
    result:='';
end;

procedure txtBuf.LoadFile(VFileName: String);
begin
  if fHandle > 0 then
    CloseFile;
  try
    fhandle:=FileOpen(VFileName, fmOpenRead);
  except
    on E: Exception do
      ShowMessage('Can''t load file.'+#13+E.ClassName+' raise '+E.Message);
  end;
  if fhandle > 0 then
    begin
      FileSize:= FileSeek(fHandle,0,2);
      FileSeek(fHandle,0,0);
      FileName:=VFileName;
      FEOF:=false;
    end;
end;

procedure txtBuf.Read;
begin
  if (fHandle > 0) and (FEOF = false) then
    ReadBlock();
end;

procedure txtBuf.ReadBlock();
begin
  FileSeek(fHandle,fPosition,0);
  SecDataSize:=FileRead(fhandle, SecondaryBuf^, BlockSize);
  if SecDataSize <> BlockSize then
    FEOF:=true;
  fPosition:=fPosition+SecDataSize;

// TODO filter
  FFilter.Filter(SecondaryBuf, SecDataSize);
end;

procedure txtBuf.ReadNSwap;
begin
  Read();
  SwapBuffers();
end;

procedure txtBuf.SetBlockSize(const Value: Integer);
begin
  FBlockSize := Value;
  FreeBufs();
  AllocBufs();
end;

procedure txtBuf.SetDataSize(const Value: Integer);
begin
  FDataSize := Value;
end;

procedure txtBuf.SetFileName(const Value: string);
begin
  FFileName := Value;
end;

procedure txtBuf.SetFilePosition(const Value: integer);
begin
  if (Value >=0) and (Value < FFileSize) then
    fPosition:=Value;
end;

procedure txtBuf.SetFileSize(const Value: Integer);
begin
  FFileSize := Value;
end;

procedure txtBuf.SwapBuffers;
var
  t: Pbyte;
  ts: integer;
begin
  t:=PrimaryBuf;
  PrimaryBuf:=SecondaryBuf;
  SecondaryBuf:=t;

  ts:=PrimaryBufSize;
  PrimaryBufSize:=SecondaryBufSize;
  SecondaryBufSize:=ts;

//  ts:=DataSize;
  DataSize:=SecDataSize;
  SecDataSize:=0;
end;

end.
