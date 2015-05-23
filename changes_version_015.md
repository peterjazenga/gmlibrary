## Changes version 0.1.5 ##

July 12, 2012
  * Google Maps Library v0.1.5
  * Improvement: new component added, the TGMGeoCode.
  * Improvement: TGMCircle => Radius property becomes an integer.
  * Improvement: TGMCircle => added AutoResize property.
  * Improvement: TLatLng => it is controlled a possible exception in function StringToReal.
  * Improvement: TLatLngBounds => GetCenter function is deleted.
  * Improvement: TPolyline => added CountLinePoints property.
  * Improvement: TLinePoint => added ToStr method.
  * Improvement: TLinePoint => added StringToReal method.
  * Improvement: TRectangle => added GetCenter method.
  * Improvement: TGMMap => added events OnActiveChange, OnIntervalEventsChange and OnPrecisionChange.
  * Improvement: TGMMap => control Set methods of Zoom and MapType properties to update map automatically.
  * Improvement: TGMMap => Zoom, MaxZoom and MinZoom are limited at range 0 to 15.
  * Improvement: TLinkedComponent => added Text property (visible to all his descendants except TMarker because it has the Title property).
  * Improvement: TGMLinkedComponent => added Count property.
  * Improvement: added a new demo for all components.
  * Bug fixed: TGMBaseInfoWindow => GetConvertedString function now control the single quote.
  * Bug fixed: TLatLng => fix error in LatLngToStr function (thanks Erasmo).
  * Bug fixed: TGMMarker => the single quote is controled into Title property.
  * Bug fixed: TGMMap => bug fixed on RemoveLinkedComponent when trying delete an object without being the list created.
  * Bug fixed: JavaScript => when it had figures of different types together, there was a JS error when you move the mouse over them (thanks Erasmo).