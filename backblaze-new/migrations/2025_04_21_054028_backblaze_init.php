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
            $table->boolean('fda_permissions_issue')->nullable();
            $table->string('bzversion')->nullable();
            $table->string('bzlogin')->nullable();
            $table->string('bzlicense')->nullable();
            $table->string('bzlicense_status')->nullable();
            $table->boolean('safety_frozen')->nullable();
            $table->string('lastbackupcompleted')->nullable();
            $table->integer('remainingnumfilesforbackup')->nullable();
            $table->bigInteger('remainingnumbytesforbackup')->nullable();
            $table->integer('totnumfilesforbackup')->nullable();
            $table->bigInteger('totnumbytesforbackup')->nullable();
            $table->boolean('encrypted')->nullable();
            $table->string('online_hostname')->nullable();
            $table->string('bztempfile_size')->nullable();

            $table->unique('serial_number');
            $table->index('fda_permissions_issue');
            $table->index('bzversion');
            $table->index('bzlogin');
            $table->index('bzlicense');
            $table->index('bzlicense_status');
            $table->index('safety_frozen');
            $table->index('lastbackupcompleted');
            $table->index('bztempfile_size');

        });
    }
    
    public function down()
    {
        $capsule = new Capsule();
        $capsule::schema()->dropIfExists('backblaze');
    }
}
