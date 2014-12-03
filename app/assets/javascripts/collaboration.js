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

$(".open-fancybox").click(function() {
    
    $.fancybox.open([
        {
            href : 'https://lh3.googleusercontent.com/-7dkpRQOh1MM/UKFxdzSmWaI/AAAAAAAARGo/Ndr6xe36rqA/IMG_0756.jpg',
        },
        {
            href : 'https://lh5.googleusercontent.com/-p-TS5Sv-RgM/UKFxd3Jcc-I/AAAAAAAARHc/1xy6SxVDt_o/IMG_0764.jpg',
        },
        {
            href : 'https://lh6.googleusercontent.com/-MA1wD8Be-r4/UKFxeKSUwzI/AAAAAAAARGs/LikUiDqbUbE/IMG_0781.jpg',
        },
        {
            href : 'https://lh4.googleusercontent.com/-dE1mIGiyLv0/UKFxfH6-y8I/AAAAAAAARG0/rxU44n6dAtM/IMG_0890.jpg',
        },
        {
            href : 'https://lh3.googleusercontent.com/-TeWKJeq46oY/UmOdcdQSVfI/AAAAAAAARJE/40MPK30oeVc/_DSC0007.JPG',
        },
        {
            href : 'https://lh5.googleusercontent.com/-pxZGQEC9Cvo/UmOdcX7crLI/AAAAAAAARJI/FYQB1XcnDAE/_DSC0009.JPG',
        },
        {
            href : 'https://lh5.googleusercontent.com/-roSKA01Wans/UmOdcl7fPVI/AAAAAAAARJM/CrI7-j-jK9c/_DSC0010.JPG',
        },
        {
            href : 'https://lh5.googleusercontent.com/-roSKA01Wans/UmOdcl7fPVI/AAAAAAAARJM/CrI7-j-jK9c/_DSC0010.JPG',
        }

        
    ], {
        padding : 0
    });
    
    return false;
    
});


  var json_Photo_URI = "https://picasaweb.google.com/data/feed/base/"
        + "user/"       +   "116022896304270817039"
        + "/albumid/"   +   "5810049749048865793"
        + "?alt="       +   "json"
        + "&kind="      +   "photo"
        + "&hl="        +   "en_US"
        + "&fields="    +   "entry(media:group)"
        + "&thumbsize=" +   104;

    $.getJSON(json_Photo_URI,
      function(data) {
        $.each(data.feed.entry, function(i,item){
          console.log(JSON.stringify(item));
        });
    });
        
});
    