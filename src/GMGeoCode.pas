{
TGMGeoCode component

  ES: componente para mostrar marcadores de una dirección en un mapa de Google
      Maps mediante el componente TGMMap
  EN: component to show markers from an address on Google Map map using the
      component TGMMap

=========================================================================
MODO DE USO/HOW TO USE

  ES: poner el componente en el formulario y ejecutar el método Geocode. Si
    queremos mostrar los marcadores, linkarlo a un TGMMarker
  EN: put the component into a form and execute Geocode method. If you want to
    show markers, link it to a TGMMarker
=========================================================================
History:

ver 0.1.7
  ES:
    cambio: TGMGeoCode-> añadida propiedad booleana PaintMarkerFound. A true se
      generarán automáticamente los marcadores (si hay un TGMMarker asociado)
      (por Luis Joaquin Sencion)
    cambio: TGMGeoCode-> en DoMarkers se codifica la URL generada en UTF8 para
      evitar problemas con carácteres especiales (ñ, acentos, ....)
  EN:
    change: TGMGeoCode-> added boolean property PaintMarkerFound. To true, all
      markers are automatically generated (if a TGMMarker is linked) (by Luis
      Joaquin Sencion)
    change: TGMGeoCode-> generated URL is encoded in UTF8 to avoid problems
      with special characters (ñ, accents, ....)

ver 0.1.6
  ES:
    nuevo: TAddressComponent -> añadido método Assign
    nuevo: TAddressComponentsList -> añadido método Assign
    nuevo: TGeometry -> añadido método Assign
    nuevo: TGeoResult -> añadido método Assign
    nuevo: TGoogleBusiness -> añadido método Assign
    nuevo: TGMGeoCode -> se sobreescribe el método Notification para controlar
      la propiedad Marker
    cambio: TGMGeoCode -> se trasladan los métodos xxToStr y StrToxxx a la clase
      TTransform de la unidad GMFunctions
    nuevo: TGMGeoCode -> añadido método Assign
  EN:
    new: TAddressComponent -> added Assign method
    new: TAddressComponentsList -> added Assign method
    new: TGeometry -> added Assign method
    new: TGeoResult -> added Assign method
    new: TGoogleBusiness -> added Assign method
    new: TGMGeoCode -> overrided Notification method to control Marker property
    change: TGMGeoCode -> xxToStr and StrToxxx moved to the TTransform class
      into the GMFunctions unit
    new: TGMGeoCode -> added Assign method

ver 0.1.5
  ES: primera versión
  EN: first version
=========================================================================
ATENCION!!!  LIMITES DE USO SEGUN Google
  - 2.500 geolocalizaciones por día
  - la geolocalización debe usarse con un mapa de Google Maps
  - para más información visitar https://developers.google.com/maps/documentation/geocoding/index#Limits

WARNING!!!  USAGE LIMITS BY Google
  - 2,500 geolocation requests per day
  - the geolocation should be used with Google Maps
  - for more information visit https://developers.google.com/maps/documentation/geocoding/index#Limits
=========================================================================
URL de interés
URL of Interest

  - https://developers.google.com/maps/documentation/javascript/services
  - http://stackoverflow.com/questions/5782611/how-do-i-use-google-maps-geocoder-getlatlng-and-store-its-result-in-a-database
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
unit GMGeoCode;

interface

uses
  {$IF CompilerVersion < 23}  // ES: si la versión es inferior a la XE2 - EN: if lower than XE2 version
  Classes, Contnrs,
  {$ELSE}                     // ES: si la verisón es la XE2 o superior - EN: if version is XE2 or higher
  System.Classes, System.Contnrs,
  {$IFEND}

  GMMap, GMClasses, GMMarker, GMConstants;

type
  { ****************************************************************************
    https://developers.google.com/maps/documentation/javascript/reference?hl=en#GeocoderAddressComponent
  **************************************************************************** }
  TAddressComponent = class
  private
    FShortName: string;
    FAddrCompTypeList: TStringList;
    FLongName: string;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Assign(Source: TObject); virtual;

    property ShortName: string read FShortName;
    property LongName: string read FLongName;
    property AddrCompTypeList: TStringList read FAddrCompTypeList;
  end;

  { ****************************************************************************
    internal class
  **************************************************************************** }
  TAddressComponentsList = class
  private
    FAddrComponents: TObjectList;
    function GetItem(Index: Integer): TAddressComponent;
    function GetCount: Integer;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Assign(Source: TObject); virtual;

    function Add(AddrComp: TAddressComponent): Integer;

    property Count: Integer read GetCount;
    property Items[Index: Integer]: TAddressComponent read GetItem; default;
  end;

  { ****************************************************************************
    https://developers.google.com/maps/documentation/javascript/reference?hl=en#GeocoderGeometry
  **************************************************************************** }
  TGeometry = class
  private
    FLocation: TLatLng;
    FLocationType: TGeocoderLocationType;
    FViewport: TLatLngBounds;
    FBounds: TLatLngBounds;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Assign(Source: TObject); virtual;

    property Location: TLatLng read FLocation;
    property LocationType: TGeocoderLocationType read FLocationType;
    property Viewport: TLatLngBounds read FViewport;
    property Bounds: TLatLngBounds read FBounds;
  end;

  { ****************************************************************************
    https://developers.google.com/maps/documentation/javascript/reference?hl=en#GeocoderResult
  **************************************************************************** }
  TGeoResult = class
  private
    FTypeList: TStringList;
    FFormatedAddr: string;
    FAddrCompList: TAddressComponentsList;
    FGeometry: TGeometry;
  public
    constructor Create; virtual;
    destructor Destroy; override;

    procedure Assign(Source: TObject); virtual;

    property TypeList: TStringList read FTypeList;
    property FormatedAddr: string read FFormatedAddr;
    property AddrCompList: TAddressComponentsList read FAddrCompList;
    property Geometry: TGeometry read FGeometry;
  end;

  { ****************************************************************************
    internal class
  **************************************************************************** }
  TGoogleBusiness = class(TPersistent)
  private
    FSignature: string;
    FClient: string;
  public
    constructor Create; virtual;

    procedure Assign(Source: TPersistent); override;
  published
    property Client: string read FClient write FClient;
    property Signature: string read FSignature write FSignature;
  end;

  TParseData = procedure(Sender: TObject; ActualNode, CountNodes: Integer; var Continue: Boolean) of object;

  { ****************************************************************************
    https://developers.google.com/maps/documentation/javascript/reference?hl=en#Geocoder
    https://developers.google.com/maps/documentation/javascript/geocoding
    https://developers.google.com/maps/documentation/geocoding/index
  **************************************************************************** }
  TGMGeoCode = class(TGMObjects)
  private
    FMarker: TCustomGMMarker;
    FGBusiness: TGoogleBusiness;
    FXMLData: TStringList;
    FAfterGetData: TNotifyEvent;
    FBeforeParseData: TNotifyEvent;
    FAfterParseData: TNotifyEvent;
    FGeoStatus: TGeoCoderStatus;
    FOnParseData: TParseData;
    FGeoResults: TObjectList;
    FIcon: string;
    FBounds: TLatLngBounds;
    FRegion: TRegion;
    FLangCode: TLangCode;
    FPaintMarkerFound: Boolean;

    procedure GeocodeData(Data: string);
    procedure ParseData;

    function GetGeoResult(Index: Integer): TGeoResult;
    function GetCount: Integer;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;

    function GetAPIUrl: string; override;
    procedure DeleteMapObjects; override;
    procedure ShowElements; override;
    procedure EventFired(EventType: TEventType; Params: array of const); override;

    function StrToGeocoderLocationType(GeocoderLocationType: string): TGeocoderLocationType;
  public
    constructor Create(aOwner: TComponent); override;
    destructor Destroy; override;

    procedure Assign(Source: TPersistent); override;

    procedure Geocode(Address: string); overload;
    procedure Geocode(LatLng: TLatLng); overload;
    procedure Geocode(Lat, Lng: Real); overload;

    procedure DoMarkers;

    property Count: Integer read GetCount;
    property XMLData: TStringList read FXMLData write FXMLData;
    property GeoStatus: TGeocoderStatus read FGeoStatus;
    property GeoResult[Index: Integer]: TGeoResult read GetGeoResult; default;
  published
    property Marker: TCustomGMMarker read FMarker write FMarker;
    property GBusiness: TGoogleBusiness read FGBusiness write FGBusiness;
    property Icon: string read FIcon write FIcon;
    property Bounds: TLatLngBounds read FBounds write FBounds;
    property Region: TRegion read FRegion write FRegion;
    property LangCode: TLangCode read FLangCode write FLangCode;
    property PaintMarkerFound: Boolean read FPaintMarkerFound write FPaintMarkerFound;
    // eventos
    // events
    property AfterGetData: TNotifyEvent read FAfterGetData write FAfterGetData;
    property BeforeParseData: TNotifyEvent read FBeforeParseData write FBeforeParseData;
    property AfterParseData: TNotifyEvent read FAfterParseData write FAfterParseData;
    property OnParseData: TParseData read FOnParseData write FOnParseData;
  end;

implementation

uses
  {$IF CompilerVersion < 23}  // ES: si la versión es inferior a la XE2 - EN: if lower than XE2 version
  SysUtils, {ExtActns, }XMLIntf, XMLDoc, StrUtils,
  {$ELSE}                     // ES: si la verisón es la XE2 o superior - EN: if version is XE2 or higher
  System.SysUtils, {Vcl.ExtActns, }Xml.XMLIntf, Xml.XMLDoc, System.StrUtils,
  {$IFEND}
           Winapi.Windows,
  GMFunctions, Lang;

{ TGMGeoCode }

procedure TGMGeoCode.Geocode(Address: string);
var
  Tmp: string;
begin
  Tmp := QuotedStr(Trim(Address)) + ',-1, -1';
//  Tmp := StringReplace(Tmp, CHAR_SPACE, CHAR_PLUS, [rfReplaceAll]);
//  Tmp := StringReplace(Tmp, CHAR_RETURN, CHAR_COMMA, [rfReplaceAll]);
//  Tmp := STR_ADDRESS + Tmp;

  GeocodeData(Tmp);
end;

function TGMGeoCode.GetCount: Integer;
begin
  Result := FGeoResults.Count;
end;

procedure TGMGeoCode.Assign(Source: TPersistent);
begin
  if Source is TGMGeoCode then
  begin
    Marker := TGMGeoCode(Source).Marker;
    GBusiness.Assign(TGMGeoCode(Source).GBusiness);
    Icon := TGMGeoCode(Source).Icon;
    Bounds.Assign(TGMGeoCode(Source).Bounds);
    Region := TGMGeoCode(Source).Region;
    LangCode := TGMGeoCode(Source).LangCode;
  end
  else
    inherited Assign(Source);
end;

constructor TGMGeoCode.Create(aOwner: TComponent);
begin
  inherited;

  FGBusiness := TGoogleBusiness.Create;
  FXMLData := TStringList.Create;
  FGeoResults := TObjectList.Create;
  FBounds := TLatLngBounds.Create;
  FRegion := r_NO_REGION;
  FLangCode := lc_NOT_DEFINED;
  FGeoStatus := gsWithoutState;
end;

procedure TGMGeoCode.DeleteMapObjects;
begin
  inherited;
end;

destructor TGMGeoCode.Destroy;
begin
  if Assigned(FGBusiness) then FreeAndNil(FGBusiness);
  if Assigned(FXMLData) then FreeAndNil(FXMLData);
  if Assigned(FGeoResults) then FreeAndNil(FGeoResults);
  if Assigned(FBounds) then FreeAndNil(FBounds);

  inherited;
end;

procedure TGMGeoCode.DoMarkers;
var
  i: Integer;
  Marker: TCustomMarker;
begin
  if not Assigned(FMarker) or not FPaintMarkerFound then Exit;

  for i := 0 to FGeoResults.Count - 1 do
  begin
    Marker := FMarker.Add(TGeoResult(FGeoResults[i]).Geometry.Location.Lat,
                          TGeoResult(FGeoResults[i]).Geometry.Location.Lng,
                          TGeoResult(FGeoResults[i]).FormatedAddr);
    Marker.Icon := Icon;
  end;
end;

procedure TGMGeoCode.EventFired(EventType: TEventType; Params: array of const);
begin
  inherited;
end;

procedure TGMGeoCode.Geocode(LatLng: TLatLng);
var
  Tmp: string;
begin
//  Tmp := STR_LATLNG + LatLng.ToUrlValue(0);
  Tmp := QuotedStr('') + ',' + LatLng.LatToStr(0) + LatLng.LngToStr(0);

  GeocodeData(Tmp);
end;

procedure TGMGeoCode.GeocodeData(Data: string);
var
  Tmp: string;
  TmpFile: string;
  T: TTime;
  Msg: TMsg;
//  Download: TDownLoadURL;
begin
(*
  {$IF CompilerVersion > 20}
  Tmp := STR_WEB + string(UTF8EncodeToShortString(Data)) + STR_SENSOR;
  {$ELSE}
  Tmp := STR_WEB + Data + STR_SENSOR;
  {$IFEND}

  if TCustomTransform.LangCodeToStr(FLangCode) <> '' then
    Tmp := Tmp + STR_LANGUAGE + TCustomTransform.LangCodeToStr(FLangCode);

  if (Bounds.NE.Lat <> 0) or (Bounds.NE.Lng <> 0) or
     (Bounds.SW.Lat <> 0) or (Bounds.SW.Lng <> 0) then
    Tmp := Tmp + Format(STR_BOUNDS, [Bounds.SW.ToUrlValue(0), Bounds.NE.ToUrlValue(0)]);

  if TCustomTransform.RegionToStr(FRegion) <> '' then
    Tmp := Tmp + STR_REGION + TCustomTransform.RegionToStr(FRegion);

  if (FGBusiness.Client <> '') and (FGBusiness.Signature <> '') then
    Tmp := Tmp + STR_CLIENT + FGBusiness.Client + STR_SIGNATURE + FGBusiness.Signature;

  TmpFile := TPath.GetTempFileName;
  DeleteFile(TmpFile);
  Download := TDownLoadURL.Create(nil);
  try
    Download.URL := Tmp;
    ForceDirectories( ExtractFilePath(TmpFile) );
    Download.Filename := TmpFile;
    Download.ExecuteTarget(nil);
  finally
    FreeAndNil(Download);
  end;
  FXMLData.LoadFromFile(TmpFile);
  DeleteFile(PChar(TmpFile));
  if Assigned(FAfterGetData) then FAfterGetData(Self);
*)
  if not Assigned(Map) then
    raise Exception.Create(GetTranslateText('Mapa no asignado', Language));

  Tmp := Data + ',' + QuotedStr(TCustomTransform.RegionToStr(FRegion));
  if (Bounds.NE.Lat <> 0) or (Bounds.NE.Lng <> 0) or
     (Bounds.SW.Lat <> 0) or (Bounds.SW.Lng <> 0) then
    Tmp := Tmp + ',' +  Bounds.SW.ToUrlValue(0) + ',' + Bounds.NE.ToUrlValue(0)
  else
    Tmp := Tmp + ',-1,-1,-1,-1';

  Tmp := Tmp + ',' + QuotedStr(TCustomTransform.LangCodeToStr(FLangCode));
  ExecuteScript('GetGeocoder', Tmp);
  T := Time + EncodeTime(0, 0, 1, 0);
  repeat
    FXMLData.Text := GetStringField(GeocoderForm, GeocoderFormXML);
    Sleep(1);
    while PeekMessage(msg, 0, 0, 0, PM_REMOVE) do
      DispatchMessage(msg);
    //if GetMessage(Msg,0,0,0) then
    //begin
    //  TranslateMessage(Msg);
    //  DispatchMessage(Msg);
    //end;
  until (T < Time) or (FXMLData.Text <> '');

  ParseData;

  System.SysUtils.DeleteFile(TmpFile);
end;

function TGMGeoCode.GetAPIUrl: string;
begin
  Result := 'https://developers.google.com/maps/documentation/geocoding/index';
end;

function TGMGeoCode.GetGeoResult(Index: Integer): TGeoResult;
begin
  Result := nil;
  if Assigned(FGeoResults[Index]) then Result := TGeoResult(FGeoResults[Index]);
end;

procedure TGMGeoCode.Notification(AComponent: TComponent;
  Operation: TOperation);
begin
  inherited;

  if (Operation = opRemove) and (AComponent <> nil) and (AComponent = FMarker) then
    FMarker := nil;
end;

procedure TGMGeoCode.ParseData;
var
  XML: IXMLDocument;

  procedure ParseNodes(Node: IXMLNode);
    function ParseResultNode(Node: IXMLNode): TGeoResult;
      function ParseAddrComponent(Node: IXMLNode): TAddressComponent;
      begin
        Result := TAddressComponent.Create;

        while Assigned(Node) do
        begin
          // ES: etiqueta "long_name" (sólo una)   // EN: "long_name" tag (only one)
          if SameStr(Node.NodeName, LBL_LONG_NAME) then
            Result.FLongName := Node.NodeValue;

          // ES: etiqueta "short_name" (sólo una)   // EN: "short_name" tag (only one)
          if SameStr(Node.NodeName, LBL_SHORT_NAME) then
            Result.FShortName := Node.NodeValue;

          // ES: etiqueta "type" (una o más)   // EN: "type" tag (one or more)
          if SameStr(Node.NodeName, LBL_TYPE) then
            Result.AddrCompTypeList.Add(Node.NodeValue);

          Node := Node.NextSibling;
        end;
      end;

      procedure ParseGeometry(GeoResult: TGeoResult; Node: IXMLNode);
        procedure GetLatLng(LatLng: TLatLng; Node: IXMLNode);
        begin
          while Assigned(Node) do
          begin
            if SameStr(Node.NodeName, LBL_LAT) then
              LatLng.Lat := LatLng.StringToReal(Node.NodeValue);

            if SameStr(Node.NodeName, LBL_LNG) then
              LatLng.Lng := LatLng.StringToReal(Node.NodeValue);

            Node := Node.NextSibling;
          end;
        end;

        procedure GetLatLngBounds(LatLngBounds: TLatLngBounds; Node: IXMLNode);
        begin
          while Assigned(Node) do
          begin
            if SameStr(Node.NodeName, LBL_SOUTHWEST) and (Node.ChildNodes.Count = 2) then
              GetLatLng(LatLngBounds.SW, Node.ChildNodes.First);

            if SameStr(Node.NodeName, LBL_NORTHEAST) and (Node.ChildNodes.Count = 2) then
              GetLatLng(LatLngBounds.NE, Node.ChildNodes.First);

            Node := Node.NextSibling;
          end;
        end;
      begin
        while Assigned(Node) do
        begin
          // ES: etiqueta "location" (sólo una)   // EN: "location" tag (only one)
          if SameStr(Node.NodeName, LBL_LOCATION) and (Node.ChildNodes.Count = 2) then
            GetLatLng(Result.Geometry.Location, Node.ChildNodes.First);

          // ES: etiqueta "location_type" (sólo una)   // EN: "location_type" tag (only one)
          if SameStr(Node.NodeName, LBL_LOCATION_TYPE) then
            Result.Geometry.FLocationType := StrToGeocoderLocationType(Node.NodeValue);

          // ES: etiqueta "viewport" (sólo una)   // EN: "viewport" tag (only one)
          if SameStr(Node.NodeName, LBL_VIEWPORT) and (Node.ChildNodes.Count = 2) then
            GetLatLngBounds(Result.Geometry.Viewport, Node.ChildNodes.First);

          // ES: etiqueta "bounds" (sólo una)   // EN: "bounds" tag (only one)
          if SameStr(Node.NodeName, LBL_BOUNDS) and (Node.ChildNodes.Count = 2) then
            GetLatLngBounds(Result.Geometry.Bounds, Node.ChildNodes.First);

          Node := Node.NextSibling;
        end;
      end;
    begin
      Result := TGeoResult.Create;

      while Assigned(Node) do
      begin
        // ES: etiqueta "type" (una o varias, normalmente sólo una)
        // EN: "type" tag (one or more, normally only one)
        if SameStr(Node.NodeName, LBL_TYPE) then
          Result.TypeList.Add(Node.NodeValue);

        // ES: etiqueta "formatted_address" (sólo una)   // EN: "formatted_address" tag (only one)
        if SameStr(Node.NodeName, LBL_FORMATTED_ADDRESS) then
          Result.FFormatedAddr := Node.NodeValue;

        // ES: etiqueta "address_component" (una o varias)   // EN: "address_component" tag (one or more)
        if SameStr(Node.NodeName, LBL_ADDRCOMPONENT) and (Node.ChildNodes.Count > 0) then
          Result.AddrCompList.Add(ParseAddrComponent(Node.ChildNodes.First));

        // ES: etiqueta "geometry" (sólo una)   // EN: "geometry" tag (only one)
        if SameStr(Node.NodeName, LBL_GEOMETRY) and (Node.ChildNodes.Count > 0) then
          ParseGeometry(Result, Node.ChildNodes.First);

        Node := Node.NextSibling;
      end;
    end;
  var
    ActualNode: Integer;
    CountNodes: Integer;
    Continue: Boolean;
  begin
    // ES: nos posicionamos en "GeocodeResponse" // EN: go to "GeocodeResponse" tag
    while Assigned(Node) and not SameStr(Node.NodeName, LBL_GEOCODERESPONSE) do
      Node := Node.NextSibling;

    if not Assigned(Node) or (Node.ChildNodes.Count = 0) then Exit;
    CountNodes := Node.ChildNodes.Count;
    Node := Node.ChildNodes.First;

    Continue := True;
    ActualNode := 1;

    while Assigned(Node) and Continue do
    begin
      if Assigned(FOnParseData) then FOnParseData(Self, ActualNode, CountNodes, Continue);
      Inc(ActualNode);

      // ES: etiqueta "status" (sólo una)   // EN: "status" tag (only one)
      if SameStr(Node.NodeName, LBL_STATUS) then
        FGeoStatus := TCustomTransform.StrToGeocoderStatus(Node.NodeValue);

      // ES: etiqueta "result" (ninguna, una o varias)  // EN: "result" (none, one or more)
      if SameStr(Node.NodeName, LBL_RESULT) and (Node.ChildNodes.Count > 0) then
        FGeoResults.Add(ParseResultNode(Node.ChildNodes.First));

      Node := Node.NextSibling;
    end;
  end;
begin
  if Assigned(FBeforeParseData) then FBeforeParseData(Self);

  if FXMLData.Text <> '' then
  begin
    if Assigned(FMarker) and FPaintMarkerFound then FMarker.Clear;
    FGeoResults.Clear;

    XML := LoadXMLData(FXMLData.Text);
    try
      XML.Active := True;

      ParseNodes(XML.ChildNodes.First);
    finally
      XML := nil;
    end;

    DoMarkers;
  end;

  if Assigned(FBeforeParseData) then FBeforeParseData(Self);
end;

procedure TGMGeoCode.ShowElements;
begin
  inherited;
end;

function TGMGeoCode.StrToGeocoderLocationType(
  GeocoderLocationType: string): TGeocoderLocationType;
begin
  case AnsiIndexStr(UpperCase(GeocoderLocationType), ['APPROXIMATE', 'GEOMETRIC_CENTER',
                                    'RANGE_INTERPOLATED', 'ROOFTOP', 'NOTHING']) of
    0: Result := gltAPPROXIMATE;
    1: Result := gltGEOMETRIC_CENTER;
    2: Result := gltRANGE_INTERPOLATED;
    3: Result := gltROOFTOP;
    else Result := gltNOTHING;
  end;
end;

procedure TGMGeoCode.Geocode(Lat, Lng: Real);
var
  Tmp: TLatLng;
begin
  Tmp := TLatLng.Create(Lat, Lng);
  try
    Geocode(Tmp);
  finally
    FreeAndNil(Tmp);
  end;
end;

{ TGoogleBusiness }

procedure TGoogleBusiness.Assign(Source: TPersistent);
begin
  if Source is TGoogleBusiness then
  begin
    Client := TGoogleBusiness(Source).Client;
    Signature := TGoogleBusiness(Source).Signature;
  end
  else
    inherited Assign(Source);
end;

constructor TGoogleBusiness.Create;
begin
  FClient := '';
  FSignature := '';
end;

{ TGeoResult }

procedure TGeoResult.Assign(Source: TObject);
begin
  if Source is TGeoResult then
  begin
    FFormatedAddr := TGeoResult(Source).FormatedAddr;
    FTypeList.Assign(TGeoResult(Source).TypeList);
    FAddrCompList.Assign(TGeoResult(Source).AddrCompList);
    FGeometry.Assign(TGeoResult(Source).Geometry);
  end;
end;

constructor TGeoResult.Create;
begin
  FTypeList := TStringList.Create;
  FAddrCompList := TAddressComponentsList.Create;
  FGeometry := TGeometry.Create;
end;

destructor TGeoResult.Destroy;
begin
  if Assigned(FTypeList) then FreeAndNil(FTypeList);
  if Assigned(FAddrCompList) then FreeAndNil(FAddrCompList);
  if Assigned(FGeometry) then FreeAndNil(FGeometry);

  inherited;
end;

{ TGeometry }

procedure TGeometry.Assign(Source: TObject);
begin
  if Source is TGeometry then
  begin
    FLocationType := TGeometry(Source).LocationType;
    FLocation.Assign(TGeometry(Source).Location);
    FViewport.Assign(TGeometry(Source).Viewport);
    FBounds.Assign(TGeometry(Source).Bounds);
  end;
end;

constructor TGeometry.Create;
begin
  FLocation := TLatLng.Create;
  FLocationType := gltNOTHING;
  FViewport := TLatLngBounds.Create;
  FBounds := TLatLngBounds.Create;
end;

destructor TGeometry.Destroy;
begin
  if Assigned(FLocation) then FreeAndNil(FLocation);
  if Assigned(FViewport) then FreeAndNil(FViewport);
  if Assigned(FBounds) then FreeAndNil(FBounds);

  inherited;
end;

{ TAddressComponentsList }

function TAddressComponentsList.Add(AddrComp: TAddressComponent): Integer;
begin
  Result := FAddrComponents.Add(AddrComp);
end;

procedure TAddressComponentsList.Assign(Source: TObject);
begin
  if Source is TAddressComponentsList then
  begin
    FAddrComponents.Assign(TAddressComponentsList(Source).FAddrComponents);
  end;
end;

constructor TAddressComponentsList.Create;
begin
  FAddrComponents := TObjectList.Create;
end;

destructor TAddressComponentsList.Destroy;
begin
  if Assigned(FAddrComponents) then TObjectList.Create;

  inherited;
end;

function TAddressComponentsList.GetCount: Integer;
begin
  Result := FAddrComponents.Count;
end;

function TAddressComponentsList.GetItem(Index: Integer): TAddressComponent;
begin
  Result := nil;
  if Assigned(FAddrComponents[Index]) then
    Result := TAddressComponent(FAddrComponents[Index]);
end;

{ TAddressComponent }

procedure TAddressComponent.Assign(Source: TObject);
begin
  if Source is TAddressComponent then
  begin
    FShortName := TAddressComponent(Source).ShortName;
    FLongName := TAddressComponent(Source).LongName;
    FAddrCompTypeList.Assign(TAddressComponent(Source).AddrCompTypeList);
  end;
end;

constructor TAddressComponent.Create;
begin
  FAddrCompTypeList := TStringList.Create;
end;

destructor TAddressComponent.Destroy;
begin
  if Assigned(FAddrCompTypeList) then FreeAndNil(FAddrCompTypeList);

  inherited;
end;

end.
