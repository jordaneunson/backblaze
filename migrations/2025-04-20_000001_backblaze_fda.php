<?php
 
 use Illuminate\Database\Schema\Blueprint;
 use Illuminate\Database\Migrations\Migration;
 use Illuminate\Database\Capsule\Manager as Capsule;
 
 class BackblazeFDA extends Migration
 {
     private $tableName = 'backblaze';
 
     public function up()
     {
         $capsule = new Capsule();
         
         $capsule::schema()->table($this->tableName, function (Blueprint $table) {
             $table->boolean('fda_permissions_issue')->nullable();
 
             $table->index('fda_permissions_issue');
         });
     }
 
     public function down()
     {
         $capsule = new Capsule();
         $capsule::schema()->table($this->tableName, function (Blueprint $table) {
             $table->dropColumn('fda_permissions_issue');
         });
     }
 }
