program Notepas;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, notepas_forms_main,
  { you can add units after this }
  DefaultTranslator,

  richmemopackage
  ;

{$R *.res}

begin
  //if FileExists('NotePas.trc') then
  //  DeleteFile('NotePas.trc');
  //SetHeapTraceOutput('NotePas.trc');
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
