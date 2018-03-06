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

<div class="progress">
  <div class="progress-bar progress-bar-striped active" role="progressbar" aria-valuenow="45" aria-valuemin="0" aria-valuemax="100" style="width: 45%">
    <span class="sr-only">45% Complete</span>
  </div>
</div>

    <table class="table table-bordered table-condensed small">
      <thead>
        <tr>
          <th>First name</th>
          <th>Surname</th>
          <th>Email Address</th>
          <th>Mobile Number</th>
          <th>ID Type</th>
          <th>Document Number</th>
          <th>FICA Status</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{$user->first_name|escape}</td>
          <td>{$user->last_name|escape}</td>
          <td>{$user->email_address|escape}</td>
          <td>{$user->mobile_number|escape}</td>
          <td>{if $user->id_type == 1}SA ID{elseif $user->id_type == 2}Passport{elseif $user->id_type == 3}SA Asylum{/if}</td>
          <td>{$user->id_document_number|escape}</td>
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
      Good day.  Can I please speak with <strong>{$user->first_name|escape} {$user->last_name|escape}</strong>?
    </p>

    <div id="reachedcustomer">
      <p>
        <strong>Got this customer?</strong>:

        <input type="button" id="reached-customer" class="btn btn-primary" value="Yes">
        <input type="button" id="customer-not-available" class="btn btn-danger" value="Customer Not Available">
        <input type="button" id="msisdn-recycled" class="btn btn-danger" value="MSISDN Recycled">
      </p>
    </div>

    <p>
<div class="row">
  <div class="col-lg-6">
    <h3 class="page-header">Customer is on other end of the phone</h3>

    <p>
    How are you? (wait for customers answer)
    </p>

    <p>
    I am good thanks!
    </p>

    <p>
      You are speaking to {$smarty.session.first_name|escape}, I am a consulant from IMOGO.
    </p>

    <p>
      {if $user->gender == 'm'}Mr{else}Ms{/if} {$user->last_name|escape} please be advised - all calls are recorded for your security and training purposes.
    </p>

    <p>
      Do you have a few minutes {if $user->gender == 'm'}Mr{else}Ms{/if} {$user->last_name|escape} that you can spare?
    </p>

    <p>
      Can you confirm your {if $user->id_type == 1}Idenity Number{elseif $user->id_type == 2}Passport Number{elseif $user->id_type == 3}Asylum Document Number{/if}.  (User should give you <strong>{$user->id_document_number}</strong>).
    </p>

    <p>
      Thank you very much.
    </p>

    <p>
      {if $user->gender == 'm'}Mr{else}Ms{/if} {$user->last_name|escape} as one of our valued clients firstly I would like to introduce and offer you some of our new products.
    </p>

    <p>
      We have our 3 freedom connect packages but before I explain further about our freedom connect deals I would like to ask you if:
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

    <table class="table">
      <tr>
        <td>Are you on prepaid or contract or contract with topup?</td>
        <td>
          <select class="form-control" name="prepaid_or_contract" id="prepaid_or_contract">
            <option value="-1">Select Option</option>
            <option value="contract">Contract</option>
            <option value="hybrid">Contract with Topup</option>
            <option value="prepaid">Prepaid</option>
          </select>
        </td>
      </tr>
      <tr>
        <td>Which service provider are you with?</td>
        <td><input type="text" name="service_provider" id="service_provider" class="form-control"></td>
      </tr>
      <tr>
         <td>How much airtime do you use monthly?</td>
         <td>
          <select class="form-control" name="monthly_airtime_spend" id="monthly_airtime_spend">
            <option value="-1">Select Option</option>
            <option value="200">&lt; 200</option>
            <option value="300">&lt; 300</option>
            <option value="400">&gt; 300</option>
          </select>
         </td>
      </tr>
      <tr>
         <td>How much data do you use monthly?</td>
         <td>
          <select class="form-control" name="monthly_data_spend" id="monthly_data_spend">
            <option value="-1">Select Option</option>
            <option value="200">&lt; 200</option>
            <option value="300">&lt; 300</option>
            <option value="400">&gt; 300</option>
          </select>
         </td>
      </tr>
    </table>

    <div id="two">
      <h3 class="page-header">FREEDOM CONNECT FOUR HUNDRED</h3>

      <p>
         {if $user->gender == 'm'}Mr{else}Ms{/if} {$user->last_name|escape} we have our Freedom Connect 400 deal but we also have the Freedom Connect 600
         and Freedom Connect 800 deals but I want to introduce you to the Freedom Connect 400 deal.
      </p>

      <p>
        We double the airitme from R 200 to R 400 and you still pay R 200.
      </p>

      <p>
        This is what you get for R 200:
      </p>

      <ul>
        <li>A Telkom SIM</li>
        <li>The Bongotel App</li>
        <li>Funeral Cover</li>
        <li>A R300 Gift Voucher</li>
        <li>A Last Will and Testament</li>
      </ul>

      <p>
      For the Telkom Sim
      </p>

      <ul>
        <li>You get our Telkom Simsonke Simcard and you get to keep your number and we do a port me for you and you pay R 200 a month and you get R 400 airitime
          and you also get 300 free minutes Tekom to Telkom and it's fre to call a landline.</li>
        <li>And you get the double the value of on the recharge amount</li>
      </ul>

      <p>
        And you also get
      </p>

      <ul>
        <li>1GB of Internet bundle (data)</li>
        <li>10GB of WIFI data that you can use anttime when you go out for shopping you can download videos and movies with that 10GB wifi data</li>
        <li>100 SMS message you can use to send birthday wishes to your loved ones</li>
        <li>500Mb whatspp bundle you can use to make voice calls and video calls on whats app.</li>
      </ul>

      <p>
        Funeral Cover
      </p>

      <ul>
        <li>And then R 10000 of funeral cover but you are the main member (may I ask if you are married {if $user->gender == 'm'}Mr{else}Ms{/if} {$user->last_name|escape})? Y/N
Do you have kids?

Because you can also add your spouse and your parents and your kids for a small additional premium.
        <li>If you feel that you have more value to your life we do have the cover for R 15000, R 20000 and R 30000 and we also offering 
{if $user->id_type == 1}
        to double your funeral cover to R 20000 as you are a South African citizen.
{else}
        as a foreigner we can repatriate your body home.
{/if}

      <p>
        BongoTel
      </p>

      <p>
        And you also receive our Bongotel app and we will load R 10 airitme to start off with on the app.  Our Bongotel app has the lost cost calling of which
        I am sending the link as we speak.   (Ask for email address above? And confirm mobile number?)
      </p>

      <p>
        Once you have received the link you will need to down load the Bongotel app onto your phone from the playstore or appstore.
      </p>

      <p>
        With this app you make free calls to our users of the BongoTel app and pay less for a local call that what you would currently pay on any other
        service provided and you can travel the world with no roaming charges.
      </p>

      <p>
        R 300 Gift Voucher
      </p>

      <p>
        And we also give you a R 300 Gift Voucher loaded to your wallet that you can use for a discount on your net handset because we have amazing deals.  We
        have Apple iPhones and Samsung Phones for half price since you are our valued customer and you can go to our website to view more handsets.  The
        gift voucher is validd fro 90 days and we have the option to lay-by a phone and use the gift voucher towards your lay-by deposit.
      </p>

      <p>
        Last will and testament
      </p>

      <p>
        You also get a last will and testament that will assist you to ensure that your beneficiaries will divide your legacy in the way you intended it should your
        state be valued at more than R 250000 then a consultant will call you back with more information.
      </p>

      <p>
        May I ask how much your state is worth?
      </p>
      <p>
      < 250
     > 250
      </p>
    </div>

    <div id="three">
      <h3 class="page-header">FREEDOM CONNECT SIX HUNDRED</h3>

      <p>
        Fantastic we have a R 300/month package just for you.
      </p>

      <p>
        We will supply you with a SIM.  Don't worry you will keep your existing cell number.   Double your
        data etc.
      </p>

      <p>
        The package provides you with:

        <ul>
          <li>2GiB of data</li>
          <li>300 Telkom to Telkom minutes</li>
          <li>10GiB of Telkom Wifi Data</li>
          <li>100 SMS Message</li>
          <li>500Mb Free Whatapp Data</li>
        </ul>
      </p>
    </div>

    <div id="four">
      <h3 class="page-header">FREEDOM CONNECT EIGHT HUNDRED</h3>

      <p>
        Fantastic we have a R 400/month package just for you.
      </p>

      <p>
        We will supply you with a SIM.  Don't worry you will keep your existing cell number.   Double your
        data etc.
      </p>

      <p>
        The package provides you with:

        <ul>
          <li>1GiB of data</li>
          <li>300 Telkom to Telkom minutes (with a bonus of double the airtime which expires after 7 days)</li>
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
      There is too much value.
    </p>

    <p>
      We have a registration fee of R 200 it's a once off fee and you get your freedom connect combo within the next 48 hours after your first payment
      is received by IMOGO.  The greate part is that you can split the registration and the package fee.
    </p>

    <p>
      Do you want to pay the R 200 registration fee and then on the first of the month you can pay your package fee?
    </p>

    <p>
      Upon reciept of the registration fee, we will courier your Telkom Simsonke Simcard to you.  You will need to have proof of identity and proof of
      address when RAM comes to deliver your sim card.
    </p>

    <p>
      {if $user->gender == 'm'}Mr{else}Ms{/if} {$user->last_name|escape} isnt't this a great deal?
    </p>

    <p>
      Can I sign you up {if $user->gender == 'm'}Mr{else}Ms{/if} {$user->last_name|escape}?
    </p>

    <p>
      And would you like to pay by credit card, debit order, you can even pay via your IMOGO wallet!
    <p>

    <p>
      Is your estate worth more than R 250k?

      <select name="estate_worth_less_250k">
        <option value="no">No</option>
        <option value="yes">Yes</option>
      </select>
    </p>

    <p>
      We are going to give you special airtime.  For just R 200.
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
      May I go ahead and get your details for your activation of your Freedom Connect package?
    </p>

    <p>
      Please confirm your ID number {$user->last_name|escape} (expect {$user->id_document_number|escape}).
    </p>

{if empty($user->email_address)}
    <p>
      Could you tell me what your email address is so that I can issue you with R10.00 BongoTel credit.
    </p>

    <p>
      <input type="text" name="email_address" placeholder="Email Address" value="" id="email-address">
    </p>
{/if}

    <p>
      <button type="button" class="btn btn-info" id="bongotel-issue-dialler">Issue BongoTel Dialler</button>
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

    </div>
    <div id="debitorder">
      <h2 class="page-header">Debit Order</h2>

      <p>
<form class="form-horizontal">
  <div class="form-group">
    <label for="inputBank" class="col-sm-2 control-label">Bank</label>
    <div class="col-sm-10">
      <select name="bank_id" class="form-control" id="inputBankId">
{foreach $banks item=bank}
        <option value="{$bank->id}">{$bank->bank_name}</option>
{/foreach}
      </select>
    </div>
  </div>
  <div class="form-group">
    <label for="inputAccountNumber" class="col-sm-2 control-label">Account Number</label>
    <div class="col-sm-10">
      <input type="email" class="form-control" id="inputAccount Number" placeholder="Account Number">
    </div>
  </div>
  <div class="form-group">
    <label for="inputBranchCode" class="col-sm-2 control-label">Branch Code</label>
    <div class="col-sm-10">
      <input type="text" class="form-control" id="inputBranchCode" placeholder="Branch Code">
    </div>
  </div>
  <div class="form-group">
    <label for="inputAccountType" class="col-sm-2 control-label">Account Type</label>
    <div class="col-sm-10">
      <select name="account_type" class="form-control" id="inputAccountType">
        <option value="1">Current</option>
        <option value="2">Savings</option>
      </select>
    </div>
  </div>
  <div class="form-group">
    <div class="col-sm-offset-2 col-sm-10">
      <button id="paymethod-debitorder" type="submit" class="btn btn-default">Store Banking Details</button>
    </div>
  </div>
</form>
      </p>
      <form>
      </form>
    </div>
    <div id="creditcard">
      <h2 class="page-header">Credit Card Payment</h2>

      <button class="btn btn-primary"><i class="fa fa-fw fa-send"></i> Send Card Link</button>
    </div>

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

    $.ajax({
      type: "POST",
      url: "/admin/outboundsales/calls/{/literal}{$call->uuid}{literal}/paymentmethod",
      data: {"payment_method":selected,"{/literal}{$csrf_key}{literal}":"{/literal}{$csrf_token}{literal}"},
      success: function( returnedData ) {
        $( '#paymentmethod' ).html( '<p>Payment Method updated on Call Record.</p>' );
      }
    });
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

$('#issue-bongotel-dialler').click(function() {
   $.ajax({
    type: "POST",
    url: "/admin/outboundsales/calls/{/literal}{$call->uuid}{literal}/diallers/issue",
    data: {"call_status":"answered","{/literal}{$csrf_key}{literal}":"{/literal}{$csrf_token}{literal}"},
    success: function( returnedData ) {
      $( '#bongotel' ).html( '<p>BongoTel dialler issued to the user.  SMS should arrive shortly.</p>' );
    }
  });
});

$('#email-card-link').click(function() {
   $.ajax({
    type: "POST",
    url: "/admin/outboundsales/calls/{/literal}{$call->uuid}{literal}/email/cardlink",
    data: {"call_status":"answered","{/literal}{$csrf_key}{literal}":"{/literal}{$csrf_token}{literal}"},
    success: function( returnedData ) {
      $( '#email-card-link' ).html( '<p>Email sent to user with the credit card tokenisation link.</p>' );
    }
  });
});
{/literal}
    </script>
    <script src="/vendor/bootstrap-datepicker/dist/js/bootstrap-datepicker.js"></script>
  </body>
</html>
