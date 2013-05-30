<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="genprobhelper" %>

<templates:siteheader 
    ID="SiteHeader"
    bodyclass="contact" 
    section="contact-us" 
    title="Gen-Probe, Gen Probe, GenProbe, GPRO, Nucleic Acid Test (NAT), (NATs), Blood Screening,  Testing, Rapid Disease Detection, Blood Diseases, Screen Donated Blood"
    desc="Gen-Probe is a Global Leader in the Development, Manufacture and Marketing of Rapid, Accurate and Cost-Effective Nucleic Acid Tests (NATs) which Rapidly and Accurately Detect Diseases."
    keywords="gen probe, genprobe, nucleic acid test, nat, nats, biotechnology, detect diseases, probe, healthcare conference, blood diseases, detect blood diseases, gen probe international, gen probe incorporated, gen probe inc, san diego, global leader, development, manufacture, marketing, cost-effective, blood testing, diagnose human diseases, screen donated blood, screen donated human blood, rapid, accurate, testing methods, GPRO"
    subsection=""
    breadcrumbs="<li class=''><a href='../contact-us/'>Contact Us</a></li><li>›</li><li class='last act'><a href='../contact-us/'>Contact Info Search</a></li>"
    subsectionselected = ""
    topnavselected="" 
    leftnavselected="" 
    heroimage="/im/hero_contact.jpg"
    javascript="<script type='text/javascript'>$(document).ready(function(){$('#sectnav li').hide();$('#tabs').tabs();});</script>" 
    runat="server" />

<script type="text/javascript">

function ContactUsApp(settings) {


	// Our somewhat minimal Sammy app
	window.SammyApp = Sammy('.contactcont', function() {

	  this.get('#/', function() {});
	
	  // Our form posts to here
	  this.post('#/search/', function() {
		// Iterate over the params and set the <name>_id in our view 
		// This triggers our observer which will call get_options()
		jQuery.each(this.params,function(key,value) {
			App.drillDownView.set(key+'_id',parseInt(value));
		});
		
		if (this.params['zipcode']) {
			App.drillDownView.set('zipcode',this.params['zipcode']);
		} else {
			App.drillDownView.set('zipcode','');
		}
		
		return false;
	  });

	}); // End our Sammy stuff...
	
	window.App = Ember.Application.create({
	  rootElement	: '.contactcont'
	});
	
	/* Helper Functions */

	var makeContCb = function(name) {
		return function() {
	  		this.isEnabled(name, this.get(name));
	  		if (!this.get(name)) {
	  			this.set(name+'_id',0);
	  		}
	  	}.observes(name);
	}
	
	var makeIDCb = function(name) { 
		return function() {
	  		var value = this.get(name+'_id');
	 	 	this.get_options(name, value);	  
	 	}.observes(name+'_id');
	 }
	 
	/* Our drillDownView View */
	
	App.drillDownView = Ember.View.create({
	  templateName	: 'contact-us-drilldown',
	  
	  // The <options> ajax fetches from our script go here
	  itype			: '',
	  pstype		: '',
	  psline		: '',
	  psname		: '',
	  locat			: '',
	  
	  itype_cont_cb	: makeContCb('itype'),
	  pstype_cont_cb: makeContCb('pstype'),
	  psline_cont_cb: makeContCb('psline'),
	  psname_cont_cb: makeContCb('psname'),
	  locat_cont_cb	: makeContCb('locat'),
	  
	  // This is the internal state
	  itype_id		: 0,
	  pstype_id		: 0,
	  psline_id		: 0,
	  psname_id		: 0,
	  locat_id		: 0,
	  
	  itype_cb		: makeIDCb('itype'),	  
	  pstype_cb		: makeIDCb('pstype'),  
	  psline_cb		: makeIDCb('psline'),
	  psname_cb		: makeIDCb('psname'),
	  locat_cb		: makeIDCb('locat'),
	  
	  zipcode		: '',
	  displayZip	: 0,
	  enableZipCode	: function() {
	  	var is_salesdist 	= this.get('itype_id') == 3;
	  	var is_uslocat		= this.get('locat_id') == settings['unitedstates_id'];
	  	var is_inpsname		= jQuery.inArray(String(this.get('psname_id')),settings['productservicename_ids']) != -1
	  
	  	if ( is_salesdist && is_uslocat && is_inpsname )
	  	{ // We're going into Zip Code mode...
	  		this.set('displayZip', 1);
	  		return true;
	  	}
	  },

	  // A few utility functions to keep everything pretty

	  isEnabled		:function(name, value) {
	  	var selector = '#'+name;
	  	if (value) {
	  		jQuery(selector).removeAttr('disabled');
	  	} else {
	  		jQuery(selector).attr('disabled', 'disabled');
	  	}
	  },
	  
	  pstype_psline_state	:function() {
	  	var psline_id = this.get('psline_id');
	  	var pstype_id = this.get('pstype_id');
	  
	  	if (!psline_id && !pstype_id) {
	  		this.isEnabled('pstype, #psline',1);
	  		this.set('psname_id',0);
	  		jQuery('#pstype option[value=0],#psline option[value=0]').text('Select one');
	  	} else if (psline_id) {
	  		this.isEnabled('pstype', 0);
	  		jQuery('#pstype option[value=0]').text('Not used');
	  		jQuery('#psline option[value=0]').text('Select one');
	  	} else {
	  		this.isEnabled('psline',0);
	  		jQuery('#pstype option[value=0]').text('Select one');
	  		jQuery('#psline option[value=0]').text('Not used');	  		
	  	}
	  }.observes('pstype_id','psline_id'),
	    
	  psname_state	: function() {
	  	if ( !this.get('psname_id') ) {
	  		this.set('locat',0);
	  	}
	  }.observes('psname_id'),
	  
	  /*
	  	Our big switch statement with all our ajax calls
	  */
	  get_options	: function(name, value) {
	  	var setOption = function() {
			var selector = '#'+name;
			jQuery(selector).val(value);
	  	}
	  	
	  	var _this = this;
	  
	  	switch(name) {
	  		
	  		case 'itype':
	  			/*
	  				Get our Product Service Type drill down options
	  			*/
		  		var data = {
		  			'action'					: 'get_productservicetype',
		  			'informationtype_id'		: value
		  		}
		  		
	  			jQuery.get('/contact-us/cu_controller.aspx', data, function(html) {
	  				_this.set('pstype', html);
					setOption();
	  			});

	  			/*
	  				Get our Product Service Line drill down options
	  			*/
		  		var data = {
		  			'action'					: 'get_productserviceline',
		  			'informationtype_id'		: value
		  		}
		  		
	  			jQuery.get('/contact-us/cu_controller.aspx', data, function(html) {
	  				_this.set('psline', html);
	  				setOption();
	  			});

	  		break;
	  		case 'pstype':
	  			
	  			/*
	  				Get our Product Service Name drill down options
	  			*/
		  		var data = {
		  			'action'					: 'get_productservicename',
		  			'informationtype_id'		: App.drillDownView.get('itype_id'),
		  			'productservicetype_id'		: value
		  		}
		  		
	  			jQuery.get('/contact-us/cu_controller.aspx', data, function(html) {
	  				_this.set('psname', html);
	  				setOption();
	  			});	  			
	  			
	  		break;
	  		case 'psline':

	  			/*
	  				Get our Product Service Name drill down options
	  			*/
		  		var data = {
		  			'action'					: 'get_productservicename',
		  			'informationtype_id'		: App.drillDownView.get('itype_id'),
		  			'productserviceline_id'		: value
		  		}
		  		
	  			jQuery.get('/contact-us/cu_controller.aspx', data, function(html) {
	  				_this.set('psname', html);
	  				setOption()
	  			});	
	  		
	  		break;
	  		case 'psname':

	  			/*
	  				Get our Location drill down options
	  			*/
		  		var data = {
		  			'action'					: 'get_location',
		  			'informationtype_id'		: App.drillDownView.get('itype_id'),
		  			'productservicename_id'		: value
		  		}
		  		
		  		if ( App.drillDownView.get('pstype_id') ) {
		  			data['productservicetype_id'] = App.drillDownView.get('pstype_id');
		  		} else {
		  			data['productserviceline_id'] = App.drillDownView.get('psline_id');
		  		}
		  		
	  			jQuery.get('/contact-us/cu_controller.aspx', data, function(html) {
	  				_this.set('locat', html);
	  				setOption()
	  			});
	  		
	  		break;
	  		case 'locat':
	  		
	  		break;
	  		
	  	}
	  }
	});
	
	// Location View
	App.locationView = Ember.View.create({
	  templateName	: 'contact-us-location',
	  info			: '',
	  is_loading	: false,
	  is_technicalsupport : function(key,value) {
	  	if (arguments.length === 1) {
	  		var itype_id = App.drillDownView.get('itype_id');
	  		if (itype_id == 5) {
	  			return true;
	  		} else {
	  			return false;
	  		}
	  	}
	  }.property('App.drillDownView.itype_id'),

	  is_customerservice : function(key,value) {
	  	if (arguments.length === 1) {
	  		var itype_id = App.drillDownView.get('itype_id');
	  		if (itype_id == 2) {
	  			return true;
	  		} else {
	  			return false;
	  		}
	  	}
	  }.property('App.drillDownView.itype_id'),
	  
	  get_location_info: function() {
	  		// Check to see if we're going into Zip Code mode...
	  		if (App.drillDownView.enableZipCode()) {
	  			return;
	  		}
	  			  
			var data = {
				'action'					: 'get_contact',
				'informationtype_id'		: App.drillDownView.get('itype_id'),
				'productservicename_id'		: App.drillDownView.get('psname_id'),
				'location_id'				: App.drillDownView.get('locat_id')
			}
		
	  		if ( App.drillDownView.get('pstype_id') ) {
	  			data['productservicetype_id'] = App.drillDownView.get('pstype_id');
	  		} else {
	  			data['productserviceline_id'] = App.drillDownView.get('psline_id');
	  		}			
			
			this.set('is_loading',true);
			
			var _this = this;
			jQuery.get('/contact-us/cu_controller.aspx', data, function(html) {
				_this.set('info', html);
				_this.set('is_loading',false);
			});
	  }.observes('App.drillDownView.locat_id'),
	  
	  get_salesrep_from_zipcode:function() {
	  		if ( !App.drillDownView.get('zipcode') ) {
	  			return;
	  		}
			var data = {
				'action'					: 'get_salesrepinfo',
				'productservicename_id'		: App.drillDownView.get('psname_id'),
				'zipcode'					: App.drillDownView.get('zipcode')
			}	  

			this.set('is_loading',true);
			
			var _this = this;
			jQuery.get('/contact-us/cu_controller.aspx', data, function(html) {
				_this.set('info', html);
				_this.set('is_loading',false);
			});	  
	  }.observes('App.drillDownView.zipcode')

	});
	  	
	
	// Our onChange event for our <select>s
	jQuery('.contact-us-drilldown-select').live('change',function(e) {
		/* 
			Here we make sure we have a state the makes sense 
			before we send it over to Sammy.
			
			If it don't make no sense then we make it make sense.
		*/
		var $changed = jQuery(e.target);
		
		var reset = function(li) {
			jQuery.each(li, function(key,value) {
				jQuery('#'+value).val(0).attr('disabled','disabled');
				App.drillDownView.set(value,'');
			});
			App.drillDownView.set('displayZip',0);
		} 
		
		switch ( $changed.attr('name') ) 
		{
			case 'itype':
				// Reset everything...
				reset(['psname','psline','pstype','locat']);
			break;
			case 'psline':
			case 'pstype':
				// Reset psname and locat
				reset(['psname','locat']);
			break;
			case 'psname':
				// Reset locat
				reset(['locat']);
			break;
		}
	
		jQuery('#drilldown').submit();
	});
	
	// Get our default <options> for InformationType
	jQuery.get('/contact-us/cu_controller.aspx', {action:'get_informationtype'}, function(html) {
		App.drillDownView.set('itype', html);
	},'html');
	
	// Append our views and run Sammy run
	App.drillDownView.appendTo('#selectors');
	App.locationView.appendTo('#results');
	SammyApp.run('#/');
	
}

jQuery(function() {
	jQuery.get('/contact-us/templates.html', function(html) {
		jQuery('head').append(html);
		jQuery.getScript('/js/ember.min.js', function() {
			jQuery.get('/contact-us/cu_controller.aspx', {action:'get_appsettings'}, function(text) {
				// Prep our settings a bit...
				var li = text.split('%')
				var settings = {
					unitedstates_id:li[0],
					productservicename_ids:li[1].split(" ")
				}
				console.log(settings);
				ContactUsApp(settings);
			},'text');
		});
	}, 'html');
});

</script>


<div class="right">
	<div class="rightnarrow">
		<p class="ttl"><span>Search</span></p>
		
		<p>Use the dropdown tools below to find the specific contact info you're looking for. Start with the type of information you need (Customer Service, Technical Support, Sales Reps, etc.) and then narrow your search with the additional tools.If you need further assistance, please call Customer Service at <br/>800-523-5001 (press 1), or Technical Support at 888-484-4747.</p>

		<div class="clear"></div>
		
		<div class="contactcont">
		
				<div id="selectors"></div><!-- #selectors -->
	           	
           		<div id="results"></div><!-- #results -->
           		
           		<div class="clear hr"></div>
           		
           		<div id="mapareaholder" style="height:360px; width: 582px; display:block;">
           		    <div id="maparea"></div>
           		</div><!-- #mapareaholder -->
           		
           		<div class="clear"></div>
           		
		</div><!-- .contactcont -->
	</div><!-- .rightnarrow -->
</div><!-- .right -->	
                
                
<templates:sitefooter runat="server" />