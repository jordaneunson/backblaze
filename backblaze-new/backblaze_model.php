<?php

use munkireport\models\MRModel as Eloquent;

class Backblaze_model extends Eloquent
{
    protected $table = 'backblaze';

    protected $hidden = ['id', 'serial_number'];

    protected $fillable = [
      'serial_number',
      'fda_permissions_issue',
      'bzversion',
      'bzlogin',
      'bzlicense',
      'bzlicense_status',
      'safety_frozen',
      'lastbackupcompleted',
      'remainingnumfilesforbackup',
      'remainingnumbytesforbackup',
      'totnumfilesforbackup',
      'totnumbytesforbackup',
      'encrypted',
      'online_hostname',
      'bztempfile_size',

    ];
}
