// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery-ui.min
//= require tag-it
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require cocoon
//= require_tree .
//= require highlight_js/highlight
//= require highlight_js/languages/ruby
//= require highlight_js/languages/bash
//= require highlight_js/languages/coffeescript
//= require highlight_js/languages/css
//= require highlight_js/languages/http
//= require highlight_js/languages/javascript
//= require highlight_js/languages/json
//= require highlight_js/languages/markdown
//= require highlight_js/languages/nginx
//= require highlight_js/languages/python
//= require highlight_js/languages/sql
//= require highlight_js/languages/xml
//= require codemirror

hljs.initHighlightingOnLoad();

$(document).ready(function() {
  $('pre code').each(function(i, block) {
    hljs.highlightBlock(block);
  });
});
