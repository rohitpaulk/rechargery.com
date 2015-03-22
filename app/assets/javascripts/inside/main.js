$(document).on('page:fetch', function() { NProgress.start(); })
$(document).on('page:change', function() { NProgress.done(); })
$(document).on('page:restore', function() { NProgress.remove(); })

var detectblock = function(callback){
	var element = $('<IFRAME/>', {
        id: 'adserver',
        src: 'http://ads.google.com/adserver/adlogger_tracker.php',
        height: '300',
        width: '300',
        style: 'position: absolute; top: -1000px; left: -1000px;'
    });

    $('body').append(element);
    setTimeout(function () {
        var adserver = $('#adserver');
        if (adserver.css('visibility') === 'hidden' || adserver.css('display') === 'none')
        {
        	//document.abcd = "WOAAAH ADBLOCK";
            $.get("/api/setadblock",function(){});
            callback();
        }
        else
        {
        	$.get("/api/unsetadblock",function(){});
        }
        //element.remove();
    }, 300);
};

