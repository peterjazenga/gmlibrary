unit UMainFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.Buttons;

type
  TMainFrm = class(TForm)
    Label1: TLabel;
    eMajor: TSpinEdit;
    eMinor: TSpinEdit;
    eRelease: TSpinEdit;
    eBuild: TSpinEdit;
    Label2: TLabel;
    ePath: TEdit;
    bOk: TButton;
    Label3: TLabel;
    eSources: TEdit;
    procedure bOkClick(Sender: TObject);
  private
    procedure ChangeVersionD6ToD7;
    procedure ChangeVersionD2007;
    procedure ChangeVersionD2009ToXE;
    procedure ChangeVersionXE2ToXe4;
    procedure ChangeSourceVersion(Path: string);
  public
  end;

var
  MainFrm: TMainFrm;

implementation

uses
  System.IniFiles;

const
  cntDesc = 'GoogleMaps Library v%d.%d.%d (Copyright © Xavier Martínez - cadetill)';
  cntDescVCL = 'GoogleMaps Library v%d.%d.%d VCL (Copyright © Xavier Martínez - cadetill)';
  cntDescFMX = 'GoogleMaps Library v%d.%d.%d FMX (Copyright © Xavier Martínez - cadetill)';
  cntDescEdit = 'GoogleMaps Library Editors (Copyright © Xavier Martínez - cadetill)';
  descCompanyName = 'www.cadetill.com';
  descInternalName = 'GMLib';
  descLegalCopyright = 'Copyright © Xavier Martínez - cadetill';
  descProductName = 'GoogleMaps Library';

{$R *.dfm}

procedure TMainFrm.bOkClick(Sender: TObject);
begin
  ChangeVersionD6ToD7;
  ChangeVersionD2007;
  ChangeVersionD2009ToXE;
  ChangeVersionXE2ToXe4;
  ChangeSourceVersion(eSources.Text);
end;

procedure TMainFrm.ChangeSourceVersion(Path: string);
const
  txtVersion = '@version ';
  cntVersion = '  @version %d.%d.%d';
  GMLIB_Version = 'GMLIB_Version';
  GMLIB_VerText = 'GMLIB_VerText';
  cntGMLIB_Version = '  GMLIB_Version = ''[%d.%d.%d Final]'';';
  cntGMLIB_VerText = '  GMLIB_VerText = ''%d.%d.%d Final'';';
var
  Search: TSearchRec;
  Files: integer;
  L: TStringList;
  i: Integer;
begin
  Path := IncludeTrailingPathDelimiter(Path);
  Files := FindFirst(Path + '*.*', faAnyFile, Search);
  while Files = 0 do
  begin
    if (Search.Name <> '.') and (Search.Name <> '..') and (ExtractFileExt(Search.Name) = '.pas') then
    begin
      L := TStringList.Create;
      try
        L.LoadFromFile(Path + Search.Name);
        for i := 0 to L.Count - 1 do
        begin
          if Pos(txtVersion, L[i]) > 0 then
            L[i] := Format(cntVersion, [eMinor.Value,
                                        eRelease.Value,
                                        eBuild.Value
                                       ]);
          if (Search.Name = 'GMConstants.pas') and (Pos(GMLIB_Version, L[i]) > 0) then
            L[i] := Format(cntGMLIB_Version, [eMinor.Value,
                                              eRelease.Value,
                                              eBuild.Value
                                             ]);
          if (Search.Name = 'GMConstants.pas') and (Pos(GMLIB_VerText, L[i]) > 0) then
            L[i] := Format(cntGMLIB_VerText, [eMinor.Value,
                                              eRelease.Value,
                                              eBuild.Value
                                             ]);
        end;
        L.SaveToFile(Path + Search.Name);
      finally
        FreeAndNil(L);
      end;
    end;
    if (Search.Attr = faDirectory) and (Search.Name <> '.') and (Search.Name <> '..') then
      ChangeSourceVersion(Path + Search.Name);

    Files := FindNext(Search);
  end;
  FindClose(Search);
end;

procedure TMainFrm.ChangeVersionD2007;
  procedure ChangeVer(ProjectName, Description: string);
  const
    DpkDesc = '$DESCRIPTION ';
    DpBorlandProj = '<BorlandProject><Delphi.Personality><Parameters>';

    cntDpkDesc = '{$DESCRIPTION ''%s''}';
    cntBorlandProj  = '<BorlandProject><Delphi.Personality><Parameters><Parameters Name="UseLauncher">False</Parameters><Parameters Name="LoadAllSymbols">True</Parameters>' +
                      '<Parameters Name="LoadUnspecifiedSymbols">False</Parameters></Parameters><Package_Options><Package_Options Name="ImplicitBuild">True</Package_Options>' +
                      '<Package_Options Name="DesigntimeOnly">False</Package_Options><Package_Options Name="RuntimeOnly">False</Package_Options>' +
                      '<Package_Options Name="PackageDescription">%s</Package_Options></Package_Options>' +
                      '<VersionInfo><VersionInfo Name="IncludeVerInfo">True</VersionInfo><VersionInfo Name="AutoIncBuild">True</VersionInfo><VersionInfo Name="MajorVer">%d</VersionInfo>' +
                      '<VersionInfo Name="MinorVer">%d</VersionInfo><VersionInfo Name="Release">%d</VersionInfo><VersionInfo Name="Build">%d</VersionInfo><VersionInfo Name="Debug">False</VersionInfo>' +
                      '<VersionInfo Name="PreRelease">False</VersionInfo><VersionInfo Name="Special">False</VersionInfo><VersionInfo Name="Private">False</VersionInfo>' +
                      '<VersionInfo Name="DLL">False</VersionInfo><VersionInfo Name="Locale">3082</VersionInfo><VersionInfo Name="CodePage">1252</VersionInfo></VersionInfo>' +

                      '<VersionInfoKeys><VersionInfoKeys Name="CompanyName">%s</VersionInfoKeys><VersionInfoKeys Name="FileDescription"></VersionInfoKeys><VersionInfoKeys Name="FileVersion">%d.%d.%d.%d</VersionInfoKeys>' +
                      '<VersionInfoKeys Name="InternalName">%s</VersionInfoKeys><VersionInfoKeys Name="LegalCopyright">%s</VersionInfoKeys><VersionInfoKeys Name="LegalTrademarks"></VersionInfoKeys>' +
                      '<VersionInfoKeys Name="OriginalFilename"></VersionInfoKeys><VersionInfoKeys Name="ProductName">%s</VersionInfoKeys><VersionInfoKeys Name="ProductVersion">%d.%d.%d.%d</VersionInfoKeys>' +
                      '<VersionInfoKeys Name="Comments"></VersionInfoKeys></VersionInfoKeys><Source><Source Name="MainSource">GMLib_D2007.dpk</Source></Source><Excluded_Packages>';
  var
    L: TStringList;
    i: Integer;
  begin
    L := TStringList.Create;
    try
      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.res') then
        DeleteFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.res');

      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk') then
      begin
        L.LoadFromFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk');
        for i := 0 to L.Count -1 do
          if Pos(DpkDesc, L[i]) > 0 then
            L[i] := Format(cntDpkDesc, [Format(Description, [eMinor.Value, eRelease.Value, eBuild.Value])]);
        L.SaveToFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk');
      end;

      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dproj') then
      begin
        L.LoadFromFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dproj');
        for i := 0 to L.Count -1 do
          if Pos(DpBorlandProj, L[i]) > 0 then
            L[i] := Format(cntBorlandProj, [Format(Description, [eMinor.Value, eRelease.Value, eBuild.Value]),
                                            eMajor.Value,
                                            eMinor.Value,
                                            eRelease.Value,
                                            eBuild.Value,
                                            descCompanyName,
                                            eMajor.Value, eMinor.Value, eRelease.Value, eBuild.Value,
                                            descInternalName,
                                            descLegalCopyright,
                                            descProductName,
                                            eMajor.Value, eMinor.Value, eRelease.Value, eBuild.Value
                                            ]);
        L.SaveToFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dproj');
      end;
    finally
      FreeAndNil(L);
    end;
  end;
begin
  ChangeVer('GMLib_D2007', cntDesc);
end;

procedure TMainFrm.ChangeVersionD2009ToXE;
  procedure ChangeVer(ProjectName, Description: string);
  const
    DpkDesc = '$DESCRIPTION ';
    DpDesc = '<DCC_Description>';
    DpMaVer = '<VersionInfo Name="MajorVer">';
    DpMiVer = '<VersionInfo Name="MinorVer">';
    DpRel = '<VersionInfo Name="Release">';
    DpBuild = '<VersionInfo Name="Build">';
    DpKeyCompany = '<VersionInfoKeys Name="CompanyName"';
    DpKeyFileVer = '<VersionInfoKeys Name="FileVersion"';
    DpKeyIntName = '<VersionInfoKeys Name="InternalName"';
    DpKeyLegalCo = '<VersionInfoKeys Name="LegalCopyright"';
    DpKeyProName = '<VersionInfoKeys Name="ProductName"';
    DpKeyProdVer = '<VersionInfoKeys Name="ProductVersion"';

    cntDpkDesc = '{$DESCRIPTION ''%s''}';
    cntDpDesc  = '        <DCC_Description>%s</DCC_Description>';
    cntDpMaVer = '						<VersionInfo Name="MajorVer">%d</VersionInfo>';
    cntDpMiVer = '						<VersionInfo Name="MinorVer">%d</VersionInfo>';
    cntDpRel   = '						<VersionInfo Name="Release">%d</VersionInfo>';
    cntDpBuild = '						<VersionInfo Name="Build">%d</VersionInfo>';
    cntKeyCompany = '						<VersionInfoKeys Name="CompanyName">%s</VersionInfoKeys>';
    cntKeyFileVer = '						<VersionInfoKeys Name="FileVersion">%d.%d.%d.%d</VersionInfoKeys>';
    cntKeyIntName = '						<VersionInfoKeys Name="InternalName">%s</VersionInfoKeys>';
    cntKeyLegalCo = '						<VersionInfoKeys Name="LegalCopyright">%s</VersionInfoKeys>';
    cntKeyProName = '						<VersionInfoKeys Name="ProductName">%s</VersionInfoKeys>';
    cntKeyProdVer = '						<VersionInfoKeys Name="ProductVersion">%d.%d.%d.%d</VersionInfoKeys>';
  var
    L: TStringList;
    i: Integer;
  begin
    L := TStringList.Create;
    try
      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.res') then
        DeleteFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.res');

      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk') then
      begin
        L.LoadFromFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk');
        for i := 0 to L.Count -1 do
          if Pos(DpkDesc, L[i]) > 0 then
            L[i] := Format(cntDpkDesc, [Format(Description, [eMinor.Value, eRelease.Value, eBuild.Value])]);
        L.SaveToFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk');
      end;

      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dproj') then
      begin
        L.LoadFromFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dproj');
        for i := 0 to L.Count -1 do
        begin
          if Pos(DpDesc, L[i]) > 0 then L[i] := Format(cntDpDesc, [Format(Description, [eMinor.Value, eRelease.Value, eBuild.Value])]);
          if Pos(DpMaVer, L[i]) > 0 then L[i] := Format(cntDpMaVer, [eMajor.Value]);
          if Pos(DpMiVer, L[i]) > 0 then L[i] := Format(cntDpMiVer, [eMinor.Value]);
          if Pos(DpRel, L[i]) > 0 then L[i] := Format(cntDpRel, [eRelease.Value]);
          if Pos(DpBuild, L[i]) > 0 then L[i] := Format(cntDpBuild, [eBuild.Value]);
          if Pos(DpKeyCompany, L[i]) > 0 then L[i] := Format(cntKeyCompany, [descCompanyName]);
          if Pos(DpKeyFileVer, L[i]) > 0 then L[i] := Format(cntKeyFileVer, [eMajor.Value, eMinor.Value, eRelease.Value, eBuild.Value]);
          if Pos(DpKeyIntName, L[i]) > 0 then L[i] := Format(cntKeyIntName, [descInternalName]);
          if Pos(DpKeyLegalCo, L[i]) > 0 then L[i] := Format(cntKeyLegalCo, [descLegalCopyright]);
          if Pos(DpKeyProName, L[i]) > 0 then L[i] := Format(cntKeyProName, [descProductName]);
          if Pos(DpKeyProdVer, L[i]) > 0 then L[i] := Format(cntKeyProdVer, [eMajor.Value, eMinor.Value, eRelease.Value, eBuild.Value]);
        end;
        L.SaveToFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dproj');
      end;
    finally
      FreeAndNil(L);
    end;
  end;
begin
  ChangeVer('GMLib_D2009', cntDesc);
  ChangeVer('GMLib_D2010', cntDesc);
  ChangeVer('GMLib_DXE', cntDesc);
end;

procedure TMainFrm.ChangeVersionD6ToD7;
  procedure ChangeVer(ProjectName, Description: string);
  const
    DpkDesc = '$DESCRIPTION ';
    cntDpkDesc = '{$DESCRIPTION ''%s''}';
  var
    L: TStringList;
    i: Integer;
    Ini: TIniFile;
  begin
    L := TStringList.Create;
    try
      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.res') then
        DeleteFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.res');

      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk') then
      begin
        L.LoadFromFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk');
        for i := 0 to L.Count -1 do
          if Pos(DpkDesc, L[i]) > 0 then
            L[i] := Format(cntDpkDesc, [Format(Description, [eMinor.Value, eRelease.Value, eBuild.Value])]);
        L.SaveToFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk');
      end;
    finally
      FreeAndNil(L);
    end;

    Ini := TIniFile.Create(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dof');
    try
      Ini.WriteInteger('Version Info', 'MajorVer', eMajor.Value);
      Ini.WriteInteger('Version Info', 'MinorVer', eMinor.Value);
      Ini.WriteInteger('Version Info', 'Release', eRelease.Value);
      Ini.WriteInteger('Version Info', 'Build', eBuild.Value);

      Ini.WriteString('Version Info Keys', 'CompanyName', descCompanyName);
      Ini.WriteString('Version Info Keys', 'FileVersion', Format('%d.%d.%d.%d', [eMajor.Value, eMinor.Value, eRelease.Value, eBuild.Value]));
      Ini.WriteString('Version Info Keys', 'InternalName', descInternalName);
      Ini.WriteString('Version Info Keys', 'LegalCopyright', descLegalCopyright);
      Ini.WriteString('Version Info Keys', 'ProductName', descProductName);
      Ini.WriteString('Version Info Keys', 'ProductVersion', Format('%d.%d.%d.%d', [eMajor.Value, eMinor.Value, eRelease.Value, eBuild.Value]));
    finally
      FreeAndNil(Ini);
    end;
  end;
const
  Delphi = 'GMLib_D%d';
var
  i: Integer;
begin
  for i := 6 to 7 do
    ChangeVer(Format(Delphi, [i]), cntDesc);
end;

procedure TMainFrm.ChangeVersionXE2ToXe4;
  procedure ChangeVer(ProjectName, Description: string);
  const
    DpkDesc = '$DESCRIPTION ';
    DpDesc = '<DCC_Description>';
    DpMaVer = '<VerInfo_MajorVer>';
    DpMiVer = '<VerInfo_MinorVer>';
    DpRel = '<VerInfo_Release>';
    DpBuild = '<VerInfo_Build>';
    DpKeys = '<VerInfo_Keys>';

    cntDpkDesc = '{$DESCRIPTION ''%s''}';
    cntDpDesc  = '        <DCC_Description>%s</DCC_Description>';
    cntDpMaVer = '        <VerInfo_MajorVer>%d</VerInfo_MajorVer>';
    cntDpMiVer = '        <VerInfo_MinorVer>%d</VerInfo_MinorVer>';
    cntDpRel   = '        <VerInfo_Release>%d</VerInfo_Release>';
    cntDpBuild = '        <VerInfo_Build>%d</VerInfo_Build>';
    cntDpKeys  = '        <VerInfo_Keys>CompanyName=%s;FileDescription=;FileVersion=%d.%d.%d.%d;InternalName=%s;' +
                 'LegalCopyright=%s;LegalTrademarks=;OriginalFilename=;ProductName=%s;' +
                 'ProductVersion=%d.%d.%d.%d;Comments=</VerInfo_Keys>';
  var
    L: TStringList;
    i: Integer;
  begin
    L := TStringList.Create;
    try
      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk') then
      begin
        L.LoadFromFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk');
        for i := 0 to L.Count -1 do
          if Pos(DpkDesc, L[i]) > 0 then
            L[i] := Format(cntDpkDesc, [Format(Description, [eMinor.Value, eRelease.Value, eBuild.Value])]);
        L.SaveToFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dpk');
      end;

      if FileExists(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dproj') then
      begin
        L.LoadFromFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dproj');
        for i := 0 to L.Count -1 do
        begin
          if Pos(DpDesc, L[i]) > 0 then L[i] := Format(cntDpDesc, [Format(Description, [eMinor.Value, eRelease.Value, eBuild.Value])]);
          if Pos(DpMaVer, L[i]) > 0 then L[i] := Format(cntDpMaVer, [eMajor.Value]);
          if Pos(DpMiVer, L[i]) > 0 then L[i] := Format(cntDpMiVer, [eMinor.Value]);
          if Pos(DpRel, L[i]) > 0 then L[i] := Format(cntDpRel, [eRelease.Value]);
          if Pos(DpBuild, L[i]) > 0 then L[i] := Format(cntDpBuild, [eBuild.Value]);
          if Pos(DpKeys, L[i]) > 0 then L[i] := Format(cntDpKeys, [descCompanyName,
                                                                   eMajor.Value, eMinor.Value, eRelease.Value, eBuild.Value,
                                                                   descInternalName,
                                                                   descLegalCopyright,
                                                                   descProductName,
                                                                   eMajor.Value, eMinor.Value, eRelease.Value, eBuild.Value]);
        end;
        L.SaveToFile(IncludeTrailingPathDelimiter(ePath.Text) + ProjectName + '.dproj');
      end;
    finally
      FreeAndNil(L);
    end;
  end;
const
  XE = 'GMLib_DXE%d';
  XEVCL = 'GMLib_DXE%d_VCL';
  XEFMX = 'GMLib_DXE%d_FMX';
  XEEdit = 'GMLibEdit_DXE%d';
var
  i: Integer;
begin
  for i := 2 to 4 do
  begin
    ChangeVer(Format(XE, [i]), cntDesc);
    ChangeVer(Format(XEVCL, [i]), cntDescVCL);
    ChangeVer(Format(XEFMX, [i]), cntDescFMX);
    ChangeVer(Format(XEEdit, [i]), cntDescEdit);
  end;
end;

end.
