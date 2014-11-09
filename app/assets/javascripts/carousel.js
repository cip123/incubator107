
$( document ).ready(function() {
  
  $('.carousel').carousel({
    interval: false
  }) 
  
  $('.left').hide();

  $('#article-carousel').on('slid.bs.carousel', function (ev) {
    var carouselData = $(this).data('bs.carousel');
    var currentIndex = carouselData.getActiveIndex();
    if (currentIndex >= 1) {
      $('.left').show();
    }
    else {
      $('.left').hide();
    }

  if (currentIndex === (carouselData.$items.length-1)) {
    $('.left').show();
  }
  })
});
