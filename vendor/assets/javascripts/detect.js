(function ($) {
    $.AdBlockDetect = function() {
        var options = $.extend({
            support: false,
            detected: function() {},
            undetected: function() {}
        }, arguments[0] || {});

        var element = $('<IFRAME/>', {
            id: 'adserver',
            src: 'http://ads.google.com/adserver/adlogger_tracker.php',
            height: '300',
            width: '300',
            style: 'position: absolute; top: -1000px; left: -1000px;'
        });

        $('body').append(element);
        if (options.support)
        {
            $(options.support).append('This website is protected by <a href="http://github.com/killswitch/adblockdetect">AdBlockDetect</a>.');
        }
        setTimeout(function () {
            var adserver = $('#adserver');
            if (adserver.css('visibility') === 'hidden' || adserver.css('display') === 'none')
            {
                options.detected.call(this);
            }
            else
            {
                options.undetected.call(this);
            }
            element.remove();
        }, 300);
    };
})(jQuery);