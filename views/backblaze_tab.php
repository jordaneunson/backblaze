<div id="backblaze-tab"></div>
<h2 data-i18n="backblaze.title"></h2>

<table id="backblaze-tab-table"><tbody></tbody></table>

<script>
$(document).on('appReady', function(){
    $.getJSON(appUrl + '/module/backblaze/get_data/' + serialNumber, function(data){
        var table = $('#backblaze-tab-table');
        $.each(data, function(key,val){
            var th = $('<th>').text(i18n.t('backblaze.column.' + key));
            var td = $('<td>').text(val);
            table.append($('<tr>').append(th, td));
        });
    });
});
</script>
