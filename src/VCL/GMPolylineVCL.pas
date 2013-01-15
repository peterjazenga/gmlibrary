{
GMPolylineVCL unit

  ES: contiene las clases VCL necesarias para mostrar polilíneas en un mapa de
      Google Maps mediante el componente TGMMap
  EN: includes the VCL classes needed to show polylines on Google Map map using
      the component TGMMap

=========================================================================
MODO DE USO/HOW TO USE

  ES: poner el componente en el formulario, linkarlo a un TGMMap y poner las
      polilíneas a mostrar
  EN: put the component into a form, link to a TGMMap and put the polylines to
      show
=========================================================================
History:

ver 0.1.9
  ES:
    nuevo: documentación
    nuevo: se hace compatible con FireMonkey
  EN:
    new: documentation
    new: now compatible with FireMonkey
=========================================================================
IMPORTANTE PROGRAMADORES: Por favor, si tienes comentarios, mejoras,
  ampliaciones, errores y/o cualquier otro tipo de sugerencia, envíame un correo a:
  gmlib@cadetill.com

IMPORTANT PROGRAMMERS: please, if you have comments, improvements, enlargements,
  errors and/or any another type of suggestion, please send me a mail to:
  gmlib@cadetill.com
=========================================================================

Copyright (©) 2012, by Xavier Martinez (cadetill)

@author Xavier Martinez (cadetill)
@web  http://www.cadetill.com
}
{*------------------------------------------------------------------------------
  The GMPolylineVCL unit includes the VCL classes needed to show polylines on Google Map map using the component TGMMap.

  @author Xavier Martinez (cadetill)
  @version 0.1.9
-------------------------------------------------------------------------------}
{=------------------------------------------------------------------------------
  La unit GMPolylineVCL contiene las clases VCL necesarias para mostrar polilíneas en un mapa de Google Maps mediante el componente TGMMap

  @author Xavier Martinez (cadetill)
  @version 0.1.9
-------------------------------------------------------------------------------}
unit GMPolylineVCL;

interface

uses
  {$IF CompilerVersion < 23}  // ES: si la versión es inferior a la XE2 - EN: if lower than XE2 version
  Classes, Graphics,
  {$ELSE}                     // ES: si la verisón es la XE2 o superior - EN: if version is XE2 or higher
  System.Classes, Vcl.Graphics,
  {$IFEND}

  GMPolyline, GMLinkedComponents;

type
  {*------------------------------------------------------------------------------
    VCL class to determine the symbol to show along the path.
  -------------------------------------------------------------------------------}
  {=------------------------------------------------------------------------------
    Clase VCL para determinar el símbolo a mostrar a lo largo del camino.
  -------------------------------------------------------------------------------}
  TSymbol = class(TCustomSymbol)
  private
    {*------------------------------------------------------------------------------
      The fill color.
    -------------------------------------------------------------------------------}
    {=------------------------------------------------------------------------------
      Color de relleno.
    -------------------------------------------------------------------------------}
    FFillColor: TColor;
    {*------------------------------------------------------------------------------
      The stroke color.
    -------------------------------------------------------------------------------}
    {=------------------------------------------------------------------------------
      Color del trazo.
    -------------------------------------------------------------------------------}
    FStrokeColor: TColor;
    procedure SetFillColor(const Value: TColor);
    procedure SetStrokeColor(const Value: TColor);
  protected
    function GetFillColor: string; override;
    function GetStrokeColor: string; override;
  public
    constructor Create; override;

    procedure Assign(Source: TPersistent); override;
  published
    property FillColor: TColor read FFillColor write SetFillColor;
    property StrokeColor: TColor read FStrokeColor write SetStrokeColor;
  end;

  {*------------------------------------------------------------------------------
    VCL class to determine the icon and repetition to show.
  -------------------------------------------------------------------------------}
  {=------------------------------------------------------------------------------
    Clase VCL para determinar el icono y la repetición a mostrar.
  -------------------------------------------------------------------------------}
  TIconSequence = class(TCustomIconSequence)
  public
    constructor Create(aOwner: TBasePolyline); override;
  end;

  {*------------------------------------------------------------------------------
    VCL base class for polylines and polygons.
  -------------------------------------------------------------------------------}
  {=------------------------------------------------------------------------------
    Clase VCL base para las polilineas y polígonos.
  -------------------------------------------------------------------------------}
  TBasePolylineVCL = class(TBasePolyline)
  private
    {*------------------------------------------------------------------------------
      The stroke color.
    -------------------------------------------------------------------------------}
    {=------------------------------------------------------------------------------
      Color del trazo.
    -------------------------------------------------------------------------------}
    FStrokeColor: TColor;
    procedure SetStrokeColor(const Value: TColor);
  protected
    function GetStrokeColor: string; override;
  public
    constructor Create(Collection: TCollection); override;

    procedure Assign(Source: TPersistent); override;
  published
    property StrokeColor: TColor read FStrokeColor write SetStrokeColor;
  end;

  {*------------------------------------------------------------------------------
    VCL class for polylines.
  -------------------------------------------------------------------------------}
  {=------------------------------------------------------------------------------
    Clase VCL para los polilineas.
  -------------------------------------------------------------------------------}
  TPolyline = class(TBasePolylineVCL)
  private
    {*------------------------------------------------------------------------------
      Features for icon and repetition.
    -------------------------------------------------------------------------------}
    {=------------------------------------------------------------------------------
      Características para el icono y la repetición.
    -------------------------------------------------------------------------------}
    FIcon: TIconSequence;
    procedure OnIconChange(Sender: TObject);
  protected
    function ChangeProperties: Boolean; override;
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;
  published
    property Icon: TIconSequence read FIcon write FIcon;
  end;

  {*------------------------------------------------------------------------------
    VCL class for polylines collection.
  -------------------------------------------------------------------------------}
  {=------------------------------------------------------------------------------
    Clase VCL para la colección de polilíneas.
  -------------------------------------------------------------------------------}
  TPolylines = class(TBasePolylines)
  private
    procedure SetItems(I: Integer; const Value: TPolyline);
    function GetItems(I: Integer): TPolyline;
  protected
    function GetOwner: TPersistent; override;
  public
    function Add: TPolyline;
    function Insert(Index: Integer): TPolyline;

    {*------------------------------------------------------------------------------
      Lists the rectangles in the collection.
    -------------------------------------------------------------------------------}
    {=------------------------------------------------------------------------------
      Lista de rectángulos en la colección.
    -------------------------------------------------------------------------------}
    property Items[I: Integer]: TPolyline read GetItems write SetItems; default;
  end;

  {*------------------------------------------------------------------------------
    VCL class for GMPolyline component.
    More information at https://developers.google.com/maps/documentation/javascript/reference?hl=en#Polyline
  -------------------------------------------------------------------------------}
  {=------------------------------------------------------------------------------
    Clase VCL para el componente GMPolyline.
    Más información en https://developers.google.com/maps/documentation/javascript/reference?hl=en#Polyline
  -------------------------------------------------------------------------------}
  TGMPolyline = class(TGMBasePolyline)
  private
    {*------------------------------------------------------------------------------
      This event is fired when the polyline's Icon property are changed.
    -------------------------------------------------------------------------------}
    {=------------------------------------------------------------------------------
      Este evento ocurre cuando cambia la propiedad Icon de una polilínea.
    -------------------------------------------------------------------------------}
    FOnIconChange: TLinkedComponentChange;
  protected
    function GetAPIUrl: string; override;

    function GetItems(I: Integer): TPolyline;

    procedure ShowElements; override;
    function GetCollectionItemClass: TLinkedComponentClass; override;
    function GetCollectionClass: TLinkedComponentsClass; override;
  public
    function Add: TPolyline;

    {*------------------------------------------------------------------------------
      Array with the collection items.
    -------------------------------------------------------------------------------}
    {=------------------------------------------------------------------------------
      Array con la colección de elementos.
    -------------------------------------------------------------------------------}
    property Items[I: Integer]: TPolyline read GetItems; default;
  published
    property OnIconChange: TLinkedComponentChange read FOnIconChange write FOnIconChange;
  end;

implementation

uses
  {$IF CompilerVersion < 23}  // ES: si la versión es inferior a la XE2 - EN: if lower than XE2 version
  SysUtils,
  {$ELSE}                     // ES: si la verisón es la XE2 o superior - EN: if version is XE2 or higher
  System.SysUtils,
  {$IFEND}

  GMFunctionsVCL, GMConstants;

{ TSymbol }

procedure TSymbol.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TSymbol then
  begin
    FillColor := TSymbol(Source).FillColor;
    StrokeColor := TSymbol(Source).StrokeColor;
  end;
end;

constructor TSymbol.Create;
begin
  inherited;

  FFillColor := clRed;
  FStrokeColor := clRed;
end;

function TSymbol.GetFillColor: string;
begin
  Result := TTransform.TColorToStr(FFillColor);
end;

function TSymbol.GetStrokeColor: string;
begin
  Result := TTransform.TColorToStr(FStrokeColor);
end;

procedure TSymbol.SetFillColor(const Value: TColor);
begin
  if FFillColor = Value then Exit;

  FFillColor := Value;
  if Assigned(OnChange) then OnChange(Self);
end;

procedure TSymbol.SetStrokeColor(const Value: TColor);
begin
  if FStrokeColor = Value then Exit;

  FStrokeColor := Value;
  if Assigned(OnChange) then OnChange(Self);
end;

{ TIconSequence }

constructor TIconSequence.Create(aOwner: TBasePolyline);
begin
  inherited;

  Icon := TSymbol.Create;
  TSymbol(Icon).OnChange := OnIconChange;
end;

{ TBasePolylineVCL }

procedure TBasePolylineVCL.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TBasePolylineVCL then
  begin
    StrokeColor := TBasePolylineVCL(Source).StrokeColor;
  end;
end;

constructor TBasePolylineVCL.Create(Collection: TCollection);
begin
  inherited;

  FStrokeColor := clBlack;
end;

function TBasePolylineVCL.GetStrokeColor: string;
begin
  Result := TTransform.TColorToStr(FStrokeColor);
end;

procedure TBasePolylineVCL.SetStrokeColor(const Value: TColor);
begin
  if FStrokeColor = Value then Exit;

  FStrokeColor := Value;

  ChangeProperties;
  if Assigned(TGMPolyline(TPolylines(Collection).FGMLinkedComponent).OnStrokeColorChange) then
    TGMBasePolyline(TPolylines(Collection).FGMLinkedComponent).OnStrokeColorChange(
                  TGMPolyline(TPolylines(Collection).FGMLinkedComponent),
                  Index,
                  Self);
end;

{ TPolyline }

procedure TPolyline.Assign(Source: TPersistent);
begin
  inherited;

  if Source is TPolyline then
  begin
    Icon.Assign(TPolyline(Source).Icon);
  end;
end;

function TPolyline.ChangeProperties: Boolean;
const
  StrParams = '%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s';
var
  Params: string;
  DistRepeat: string;
  Offset: string;
begin
  inherited;

  Result := False;

  if not Assigned(Collection) or not(Collection is TPolylines) or
     not Assigned(TPolylines(Collection).FGMLinkedComponent) or
     not TGMPolyline(TPolylines(Collection).FGMLinkedComponent).AutoUpdate or
     not Assigned(TGMPolyline(TPolylines(Collection).FGMLinkedComponent).Map) or
     (csDesigning in TGMPolyline(TPolylines(Collection).FGMLinkedComponent).ComponentState) then
    Exit;

  case Icon.DistRepeat.Measure of
    mPixels: DistRepeat := IntToStr(Icon.DistRepeat.Value) + 'px';
    else DistRepeat := IntToStr(Icon.DistRepeat.Value) + '%';
  end;

  case Icon.OffSet.Measure of
    mPixels: Offset := IntToStr(Icon.OffSet.Value) + 'px';
    else Offset := IntToStr(Icon.OffSet.Value) + '%';
  end;

  Params := Format(StrParams, [
                  IntToStr(IdxList),
                  IntToStr(Index),
                  LowerCase(TTransform.GMBoolToStr(Clickable, True)),
                  LowerCase(TTransform.GMBoolToStr(Editable, True)),
                  LowerCase(TTransform.GMBoolToStr(Geodesic, True)),
                  QuotedStr(GetStrokeColor),
                  StringReplace(FloatToStr(StrokeOpacity), ',', '.', [rfReplaceAll]),
                  IntToStr(StrokeWeight),
                  LowerCase(TTransform.GMBoolToStr(Visible, True)),
                  QuotedStr(PolylineToStr),
                  QuotedStr(InfoWindow.GetConvertedString),
                  LowerCase(TTransform.GMBoolToStr(InfoWindow.DisableAutoPan, True)),
                  IntToStr(InfoWindow.MaxWidth),
                  IntToStr(InfoWindow.PixelOffset.Height),
                  IntToStr(InfoWindow.PixelOffset.Width),
                  LowerCase(TTransform.GMBoolToStr(InfoWindow.CloseOtherBeforeOpen, True)),
                  QuotedStr(DistRepeat),
                  QuotedStr(TSymbol(Icon.Icon).GetFillColor),
                  StringReplace(FloatToStr(Icon.Icon.FillOpacity), ',', '.', [rfReplaceAll]),
                  QuotedStr(TTransform.SymbolPathToStr(Icon.Icon.Path)),
                  QuotedStr(TSymbol(Icon.Icon).GetStrokeColor),
                  StringReplace(FloatToStr(Icon.Icon.StrokeOpacity), ',', '.', [rfReplaceAll]),
                  IntToStr(Icon.Icon.StrokeWeight),
                  QuotedStr(Offset)
                  ]);

  Result := TGMPolyline(TPolylines(Collection).FGMLinkedComponent).ExecuteScript('MakePolyline', Params);
  TGMPolyline(TPolylines(Collection).FGMLinkedComponent).ErrorControl;
end;

constructor TPolyline.Create(Collection: TCollection);
begin
  inherited Create(Collection);

  FIcon := TIconSequence.Create(Self);
  FIcon.OnChange := OnIconChange;
end;

destructor TPolyline.Destroy;
begin
  if Assigned(FIcon) then FreeAndNil(FIcon);

  inherited;
end;

procedure TPolyline.OnIconChange(Sender: TObject);
begin
  if ChangeProperties and Assigned(TGMPolyline(TPolylines(Collection).FGMLinkedComponent).FOnIconChange) then
    TGMPolyline(TPolylines(Collection).FGMLinkedComponent).FOnIconChange(
                  TGMPolyline(TPolylines(Collection).FGMLinkedComponent),
                  Index,
                  Self);
end;

{ TPolylines }

function TPolylines.Add: TPolyline;
begin
  Result := TPolyline(inherited Add);
end;

function TPolylines.GetItems(I: Integer): TPolyline;
begin
  Result := TPolyline(inherited Items[I]);
end;

function TPolylines.GetOwner: TPersistent;
begin
  Result := TGMPolyline(inherited GetOwner);
end;

function TPolylines.Insert(Index: Integer): TPolyline;
begin
  Result := TPolyline(inherited Insert(Index));
end;

procedure TPolylines.SetItems(I: Integer; const Value: TPolyline);
begin
  inherited SetItem(I, Value);
end;

{ TGMPolyline }

function TGMPolyline.Add: TPolyline;
begin
  Result := TPolyline(inherited Add);
end;

function TGMPolyline.GetAPIUrl: string;
begin
  Result := 'https://developers.google.com/maps/documentation/javascript/reference?hl=en#Polyline';
end;

function TGMPolyline.GetCollectionClass: TLinkedComponentsClass;
begin
  Result := TPolylines;
end;

function TGMPolyline.GetCollectionItemClass: TLinkedComponentClass;
begin
  Result := TPolyline;
end;

function TGMPolyline.GetItems(I: Integer): TPolyline;
begin
  Result := TPolyline(inherited Items[i]);
end;

procedure TGMPolyline.ShowElements;
var
  i: Integer;
begin
  if not ExecuteScript('DeleteObjects', IntToStr(IdxList)) then Exit;

  for i:= 0 to VisualObjects.Count - 1 do
    Items[i].ChangeProperties;
end;

end.
