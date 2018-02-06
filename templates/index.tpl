<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Bootstrap 101 Template</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
  </head>
  <body class="container">
    <h2 class="page-header">Calling {$user->first_name|escape} {$user->last_name|escape} on {$user->mobile_number|escape}</h2>

    <p>
      Good day.  Can I please speak to {$user->first_name|escape} {$user->last_name|escape}?
    </p>

    <p>
<div class="row">
  <div class="col-lg-6">
    <h3 class="page-header">Customer is on other end of the phone</h3>

    <p>
      Hi it's {$smarty.session.first_name|escape} calling you from IMOGO.

      Is it a good time to introduce you to our amazing Telkom and BongoTel offering?
    </p>
  </div>
  <div class="col-lg-6">
    <h3 class="page-header">Customer is not on other end of the phone</h3>

    <p>
      Do you know when {$user->first_name|escape} {$user->last_name|escape} will be
      available to take a call?
    </p>

    <h3 class="page-header">Callback</h3>

    <p>When would it be a good time to call you back?</p>

    <p>
       Form for call back goes here.
    </p>

  </div>
</div>
    </p>

    <p>
      IMOGO has a very exciting offer for our customers.  The Telkom Sim Sonke Sim Card.
    </p>


    <p>
      The package provides you with:

      <ul>
        <li>1GiB of data</li>
        <li>300 telkom to telkom minutes</li>
        <li>10GiB of Telkom Wifi Data</li>
        <li>Free Whatapp</li>
      </ul>
    </p>

    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
  </body>
</html>
