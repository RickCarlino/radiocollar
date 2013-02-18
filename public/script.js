$(function() {
  var errorHandler, getLocation, showLocation;
  showLocation = function(position) {
    var latitude, longitude;
    latitude = position.coords.latitude;
    longitude = position.coords.longitude;
    $('.lat').val(latitude);
    $('.lng').val(longitude);
    return $('.status').html("Ready to send");
  };
  errorHandler = function(err) {
    if (err.code === 1) {
      return $('.status').html("Access to GPS denied");
    } else {
      if (err.code === 2) {
        return $('.status').html("Can't find location.");
      }
    }
  };
  getLocation = function() {
    var options;
    if (navigator.geolocation) {
      options = {
        timeout: 10000
      };
      return navigator.geolocation.getCurrentPosition(showLocation, errorHandler, options);
    } else {
      return $('.status').html("App requires GPS connectivity. Try another device.");
    }
  };
  getLocation();
  return $('.button').click(function() {
    getLocation();
    $.ajax({
      type: "POST",
      url: 'http://localhost:4567/',
      data: $('form').serialize(),
      success: function() {
        return alert('good');
      },
      dataType: 'json'
    });
    return alert('sent');
  });
});