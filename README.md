MunkiReport Backblaze Module
===================

Gets data about the current Backblaze status.

Installation
----
cd to munkireport/local/modules
git clone https://www.jordaneunson.com/backblaze
cd to munkireport 
./please migrate

Table Schema
----
* fda_permissions_issue - boolean
* bzversion - string 
* bzlogin - string
* bzlicense - string
* bzlicense_status - string
* safety_frozen - boolean
* lastbackupcompleted - string
* remainingnumfilesforbackup - integer
* remainingnumbytesforbackup - bigInteger 
* totnumfilesforbackup - integer 
* totnumbytesforbackup - bigInteger
* encrypted - boolean
* online_hostname - string
* bztempfile_size - string
