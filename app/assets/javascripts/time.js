jQuery(document).ready(function($){
	var now = moment();

  $('time').each(function(i, e) {
  	var datetime = $(e).attr('datetime');
    var time = moment(datetime);

    $(e).html('<span title="' + datetime + '">' + time.from(now) + '</span>');
  });
});