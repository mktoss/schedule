$(document).on('turbolinks:load', function() {

  $('#calendar').fullCalendar({
    header:{
      left:'title',
      center: '',
      right: 'month,agendaWeek,agendaDay today prev,next',
    },
    height: '',
    firstDay: 1,
    navLinks: true,
    weekNumbers: true,
    weekNumbersWithinDays: true,
    nowIndicator: true,
  });
});
