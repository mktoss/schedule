$(document).on('turbolinks:load', function() {

  function get_month(month) {
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    return months.indexOf(month) + 1
  }

  $('#calendar').fullCalendar({
    header: {
      left:'title',
      center: '',
      right: 'month,agendaWeek,agendaDay today prev,next',
    },
    firstDay: 1,
    navLinks: true,
    weekNumbers: true,
    weekNumbersWithinDays: true,
    nowIndicator: true,
    editable: true,
    eventLimit: true,
    events: location.href,
    eventClick: function(event) {
      location.href = `/projects/${event.project_id}/events/${event.id}`
    },
    eventDrop: function(event) {
      var start = String(event.start._d).split(' ');
      var start_time = start[3] + '-' + get_month(start[1]) + '-' + start[2] + ' ' + start[4];
      if (event.end) {
        var end = String(event.end._d).split(' ');
        var end_time = end[3] + '-' + get_month(end[1]) + '-' + end[2] + ' ' + end[4];
      }
      var data = {
        event: {
          start: start_time,
          end: end_time,
        }
      };

      console.log(start);

      $.ajax({
        type: 'PATCH',
        url:  `/projects/${event.project_id}/events/${event.id}`,
        data: data,
      })
    },
  });
});
