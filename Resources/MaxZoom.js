  function GetMaxZoom(Lat, Lng) {
    document.maxzoomdata.maxzoom.value = -1;
    document.maxzoomdata.response.value = 0;
    var MZ = new google.maps.MaxZoomService();
	MZ.getMaxZoomAtLatLng(new google.maps.LatLng(Lat,Lng), function(MaxZoomResult) {
      document.maxzoomdata.status.value = MaxZoomResult.status;
      if (MaxZoomResult.status = google.maps.MaxZoomStatus.OK) 
        document.maxzoomdata.maxzoom.value =  MaxZoomResult.zoom;
      document.maxzoomdata.response.value = 1;
	})
  }
