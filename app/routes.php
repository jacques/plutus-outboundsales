<?php
/**
 * Plutus Outbound Sales Modules
 *
 * @author    Jacques Marneweck <jacques@powertrip.co.za>
 * @copyright 2018 Jacques Marneweck.  All rights strictly reserved.
 * @package   OutboundSales
 */

use Illuminate\Database\Capsule\Manager as DB;
use Leopardrock\Pagination;
use Leopardrock\UUID;
use Plutus\Models\Account;
use Plutus\Models\AgencyUser;
use Plutus\Models\Bank;
use Plutus\Models\OutboundCall;
use Plutus\Models\OutboundCampaign;
use Plutus\Models\OutboundCampaignLead;
use Plutus\Models\OutboundSale;
use Plutus\Models\User;

/**
 * Show the outbound campaigns an agent is allowed to dial.
 */
$app->get('/admin/outboundsales', $authenticate($app), $is_admin($app), function () use ($app)
    {
        /**
         * @TODO Filter on campaigns by agent.
         */
        $campaigns = OutboundCampaign::where('active', 1)
            ->get();

        $app->template->bulkAssign([
            'campaigns' => $campaigns,
        ]);
        $app->template->display('outboundsales/outboundsales.tpl');
    }
);

/**
 * Sales Script Page
 */
$app->get('/admin/outboundsales/:id', $authenticate($app), $is_admin($app), function ($id) use ($app)
    {
        $campaign = OutboundCampaign::findOrFail($id);
        if (!$campaign->active) {
            $app->notFound();
        }
        $uuid = $app->request()->get('uuid');

        if (!is_null($uuid)) {
            try {
                $user = User::where('uuid', $uuid);
                $user->firstOrFail();
            } catch (\Exception $e) {
                $app->notFound();
            }
        } else {
            $user = $campaign->outbound_campaign_leads()->inRandomOrder()->first()->user()->first();
        }

        $call = new OutboundCall;
        $call->uuid = UUID::uuidv4();
        $call->user_id = $user->id;
        $call->outbound_campaign_id = $campaign->id;
        $call->staff_id = $_SESSION['user_id'];
        $call->save();

        $banks = Bank::where('country_id', '177')
            ->whereNotIn('id', [1])
            ->orderBy('bank_name', 'ASC')
            ->get();

        $app->template->bulkAssign([
            'campaign' => $campaign,
            'user' => $user,
            'call' => $call,
            'banks' => $banks,
        ]);
        $app->template->display('outboundsales/index.tpl');
    }
)->conditions(['id' => '\d+']);

$app->post('/admin/outboundsales/calls/:uuid/bankdetails', $authenticate($app), $is_admin($app), function ($uuid) use ($app)
    {
        $post = $app->request()->post();

        error_log("[BANK DETAILS]" . json_encode($post));
        try {
            $call = OutboundCall::where('uuid', $uuid)->firstOrFail();
        } catch (\Exception $e) {
            echo json_encode([
                'status' => 'error',
                'message' => $e->getMessage(),
            ]);
        }
        $call->bank_id = $post['bank_id'];
        $call->account_number = $post['account_number'];
        $call->branch_code = $post['branch_code'];
        $call->account_type = $post['account_type'];
        $call->save();

        echo json_encode([
            'status' => 'ok',
        ]);
    }
);

$app->post('/admin/outboundsales/calls/:uuid/callstatus', $authenticate($app), $is_admin($app), function ($uuid) use ($app)
    {
        $post = $app->request()->post();

        try {
            $call = OutboundCall::where('uuid', $uuid)->firstOrFail();
        } catch (\Exception $e) {
            echo json_encode([
                'status' => 'error',
                'message' => $e->getMessage(),
            ]);
        }
        $call->call_status = $post['call_status'];
        $call->save();

        echo json_encode([
            'status' => 'ok',
        ]);
    }
);

$app->post('/admin/outboundsales/calls/:uuid/paymentmethod', $authenticate($app), $is_admin($app), function ($uuid) use ($app)
    {
        $post = $app->request()->post();

        try {
            $call = OutboundCall::where('uuid', $uuid)->firstOrFail();
        } catch (\Exception $e) {
            echo json_encode([
                'status' => 'error',
                'message' => $e->getMessage(),
            ]);
        }
        $call->payment_method = $post['payment_method'];
        $call->save();

        echo json_encode([
            'status' => 'ok',
        ]);
    }
);

$app->get('/admin/outboundsales/campaigns', $authenticate($app), $is_admin($app), function () use ($app)
    {
        if (
            !is_superadmin() &&
            !is_financeadmin()
        ) {
            $app->notFound();
        }

        $query = OutboundCampaign::orderBy('id', 'DESC');
        $data = Pagination::paginate($app, 0, 50, 1, $query);
        $app->template->bulkAssign([
            'data' => $data,
        ]);
        $app->template->display('outboundsales/campaigns.tpl');
    }
);

$app->get('/admin/outboundsales/campaigns/new', $authenticate($app), $is_admin($app), function () use ($app)
    {
        if (
            !is_superadmin() &&
            !is_financeadmin()
        ) {
            $app->notFound();
        }

        $app->template->display('outboundsales/campaigns__new.tpl');
    }
);

$app->get('/admin/outboundsales/campaigns/:id/leads', $authenticate($app), $is_admin($app), function ($id) use ($app)
    {
        if (
            !is_superadmin() &&
            !is_financeadmin()
        ) {
            $app->notFound();
        }

        $campaign = OutboundCampaign::findOrFail($id);

        $app->template->bulkAssign([
            'campaign' => $campaign,
            'leads' => $campaign->outbound_campaign_leads()->get(),
        ]);
        $app->template->display('outboundsales/campaigns__leads.tpl');
    }
);

$app->get('/admin/outboundsales/campaigns/qa', $authenticate($app), $is_admin($app), function () use ($app)
    {
        if (
            !is_superadmin() &&
            !is_financeadmin()
        ) {
            $app->notFound();
        }

        $query = OutboundSale::orderBy('id', 'DESC');
        $data = Pagination::paginate($app, 0, 50, 1, $query);
        $app->template->bulkAssign([
            'data' => $data,
        ]);
        $app->template->display('outboundsales/campaigns__qa.tpl');
    }
);

/**
 * Issue the dialler to the user.
 */
$app->post('/admin/outboundsales/:uuid/issuedialler', $authenticate($app), $is_admin($app), function ($uuid) use ($app, $config)
    {
        try {
            $user = User::where('uuid', $uuid)
                ->firstOrFail();
        } catch (\Exception $e) {
            $app->notFound();
        }

        if (
            !is_null($user->email_address) &&
            !empty($user->email_address) &&
            !empty(trim($user->email_address))
        ) {
            /**
             * BongoTel:
             *
             * 130 - BongoTEL
             */
            $client = new \Jacques\NWS\TOS\Client(
                [
                    'hostname' => $config['nws']['hostname'],
                    'port'     => $config['nws']['port'],
                ], [
                    'agent_username' => $config['nws']['agent_username'],
                    'agent_password' => $config['nws']['agent_password'],
                    'agent_id'       => $config['nws']['agent_id'],
                ]
            );
            $logger = new Monolog('/home/plutus/web/logs/nws-tos-' . date('Y-m-d') . '.log', 'DEBUG', 'news-tos', $client);
            $password = bin2hex(openssl_random_pseudo_bytes(4));
            $response = $client->addTrialAccount(trim(strtolower($user->email_address)), $password, $user->mobile_number, $user->email_address, $config['nws']['plan_id']);

            $diallerbalance = json_decode($response['body']);
            if (1 == $diallerbalance->Result) {
                $_SESSION['flash']['errors'][] = $json->ResultDescription;

                error_log(
                    sprintf(
                        '[NWS TOS ADD DIALER USER] user_id: %d api response: %d',
                        $user->id,
                        json_encode($response)
                    )
                );
                echo json_encode([
                    'status' => 'error',
                    'message' => $json->ResultDescription,
                ]);
                return;
            }

            $dialler = new UserDialer;
            $dialler->user_id = $user->id;
            $dialler->dialer_supplier_id = 2;
            $dialler->username = $user->email_address;
            $dialler->msisdn = $user->mobile_number;
            $dialler->response = json_encode($response);
            $dialler->save();
            error_log(
                sprintf(
                    '[NWS TOS ADD DIALLER USER] user_id: %d api response: %d',
                    $user->id,
                    json_encode($response)
                )
            );
        }

        echo json_encode([
            'status' => 'ok',
            'message' => 'User has been issued with their BongoTel Dialler account.',
        ]);
    }
);
