$ ->

  time_zone = "America/New_York"
  date_format = "dddd M/D"
  time_format = "h:mma"

  formatTime = (timestamp) ->
    moment(timestamp).tz(time_zone).format(time_format)

  formatDate = (timestamp) ->
    moment(timestamp).tz(time_zone).format(date_format)

  promos_url = "http://www.google.com/calendar/feeds/hbjs5fr1p58g3unvfmbu31vjm4@group.calendar.google.com/public/full"
  $.get promos_url,
    alt: "json"
    orderby: "starttime"
    "max-results": 4
    singleevents: true
    sortorder: "ascending"
    futureevents: true
    fields: "entry(title,content,gd:when)"
  , (data) ->
    html_output = ""

    _.each data.feed.entry, (promo) ->
      promo_title = promo.title.$t
      promo_when = promo.gd$when[0]
      promo_date = formatDate promo_when.startTime
      promo_open = formatTime promo_when.startTime
      promo_close = formatTime promo_when.endTime
      promo_content = promo.content.$t
      html_output += "<article><h3>#{promo_title}</h3><p class='small'>#{promo_date} #{promo_open}-#{promo_close}</p><p>#{promo_content}</p></article>"

    $("#promotions").html html_output
