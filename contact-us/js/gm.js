function loadMap(addrid) {

	setTimeout( function() { 
	var map = new GMap2(document.getElementById("maparea"));
	
	var geocoder = new GClientGeocoder();
	
	if(addrid == 'addr1') { var address = '10210+Genetic+Center+Drive,+San+Diego,+CA+92121'; }
	else if(addrid == 'addr2'){ var address = '1W229+N1870+Westwood+Drive+Waukesha,+WI+53186'; }
	else if(addrid == 'addr3'){ var address = '12+Blacklands+Way,+Abingdon+Business+Park+Abingdon,+Oxfordshire,+OX14+1DY,+UK'; }
	else if(addrid == 'addr4'){ var address = '50+West+Avenue+Stamford,+CT+06902'; }
	else if(addrid == 'addr5'){ var address = '1+Boulevard+Alexandre+Fleming+25000+Besancon,+France'; }
	else if(addrid == 'addr6'){ var address = 'Crewe+Rd+The+Oaks+Business+Pk,+Manchester+M23+9HZ,+United+Kingdom'; }
	else if(addrid == 'addr7'){ var address = 'Appleton+Pl+Appleton+Pkwy,+Livingston,+West+Lothian+EH54+7EZ,+UK'; }

	
	geocoder.getLatLng(
    address,
    function(point) {
      if (!point) {
          alert(address + " not found");

      } else {
        map.setCenter(point, 15);
        var marker = new GMarker(point);
        map.addOverlay(marker);
      }
    }
  );
    //map.setCenter(new GLatLng(34.4647, -118.4656), 7);
	map.setMapType(G_NORMAL_MAP);
	var customUI = map.getDefaultUI();
	customUI.maptypes.satellite = false;
	customUI.maptypes.hybrid = false;
	customUI.maptypes.physical = false;
	map.setUI(customUI);
	},1);
}

function loadMapFromAddress(address) {
    $('#maparea').show();
    setTimeout(function() {
        var map = new GMap2(document.getElementById("maparea"));

        var geocoder = new GClientGeocoder();

        geocoder.getLatLng(
    address,
    function(point) {
        if (!point) {
            //alert(address + " not found");
            if (console.log) { console.log('not found'); }
        } else {
            map.setCenter(point, 15);
            var marker = new GMarker(point);
            map.addOverlay(marker);
        }
    }
  );
        //map.setCenter(new GLatLng(34.4647, -118.4656), 7);
        map.setMapType(G_NORMAL_MAP);
        var customUI = map.getDefaultUI();
        customUI.maptypes.satellite = false;
        customUI.maptypes.hybrid = false;
        customUI.maptypes.physical = false;
        map.setUI(customUI);
    }, 1);
}
