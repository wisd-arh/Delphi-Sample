unit utxtParser;

interface
uses
  utxtBufs;

const
  Delimetres: Set of Char = [' ', #$D, #$A];
  Space: Char = ' ';
type
  txtParser = class
  private
    FFileProcessor: txtBuf;
    FCurPosition: Integer;
    FEOF: boolean;

  protected
    procedure SetFPosition(const Value: integer);
    function GetFPosition(): integer;
  public
    constructor Create;
    destructor Destroy; override;
    property FileProcessor: txtBuf read FFileProcessor;
    property EOF: boolean read FEOF;

    procedure LoadFile(VFileName: string);
    procedure CloseFile();
    function NextWord(): string;
    function NextWords(Count: Integer): string;
    function PreviousWord(): string;

  end;
implementation

{ txtParser }

procedure txtParser.CloseFile;
begin
  if FileProcessor <> nil then
    FileProcessor.CloseFile;
  FCurPosition:=-1;
end;

constructor txtParser.Create;
begin
  FFileProcessor:=nil;
  FCurPosition:=-1;
  FEOF:=false;
end;

destructor txtParser.Destroy;
begin
  if FileProcessor <> nil then
    FileProcessor.Destroy();
  inherited Destroy;
end;

function txtParser.GetFPosition: integer;
begin
//
  result:=0;
  if Assigned(FileProcessor) then
    result:=FileProcessor.GetFilePosition() - FileProcessor.BlockSize + FCurPosition;
end;

procedure txtParser.LoadFile(VFileName: string);
begin
  if FileProcessor = nil then
    FFileProcessor:=txtBuf.Create;
  FileProcessor.LoadFile(VFileName);
  FEOF:=false;
end;

function txtParser.NextWord: string;
var
  s: string;
//  i: integer;
  b: Char;
begin
  S:='';
  if FCurPosition = -1 then
    begin
      FileProcessor.ReadNSwap;
      FCurPosition:=0;
      FEOF:=FileProcessor.DataSize = 0;
    end;

  while FCurPosition <> FileProcessor.DataSize do
    begin
      b:=FileProcessor.Buffer[FCurPosition];
      Inc(FCurPosition);
      if b in Delimetres then
        break;
      S:=Concat(s, b);
      if FCurPosition = FileProcessor.DataSize then
        begin
          FCurPosition:=0;
          FileProcessor.ReadNSwap;
          FEOF:=FileProcessor.DataSize = 0;
        end;
    end;

  while (FileProcessor.Buffer[FCurPosition] in Delimetres) and (FCurPosition < FileProcessor.DataSize) do
    Inc(FCurPosition);

  if (FCurPosition = FileProcessor.DataSize) and (FileProcessor.DataSize <> 0) then
    begin
      FCurPosition:=0;
      FileProcessor.ReadNSwap;
      FEOF:=FileProcessor.DataSize = 0;
    end;
  result:=s;
end;

function txtParser.NextWords(Count: Integer): string;
var
  i: integer;
begin
  result:='';
  for i:=1 to Count do
    result:=result + Space + Self.NextWord;
end;

function txtParser.PreviousWord: string;
var
  s: string;
//  i: integer;
  b: Char;
begin
  S:='';
  if FCurPosition = -1 then
    begin
      FileProcessor.ReadNSwap;
      FCurPosition:=0;
      FEOF:=FileProcessor.DataSize = 0;
    end;

  while FCurPosition >= 0 do
    begin
      b:=FileProcessor.Buffer[FCurPosition];
      Dec(FCurPosition);
      if b in Delimetres then
        break;
      S:=Concat(s, b);
      if FCurPosition = 0 then
        begin
          FCurPosition:=0;
          FileProcessor.ReadNSwap;
          FEOF:=FileProcessor.DataSize = 0;
        end;
    end;

  while (FileProcessor.Buffer[FCurPosition] in Delimetres) and (FCurPosition > 0) do
    Dec(FCurPosition);

  if (FCurPosition = 0) and (FileProcessor.DataSize <> 0) then
    begin
      FCurPosition:=0;
      FileProcessor.ReadNSwap;
      FEOF:=FileProcessor.DataSize = 0;
    end;
  result:=s;
end;

procedure txtParser.SetFPosition(const Value: integer);
begin
//
  if Assigned(FileProcessor) then begin
    FCurPosition:=0;
    FileProcessor.SetFilePosition(Value);
    FileProcessor.ReadNSwap;
  end;
end;

end.
