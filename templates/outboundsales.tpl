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
  <h2>Campaigns</h2>
</div>

<table class="table table-striped table-bordered">
  <thead>
    <tr>
      <th>#</th>
      <th>Campaign Name</th>
      <th>Links</th>
    </tr>
  </thead>
  <tbody>
{foreach $campaigns item=row}
    <tr{if !$row->active} class="danger"{/if}>
      <td>{$row->id}</td>
      <td>{$row->name|escape}</td>
      <td>
        <a href="/admin/outboundsales/{$row->id}">Start Dialling</a>
      </td>
    </tr>
{foreachelse}
    <tr>
      <td colspan="3">You presently do not have any campaigns defined.  <a href="/admin/outboundsales/campaigns/new">Create a new Campaign</a>.
    </tr>
{/foreach}
  </tbody>
  <tfoot>
      <th>#</th>
      <th>Campaign Name</th>
      <th>Links</th>
  </tfoot>
</table>

{include file="../admin__footer.tpl"}
