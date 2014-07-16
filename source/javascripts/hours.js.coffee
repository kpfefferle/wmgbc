$ ->

  time_zone = "America/New_York"
  date_format = "dddd M/D"
  time_format = "h:mma"

  formatTime = (timestamp) ->
    moment(timestamp).tz(time_zone).format(time_format)

  formatDate = (timestamp) ->
    moment(timestamp).tz(time_zone).format(date_format)

  hours_url = "http://www.google.com/calendar/feeds/5j72n5flnhdq7s78ks3n12stgk@group.calendar.google.com/public/full"
  $.get hours_url,
    alt: "json"
    orderby: "starttime"
    "max-results": 7
    singleevents: true
    sortorder: "ascending"
    futureevents: true
    fields: "entry(title,gd:when)"
  , (data) ->
    html_output = ""

    _.each data.feed.entry, (day) ->
      day_when = day.gd$when[0]
      day_date = formatDate day_when.startTime
      if day.title.$t == "Closed"
        day_hours = "Closed"
      else
        day_open = formatTime day_when.startTime
        day_close = formatTime day_when.endTime
        day_hours = "#{day_open}-#{day_close}"
      html_output += "<tr><th>#{day_date}</th><td>#{day_hours}</td></tr>"

    $("table#hours").html html_output
