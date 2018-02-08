<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Outbound Sales</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
  </head>
  <body class="container">
    <h2 class="page-header">Calling {$user->first_name|escape} {$user->last_name|escape} on {$user->mobile_number|escape}</h2>

    <div class="alert alert-danger">
      <p>
        This is not a finalised and signed off by Tim Colman script.  It is rough for
        figuring out how to get a web page to display information and change the script
        as the call goes on. (i.e. opting into product / requesting info / etc.)
      </p>
    </div>

    <table class="table table-bordered table-condensed small">
      <thead>
        <tr>
          <th>First name</th>
          <th>Surname</th>
          <th>FICA Status</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{$user->first_name|escape}</td>
          <td>{$user->last_name|escape}</td>
          <td class="{if $user->fica_status == 0}danger{elseif $user->fica_status == 1}warning{else}success{/if}">{$user->fica_status}</td>
        </tr>
      </tbody>
    </table>

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
      available to take a call?   Or would you be interested in finding out more about our
      offering?  If they want to find out more then we need to show a clean script to capture
      the minimum info for the potential customer.
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
      IMOGO has a very exciting offer for our customers.  The Telkom Sim Sonke Sim Card as well as
      monthly airtime.
    </p>

    <p>
      How much money do you spend on airtime every month?
    </p>

    <p>
      The package provides you with:

      <ul>
        <li>100GiB of data</li>
        <li>Unlimited Telkom to Telkom minutes</li>
        <li>10GiB of Telkom Wifi Data</li>
        <li>Free Whatapp</li>
      </ul>
    </p>

    <p>
      Do you have a funeral plan?
    </p>

    <p>
      Can I interest you in a funeral plan for R 10k cover for you and your family?  (Details to be populated still).
    </p>

    <p>
      How does that sound {$user->last_name|escape}?
    </p>

    <p>
      May I go ahead and get your details for your activation of your IMOGO BongoTel Telkom Sim Sonke product?
    </p>

    <p>
      Please confirm your ID number {$user->last_name|escape} (expect {$user->id_document_number|escape}).
    </p>

    <p>
      Can I confirm how you would like to pay for your product Bouquet?

      <select name="payment_method" class="form-control">
        <option value="wallet">IMOGO Account</option>
        <option value="creditcard">Credit Card</option>
        <option value="debitorder">Debit Order</option>
      </select>
    </p>

    <div class="wallet">
      <h2 class="page-header">IMOGO Wallet</h2>

      <p>
        Great.  Please remember to ensure your monthly amount of R 200.00 and your once-off amount of R 200.00
        is deposited into the following FNB bank account.  I will also send you an email with the confirm your
        subscription which includes the banking details to use as well as how deposit at Boxer, Pick 'n Pay,
        Checkers, Shoprite and Spar if that is more convient for you.
      </p>

      <p>

      </p>
      <form>
      </form>
    </div>
    <div class="debitorder">
      <h2 class="page-header">Debit Order</h2>

      <p>
        Great.  Please provide me with your banking details so we can setup a debit order for paying for your bouquet.
      </p>

      <p>

      </p>
      <form>
      </form>
    </div>
    <div class="creditcard">
      <h2 class="page-header">Credit Card Payment</h2>

      <p>
        I will send you an email with a link to add a credit card to your profile via PayFast our payment provider.
      </p>

      <button class="btn btn-primary"><i class="fa fa-fw fa-send"></i> Send Card Link</button>
    </div>

    <p>
      May I interest you with one of our exciting cellphones?   Blurb goes here.
    </p>


    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

  </body>
</html>
