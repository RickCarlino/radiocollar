$ ->
  showLocation = (position) ->
    latitude = position.coords.latitude
    longitude = position.coords.longitude
    $(".lat").val latitude
    $(".lng").val longitude
    $(".status").html "Ready to send"

  errorHandler = (err) ->
    if err.code is 1
      $(".status").html "Access to GPS denied"
    else
      $(".status").html "Can't find location."  if err.code is 2

  getLocation = ->
    if navigator.geolocation
      options = timeout: 10000
      navigator.geolocation.getCurrentPosition showLocation, errorHandler, options
    else
      $(".status").html "App requires GPS connectivity. Try another device."
  getLocation()
  $(".button").click ->
    getLocation()
    $.ajax
      type: "POST"
      url: "http://localhost:4567/"
      data: $("form.send").serialize()
      success: (-> alert "good")
      dataType: "json"
    alert "sent"