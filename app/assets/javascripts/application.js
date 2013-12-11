// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//    -- on bug/error, you see no styling in the page, it goes white & black
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//    -- haven't yet gotten relative paths to work
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
// Tried putting the datepicker files in app/assets/javascripts, 
//  -- but inspite of much stuff about the asset path, they were not found

// jquery & jquery_ujs are in `bundle show jquery-rails` 
//  => /Users/taqm/.rvm/gems/ruby-2.0.0-p353/gems/jquery-rails-3.0.4/vendor/assets/javascripts
//= require jquery
//= require jquery_ujs

// it appears that this is the correct setup for datepicker & datepicker.mobile, instrument datepicker to understand failures
//  -- pulled the latest datepicker down from http://blog.jqueryui.com/2013/05/jquery-ui-1-10-3/
//  -- it worked!
//  -- don't bother with minified version, let asset pipeline take care of that
//  -- require jQuery.ui.datepicker
//    -- this is patched version of datepicker.mobile, with live => on
//  -- require jquery.ui.datepicker.mobile

// mobileinit.js should be called after jquery but before jquery.mobile
//= require mobileinit.js

// jquery.mobile is in `bundle show jquery_mobile_rails`
// => /Users/taqm/.rvm/gems/ruby-2.0.0-p353/gems/jquery_mobile_rails-1.3.2/vendor/assets/javascripts
//  -- contains many ui widgets (fixed up a bit) & also some new ones but does not have datepicker & some others

// jquery.mobile 
//= require jquery.mobile
//= require turbolinks
