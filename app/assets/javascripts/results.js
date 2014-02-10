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
  		$('.compared-to').addClass('grey-bg');
		} else {
			$('.group2-filter').addClass('hidden');
			$('.group1-label').addClass('hidden');
			$('.group2-label').addClass('hidden');
			$('.compared-to').removeClass('grey-bg');
		}
	});
	

	if ($("#results").length) {
		$('#chart-container').highcharts({
			chart: {
				type: 'column'
			},
			title: {
				text: 'Speed'
			},
			xAxis: {
				categories: ['Solid Black', 'Hollow Black', 'Solid White', 'Hollow White'],
				title: {
					text: "Style/Color Combinations"
				}
			},
			yAxis: {
				type: "integer",
				title: {
					text: "Time"
				}
			},
			series: [{
				name: 'Group 1',
				data: [1, 0, 4, 5]
			}, {
				name: 'Group 2',
				data: [5, 7, 3, 5]
			}],
			colors: [
			   '#00bcdf',
			   '#ed145b'
			],
			credits: {
				enabled: false
			}
		});
	}


});