	    $(document).ready(function() {

	        if ($.browser.msie) {
	            $('select#psname').ieSelectWidth
			({
			    containerClassName: 'select-container',
			    overlayClassName: 'select-overlay'
			});
	        }


	        //the absolute value of the controller for contact us
//	        var controllerurl = 'controller.aspx'; 
	        var controllerurl = '/contact-us/controller.aspx';

	        $(".sres").hide();

	        if ($.browser.msie && $.browser.version < 8 && 1 == 2) {
	            $('#psname').mouseover(function() {
	                $(this).data("origWidth", $(this).css("width")).css("width", "auto");
	            })

        .mouseout(function() {
            $(this).css("width", $(this).data("origWidth"));
        });
	        }


	        $("#itype").change(function() {

	            if ($("#itype").val() == "loc") {
	                // alert('locations!');
	                $("#results").html('<div id="panelLocation"><p><em>Location/ Instrument Systems, Sexually Transmitted Diseases, Virals, Microbial Infectious Diseases, Culture Identification, Blood Screening/all products within these sections </em></p><p><strong>Gen-Probe Incorporated </strong><br />10210 Genetic Center Drive <br />San Diego, CA 92121 <br />(858) 410-8000 <br /></p><p><em>Location/Respiratory Infectious Diseases/all Prodesse products </em>  </p><strong>Gen-Probe Prodesse, Inc.</strong><p>W229 N1870 Westwood Drive <br />Waukesha, WI 53186</p><p>(262) 446-0700 <br />(888) 589-6974 <br />Fax: (262) 446-0600 </p><p><em>Location/Genetic Disease Testing/all Elucigene products </em></p><p><strong>Gen-Probe Life Sciences Ltd. </strong><br />12 Blacklands Way, Abingdon Business Park <br />Abingdon, Oxfordshire, OX14 1DY, UK <br />Tel: +44 (0)1235 544220 <br />Fax: +44 (0)1235 544222 <br />  Email: elucigene@gen-probe.com </p><em>Location/Transplant Diagnostics/all Lifecodes products </em><strong>Gen-Probe Transplant Diagnostics Inc.</strong><p>550 West Avenue, Stamford, CT 06902, USA <br />Tel: +01 888 329 0255 <br />Fax: +01 203 328 9599 <br />Email: lifecodes@gen-probe.com </p><p><em>Location/Immunology Products/all Diaclone products</em></p>           				<p>            				  <strong>Gen-Probe Diaclone SAS, 1 Bd A Fleming, BP 1985 </strong><br />           				  F-25020 Besancon Cedex, France <br />           				  Phone: +33 3 81 41 38 38 <br />           				  Fax: +33 3 81 41 36 36 <br />           				  e-mail: diaclone@gen-probe.com <br />  </p>           				<p><em>Location/DNA Extraction Products/all Nucleon products </em></p>           				<p><strong>Gen-Probe Life Sciences Ltd.</strong></p>           				<p>Heron House, Oaks Business Park<br/>           				Crewe Road,  Wythenshawe           				Manchester            				  M23 9HZ <br/>           				UK Tel: +44 (0)161 946 2200 <br/>           				Freephone: (800) 731 3016 <br />           				  UK Fax: +44 (0)161 946 2211 <br />           				  UK Email: pharmaservices@gen-probe.com <br />  </p>           				<p><em>Location/Pharmaceutical Services/all Pharma Services </em></p>           				<em>Pharmaceutical Services Ð Livingston </em>           				<p><strong>Gen-Probe Life Sciences Ltd.</strong></p>           				<p>Appleton Place, Appleton Parkway <br />           				  Livingston, West Lothian. EH54 7EZ <br />           				  Phone: +44 (0)1506 424270 <br />           				  Fax: +44 (0)1506 424280 <br />           				  e-mail: pharmaservices@gen-probe.com <br />  </p>           				<em>Nucleic Acid Purification Ð Manchester </em>           				<p><strong>Gen-Probe Life Sciences Ltd., Heron House, </strong><br />           				  Oaks Business Park, Crewe Road, <br />           				  Wythenshawe, Manchester <br />  M23 9HZ</p><p>UK Tel: +44 (0)161 946 2200 <br />UK Fax: +44 (0)161 946 2211 <br />UK Email: pharmaservices@gen-probe.com<br />  </p></div>');
	                $('#maparea').hide();

	                $("#psname").html("<option value='0'>Select one</option>");
	                $("#psline").html("<option value='0'>Select one</option>");
	                $("#pstype").html("<option value='0'>Select one</option>");
	                $("#locat").html("<option value='0'>Select one</option>");
	                $("#psline").attr('disabled', 'disabled');
	                $("#pstype").attr('disabled', 'disabled');
	                $("#psname").attr('disabled', 'disabled');
	                $("#locat").attr('disabled', 'disabled');
	                $("#psline").val('0');
	                $("#pstype").val('0');
	                $("#psname").val('0');
	                $("#locat").val('0');


	                return false;
	            }
	            else {

	                //reset other panels
	                $('.sres').hide();
	                $('.zipcodes').hide();
	                $('#maparea').hide();

	                var optval = encodeURIComponent($("#itype").val());

	                //show which dropdowns are loading
	                $("#pstype").html("<option value='0'>Loading...</option>");
	                $("#psline").html("<option value='0'>Loading...</option>");

	                //reset other selects
	                $("#psname").html("<option value='0'>Select one</option>");
	                $("#locat").html("<option value='0'>Select one</option>");
	                $("#psline").attr('disabled', 'disabled');
	                $("#pstype").attr('disabled', 'disabled');
	                $("#psname").attr('disabled', 'disabled');
	                $("#locat").attr('disabled', 'disabled');
	                $("#psline").val('0');
	                $("#pstype").val('0');
	                $("#psname").val('0');
	                $("#locat").val('0');

	                $.ajax({

	                    type: "POST",
	                    url: controllerurl,
	                    data: "informationtype=" + optval,
	                    success: function(msg) {

	                        if (msg.toString().indexOf('pstype') > -1 && msg.toString().indexOf('line') > -1) {

	                            //load second two dropdowns productionline and productiontype
	                            var select1string = msg.toString().split("<!--||||||||||-->")[0];
	                            var select2string = msg.toString().split("<!--||||||||||-->")[1];
	                            var locstring = msg.toString().split("<!--||||||||||-->")[2];
	                            var resultstring = msg.toString().split("<!--||||||||||-->")[3];

	                            //alert(resultstring);

	                            $("#pstype").removeAttr('disabled');
	                            $("#pstype").html(select1string);
	                            $("#pstype").val('0');

	                            $("#psline").removeAttr('disabled');
	                            $("#psline").html(select2string);
	                            $("#psline").val('0');

								if ( optval == "locations" ){
	                            //setup location dropdown
	                            $("#locat").html(locstring);
	                            $("#locat").val('0');
	                            $("#locat").removeAttr('disabled');
	                            //fixlocations();

	                            $("#results").html(resultstring);
	                            }
	                        }

	                    } //end of success
	                }); //end of $ajax

	            } //end else

	        });

	        $("#pstype").change(function() {

	            //reset other panels
	            $('.sres').hide();
	            $('.zipcodes').hide();
	            $('#maparea').hide();

	            var pstype_optval = encodeURIComponent($("#pstype").val());
	            var itype_optval = encodeURIComponent($("#itype").val());

	            $("#psline").html("<option value='0'>Not Used</option>").attr('disabled', 'disabled');
	            $("#psname").html("<option value='0'>Loading...</option>");


	            //reset other selects
	            //  $("#psline").html("<option value='0'>Select one</option>");
	            //   $("#psname").html("<option value='0'>Select one</option>");
	            $("#locat").html("<option value='0'>Select one</option>");
	            $("#psline").attr('disabled', 'disabled');
	            $("#psname").attr('disabled', 'disabled');
	            $("#locat").attr('disabled', 'disabled');
	            $("#psline").val('0');
	            $("#psname").val('0');
	            $("#locat").val('0');


	            $.ajax({

	                type: "POST",
	                url: controllerurl,
	                data: "informationtype=" + itype_optval + "&productservicetype=" + pstype_optval,
	                success: function(msg) {

	                    if (msg.toString().indexOf('psname') > -1) {

	                        $("#psname").removeAttr('disabled');
	                        $("#locat").removeAttr('disabled');

	                        var namestring = msg.toString().split("<!--||||||||||-->")[0];
	                        var selectstring = msg.toString().split("<!--||||||||||-->")[1];
	                        var resultstring = msg.toString().split("<!--||||||||||-->")[2];
	                        //alert(selectstring);

	                        //set prodcut name dropdown
	                        $("#psname").html(namestring);
	                        $("#psname").val('0');

	                        //setup location dropdown
	                        $("#locat").html(selectstring);
	                        $("#locat").val('0');
	                        fixlocations();

	                        //setup hidden result divs
	                        $("#results").html(resultstring);

	                    }

	                } //end of success
	            }); //end of $ajax

	        });



	        $("#psline").change(function() {

	            //reset other panels
	            $('.sres').hide();
	            $('.zipcodes').hide();
	            $('#maparea').hide();

	            //var pstype_optval = encodeURIComponent($("#pstype").val());
	            var itype_optval = encodeURIComponent($("#itype").val());
	            var psline_optval = encodeURIComponent($("#psline").val());

	            //show which dropdown is not being used
	            $("#pstype").html("<option value='0'>Not Used</option>").attr('disabled', 'disabled');

	            //show with dropdown is loading
	            $("#psname").attr('disabled', 'disabled').html("<option value='0'>Loading...</option>");

	            //reset other selects
	            $("#locat").html("<option value='0'>Select one</option>");
	            $("#locat").attr('disabled', 'disabled');
	            $("#locat").val('0');


	            $.ajax({

	                type: "POST",
	                url: controllerurl,
	                data: "informationtype=" + itype_optval + "&productserviceline=" + psline_optval, // + "&productservicetype=" + pstype_optval,
	                success: function(msg) {

	                    //alert(msg);
	                    $("#psname").removeAttr('disabled');
	                    $("#locat").removeAttr('disabled');

	                    var namestring = msg.toString().split("<!--||||||||||-->")[0];
	                    var selectstring = msg.toString().split("<!--||||||||||-->")[1];
	                    var resultstring = msg.toString().split("<!--||||||||||-->")[2];
	                    //alert(selectstring);

	                    //set prodcut name dropdown
	                    $("#psname").html(namestring);
	                    $("#psname").val('0');

	                    //setup location dropdown
	                    $("#locat").html(selectstring);
	                    $("#locat").val('0');
	                    fixlocations();

	                    //setup hidden result divs
	                    $("#results").html(resultstring);

	                    //	                //set prodcut name dropdown
	                    //	                $("#psname").html(namestring);
	                    //	                $("#psname").val('0');

	                    //	                //setup location dropdown
	                    //	                $("#locat").html(selectstring);
	                    //	                $("#locat").val('0');

	                    //	                //setup hidden result divs
	                    //	                $("#results").html(resultstring);
	                    //	                
	                    //	                    //alert("Returned: " + msg);
	                    //	                    if (msg.toString().indexOf('psname') > -1) {

	                    //	                        $("#psname").removeAttr('disabled');
	                    //	                        $("#psname").html(msg);

	                    //	                        $("#psname").val('0');

	                    //	                    }
	                    //	                    else if (msg.toString().indexOf('locat') > -1) {

	                    //	                        $("#locat").removeAttr('disabled');

	                    //	                        var selectstring = msg.toString().split("<!--||||||||||-->")[0];
	                    //	                        var resultstring = msg.toString().split("<!--||||||||||-->")[1];
	                    //	                        //alert(selectstring);

	                    //	                        //setup dropdown
	                    //	                        $("#locat").html(selectstring);

	                    //	                        //setup hidden result divs
	                    //	                        $("#results").html(resultstring);

	                    //	                        //set location dropdown to "select one" option
	                    //	                        $("#locat").val('0');
	                    //	                        $("#psname").attr('disabled', 'disabled').html("<option value='0'>Not Used</option>");
	                    //	                    }

	                } //end of success
	            }); //end of $ajax
	        });




	        $("#psname").change(function() {
	            //reset other panels
	            $('.sres').hide();
	            $('.zipcodes').hide();
	            $('#maparea').hide();

	            //grab all values from selects
	            var pstype_optval = encodeURIComponent($("#pstype").val());
	            var itype_optval = encodeURIComponent($("#itype").val());
	            var psline_optval = encodeURIComponent($("#psline").val());
	            var psname_optval = encodeURIComponent($("#psname").val());

	            //data string, we know we will send informationtype and productionservicename
	            var data = "informationtype=" + itype_optval + "&productservicename=" + psname_optval;

	            //we will send on of these two
	            if (pstype_optval != '0')
	                data += "&productservicetype=" + pstype_optval;
	            if (psline_optval != '0')
	                data += "&productserviceline=" + psline_optval

	            //show which dropdown we are about to load
	            $("#locat").html("<option value='0'>Loading...</option>");

	            $.ajax({

	                type: "POST",
	                url: controllerurl,
	                data: data,
	                success: function(msg) {
	                    //alert("Returned: " + msg);

	                    //alert(msg.toString().indexOf('pstype'))

	                    if (msg.toString().indexOf('locat') > -1) {

	                        $("#locat").removeAttr('disabled');

	                        var selectstring = msg.toString().split("<!--||||||||||-->")[0];
	                        var resultstring = msg.toString().split("<!--||||||||||-->")[1];
	                        //alert(selectstring);

	                        //setup dropdown
	                        $("#locat").html(selectstring);
	                        fixlocations();

	                        //setup hidden result divs
	                        $("#results").html(resultstring);



	                        //if there is only 1 option choose that one
	                        if ($('#locat option').length == 2) {

	                            $("#locat").val($('#locat [value="0"] ').next().val());

	                            var maptoload = $('#locat [value="' + $('#locat :selected').val() + '"] ').attr("class");
	                            var locationid = $('#locat [value="' + $('#locat :selected').val() + '"] ').attr("id");
	                            //alert(locationid.toString().replace("loc", ""));

	                            loadMapFromAddress($('#sres' + locationid.toString().replace("loc", "")).find('textarea.original_address').val());
	                            //alert($('#sres' + locationid.toString().replace("loc", "")).find('textarea').val());
	                            //loadMap(maptoload);

	                            $('.sres').hide();
	                            $('#sres' + locationid.toString().replace("loc", "")).show();
	                        }
	                        else //if there is more than one location choose option one 'Select One'
	                            $("#locat").val('0');

	                    }

	                } //end of success
	            }); //end of $ajax
	        }); // end of change



	        $("#locat").change(function() {

	            //alert('hey');
	            $('.sres').hide();
	            $('.zipcodes').hide();
	            $('#maparea').hide();

	            var maptoload = $('#locat [value="' + $('#locat :selected').val() + '"] ').attr("class");
	            var locationid = $('#locat [value="' + $('#locat :selected').val() + '"] ').attr("id");
	            var originaladdress = $('#sres' + locationid.toString().replace("loc", "")).find('textarea').val();

	            //alert(maptoload);
	            //alert(locationid);
	            //alert(originaladdress);
	            //alert(locationid.toString().replace("loc", ""));

	            //alert($('#sres' + locationid.toString().replace("loc", "")).find('textarea').val());
	            //loadMap(maptoload);

	            $('.sres').hide();

	            //added for multiple countries
	            if ($('#locat [value="' + $('#locat :selected').val() + '"] ').hasClass('multi')) {
	                //alert('show more');
	                //$('#sres' + locationid.toString().replace("loc", "")).show();


	                //show other locations

	                //alert($('#locat [value="' + $('#locat :selected').val() + '"] ').text().split(' - ')[0]);
	                $('.sres.' + $('#locat [value="' + $('#locat :selected').val() + '"] ').text().split(' - ')[0].replace(' ', '')).show().append("<br/><a class='seemap'>See Map</a>"); ;

	                $('#maparea').hide();
	            }
	            else {
	                if (originaladdress.indexOf("zipcode") > -1) { $('.zipcodes').fadeIn("fast"); }
	                else {
	                    loadMapFromAddress($('#sres' + locationid.toString().replace("loc", "")).find('textarea.original_address').val());
	                    $('#sres' + locationid.toString().replace("loc", "")).show();
	                    $('.zipcodes').hide();
	                }
	                // loadMap('addr1');

	            } //if not multi
	        });


	        $("#zipcode").click(function() {
	            var zipcodetosearch = $('#zipcodetext').val();

	            //add validation here 

	            //alert(zipcodetosearch);

	            //data string, we know we will send informationtype and productionservicename
	            var data = "zipcode=" + zipcodetosearch;

	            $.ajax({

	                type: "POST",
	                url: controllerurl,
	                data: data,
	                success: function(msg) {

	                    //alert(msg);

	                    //setup hidden result divs
	                    $("#results").html(msg.toString().replace("<!--||||||||||-->", ""));
	                    $('.sres').show();

	                } //end of success
	            }); //end of $ajax

	        }); //end of zipcode click

	        $(".seemap").live("click", function() {

	            loadMapFromAddress($(this).parent().find('textarea.original_address').val());
	        });


	    });                                             //end of onready


	    function fixlocations() {
	            var lastcountry = 'haha';
	        $('#locat option').each(function() {

	            //	            alert($(this).val());

	            //	            alert($(this).val().indexOf(' - '));


	            currentval = $(this).val();
	            if (currentval.indexOf(' - ') > -1 && currentval.indexOf('Gen-Probe') == -1) {

	                if (currentval.indexOf(lastcountry) > -1) {

	                  //  alert('removing ' + $(this).val() + 'last country:' + lastcountry);
	                    $(this).remove();
	                }

	                $(this).text(currentval.split(' - ')[0]);
	                $(this).addClass('multi');
	                lastcountry = currentval.split(' - ')[0];
	                //alert(lastcountry);

	            }

	        });
	    }