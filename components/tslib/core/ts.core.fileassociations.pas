{
  Copyright (C) 2013 Tim Sinaeve tim.sinaeve@gmail.com

  This library is free software; you can redistribute it and/or modify it
  under the terms of the GNU Library General Public License as published by
  the Free Software Foundation; either version 2 of the License, or (at your
  option) any later version.

  This library is distributed in the hope that it will be useful, but WITHOUT
  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  FITNESS FOR A PARTICULAR PURPOSE. See the GNU Library General Public License
  for more details.

  You should have received a copy of the GNU Library General Public License
  along with this library; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
}

{-------------------------------------------------------------------------------
The contents of this file are subject to the Mozilla Public License
Version 1.1 (the "License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at
http://www.mozilla.org/MPL/

Software distributed under the License is distributed on an "AS IS" basis,
WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for
the specific language governing rights and limitations under the License.

The Original Code is: uAssociate.pas

The Initial Developer of the Original Code is: AD <adsoft@nm.ru>
Copyright (c) 2005 ADSoft          
All Rights Reserved.

Alternatively, the contents of this file may be used under the terms of the
GNU General Public License Version 2 or later (the "GPL"), in which case
the provisions of the GPL are applicable instead of those above.
If you wish to allow use of your version of this file only under the terms
of the GPL and not to allow others to use your version of this file
under the MPL, indicate your decision by deleting the provisions above and
replace them with the notice and other provisions required by the GPL.
If you do not delete the provisions above, a recipient may use your version
of this file under either the MPL or the GPL.

$Id: uAssociate.pas,v 1.2 2006/03/15 09:38:14 adsoft Exp $
-------------------------------------------------------------------------------}

// based on original file uAssociate.pas

unit ts.Core.FileAssociations;

{$MODE Delphi}

interface

uses
  Classes, ComCtrls,

{$IFDEF Windows}
  Windows,
{$ENDIF WINDOWS}

  LCLIntf, LCLType, LMessages;

type
  TAssociateItem = class(TCollectionItem)
  private
    FExt: string;
    FDescr: string;
    FIcon: string;
    FBackup: string;
    FIsAssociate: Boolean;

  public
    property Ext: string
      read FExt write FExt;

    property Descr: string
      read FDescr write FDescr;

    property Icon: string
      read FIcon write FIcon;

    property Backup: string
      read FBackup write FBackup;

    property IsAssociate: Boolean
      read FIsAssociate write FIsAssociate;
  end;

  TAssociatesList = class(TCollection)
  protected
    function GetAssociateItem(Index: Integer): TAssociateItem;
    procedure SetAssociateItem(Index: Integer; const Value: TAssociateItem);
  public
    function Add: TAssociateItem;

    property Items[Index: Integer]: TAssociateItem
      read GetAssociateItem  write SetAssociateItem; default;
  end;

  TFileAssociate = class(TComponent)
  private
    FItems: TAssociatesList;
    FAppDescription: string;
    FAppShellCaption: string;
    FAppKey: string;
    FCommandLine: string;
    FRootKey: HKEY;
    FListView: TListView;

    FClasses: string;
    FClassesRoot: HKEY;

    function GetIsAssociateToContext: Boolean;
    function GetIsAssociateToUnknown: Boolean;
    function GetMenuCaption: string;
    procedure SetIsAssociateToContext(const Value: Boolean);
    procedure SetIsAssociateToUnknown(const Value: Boolean);
    procedure SetMenuCaption(const Value: string);
    procedure SetAppDescription(const Value: string);
    function GetAllUsers: Boolean;
    procedure SetAllUsers(const Value: Boolean);

  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    function AddItem(const AExt: string): TAssociateItem;
    procedure DeleteItem(const AIndex: integer);

    procedure AssociateExt(const AIndex: integer; const ADelete: Boolean = False);
    procedure AssociateItem(const AItem: TAssociateItem; const ADelete: Boolean = False);

    procedure LoadAssociates;
    procedure SaveAssociates;

    procedure WriteShell(const ARoot: string; const AEnable: Boolean);

    function GetAssociateNameByExt(const AExt: string): string;

    function GetDescr(const AExt: string): string;
    function GetIcon(const AExt: string): string;
    function GetBackup(const AExt: string): string;

    function IndexOf(const AExt: string): integer;

    function GetItemByExt(const AExt: string): TAssociateItem;

  published
    property Items: TAssociatesList read FItems write FItems;

    property IsAssociateToUnknown: Boolean
      read GetIsAssociateToUnknown write SetIsAssociateToUnknown;

    property IsAssociateToContext: Boolean
      read GetIsAssociateToContext write SetIsAssociateToContext;

    property MenuCaption: string
      read GetMenuCaption write SetMenuCaption;

    property CommandLine: string
      read FCommandLine write FCommandLine;

    property AppDescription: string
      read FAppDescription write SetAppDescription;

    property AppKey: string
      read FAppKey write FAppKey;

    property RootKey: HKEY
      read FRootKey write FRootKey;

    property AllUsers: Boolean
      read GetAllUsers write SetAllUsers;

    property ListView: TListView
      read FListView write FListView;
  end;

resourcestring
  SAllMenu              = '*';
  SUnknown              = 'Unknown';
  SMenuCaption          = 'MenuCaption';
  SAllUsers             = 'AssociateForAllUsers';
  SAssocKey             = '\Associate';
  SOtherAssocKey        = '\OtherAssociate';
  SOpenCaption          = 'OpenWith';
  SClassesKey           = 'Software\Classes\';

  SShell                = 'Shell';
  SOpen                 = 'Open';
  SCommand              = 'Command';
  SBackup               = 'Backup';
  SDefIcon              = 'DefaultIcon';
  SDefIconIndex         = '1';

  SExtDescrFormat       = '%s file';

type
  TRegKeyInfo = record
    NumSubKeys: Integer;
    MaxSubKeyLen: Integer;
    NumValues: Integer;
    MaxValueLen: Integer;
    MaxDataLen: Integer;
    FileTime: TFileTime;
  end;

const
  HKCU                  = HKEY_CURRENT_USER;
  HKLM                  = HKEY_LOCAL_MACHINE;
  HKCR                  = HKEY_CLASSES_ROOT;

resourcestring
  //SSoft                 = 'Software';
  //SRun                  = 'Software\Microsoft\Windows\CurrentVersion\Run';
  //SRunOnce              = 'Software\Microsoft\Windows\CurrentVersion\RunOnce';
  //SShell                = 'Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders';
  //SUnknownShell         = 'Unknown\Shell';
  //SDefShell             = '*\Shell';
  SHKCR                 = 'HKEY_CLASSES_ROOT';
  SHKCU                 = 'HKEY_CURRENT_USER';
  SHKLM                 = 'HKEY_LOCAL_MACHINE';

// Registry
function ADRegReadString(const ARoot: HKEY; const ASubKey, AName, ADefault: string): string;
function ADRegReadInteger(const ARoot: HKEY; const ASubKey, AName: string; const ADefault: integer): integer;
function ADRegReadBoolean(const ARoot: HKEY; const ASubKey, AName: string; const ADefault: boolean): boolean;

function ADRegWriteString(const ARoot: HKEY; const ASubKey, AName, AValue: string): integer;
function ADRegWriteInteger(const ARoot: HKEY; const ASubKey, AName: string; const AValue: integer): integer;
function ADRegWriteBoolean(const ARoot: HKEY; const ASubKey, AName: string; const AValue: boolean): integer;

function ADRegWriteStringEx(const ARoot: HKEY; const ASubKey, AName, AValue: string): integer;
function ADRegWriteIntegerEx(const ARoot: HKEY; const ASubKey, AName: string; const AValue: integer): integer;
function ADRegWriteBooleanEx(const ARoot: HKEY; const ASubKey, AName: string; const AValue: boolean): integer;

function ADRegCreateKey(const ARoot: HKEY; const ASubKey: string): boolean;
function ADRegDeleteKey(const ARoot: HKEY; const ASubKey: string): boolean;
function ADRegDeleteValue(const ARoot: HKEY; const ASubKey, AName: string): integer;
function ADGetKeyInfo(const ARoot: HKEY; const AKey: string; var Value: TRegKeyInfo): boolean;
function ADGetKeyInfoEx(const ARoot: HKEY; const AKey: string; var Value: TRegKeyInfo): boolean;
function ADRegKeyExist(const ARoot: HKEY; const ASubKey: string): boolean;
function ADRegValueExist(const ARoot: HKEY; const ASubKey, AName: string): boolean;
function ADRegCheckKey(const ARoot: HKEY; const ASubKey: string): boolean;
function ADRegCheckAccess(const ARoot: HKEY; const ASubKey: string; const samDesired: REGSAM): boolean;

// INI
function ADINIReadString(const AFilename, ASection, AKey, ADefault: string): string;
function ADINIReadInteger(const AFilename, ASection, AKey: string; const ADefault: integer): integer;
function ADINIReadBoolean(const AFilename, ASection, AKey: string; const ADefault: boolean): boolean;

function ADINIWriteString(const AFilename, ASection, AKey, AValue: string): boolean;
function ADINIWriteInteger(const AFilename, ASection, AKey: string; const AValue: integer): boolean;
function ADINIWriteBoolean(const AFilename, ASection, AKey: string; const AValue: boolean): boolean;

function ADINIDeleteKey(const AFilename, ASection, AKey: string): boolean;
function ADINIDeleteSection(const AFilename, ASection: string): boolean;


implementation

uses
  SysUtils;

{$region 'interfaced methods' /fold}
// Registry

function ADRegCheckAccess(const ARoot: HKEY; const ASubKey: string; const samDesired: REGSAM): boolean;
var
  HK: HKEY;
begin
  Result := False;
  if RegOpenKeyEx(ARoot, PChar(ASubKey), 0, samDesired, HK) = ERROR_SUCCESS then
  begin
    Result := True;
    RegCloseKey(HK);
  end;
end;

function ADRegCreateKey(const ARoot: HKEY; const ASubKey: string): boolean;
var
  HK: HKEY;
begin
  Result := RegCreateKeyEx(ARoot, PChar(ASubKey), 0, nil, 0,
    KEY_ALL_ACCESS, nil, HK, nil) = ERROR_SUCCESS;
end;

function ADRegDeleteKey(const ARoot: HKEY; const ASubKey: string): boolean;
begin
  Result := RegDeleteKey(ARoot, PChar(ASubKey)) =  ERROR_SUCCESS;
end;

function ADGetKeyInfo(const ARoot: HKEY; const AKey: string; var Value: TRegKeyInfo): boolean;
begin
  FillChar(Value, SizeOf(TRegKeyInfo), 0);
  Result := RegQueryInfoKey(ARoot, nil, nil, nil, @Value.NumSubKeys,
    @Value.MaxSubKeyLen, nil, @Value.NumValues, @Value.MaxValueLen,
    @Value.MaxDataLen, nil, @Value.FileTime) = ERROR_SUCCESS;
end;

function ADGetKeyInfoEx(const ARoot: HKEY; const AKey: string; var Value: TRegKeyInfo): boolean;
var
  HK: HKEY;
begin
  Result := False;
  if RegOpenKeyEx(ARoot, PChar(AKey), 0, KEY_QUERY_VALUE, HK) = ERROR_SUCCESS then
  try
    Result := ADGetKeyInfo(HK, AKey, Value);
  finally
    RegCloseKey(HK);
  end;
end;

function ADRegKeyExist(const ARoot: HKEY; const ASubKey: string): boolean;
var
  HK: HKEY;
begin
  Result := False;
  if RegOpenKeyEx(ARoot, PChar(ASubKey), 0, KEY_ALL_ACCESS, HK) = ERROR_SUCCESS then
    Result := RegCloseKey(HK) = ERROR_SUCCESS;
end;

function ADRegValueExist(const ARoot: HKEY; const ASubKey, AName: string): boolean;
var
  Flag: integer;
  HK: HKEY;
begin
  Result := False;
  if RegOpenKey(ARoot, PChar(ASubKey), HK) = ERROR_SUCCESS then
  begin
    Flag := REG_NONE;
    Result := RegQueryValueEx(HK, PChar(AName), nil, @Flag, nil, nil) = ERROR_SUCCESS;
    RegCloseKey(HK);
  end;
end;

function ADRegDeleteValue(const ARoot: HKEY; const ASubKey, AName: string): integer;
var
  HK: HKEY;
begin
  Result := -1;
  if RegOpenKeyEx(ARoot, PChar(ASubKey), 0, KEY_WRITE, HK) = ERROR_SUCCESS then
  begin
    Result := RegDeleteValue(HK, PChar(AName));
    RegCloseKey(HK);
  end
end;

function ADRegWriteString(const ARoot: HKEY; const ASubKey, AName, AValue: string): integer;
var
  HK: HKEY;
begin
  Result := -1;
  if RegOpenKeyEx(ARoot, PChar(ASubKey), 0, KEY_WRITE, HK) = ERROR_SUCCESS then
  begin
    Result := RegSetValueEx(HK, PChar(AName), 0, REG_SZ, PChar(AValue), Length(AValue));
    RegCloseKey(HK);
  end;
end;

function ADRegReadString(const ARoot: HKEY; const ASubKey, AName, ADefault: string): string;
var
  Buffer: pointer;
  MaxData, Flag: integer;
  HK: HKEY;
begin
  Result := ADefault;
  if RegOpenKey(ARoot, PChar(ASubKey), HK) = ERROR_SUCCESS then
  begin
    Flag := REG_SZ;
    Buffer := nil;
    if RegQueryValueEx(HK, PChar(AName), nil, @Flag, nil, @MaxData) = ERROR_SUCCESS then
      if MaxData > 0 then
      try
        GetMem(Buffer, MaxData);
        if RegQueryValueEx(HK, PChar(AName), nil, @Flag, Buffer, @MaxData) = ERROR_SUCCESS then
          SetString(Result, PChar(Buffer), MaxData - 1);
      finally
        FreeMem(Buffer, MaxData);
      end;
  end;
end;

function ADRegReadInteger(const ARoot: HKEY; const ASubKey, AName: string; const ADefault: integer): integer;
var
  R, Flag, DSize: integer;
  HK: HKEY;
begin
  Result := ADefault;
  if RegOpenKey(ARoot, PChar(ASubKey), HK) = ERROR_SUCCESS then
  begin
    Flag := REG_DWORD;
    DSize := SizeOf(DWORD);
    if RegQueryValueEx(HK, PChar(AName), nil, @Flag, @R, @DSize) = ERROR_SUCCESS then
      Result := R;
  end;
end;

function ADRegReadBoolean(const ARoot: HKEY; const ASubKey, AName: string; const ADefault: boolean): boolean;
begin
  Result := boolean(ADRegReadInteger(ARoot, ASubKey, AName, integer(ADefault)));
end;

function ADRegWriteInteger(const ARoot: HKEY; const ASubKey, AName: string; const AValue: integer): integer;
var
  HK: HKEY;
begin
  Result := -1;
  if RegOpenKeyEx(ARoot, PChar(ASubKey), 0, KEY_WRITE, HK) = ERROR_SUCCESS then
  begin
    Result := RegSetValueEx(HK, PChar(AName), 0, REG_DWORD, @AValue, SizeOf(DWORD));
    RegCloseKey(HK);
  end;
end;

function ADRegWriteBoolean(const ARoot: HKEY; const ASubKey, AName: string; const AValue: boolean): integer;
begin
  Result := ADRegWriteInteger(ARoot, ASubKey, AName, integer(AValue));
end;

function ADRegCheckKey(const ARoot: HKEY; const ASubKey: string): boolean;
begin
  if ADRegKeyExist(ARoot, ASubKey) then
    Result := True
  else
    Result := ADRegCreateKey(ARoot, ASubKey);
end;

function ADRegWriteStringEx(const ARoot: HKEY; const ASubKey, AName, AValue: string): integer;
begin
  Result := -1;
  if ADRegCheckKey(ARoot, ASubKey) then
    Result := ADRegWriteString(ARoot, ASubKey, AName, AValue);
end;

function ADRegWriteIntegerEx(const ARoot: HKEY; const ASubKey, AName: string; const AValue: integer): integer;
begin
  Result := -1;
  if ADRegCheckKey(ARoot, ASubKey) then
    Result := ADRegWriteInteger(ARoot, ASubKey, AName, AValue);
end;

function ADRegWriteBooleanEx(const ARoot: HKEY; const ASubKey, AName: string; const AValue: boolean): integer;
begin
  Result := -1;
  if ADRegCheckKey(ARoot, ASubKey) then
    Result := ADRegWriteBoolean(ARoot, ASubKey, AName, AValue);
end;

// INI

function ADINIReadString(const AFilename, ASection, AKey, ADefault: string): string;
var
 Buffer: array[0..2047] of Char;
begin
  SetString(Result, Buffer, GetPrivateProfileString(PChar(ASection), PChar(AKey),
    PChar(ADefault), Buffer, SizeOf(Buffer), PChar(AFilename)));
end;

function ADINIWriteString(const AFilename, ASection, AKey, AValue: string): boolean;
begin
  Result := WritePrivateProfileString(PChar(ASection), PChar(AKey), PChar(AValue),
    PChar(AFilename));
end;

function ADINIDeleteKey(const AFilename, ASection, AKey: string): boolean;
begin
  Result := WritePrivateProfileString(PChar(ASection), PChar(AKey), nil, PChar(AFilename));
end;

function ADINIDeleteSection(const AFilename, ASection: string): boolean;
begin
  Result := WritePrivateProfileSection(PChar(ASection), nil, PChar(AFilename));
end;

function ADINIReadInteger(const AFilename, ASection, AKey: string; const ADefault: integer): integer;
var
  S: string;
  Code: integer;
begin
  Str(ADefault, S);
  S := ADINIReadString(AFilename, ASection, AKey, S);
  Val(S, Result, Code);
end;

function ADINIWriteInteger(const AFilename, ASection, AKey: string; const AValue: integer): boolean;
var
  S: string;
begin
  Str(AValue, S);
  Result := ADINIWriteString(AFilename, ASection, AKey, S);
end;

function ADINIReadBoolean(const AFilename, ASection, AKey: string; const ADefault: boolean): boolean;
begin
  Result := boolean(ADINIReadInteger(AFilename, ASection, AKey, integer(ADefault)));
end;

function ADINIWriteBoolean(const AFilename, ASection, AKey: string; const AValue: boolean): boolean;
begin
  Result := ADINIWriteInteger(AFilename, ASection, AKey, integer(AValue));
end;
{$endregion}

{ TAssociatesList }

function TAssociatesList.Add: TAssociateItem;
begin
  Result := TAssociateItem(inherited Add);
end;

function TAssociatesList.GetAssociateItem(Index: Integer): TAssociateItem;
begin
  Result := TAssociateItem(inherited Items[Index]);
end;

procedure TAssociatesList.SetAssociateItem(Index: Integer;
  const Value: TAssociateItem);
begin
  Items[Index].Assign(Value);
end;

{ TFileAssociate }

function TFileAssociate.AddItem(const AExt: string): TAssociateItem;
var
  Item: TAssociateItem;
begin
  Result := nil;
  if IndexOf(AExt) <> -1 then
    Exit;

  Item := GetItemByExt(AExt);
  with Items.Add do
  begin
    Ext := Item.Ext;
    IsAssociate := Item.IsAssociate;
    Descr := Item.Descr;
    Icon := Item.Icon;
    Backup := Item.Backup;
  end;

  if Assigned(FListView) then
    with FListView.Items.Add do begin
      Caption := AExt;
      Checked := Item.IsAssociate;
    end;
  Result := Item;
end;

constructor TFileAssociate.Create(AOwner: TComponent);
begin
  inherited;
  FItems := TAssociatesList.Create(TAssociateItem);
  AppDescription := 'MyApp';
  CommandLine := '"' + ParamStr(0) + '" "%1"';
  FRootKey := HKEY_CURRENT_USER;
  AllUsers := False;
end;

procedure TFileAssociate.DeleteItem(const AIndex: integer);
begin
  FItems[AIndex].IsAssociate := False;
  AssociateExt(AIndex, True);
  FItems.Delete(AIndex);
  if Assigned(FListView) then
    FListView.Items[AIndex].Delete;
end;

destructor TFileAssociate.Destroy;
begin
  FItems.Free;
  inherited;
end;

function TFileAssociate.GetAssociateNameByExt(
  const AExt: string): string;
begin
  if (AExt <> SAllMenu) and (AExt <> SUnknown) then
    Result := FAppDescription + '_' + Copy(AExt, 2, Length(AExt))
  else
    Result := FAppDescription + '_' + AExt;
end;

function TFileAssociate.GetDescr(const AExt: string): string;
var
  S: string;
begin
  Result := ADRegReadString(FClassesRoot, FClasses + AExt, '', '');
  if Result = '' then
  begin
    Result := ADRegReadString(HKCR, AExt, '', '');
    if Result = '' then
    begin
      if (AExt <> SAllMenu) and (AExt <> SUnknown) then
      begin
        S := AnsiUpperCase(Copy(AExt, 2, Length(AExt)));
        Result := Format(SExtDescrFormat, [S]);
      end;
    end else
    begin
      S := ADRegReadString(HKCR, Result, '', '');
      if S <> '' then
        Result := S;
    end;
  end else
  begin
    S := ADRegReadString(FClassesRoot, FClasses + Result, '', '');
    if S <> '' then
      Result := S;
  end;
end;

function TFileAssociate.GetIcon(const AExt: string): string;
var
  S: string;
begin
  S := ADRegReadString(FClassesRoot, FClasses + AExt, '', '');
  if S = '' then
    S := ADRegReadString(HKCR, AExt, '', '');
  Result := ADRegReadString(FClassesRoot, FClasses + S + '\' + SDefIcon, '', '');
  if Result = '' then
  begin
    Result := ADRegReadString(HKCR, S + '\' + SDefIcon, '', '');
    if Result = '' then
      Result := ParamStr(0) + ',' + SDefIconIndex;
  end;
end;

function TFileAssociate.GetBackup(const AExt: string): string;
begin
  Result := ADRegReadString(FClassesRoot, FClasses + AExt + '\' + SBackup, '', '');
  if Result = GetAssociateNameByExt(AExt) then
    Result := '';
end;

function TFileAssociate.GetIsAssociateToContext: Boolean;
begin
  Result := ADRegReadString(FClassesRoot, FClasses + SAllMenu + '\' + SShell, '', '') = FAppShellCaption;
end;

function TFileAssociate.GetIsAssociateToUnknown: Boolean;
begin
  Result := ADRegReadString(FClassesRoot, FClasses + SUnknown + '\' + SShell, '', '') = FAppShellCaption;
end;

function TFileAssociate.GetMenuCaption: string;
begin
  Result := ADRegReadString(FRootKey, FAppKey, SMenuCaption, {GetLangStr('SDefMenuCaption')}'');
end;

procedure TFileAssociate.LoadAssociates;
var
  I: integer;
  Len: DWORD;
  Info: TRegKeyInfo;
  Key: string;
  Buffer: array [0..9] of Char;
  HK: HKEY;
begin
  Key := FAppKey + SAssocKey;
  if RegOpenKey(FRootKey, PChar(Key), HK) = ERROR_SUCCESS then
  try
    if not ADGetKeyInfo(HK, Key, Info) then
      Exit;
    FItems.Clear;
    if Assigned(FListView) then
      FListView.Clear;
    for I := 0 to Info.NumValues - 1 do
    begin
      Len := Info.MaxValueLen + 1;
      RegEnumValue(HK, I, Buffer, Len, nil, nil, nil, nil);
      AddItem(Buffer);
    end;
  finally
    RegCloseKey(HK);
  end;
end;

procedure TFileAssociate.SetAppDescription(const Value: string);
begin
  FAppDescription := Value;
  FAppShellCaption := SOpenCaption + FAppDescription;
end;

procedure TFileAssociate.SetIsAssociateToContext(const Value: Boolean);
begin
  WriteShell(SAllMenu, Value);
end;

procedure TFileAssociate.SetIsAssociateToUnknown(const Value: Boolean);
begin
  WriteShell(SUnknown, Value);
end;

procedure TFileAssociate.SetMenuCaption(const Value: string);
begin
  ADRegWriteStringEx(FRootKey, FAppKey, SMenuCaption, Value);
end;

function TFileAssociate.IndexOf(const AExt: string): integer;
var
  I: integer;
begin
  Result := -1;
  for I := 0 to FItems.Count - 1 do
    if FItems[I].Ext = AExt then begin
      Result := I;
      Exit;
    end;
end;

procedure TFileAssociate.AssociateItem(const AItem: TAssociateItem;
  const ADelete: Boolean);
var
  S: string;
begin
  with AItem do begin
    S := GetAssociateNameByExt(Ext);
    if IsAssociate then begin
      ADRegCreateKey(FClassesRoot, FClasses + S);
      ADRegCreateKey(FClassesRoot, FClasses + S + '\' + SDefIcon);
      ADRegCreateKey(FClassesRoot, FClasses + S + '\' + SBackup);
      ADRegCreateKey(FClassesRoot, FClasses + S + '\' + SShell);
      ADRegCreateKey(FClassesRoot, FClasses + S + '\' + SShell + '\' + SOpen);
      ADRegCreateKey(FClassesRoot, FClasses + S + '\' + SShell + '\' + SOpen + '\' + SCommand);
      ADRegWriteString(FClassesRoot, FClasses + S, '', Descr);
      ADRegWriteString(FClassesRoot, FClasses + S + '\' + SShell + '\' + SOpen, '', MenuCaption);
      ADRegWriteString(FClassesRoot, FClasses + S + '\' + SDefIcon, '', Icon);
      ADRegWriteString(FClassesRoot, FClasses + S + '\' + SBackup, '', Backup);
      ADRegWriteString(FClassesRoot, FClasses + S + '\' + SShell + '\' + SOpen + '\' + SCommand, '', FCommandLine);
      ADRegCreateKey(FClassesRoot, FClasses + Ext);
      ADRegWriteString(FClassesRoot, FClasses + Ext, '', S);

      ADRegCreateKey(FRootKey, FAppKey + SAssocKey);
      ADRegWriteString(FRootKey, FAppKey + SAssocKey, Ext, Backup);
    end else
    begin
      ADRegDeleteKey(FClassesRoot, FClasses + S + '\' + SShell + '\' + SOpen + '\' + SCommand);
      ADRegDeleteKey(FClassesRoot, FClasses + S + '\' + SShell + '\' + SOpen);
      ADRegDeleteKey(FClassesRoot, FClasses + S + '\' + SShell);
      ADRegDeleteKey(FClassesRoot, FClasses + S + '\' + SDefIcon);
      ADRegDeleteKey(FClassesRoot, FClasses + S + '\' + SBackup);
      ADRegDeleteKey(FClassesRoot, FClasses + S);

      if Backup <> '' then
        ADRegWriteString(FClassesRoot, FClasses + Ext, '', Backup)
      else
        ADRegDeleteKey(FClassesRoot, FClasses + Ext);
    end;
    if ADelete then
    begin
      ADRegDeleteValue(FRootKey, FAppKey + SAssocKey, Ext);
      ADRegDeleteKey(FRootKey, FAppKey + SAssocKey + SOtherAssocKey);
      ADRegDeleteKey(FRootKey, FAppKey + SAssocKey);
    end;
  end;
end;

procedure TFileAssociate.AssociateExt(const AIndex: integer; const ADelete: Boolean);
begin
  AssociateItem(Items[AIndex], ADelete);
end;

procedure TFileAssociate.SaveAssociates;
var
  I: integer;
begin
  for I := 0 to FItems.Count - 1 do
    AssociateExt(I);
end;

procedure TFileAssociate.WriteShell(const ARoot: string;
  const AEnable: Boolean);
var
  Backup: string;
  CanBackup: Boolean;
begin
  if AEnable then
  begin
    Backup := ADRegReadString(FClassesRoot, FClasses + ARoot + '\' + SShell, '', '');
    if Backup = FAppShellCaption then
      Backup := '';
    ADRegCreateKey(FClassesRoot, FClasses + ARoot);
    ADRegCreateKey(FClassesRoot, FClasses + ARoot + '\' + SShell);
    ADRegCreateKey(FClassesRoot, FClasses + ARoot + '\' + SShell + '\' + FAppShellCaption);
    ADRegCreateKey(FClassesRoot, FClasses + ARoot + '\' + SShell + '\' + FAppShellCaption + '\' + SCommand);

    ADRegWriteString(FClassesRoot, FClasses + ARoot + '\' + SShell, '', FAppShellCaption);
    ADRegWriteString(FClassesRoot, FClasses + ARoot + '\' + SShell + '\' + FAppShellCaption, '', MenuCaption);
    ADRegWriteString(FClassesRoot, FClasses + ARoot + '\' + SShell + '\' + FAppShellCaption + '\' + SCommand, '', FCommandLine);

    ADRegCreateKey(FRootKey, FAppKey + SAssocKey + SOtherAssocKey);
    ADRegWriteString(FRootKey, FAppKey + SAssocKey + SOtherAssocKey, ARoot, Backup);
  end else
  begin
    CanBackup := ADRegValueExist(FRootKey, FAppKey + SAssocKey + SOtherAssocKey, ARoot);
    if CanBackup then
      Backup := ADRegReadString(FRootKey, FAppKey + SAssocKey + SOtherAssocKey, ARoot, '');
    ADRegDeleteKey(FClassesRoot, FClasses + ARoot + '\' + SShell + '\' + FAppShellCaption + '\' + SBackup);
    ADRegDeleteKey(FClassesRoot, FClasses + ARoot + '\' + SShell + '\' + FAppShellCaption + '\' + SCommand);
    ADRegDeleteKey(FClassesRoot, FClasses + ARoot + '\' + SShell + '\' + FAppShellCaption);
    ADRegDeleteKey(FClassesRoot, FClasses + ARoot + '\' + SShell);
    ADRegDeleteKey(FClassesRoot, FClasses + ARoot);
    if CanBackup then
    begin
      ADRegWriteString(FClassesRoot, FClasses + ARoot + '\' + SShell, '', Backup);
      ADRegDeleteValue(FRootKey, FAppKey + SAssocKey + SOtherAssocKey, ARoot);
    end;
    ADRegDeleteKey(FRootKey, FAppKey + SAssocKey + SOtherAssocKey);
    ADRegDeleteKey(FRootKey, FAppKey + SAssocKey);
  end;
end;

function TFileAssociate.GetItemByExt(const AExt: string): TAssociateItem;
var
  Item: TAssociateItem;
  DescrStr, S: string;
  FDescr, FIcon, FBackup: string;
  IsAssociate: Boolean;
begin
  IsAssociate := False;
  DescrStr := ADRegReadString(FClassesRoot, FClasses + AExt, '', '');
  S := GetAssociateNameByExt(AExt);

  Item := TAssociateItem.Create(nil);
  Item.Ext := AExt;

  if DescrStr = S then          // Ext is associated for App
  begin
    FDescr := GetDescr(AExt);
    FIcon := GetIcon(AExt);
    FBackup := GetBackup(S);
    IsAssociate := True;
  end
  else
    if DescrStr = '' then       // Ext is not associated
    begin
      FDescr := GetDescr(AExt);
      FIcon := GetIcon(AExt);
      FBackup := GetBackup(AExt);
    end
    else
      if DescrStr <> '' then    // Ext is associated for other program
      begin
        FBackup := DescrStr;
        FDescr := GetDescr(AExt);
        FIcon := GetIcon(AExt);
        if FDescr = '' then
          FDescr := GetDescr(AExt);
      end;

  Item.IsAssociate := IsAssociate;
  Item.Descr := FDescr;
  Item.Icon := FIcon;
  Item.Backup := FBackup;

  Result := Item;
end;

function TFileAssociate.GetAllUsers: Boolean;
begin
  Result := ADRegReadBoolean(FRootKey, FAppKey, SAllUsers, False);
end;

procedure TFileAssociate.SetAllUsers(const Value: Boolean);
begin
  if Value and ADRegCheckAccess(HKCR, '', KEY_ALL_ACCESS) then
  begin
    FRootKey := HKLM;
    FClassesRoot := HKLM;
    FClasses := SClassesKey;
    ADRegWriteBooleanEx(FRootKey, FAppKey, SAllUsers, True)
  end
  else
  begin
    FRootKey := HKCU;
    FClassesRoot := HKCU;
    FClasses := SClassesKey;
    ADRegWriteBooleanEx(FRootKey, FAppKey, SAllUsers, False);
  end;
end;

end.
