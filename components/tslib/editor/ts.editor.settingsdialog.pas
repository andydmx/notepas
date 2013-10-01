{
  Copyright (C) 2013 Tim Sinaeve tim.sinaeve@gmail.com

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version.

  This program is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

unit ts.Editor.SettingsDialog;

{$MODE Delphi}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls,

  VirtualPages;

type

  { TEditorSettingsDialog }

  TEditorSettingsDialog = class(TForm)
    lbxPages    : TListBox;
    pnlLeft     : TPanel;
    pnlRight    : TPanel;
    splVertical : TSplitter;

    procedure lbxPagesClick(Sender: TObject);

  private
    FVPM : TVirtualPageManager;

  public
    procedure AfterConstruction; override;
  end;

implementation

{$R *.lfm}

uses
  ts.Editor.SettingsDialog.FileAssociations,
  ts.Editor.SettingsDialog.FileTypes,
  ts.Editor.SettingsDialog.KeyMappings,
  ts.Editor.SettingsDialog.Highlighters;

{$region 'construction and destruction' /fold}
procedure TEditorSettingsDialog.AfterConstruction;
begin
  inherited AfterConstruction;
  FVPM := TVirtualPageManager.Create(Self);
  FVPM.DisplayOptions.Parent := pnlRight;
  FVPM.Pages.Add(
    'FileAssociations',
    'File associations',
    TfrmOptionsAssociate,
    []
  );
  FVPM.Pages.Add(
    'FileTypes',
    'File types',
    TfrmFileTypeSettings,
    []
  );
  FVPM.Pages.Add(
    'KeyMappings',
    'Key mappings',
    TfrmKeyMappings,
    []
  );
  FVPM.Pages.Add(
    'Highlighters',
    'Highlighters',
    TfrmOptionsThemes,
    []
  );
  //TfrmOptionsThemes
  FVPM.Pages.AssignTo(lbxPages.Items);
end;
{$endregion}

{$region 'event handlers' /fold}
procedure TEditorSettingsDialog.lbxPagesClick(Sender: TObject);
begin
  FVPM.PageIndex := lbxPages.ItemIndex;
end;
{$endregion}

end.

