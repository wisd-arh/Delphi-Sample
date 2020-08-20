program Reader;

{%ToDo 'Reader.todo'}

uses
  Forms,
  ufmMain in 'ufmMain.pas' {Form1},
  utrLoad in 'utrLoad.pas',
  utxtBufs in 'utxtBufs.pas',
  utxtParser in 'utxtParser.pas',
  utxtPremiere in 'utxtPremiere.pas',
  uiGrFilters in 'uiGrFilters.pas',
  uConfig in 'uConfig.pas',
  utxtFilter in 'utxtFilter.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
