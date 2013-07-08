  function GetMaxZoom(doc, Lat, Lng) {
    doc.maxzoomdata.maxzoom.value = -1;
    doc.maxzoomdata.response.value = 0;
    var MZ = new google.maps.MaxZoomService();
	MZ.getMaxZoomAtLatLng(new google.maps.LatLng(Lat,Lng), function(MaxZoomResult) {
      doc.maxzoomdata.status.value = MaxZoomResult.status;
      if (MaxZoomResult.status = google.maps.MaxZoomStatus.OK) 
        doc.maxzoomdata.maxzoom.value =  MaxZoomResult.zoom;
      doc.maxzoomdata.response.value = 1;
	})
  }
