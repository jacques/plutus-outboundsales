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
    <link href="/vendor/bootstrap-datepicker/dist/css/bootstrap-datepicker3.min.css" rel="stylesheet">
  </head>
  <body class="container">
{* Phone number to be dialled needs to be be in e164 format as the call centree will be dialling both the UK and South Africa *}
    <h2 class="page-header">Calling {$user->first_name|escape} {$user->last_name|escape} on +{$user->mobile_number|escape}</h2>

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
          <th>Email Address</th>
          <th>Mobile Number</th>
          <th>FICA Status</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{$user->first_name|escape}</td>
          <td>{$user->last_name|escape}</td>
          <td>{$user->email_address|escape}</td>
          <td>{$user->mobile_number|escape}</td>
          <td class="{if $user->fica_status == 0}danger{elseif $user->fica_status == 1}warning{else}success{/if}">{$user->fica_status}</td>
        </tr>
      </tbody>
    </table>

    <div id="callstatus">
      <p>
        <strong>Call Status</strong>:

        <input type="button" id="call-noanswer" class="btn btn-danger" value="No Answer">
        <input type="button" id="call-busy" class="btn btn-danger" value="Busy">
        <input type="button" id="call-voicemail" class="btn btn-danger" value="Went to Voicemail">
        <input type="button" id="call-answered" class="btn btn-primary" value="Answered">
      </p>
    </div>

    <p>
      Good day.  Can I please speak to <strong>{$user->first_name|escape} {$user->last_name|escape}</strong>?
    </p>

    <p>
<div class="row">
  <div class="col-lg-6">
    <h3 class="page-header">Customer is on other end of the phone</h3>

    <p>
      Hi it's {$smarty.session.first_name|escape} calling you from IMOGO.
    </p>

    <p>
      Please note all calls are recorded for your protection and ours. (Ursula to supply wording here).
    </p>

    <p>
      Can you please give me your {if $user->id_type == 1}Idenity Number{elseif $user->id_type == 2}Passport Number{elseif $user->id_type == 3}Asylum Document Number{/if}.  (User should give you <strong>{$user->id_document_number}</strong>).
    </p>

    <p>
      Is it a convenient time to talk?
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

    <p id="callbackform">
      <form method="post">
      <table class="table table-bordered table-stripped">
        <tbody>
          <tr>
            <th>Date</th>
            <td>
              <input class="form-control datepicker" data-provide="datepicker" data-date-orientation="top right" data-date-format="yyyy-mm-dd" value="2018-02-28" data-date-start-date="0d" data-date-end-date="+14d" data-date-days-of-week-disabled="0,6">
            </td>
          </tr>
          <tr>
            <th>Time</th>
            <td>
              <select class="form-control" name="callback_time">
                <option value="09:00:00">9am</option>
                <option value="10:00:00">10am</option>
                <option value="11:00:00">11am</option>
                <option value="12:00:00">12pm</option>
                <option value="13:00:00">1am</option>
                <option value="14:00:00">2am</option>
                <option value="15:00:00">3am</option>
                <option value="16:00:00">4am</option>
              </select>
            </td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td><input type="button" class="btn btn-primary" value="Set Callback">
          </tr>
        </tbody>
      </table>
      </form>
    </p>

  </div>
</div>
    </p>

    <p>
      I have an exciting offer.
    </p>

    <p>
      IMOGO has a very exciting offer for our customers.  The Telkom Sim Sonke Sim Card as well as
      monthly airtime and cheap international calls.
    </p>

    <p>
      How much airtime do you use every month?
    </p>

    <p>
      <strong>ZAR</strong> <input type="text" value="" name="monthly_airtime_spend" id="monthly_airtime_spend">
    </p>

    <p>
      As a valued customer of IMOGO, not only can I double your talk time or even triple your talk time.
    </p>

    <div id="two">
      <h3 class="page-header">PACKAGE TWO</h3>

      <p>
        Fantastic we have a R 200/month package just for you with a R200 once off registration fee.
      </p>

      <p>
        We will supply you with a Telkom Simsonke SIM Card.  Don't worry you will keep your existing phone number.   Double your
        data etc.
      </p>

      <p>
        The package provides you with:

        <ul>
          <li>1GiB of data</li>
          <li>300 Telkom to Telkom minutes</li>
          <li>10GiB of Telkom Wifi Data</li>
          <li>100 SMS Message</li>
          <li>500Mb Free Whatapp Data</li>
        </ul>
      </p>
    </div>

    <div id="three">
      <h3 class="page-header">THREE</h3>

      <p>
        Fantastic we have a R 300/month package.
      </p>

      <p>
        We will supply you with a SIM.  Don't worry you will keep your existing cell number.   Double your
        data etc.
      </p>

      <p>
        The package provides you with:

        <ul>
          <li>1GiB of data</li>
          <li>300 Telkom to Telkom minutes</li>
          <li>10GiB of Telkom Wifi Data</li>
          <li>100 SMS Message</li>
          <li>500Mb Free Whatapp Data</li>
        </ul>
      </p>
    </div>

    <div id="four">
      <h3 class="page-header">FOUR</h3>

      <p>
        Fantastic we have a R 400/month package.
      </p>

      <p>
        We will supply you with a SIM.  Don't worry you will keep your existing cell number.   Double your
        data etc.
      </p>

      <p>
        The package provides you with:

        <ul>
          <li>1GiB of data</li>
          <li>300 Telkom to Telkom minutes</li>
          <li>10GiB of Telkom Wifi Data</li>
          <li>100 SMS Message</li>
          <li>500Mb Free Whatapp Data</li>
        </ul>
      </p>
    </div>

    <p>
      Included in your R 200 is R 10000 funeral cover.
{if $user->id_type == 1}
        As a South African we can double your funeral cover.
{else}
        As a foreigner we can repatriate your body home.
{/if}
    </p>

    <p>
      You get a free last will and testament.  You don't have to take this up.  If you die without a will the state takes everything.
    </p>

    <p>
      Is your estate worth more than R 250k?
    </p>

    <p>
      We are going to give you special airtime.  For just R 200.
    </p>

    <p>
      As an existing IMOGO customer, we are going to give you a R 300 gift voucher for when you buy your next cellphone from Phones4U Warehouse.
    </p>

    <p>
      Do you have a funeral plan?
<div class="pull-right">
    <select name="has_funeral" class="form-control">
      <option value="yes">Yes</option>
      <option value="no">No</option>
    </select>
</div>
    </p>


    <p>
      Can I interest you in a funeral plan for R 10k cover for you and your family?  (Details to be populated still).
<div class="pull-right">
    <select name="interested_funeral" class="form-control">
      <option value="yes">Yes</option>
      <option value="no">No</option>
    </select>
</div>
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
      RAM will courier the package to you within the next 24 hours after this phone call.
    </p>

    <p>
      Can I confirm how you would like to pay for your product Bouquet?

<div class="pull-right">
      <select id="payment_method" name="payment_method" class="form-control">
        <option value="wallet">IMOGO Account</option>
        <option value="creditcard">Credit Card</option>
        <option value="debitorder">Debit Order</option>
      </select>
</div>
    </p>

    <div id="wallet">
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
        <table class="table table-bordered table-stripped">
          <thead>
            <tr>
              <th>Select Wallet</th>
            </tr>
          </thead>
        </table>
      </form>
    </div>
    <div id="debitorder">
      <h2 class="page-header">Debit Order</h2>

      <p>
        Great.  Please provide me with your banking details so we can setup a debit order for paying for your bouquet.
      </p>

      <p>

      </p>
      <form>
      </form>
    </div>
    <div id="creditcard">
      <h2 class="page-header">Credit Card Payment</h2>

      <p>
        I will send you an email with a link to add a credit card to your profile via PayFast our payment provider.
      </p>

      <button class="btn btn-primary"><i class="fa fa-fw fa-send"></i> Send Card Link</button>
    </div>

    <p>
      May I interest you with one of our exciting cellphones?   Blurb goes here.
    </p>


    <p>

    </p>

    <p>
      May I interest you with one of our exciting cellphones?   Blurb goes here.
    </p>


    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>
    <script type="text/javascript">
{literal}
jQuery(document).ready(function(){
  $('#payment_method').change(function(){
    console.log($(this).find('option:selected').val());
    var selected = $(this).find('option:selected').val();
    if (selected == 'wallet') {
      $('#wallet').show();
      $('#debitorder').hide();
      $('#creditcard').hide();
    } else if (selected == 'debitorder') {
      $('#wallet').hide();
      $('#debitorder').show();
      $('#creditcard').hide();
    } else {
      $('#wallet').hide();
      $('#debitorder').hide();
      $('#creditcard').show();
    }
  }).change();

  $('#wallet').show();
  $('#debitorder').hide();
  $('#creditcard').hide();
});

jQuery(document).ready(function(){
  $('#monthly_airtime_spend').change(function(){
    var monthly_airtime_spend = $('#monthly_airtime_spend').val();

    if (monthly_airtime_spend < 201) {
        $('#two').show();
        $('#three').hide();
        $('#four').hide();
    } else if (monthly_airtime_spend < 301) {
        $('#two').hide();
        $('#three').show();
        $('#four').hide();
    } else if (monthly_airtime_spend < 401) {
        $('#two').hide();
        $('#three').hide();
        $('#four').show();
    }
  }).change();

  $('#two').hide();
  $('#three').hide();
  $('#four').hide();
});

$('#call-noanswer').click(function() {
   $.ajax({
    type: "POST",
    url: "/admin/outboundsales/calls/{/literal}{$call->uuid}{literal}/callstatus",
    data: {"call_status":"noanswer","{/literal}{$csrf_key}{literal}":"{/literal}{$csrf_token}{literal}"},
    success: function( returnedData ) {
      $( '#callstatus' ).html( '<p>Call Status updated on Call Record.</p>' );
      location.reload(true);
    }
  });
});

$('#call-busy').click(function() {
   $.ajax({
    type: "POST",
    url: "/admin/outboundsales/calls/{/literal}{$call->uuid}{literal}/callstatus",
    data: {"call_status":"busy","{/literal}{$csrf_key}{literal}":"{/literal}{$csrf_token}{literal}"},
    success: function( returnedData ) {
      $( '#callstatus' ).html( '<p>Call Status updated on Call Record.</p>' );
      location.reload(true);
    }
  });
});

$('#call-voicemail').click(function() {
   $.ajax({
    type: "POST",
    url: "/admin/outboundsales/calls/{/literal}{$call->uuid}{literal}/callstatus",
    data: {"call_status":"voicemail","{/literal}{$csrf_key}{literal}":"{/literal}{$csrf_token}{literal}"},
    success: function( returnedData ) {
      $( '#callstatus' ).html( '<p>Call Status updated on Call Record.</p>' );
      location.reload(true);
    }
  });
});

$('#call-answered').click(function() {
   $.ajax({
    type: "POST",
    url: "/admin/outboundsales/calls/{/literal}{$call->uuid}{literal}/callstatus",
    data: {"call_status":"answered","{/literal}{$csrf_key}{literal}":"{/literal}{$csrf_token}{literal}"},
    success: function( returnedData ) {
      $( '#callstatus' ).html( '<p>Call Status updated on Call Record.</p>' );
    }
  });
});
{/literal}
    </script>
    <script src="/vendor/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"></script>
  </body>
</html>
