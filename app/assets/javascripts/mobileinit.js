// mobileinit.js
/*global document, pagebeforeshow, pagecreate, pageinit, pagechange, pageshow, pagehide, pageremove */
/*
	mobileinit is called *after* talkinvite code loaded but before jquery mobile
		-- it is used to setup the interface with jquery.mobile

	mobileinit trap has to be set *before* jquery.mobile is called,
		if it is to work, per the docs

	-- sets options for phonegap
	-- sets up back button
	-- sets default page traps, including the at one point important pageinit trap which (at that point) kicked off each page

	DEV:
		-- comment pageremove out & turn off domCache to help reduce caching, if cache-related bug suspected
    -- nesting here may be one level more than is needed, given that the ruby-on-rails asset pipeline
      wraps all functions in an anonymous self-executing function anyway
*/
(function ($) {
  console.log("mobileinit.js")

	$(document).on("mobileinit", function () {
		$.mobile.page.prototype.options.domCache = true;		// cache all pages

		// support back button
		$.mobile.page.prototype.options.addBackBtn = true;		// automatic back button, per Homeing Mobile Web Apps
		$.mobile.page.prototype.options.backBtnText = "Back";
		// $.mobile.page.prototype.options.backBtnTheme = "b";		// "b" gives white on blue, as does "a", "c", "d", and "e", actually seems to have *no* effect

		/*
			support for PhoneGap
				-- see http://jquerymobile.com/demos/1.2.0/docs/pages/phonegap.html
					for explanation & also for details on:
						Android navigation
						whitelisting
		*/
		$.support.cors = true;
		$.mobile.allowCrossDomainPages = true;

		// p163 jQuery Mobile: Up and Running says you can bind to element with data-role = page, doens"t seem to actually work...
		// $(":jqmData(role ="page")").bind("pagecreate", pagecreate);
		// $(":jqmData(role ="page")").bind("pageinit", pageinit);
		// $("#zetas").bind("pagecreate", pagecreate);

		/*
      events seem to okay in roughly the order:
				pagecreate
				pageinit
				[pageload] even tho logically load happens before create & init, the event happens after or so it seems
				[pagehide] only if there was a from page
				[pageremove] ???
				pageshow
				pagechange

			pagecreate sees new pages, so every page passes thru it once, on first build
			pageinit called, apparently reliabily, every time a page is shown
			pageremove is needed to keep pages from being disposed of
			-- rest of the page events aren't currently needed
		*/

		// talkinvite setup here, if necessary
		// e.g.: $(document).on("pageload", pageload);  // where pageload is a function defined in talkinvite.js somewhere

    $.mobile.ignoreContentEnabled = true; // so we can ignore some elements
    $(document).on("pageinit", "#talks-control", function(event0, data0){
      try {
        $('input[type=date]').datepicker();
      } catch(except1){ 
        console.error("error thrown on datepicker");
        console.dir(except1);
      }
    })
    // to keep the date inputs out of the hands of competing datepickers
    // see http://jquerymobile.com/demos/1.0a4.1/experiments/ui-datepicker/
    $.mobile.page.prototype.options.degradeInputs.date = true;  

	});
}(jQuery));
