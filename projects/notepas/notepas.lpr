program Notepas;

{$MODE objfpc}{$H+}

uses
  SysUtils,
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  notepas_forms_main,
  { you can add units after this }
  DefaultTranslator, pl_exsystem, pl_virtualtrees, FrameViewer09,
  lazrichedit, richmemopackage,

  sharedlogger, ipcchannel, pl_luicontrols, runtimetypeinfocontrols,
  pl_kcontrols, pl_zeosdbocomp, pl_zmsql, pl_richview, ts.Components.MultiPanel,
  ts.Components.DBGridView, ts.Components.Docking,
  ts.Components.Docking.OptionsDialog, ts.Components.Docking.Resources,
  ts.Components.Docking.Storage, ts.Components.ExportRTF,
  ts.Components.FileAssociation, ts.Components.GridView,
  ts.Components.Inspector, ts.Components.SynMiniMap,
  ts.Components.UNIHighlighter, ts.Components.UniqueInstance,
  ts.Components.XMLTree, ts.Components.XMLTree.Editors,
  ts.Components.XMLTree.NodeAttributes, ts_core_componentinspector,
  ts.Core.BRRE, ts.Core.BRREUnicode, ts.Core.NativeXml.Debug,
  ts.Core.NativeXml.Streams, ts.Core.NativeXml.StringTable,
  ts.Core.CodecUtilsWin32, ts.Core.Collections, ts.Core.ColumnDefinitions,
  ts.Core.ColumnDefinitionsDataTemplate,
  ts.Core.DataTemplates, ts.Core.DBUtils, ts.Core.DirectoryWatch,
  ts.Core.EncodingUtils, ts.Core.FormSettings, ts.Core.HashStrings,
  ts.Core.Helpers, ts.Core.KeyValues, ts.Core.NativeXml,
  ts.Core.NativeXml.ObjectStorage, ts.core.nativexml.win32compat,
  ts.Core.SQLParser, ts.Core.SQLScanner, ts.Core.SQLTree, ts.Core.StringUtils,
  ts.Core.TreeViewPresenter, ts.Core.Utils, ts.Core.Value, ts.Core.VersionInfo,
  ts.Core.XMLUtils, ts.Core.FileAssociations, ts.Editor.CodeFormatters,
  ts.Editor.CodeFormatters.SQL, ts.Editor.CodeTags, ts.Editor.Commands,
  ts.Editor.CommentStripper, ts.Editor.Helpers, ts.Editor.HighlighterAttributes,
  ts.Editor.Highlighters, ts.Editor.Interfaces, ts.Editor.Resources,
  ts.editor.searchengine, ts.Editor.Selection, ts.editor.settings,
  ts.Editor.Settings.AlignLines, ts.Editor.Settings.CodeShaper,
  ts.editor.settings.searchengine, ts.Editor.Utils, SetupFiltersDialog,
  ts_editor_toolview_actionlist, ts_editor_toolview_alignlines,
  ts_editor_toolview_base, ts_editor_toolview_charactermap,
  ts_editor_toolview_codefilter, ts_editor_toolview_codeshaper,
  ts_editor_toolview_hexeditor, ts_editor_toolview_htmlview,
  ts_editor_toolview_minimap, ts_editor_toolview_preview,
  ts_editor_toolview_scripteditor, ts_editor_toolview_search,
  ts_editor_toolview_selectioninfo, ts_editor_toolview_shortcuts,
  ts_editor_toolview_structure, ts_editor_toolview_test,
  ts_editor_toolview_viewlist, ts.RichEditor.Helpers, ts.RichEditor.Interfaces,
  ts.RichEditor.Manager, ts.RichEditor.TextAttributes, ts.RichEditor.View,

  ts.editor.toolview.manager, ts_editor_manager, ts_Editor_AboutDialog,
  ts_editor_settingsdialog_old, ts_editor_settingsdialog;

{$R *.res}

begin
  Application.Title := 'Notepas';
  //if FileExists('Notepas.trc') then
  //  DeleteFile('Notepas.trc');
  //SetHeapTraceOutput('Notepas.trc');
  RequireDerivedFormResource := True;
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
//  SetDefaultLang('nl');
  Application.Run;
end.

