
$(document).ready(function () {


  var originalLeave = $.fn.popover.Constructor.prototype.leave;
  $.fn.popover.Constructor.prototype.leave = function(obj){
    var self = obj instanceof this.constructor ?
      obj : $(obj.currentTarget)[this.type](this.getDelegateOptions()).data('bs.' + this.type)
    var container, timeout;

    originalLeave.call(this, obj);

    if(obj.currentTarget) {
      container = $(obj.currentTarget).siblings('.popover')
      timeout = self.timeout;
      container.one('mouseenter', function(){
        //We entered the actual popover – call off the dogs
        clearTimeout(timeout);
        //Let's monitor popover content instead
        container.one('mouseleave', function(){
          $.fn.popover.Constructor.prototype.leave.call(self, self);
        });
      })
    }
  };

  var options = {
      selector: '[data-popover]',
      trigger: 'click hover',
      delay: {show: 1000, hide: 400},
      placement: function (context, source) {
        var length = $(source).html().length;
        
        if (length > 70) {
            return "left";
        } else {
            return "right";
        }

    }
  };

  $('body').popover(options);

 });

