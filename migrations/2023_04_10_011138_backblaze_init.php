<?php
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Capsule\Manager as Capsule;

class BackblazeInit extends Migration
{
    public function up()
    {
        $capsule = new Capsule();
        $capsule::schema()->create('backblaze', function (Blueprint $table) {
            $table->increments('id');
            $table->string('serial_number');
            $table->string('bzversion')->nullable();
            $table->string('bzlogin')->nullable();
            $table->string('bzlicense')->nullable();
            $table->string('bzlicense_status')->nullable();
            $table->boolean('safety_frozen')->nullable();
            $table->bigInteger('lastbackupcompleted')->nullable();
            $table->bigInteger('remainingnumfilesforbackup')->nullable();
            $table->bigInteger('remainingnumbytesforbackup')->nullable();
            $table->bigInteger('totnumbytesforbackup')->nullable();
            $table->bigInteger('totnumfilesforbackup')->nullable();
            $table->boolean('encrypted')->nullable();

            $table->unique('serial_number');
            $table->index('bzversion');
            $table->index('bzlogin');
            $table->index('bzlicense');
            $table->index('bzlicense_status');
            $table->index('safety_frozen');
            $table->index('lastbackupcompleted');
            $table->index('remainingnumfilesforbackup');
            $table->index('remainingnumbytesforbackup');
            $table->index('totnumbytesforbackup');
            $table->index('totnumfilesforbackup');
            $table->index('encrypted');
        });
    }
    
    public function down()
    {
        $capsule = new Capsule();
        $capsule::schema()->dropIfExists('backblaze');
    }
}

