// Compiled with Coffeescript
$(function() {
  var errorHandler, getLocation, showLocation;
  $("#receive").click(function() {
    var waypoint_url;
    waypoint_url = "p/" + ($('#waypoint_name').val());
    return document.location.href = waypoint_url;
  });
  showLocation = function(position) {
    var latitude, longitude;
    latitude = position.coords.latitude;
    longitude = position.coords.longitude;
    $("#lat").val(latitude);
    $("#lng").val(longitude);
    return $(".status").html("Ready to send");
  };
  errorHandler = function(err) {
    if (err.code === 1) {
      return $(".status").html("Access to GPS denied");
    } else {
      if (err.code === 2) {
        return $(".status").html("Can't find location.");
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
      return $(".status").html("App requires GPS connectivity. Try another device.");
    }
  };
  getLocation();
  return $("#send").click(function() {
    getLocation();
    $.ajax({
      type: "POST",
      url: "/",
      data: $("form.send").serialize(),
      dataType: "json"
    });
    var conf_url;
    conf_url = "p/" + ($('#sendName').val());
    alert("Your location has been sent. We will now redirect you to the map to verify accuracy. Your shareable URL for this waypoint is: http://radiocollar.heroku.com/"+conf_url);
    document.location.href = conf_url;
  });

});
