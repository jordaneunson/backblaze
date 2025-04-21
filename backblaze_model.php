<?php

use munkireport\models\MRModel as Eloquent;

class Backblaze_model extends Eloquent
{
    protected $table = 'backblaze';

    protected $hidden = ['id', 'serial_number'];

    protected $fillable = [
      'serial_number',
      'bzversion',
      'bzlogin',
      'bzlicense',
      'bzlicense_status',
      'safety_frozen',
      'lastbackupcompleted',
      'remainingnumfilesforbackup',
      'remainingnumbytesforbackup',
      'totnumbytesforbackup',
      'totnumfilesforbackup',
      'encrypted',
      'online_hostname',
      'bztempfile_size',
      'fda_permissions_issue',
    ];
}
