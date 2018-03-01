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
      <th>Campaign</th>
      <th>Customer Name</th>
      <th>Call Status</th>
      <th>Staff Member</th>
      <th>Links</th>
    </tr>
  </thead>
  <tbody>
{foreach $data.data.resultset item=row}
{assign var="campaign" value=$row->outbound_campaign()->first()}
{assign var="user" value=$row->user()->first()}
    <tr{if !$row->active} class="danger"{/if}>
      <td>{$row->id}</td>
      <td>{$campaign->name|escape}</td>
      <td>{$user->first_name|escape} {$user->last_name|escape}</td>
      <td>{$row->call_status|escape}</td>
      <td>{$row->staff_id|staff_name|escape}</td>
      <td>{$row->created_at|datetz}</td>
      <td>{$row->active}</td>
      <td>
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
      <th>Campaign</th>
      <th>Customer Name</th>
      <th>Call Status</th>
      <th>Staff Member</th>
      <th>Links</th>
  </tfoot>
</table>

{include file="../_partials/pagination.tpl" pages=$data.data.pages page=$data.data.page count=$data.data.count}
{include file="../admin__footer.tpl"}
