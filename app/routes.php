<?php
/**
 * Plutus Outbound Sales Modules
 *
 * @author    Jacques Marneweck <jacques@powertrip.co.za>
 * @copyright 2018 Jacques Marneweck.  All rights strictly reserved.
 * @package   OutboundSales
 */

use Leopardrock\Pagination;
use Plutus\Models\Account;
use Plutus\Models\AgencyUser;
use Plutus\Models\OutboundCampaign;
use Plutus\Models\OutboundCampaignLead;
use Plutus\Models\OutboundSale;
use Plutus\Models\User;

/**
 * Sales Script Page
 */
$app->get('/admin/outboundsales', $authenticate($app), $is_admin($app), function () use ($app)
    {
        $campaigns = OutboundCampaign::where('active', 1)
            ->get();

        $app->template->bulkAssign([
            'campaigns' => $campaigns,
        ]);
        $app->template->display('outboundsales/outboundsales.tpl');
    }
);

$app->get('/admin/outboundsales/:id', $authenticate($app), $is_admin($app), function ($id) use ($app)
    {
        $campaign = OutboundCampaign::findOrFail($id);
        $user = $campaign->outbound_campaign_leads()->inRandomOrder()->first()->user()->first();

        $app->template->bulkAssign([
            'campaign' => $campaign,
            'user' => $user,
        ]);
        $app->template->display('outboundsales/index.tpl');
    }
)->conditions(['id' => '\d+']);

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
