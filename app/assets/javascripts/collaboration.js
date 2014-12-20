// $(document).ready(function () {

 //  $(".incubator-play").click(function () {
 //     alert('123');
 // });

  $(document).ready(function () {
    $(".fancybox-pdf").fancybox({
    openEffect  : 'none',
    closeEffect : 'none',
    iframe : {
        preload: false
    }
    });

$(".fancybox-img").click(function() {

    var images =[];
    
    $.each(JSON.parse($(this).attr('data')), function(index, url) {
        images.push({"href": url});
    });

    $.fancybox.open(
        images, {
        padding : 0
    });
    
    return false;
    
});


});