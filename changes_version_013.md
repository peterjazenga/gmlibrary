## Changes version 0.1.3 ##

June 21, 2012
  * Google Maps Library v0.1.3
  * Improvement: new component added, the TRectangle to create rectangles.
  * Improvement: General => Changed destination folder of DCU files. Now, each version have their own folder. Check "library path".
  * Improvement: TLatLng => added OnChange method.
  * Improvement: TLatLng => added StringToReal method. This methoid takes into account the regional configuration.
  * Improvement: TLatLngBounds => added GetCenter method.
  * Improvement: TLatLngBounds => properties NE and SW now are published.
  * Improvement: TLinkedComponent => added Tag (integer) property.
  * Improvement: TLinkedComponent => added FObject (TObject) property.
  * Improvement: TLinkedComponent => added protected methods (SetProperty) to generalize change into properties to avoid duplicate code.
  * Improvement: TMarker => added Icon property to specify the icon to show into a map. Can be a file into your PC or an image on the web.
  * Improvement: TGMMarker => added OnIconChange event.
  * Improvement: General => all Set methods are changed to avoid duplicate code.