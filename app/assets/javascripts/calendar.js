$(document).ready(function () {
  $('#calendar').fullCalendar({
    header: {
        left: 'prev',
        center: 'title',
        right: 'next'
    },
    lang: 'ro',
    contentHeight: "auto",
    firstDay: 1,

    dayNames: ['Duminică', 'Luni', 'Marți', 'Miercuri', 'Joi', 'Vineri', 'Sâmbătă'],

    monthNames: ['ianuarie', 'februarie', 'martie', 'aprilie', 'mai', 'iunie', 'iulie', 'august', 'septembrie', 'octombrie',
           'noiembrie', 'decembrie'],

    eventSources: [{
      url: '/events',
      allDay: false
    }],

    eventBackgroundColor: "transparent",
    eventTextColor: "#a3346c",
    eventBorderColor: "transparent",
    displayEventEnd: true,
    titleFormat: '[Calendar] MMMM YYYY',

    columnFormat: {
      month: 'dddd',    // Monday, Wednesday, etc
      week: 'dddd, MMM dS', // Monday 9/7
      day: 'dddd, MMM dS'  // Monday 9/7
    },

    dayRender: function(date, cell) {
      day_number = cell.find(".fc-day-number").remove().html();
      cell.find("> div:first-child").css("class", "day-wrapper");
      cell.find("> div:first-child").append('<div class="fc-day-number">' + day_number + '</div>');
    },

  eventClick: function(calEvent, jsEvent, view) {

      document.location ="workshops/" + calEvent.id;
        
    },

    eventRender: function(event, element, view) {
      event_time = element.find('span.fc-event-time').remove().html();
      element.find(".fc-event-inner").append(' <div class="fc-event-time">' + event_time + '</div>');
      

      var limit = 20;
      if (event.title.length > limit) {
        element.find('.fc-event-title').text( event.title.substr(0,limit)+'...').parent().attr('title', event.title);
      }


    }


  });




});

