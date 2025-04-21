<?php

// Database seeder
// Please visit https://github.com/fzaninotto/Faker for more options

/** @var \Illuminate\Database\Eloquent\Factory $factory */
$factory->define(Backblaze_model::class, function (Faker\Generator $faker) {

    return [
        'fda_permissions_issue' => $faker->boolean(),
        'bzversion' => $faker->word(),
        'bzlogin' => $faker->word(),
        'bzlicense' => $faker->word(),
        'bzlicense_status' => $faker->word(),
        'safety_frozen' => $faker->boolean(),
        'lastbackupcompleted' => $faker->word(),
        'remainingnumfilesforbackup' => $faker->randomNumber($nbDigits = 4, $strict = false),
        'remainingnumbytesforbackup' => $faker->randomNumber($nbDigits = 8, $strict = false),
        'totnumfilesforbackup' => $faker->randomNumber($nbDigits = 4, $strict = false),
        'totnumbytesforbackup' => $faker->randomNumber($nbDigits = 8, $strict = false),
        'encrypted' => $faker->boolean(),
        'online_hostname' => $faker->word(),
        'bztempfile_size' => $faker->word(),
    ];
});
