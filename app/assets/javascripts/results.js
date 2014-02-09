$(document).ready(function() {
  
  console.log("results.js working");

	//Expand and Contract Group 1 Filters
	$('.group1-input').click(function() {
		console.log("clicked");
		if ($('.all-people').is(':checked')){
      $('.group1-filter').removeClass('hidden');
      $('span.elipses').addClass('hidden');
    }
    else {
			$('.group1-filter').addClass('hidden');
			$('span.elipses').removeClass('hidden');
    }
  });

	//Expand and Contract Group 2 Filters
	$('.compared-to').mouseup(function() {
  	if ($('.group2-filter').hasClass('hidden')) {
  		$('.group1-label').removeClass('hidden');
  		$('.group2-filter').removeClass('hidden');
  		$('.group2-label').removeClass('hidden');
		} else {
			$('.group2-filter').addClass('hidden');
			$('.group1-label').addClass('hidden');
			$('.group2-label').addClass('hidden');
		}
	});

});