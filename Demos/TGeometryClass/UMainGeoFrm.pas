unit UMainGeoFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GMClasses, GMMap, GMMapVCL,
  Vcl.OleCtrls, SHDocVw, Vcl.StdCtrls, Vcl.ExtCtrls, GMPolyline, GMPolygonVCL,
  GMLinkedComponents, GMMarker, GMMarkerVCL;

type
  TMainGeoFrm = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    WebBrowser1: TWebBrowser;
    GMMap1: TGMMap;
    GMMarker1: TGMMarker;
    GMPolygon1: TGMPolygon;
    ScrollBox1: TScrollBox;
    Label1: TLabel;
    eEncodePath: TEdit;
    Label2: TLabel;
    eDecodePath: TEdit;
    procedure GMMap1AfterPageLoaded(Sender: TObject; First: Boolean);
  private
    procedure DoDemo;
  public
  end;

var
  MainGeoFrm: TMainGeoFrm;

implementation

uses
  GMFunctionsVCL;

{$R *.dfm}

procedure TMainGeoFrm.DoDemo;
begin
  eEncodePath.Text := GMPolygon1[0].EncodePath;
  // you can do also:
  //     eEncodePath.Text := TGeometry.EncodePath(GMMap1, GMPolygon1[0].PolylineToStr);

  eDecodePath.Text := TGeometry.DecodePath(GMMap1, eEncodePath.Text);
  // you can do also:
  //     GMPolygon1[0].DecodePath(eEncodePath.Text, True or False);
end;

procedure TMainGeoFrm.GMMap1AfterPageLoaded(Sender: TObject; First: Boolean);
begin
  if First then
  begin
    GMMap1.DoMap;
    DoDemo;
  end;
end;

end.
