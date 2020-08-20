unit utrLoad;

interface

uses
  Classes, Windows, Messages, SysUtils, utxtPremiere;

type
  exMode = (trmFRead, trmCRead, trmSwapBufs);

  trLoad = class(TThread)
  private
    { Private declarations }
    MainPr: txtPremiere;
    FOwner: TComponent;
  protected
    procedure Execute; override;
  public
    property Terminated;
    constructor Create(CreateSuspended: Boolean; AOwner: TComponent);
    destructor Destroy; override;
  end;


implementation

{ Important: Methods and properties of objects in VCL or CLX can only be used
  in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure trLoad.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end; }


{ trLoad }
constructor trLoad.Create(CreateSuspended: Boolean; AOwner: TComponent);
begin
  inherited Create(CreateSuspended);
  MainPr:=nil;
  FOwner:=AOwner;
end;

destructor trLoad.Destroy;
begin
  if MainPr <> nil then
    try
      MainPr.StopTimer;
      MainPr.Destroy;
    finally
      MainPr:=nil;
    end;
  inherited;
end;

procedure trLoad.Execute;
begin
  if MainPr = nil then
    MainPr:=txtPremiere.Create(FOwner);
  while not Terminated do
    MainPr.Run;
end;

end.
