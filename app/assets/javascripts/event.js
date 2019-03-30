$(document).on('turbolinks:load', function() {
  $('#calendar').fullCalendar({
    header:{
      left:'title',
      center: '',
      right: 'month,agendaWeek,agendaDay today prev,next',
    },
    firstDay: 1,
    navLinks: true,
    weekNumbers: true,
    weekNumbersWithinDays: true,
    nowIndicator: true,
    eventLimit: true,
    events: location.href,
    eventClick: function(event) {
      location.href = `/projects/${event.project_id}/events/${event.id}`
    }
  });
});
