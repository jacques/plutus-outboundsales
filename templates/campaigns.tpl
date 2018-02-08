{*
 * Outbound Sales
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Copyright 2018 Jacques Marneweck.  All rights strictly reserved.
 *}
{include file="../admin__header.tpl" title="Outbound Sales &mdash; Campaigns" nav="home"}

<h2 class="page-header">Campaigns</h2>

<table class="table table-striped table-bordered table-condensed">
  <thead>
    <tr>
      <th>#</th>
      <th>Campaign Name</th>
      <th>Created At</th>
      <th>Created By</th>
      <th>Active</th>
    </tr>
  </thead>
  <tbody>
{foreach $data.data.resultset item=row}
    <tr{if !$row->active} class="danger"{/if}>
      <td>{$row->id}</td>
      <td>{$row->name|escape}</td>
      <td>{$row->created_at|datetz}</td>
      <td>{$row->created_by}</td>
      <td>{$row->active}</td>
    </tr>
{foreachelse}
    <tr>
      <td colspan="5">You presently do not have any campaigns defined.  <a href="/admin/outboundsales/campaigns/new">Create a new Campaign</a>.
    </tr>
{/foreach}
  </tbody>
  <tfoot>
      <th>#</th>
      <th>Campaign Name</th>
      <th>Created At</th>
      <th>Created By</th>
      <th>Active</th>
  </tfoot>
</table>

{include file="../_partials/pagination.tpl" pages=$data.data.pages page=$data.data.page count=$data.data.count}
{include file="../admin__footer.tpl"}
