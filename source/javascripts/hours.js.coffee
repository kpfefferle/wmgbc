$ ->

  time_zone = "America/New_York"
  date_format = "dddd M/D"
  time_format = "h:mma"

  formatTime = (timestamp) ->
    moment(timestamp).tz(time_zone).format(time_format)

  formatDate = (timestamp) ->
    moment(timestamp).tz(time_zone).format(date_format)

  hours_url = "https://www.googleapis.com/calendar/v3/calendars/5j72n5flnhdq7s78ks3n12stgk@group.calendar.google.com/events"
  $.get hours_url,
    alt: "json"
    key: "AIzaSyCYFGl_MCQq7TyZ3xXJvCcxHJSwleulLUk"
    timeMin: moment().toISOString()
    maxResults: 7
    orderBy: "startTime"
    singleEvents: true
  , (data) ->
    html_output = ""

    if data.items.length
      _.each data.items, (day) ->
        day_date = formatDate day.start.dateTime
        if day.summary == "Closed"
          day_hours = "Closed"
        else
          day_open = formatTime day.start.dateTime
          day_close = formatTime day.end.dateTime
          day_hours = "#{day_open}-#{day_close}"
        html_output += "<tr><th>#{day_date}</th><td>#{day_hours}</td></tr>"
    else
      html_output += "<tr><td>Closed for the season. We'll be back in the Spring!</td></tr>"

    $("table#hours").html html_output
