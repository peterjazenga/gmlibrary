object MainGeoFrm: TMainGeoFrm
  Left = 0
  Top = 0
  Caption = 'Main Form'
  ClientHeight = 444
  ClientWidth = 742
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 742
    Height = 129
    Align = alTop
    Caption = ' '
    TabOrder = 0
    object Memo1: TMemo
      Left = 409
      Top = 1
      Width = 332
      Height = 127
      Align = alRight
      Lines.Strings = (
        'uses GMFunctionsVCL'
        ''
        'At design-time'
        '  - GMInfoWindow1.Map := GMMap1'
        '  - GMMap1.WebBrowser := WebBrowser1'
        '  - GMMap1.Active := True'
        '  - GMMap1.RequiredProp.Center.Lat := 41,39963248'
        '  - GMMap1.RequiredProp.Center.Lng := 2,16794777'
        'At run-time'
        '  - Event GMMap1.AfterPageLoaded')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object ScrollBox1: TScrollBox
      Left = 1
      Top = 1
      Width = 408
      Height = 127
      Align = alClient
      TabOrder = 1
      DesignSize = (
        404
        123)
      object Label1: TLabel
        Left = 16
        Top = 16
        Width = 158
        Height = 13
        Caption = 'EncodePath from GMPolygon1[0]'
      end
      object Label2: TLabel
        Left = 16
        Top = 56
        Width = 196
        Height = 13
        Caption = 'DecodePath from previous Encoded Path'
      end
      object eEncodePath: TEdit
        Left = 24
        Top = 32
        Width = 357
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'eEncodePath'
      end
      object eDecodePath: TEdit
        Left = 24
        Top = 72
        Width = 357
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 1
        Text = 'eDecodePath'
      end
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 129
    Width = 742
    Height = 315
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 619
    ExplicitHeight = 298
    ControlData = {
      4C000000B04C00008E2000000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object GMMap1: TGMMap
    Language = Espanol
    Active = True
    IntervalEvents = 200
    Precision = 0
    RequiredProp.Center.Lat = 41.399632480000000000
    RequiredProp.Center.Lng = 2.167947770000000000
    RequiredProp.MapType = mtROADMAP
    RequiredProp.Zoom = 12
    NonVisualProp.MaxZoom = 0
    NonVisualProp.MinZoom = 0
    NonVisualProp.MapMaker = False
    Layers.Panoramio.Filtered = False
    Layers.Panoramio.Clickable = True
    Layers.Panoramio.Show = False
    Layers.Traffic.Show = False
    Layers.Transit.Show = False
    Layers.Bicycling.Show = False
    Layers.Weather.Show = False
    Layers.Weather.Clickable = True
    Layers.Weather.LabelColor = lcBLACK
    Layers.Weather.SuppressInfoWindows = False
    Layers.Weather.TemperatureUnit = tuCELSIUS
    Layers.Weather.WindSpeedUnit = wsKILOMETERS_PER_HOUR
    AfterPageLoaded = GMMap1AfterPageLoaded
    VisualProp.MapTypeCtrl.Position = cpTOP_RIGHT
    VisualProp.MapTypeCtrl.Style = mtcDEFAULT
    VisualProp.MapTypeCtrl.Show = True
    VisualProp.OverviewMapCtrl.Opened = True
    VisualProp.OverviewMapCtrl.Show = True
    VisualProp.PanCtrl.Position = cpTOP_LEFT
    VisualProp.PanCtrl.Show = True
    VisualProp.RotateCtrl.Position = cpTOP_LEFT
    VisualProp.RotateCtrl.Show = True
    VisualProp.ScaleCtrl.Position = cpBOTTOM_LEFT
    VisualProp.ScaleCtrl.Style = scDEFAULT
    VisualProp.ScaleCtrl.Show = True
    VisualProp.StreetViewCtrl.Position = cpTOP_LEFT
    VisualProp.StreetViewCtrl.Show = True
    VisualProp.ZoomCtrl.Position = cpTOP_LEFT
    VisualProp.ZoomCtrl.Style = zcDEFAULT
    VisualProp.ZoomCtrl.Show = True
    VisualProp.BGColor = 15659247
    WebBrowser = WebBrowser1
    Left = 240
    Top = 152
  end
  object GMMarker1: TGMMarker
    Language = Espanol
    Map = GMMap1
    AutoUpdate = True
    VisualObjects = <
      item
        Tag = 0
        MarkerType = mtStandard
        Animation.OnDrop = False
        Animation.Bounce = False
        Clickable = True
        Draggable = False
        Flat = False
        Position.Lat = 41.380866000000000000
        Position.Lng = 2.122579000000000000
        Title = 'Camp Nou'
        Visible = True
        Optimized = True
        RaiseOnDrag = True
        ColoredMarker.Width = 32
        ColoredMarker.Height = 32
        ColoredMarker.PrimaryColor = clRed
        ColoredMarker.StrokeColor = clBlack
        ColoredMarker.CornerColor = clWhite
        StyledMarker.StyledIcon = siMarker
        StyledMarker.ShowStar = False
        StyledMarker.BackgroundColor = clRed
        StyledMarker.TextColor = clBlack
        StyledMarker.StarColor = clLime
        InfoWindow.DisableAutoPan = False
        InfoWindow.MaxWidth = 0
        InfoWindow.PixelOffset.Height = 0
        InfoWindow.PixelOffset.Width = 0
        InfoWindow.CloseOtherBeforeOpen = True
        ShowInfoWinMouseOver = False
      end
      item
        Tag = 0
        MarkerType = mtStandard
        Animation.OnDrop = False
        Animation.Bounce = False
        Clickable = True
        Draggable = False
        Flat = False
        Position.Lat = 41.403185000000000000
        Position.Lng = 2.173725000000000000
        Title = 'Bas'#237'lica de la Sagrada Familia'
        Visible = True
        Optimized = True
        RaiseOnDrag = True
        ColoredMarker.Width = 32
        ColoredMarker.Height = 32
        ColoredMarker.PrimaryColor = clRed
        ColoredMarker.StrokeColor = clBlack
        ColoredMarker.CornerColor = clWhite
        StyledMarker.StyledIcon = siMarker
        StyledMarker.ShowStar = False
        StyledMarker.BackgroundColor = clRed
        StyledMarker.TextColor = clBlack
        StyledMarker.StarColor = clLime
        InfoWindow.DisableAutoPan = False
        InfoWindow.MaxWidth = 0
        InfoWindow.PixelOffset.Height = 0
        InfoWindow.PixelOffset.Width = 0
        InfoWindow.CloseOtherBeforeOpen = True
        ShowInfoWinMouseOver = False
      end
      item
        Tag = 0
        MarkerType = mtStandard
        Animation.OnDrop = False
        Animation.Bounce = False
        Clickable = True
        Draggable = False
        Flat = False
        Position.Lat = 41.415382000000000000
        Position.Lng = 2.151847000000000000
        Title = 'Parc G'#252'ell'
        Visible = True
        Optimized = True
        RaiseOnDrag = True
        ColoredMarker.Width = 32
        ColoredMarker.Height = 32
        ColoredMarker.PrimaryColor = clRed
        ColoredMarker.StrokeColor = clBlack
        ColoredMarker.CornerColor = clWhite
        StyledMarker.StyledIcon = siMarker
        StyledMarker.ShowStar = False
        StyledMarker.BackgroundColor = clRed
        StyledMarker.TextColor = clBlack
        StyledMarker.StarColor = clLime
        InfoWindow.DisableAutoPan = False
        InfoWindow.MaxWidth = 0
        InfoWindow.PixelOffset.Height = 0
        InfoWindow.PixelOffset.Width = 0
        InfoWindow.CloseOtherBeforeOpen = True
        ShowInfoWinMouseOver = False
      end
      item
        Tag = 0
        MarkerType = mtStandard
        Animation.OnDrop = False
        Animation.Bounce = False
        Clickable = True
        Draggable = False
        Flat = False
        Position.Lat = 41.375875000000000000
        Position.Lng = 2.177757000000000000
        Title = 'Estatua de Col'#243'n'
        Visible = True
        Optimized = True
        RaiseOnDrag = True
        ColoredMarker.Width = 32
        ColoredMarker.Height = 32
        ColoredMarker.PrimaryColor = clRed
        ColoredMarker.StrokeColor = clBlack
        ColoredMarker.CornerColor = clWhite
        StyledMarker.StyledIcon = siMarker
        StyledMarker.ShowStar = False
        StyledMarker.BackgroundColor = clRed
        StyledMarker.TextColor = clBlack
        StyledMarker.StarColor = clLime
        InfoWindow.DisableAutoPan = False
        InfoWindow.MaxWidth = 0
        InfoWindow.PixelOffset.Height = 0
        InfoWindow.PixelOffset.Width = 0
        InfoWindow.CloseOtherBeforeOpen = True
        ShowInfoWinMouseOver = False
      end>
    Left = 304
    Top = 152
  end
  object GMPolygon1: TGMPolygon
    Language = Espanol
    Map = GMMap1
    AutoUpdate = True
    VisualObjects = <
      item
        Tag = 0
        Clickable = True
        Editable = False
        Geodesic = False
        StrokeOpacity = 1.000000000000000000
        StrokeWeight = 2
        Visible = True
        AutoUpdatePath = True
        LinePoints = <
          item
            Lat = 41.403185000000000000
            Lng = 2.173725000000000000
          end
          item
            Lat = 41.432399270000000000
            Lng = 2.170203890000000000
          end
          item
            Lat = 41.415713950000000000
            Lng = 2.162254230000000000
          end>
        InfoWindow.DisableAutoPan = False
        InfoWindow.MaxWidth = 0
        InfoWindow.PixelOffset.Height = 0
        InfoWindow.PixelOffset.Width = 0
        InfoWindow.CloseOtherBeforeOpen = True
        Text = 'TPol'
        StrokeColor = clBlack
        FillColor = clRed
        FillOpacity = 0.500000000000000000
      end>
    Left = 376
    Top = 152
  end
end
