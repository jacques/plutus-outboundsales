{*
 * Outbound Sales
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Copyright 2018 Jacques Marneweck.  All rights strictly reserved.
 *}
{include file="../admin__header.tpl" title="Outbound Sales &mdash; Campaigns" nav="salestools"}

<div class="page-header">
  <div class="pull-right">
    <a href="/admin/outboundsales/campaigns/new" class="btn btn-primary"><i class="fa fa-fw fa-plus"></i> Add new Campaign</a>
  </div>
  <h2>Campaigns</h2>
</div>

<table class="table table-stripped table-bordered">
  <thead>
    <tr>
      <th>#</th>
      <th>Campaign Name</th>
      <th>Created At</th>
      <th>Created By</th>
      <th>Active</th>
      <th>Leads</th>
      <th>Links</th>
    </tr>
  </thead>
  <tbody>
{foreach $data.data.resultset item=row}
    <tr{if !$row->active} class="danger"{/if}>
      <td>{$row->id}</td>
      <td>{$row->name|escape}</td>
      <td>{$row->created_at|datetz}</td>
      <td>{$row->created_by|staff_name|escape}</td>
      <td>{$row->active}</td>
      <td>{$row->outbound_campaign_leads()->count()}</td>
      <td>
        <a href="/admin/outboundsales/campaigns/{$row->id}/leads">Leads</a>
        |
        <a href="/admin/outboundsales/campaigns/{$row->id}/sales">Sales</a>
      </td>
    </tr>
{foreachelse}
    <tr>
      <td colspan="6">You presently do not have any campaigns defined.  <a href="/admin/outboundsales/campaigns/new">Create a new Campaign</a>.
    </tr>
{/foreach}
  </tbody>
  <tfoot>
      <th>#</th>
      <th>Campaign Name</th>
      <th>Created At</th>
      <th>Created By</th>
      <th>Active</th>
      <th>Leads</th>
      <th>Links</th>
  </tfoot>
</table>

{include file="../_partials/pagination.tpl" pages=$data.data.pages page=$data.data.page count=$data.data.count}
{include file="../admin__footer.tpl"}
