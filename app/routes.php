<?php
/**
 * Plutus Outbound Sales Modules
 *
 * @author    Jacques Marneweck <jacques@powertrip.co.za>
 * @copyright 2018 Jacques Marneweck.  All rights strictly reserved.
 * @package   OutboundSales
 */

use Plutus\Models\Account;
use Plutus\Models\User;

/**
 * Frameset
 */
$app->get('/admin/outboundsales', $authenticate($app), $is_admin($app), function () use ($app)
    {
        /**
         * We want to not select any of Sybille's userbase here.  Just IMOGO users.
         */
        $user = User::whereNull('source_id')
            ->inRandomOrder()
            ->firstOrFail();

        $app->template->bulkAssign([
            'user' => $user,
        ]);
        $app->template->display('outboundsales/index.tpl');
    }
);

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
