{include file="../admin__header.tpl" title="Outbound Sales &mdash; Campaigns &mdash; Leads" nav="salestools"}

<h2 class="page-header">Campaigns Leads &mdash; {$campaign->name|escape}</h2>

<p>
  <a href="/admin/outboundsales/campaigns">Return to Campaigns list</a>.
</p>

<table class="table table-bordered table-stripped">
  <thead>
    <tr>
      <th>First Name</th>
      <th>Surname</th>
      <th>ID Number</th>
      <th>Mobile Number</th>
      <th>FICA Status</th>
      <th>Links</th>
    </tr>
  </thead>
  <tbody>
{foreach $leads item=row}
{assign var=user value=$row->user()->first()}
    <tr>
      <td>{$user->first_name|escape}</td>
      <td>{$user->last_name|escape}</td>
      <td>{$user->id_document_number|escape}</td>
      <td>{$user->mobile_number|escape}</td>
      <td class="{if $user->fica_status == 0}danger{elseif $user->fica_status == 1}warning{elseif $user->fica_status == 2}success{/if}">{$user->fica_status}</td>
      <td>
        <a href="/admin/customers/{$user->id}"><i class="fa fa-user fa-fw"></i> View Customer</a>
      </td>
    </tr>
{foreachelse}
    <tr>
      <td colspan="10">You presently have no leads associated with this campaign.</td>
    </tr>
{/foreach}
  </tbody>
  <tfoot>
    <tr>
      <th>First Name</th>
      <th>Surname</th>
      <th>ID Number</th>
      <th>Mobile Number</th>
      <th>FICA Status</th>
      <th>Links</th>
    </tr>
  </tfoot>
</table>
