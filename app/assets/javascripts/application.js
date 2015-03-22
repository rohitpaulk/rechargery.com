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
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).on('page:fetch', function() { NProgress.start(); })
$(document).on('page:change', function() { NProgress.done(); })
$(document).on('page:restore', function() { NProgress.remove(); })

function zopim_chat(){
  $('[__jx__id], embed#__zopnetworkswf').remove();
  window.$zopim = null;
  (function(d,s){
    var z = $zopim = function(c){
      z._.push(c)
    }, $ = z.s = d.createElement(s), e = d.body.getElementsByTagName(s)[0];
    z.set = function(o){
      z.set._.push(o)
    };
    z._ = [];
    z.set._ = [];
    $.async = !0;
    $.setAttribute('charset','utf-8');
    $.src = '//v2.zopim.com/?1cGnGfQz1c3fmX9mbEBvOXtF3XZD1lIZ';
    z.t = +new Date;
    $.type = 'text/javascript';
    e.parentNode.insertBefore($,e)
  })(document,'script');
}

$(document).on('ready', zopim_chat);

$(document).on('page:load', function(){
	zopim_chat();
	$zopim(function() {
    $zopim.livechat.button.show();
  });
});

