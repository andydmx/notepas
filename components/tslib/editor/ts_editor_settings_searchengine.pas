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

unit ts_Editor_Settings_SearchEngine;

{$mode delphi}

//*****************************************************************************

interface

uses
  Classes, Forms, Controls;

//=============================================================================

type
  TSearchEngineSettings = class(TPersistent)
  public
    procedure AfterConstruction; override;
    procedure AssignTo(Dest: TPersistent); override;
    procedure Assign(Source: TPersistent); override;
  end;

//*****************************************************************************

implementation

//*****************************************************************************
// construction and destruction                                          BEGIN
//*****************************************************************************

procedure TSearchEngineSettings.AfterConstruction;
begin
  inherited AfterConstruction;
end;

//*****************************************************************************
// construction and destruction                                            END
//*****************************************************************************

//*****************************************************************************
// public methods                                                        BEGIN
//*****************************************************************************

procedure TSearchEngineSettings.AssignTo(Dest: TPersistent);
begin
  inherited AssignTo(Dest);
end;

procedure TSearchEngineSettings.Assign(Source: TPersistent);
begin
  inherited Assign(Source);
end;

//*****************************************************************************
// public methods                                                          END
//*****************************************************************************

end.


