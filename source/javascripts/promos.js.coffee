$ ->

  time_zone = "America/New_York"
  date_format = "dddd M/D"
  time_format = "h:mma"

  formatTime = (timestamp) ->
    moment(timestamp).tz(time_zone).format(time_format)

  formatDate = (timestamp) ->
    moment(timestamp).tz(time_zone).format(date_format)

  promos_url = "https://www.googleapis.com/calendar/v3/calendars/hbjs5fr1p58g3unvfmbu31vjm4@group.calendar.google.com/events"
  $.get promos_url,
    alt: "json"
    key: "AIzaSyCYFGl_MCQq7TyZ3xXJvCcxHJSwleulLUk"
    timeMin: moment().toISOString()
    maxResults: 4
    orderBy: "startTime"
    singleEvents: true
  , (data) ->
    html_output = ""

    if data.items.length
      _.each data.items, (promo) ->
        promo_title = promo.summary
        promo_date = formatDate promo.start.dateTime
        promo_open = formatTime promo.start.dateTime
        promo_close = formatTime promo.end.dateTime
        promo_content = promo.description
        html_output += "<article><h3>#{promo_title}</h3><p class='small'>#{promo_date} #{promo_open}-#{promo_close}</p><p>#{promo_content}</p></article>"
    else
      html_output += "<article><h3>No Current Promotions</h3><p>Check back here later for special deals and events!</p></article>"

    $("#promotions").html html_output
