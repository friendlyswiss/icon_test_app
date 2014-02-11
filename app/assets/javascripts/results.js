$(document).ready(function() {
	
	if ($('#results').length){

		$.getJSON(
			"/sessions",
			// data: {},
			function(data) {
			console.log(data)
		});

	  console.log("results.js working");
		
		var cats = ["Solid Black","Hollow Black","Solid White","Hollow White"];

		var group1_series = {name: 'Group 1', data: [5, 8, 8, 2]};
		
		var group2_series = {name: 'Group 2', data: [5, 7, 3, 5]};
		
		if ($('.group2-filter').hasClass('hidden')) {
			var series_visible = [group1_series];
		} else {
			var series_visible = [group1_series, group2_series];
		};	

		$(function() {
			chart = $('#chart-container').highcharts({
				chart: {
					type: 'column',
					renderTo: 'chart-container',
					style: {
						fontFamily: '"Helvetica Neue", Helvetica, Arial, sans-serif'
					}
				},
				title: {
					text: 'Speed'
				},
				xAxis: {
					categories: cats,
					title: {
						text: "Style/Color Combinations"
					}
				},
				yAxis: {
					type: "linear",
					title: {
						text: "Time"
					}
				},
				series: series_visible,
				colors: [
				   '#00bcdf',
				   '#ed145b'
				],
				credits: {
					enabled: false
				}
			});
		});

		//Redraw chart when dropdowns are clicked
		$("select").on('change', (function(e) {
			
			console.log('option clicked');
			console.log('sending GET to sessions')

			$.getJSON(
				"/sessions",
				// data: {},
				function(data) {
				console.log(data)
			});
		}));
		

		//Expand and Contract Group 1 Filters
		$('.group1-input').click(function() {
			console.log("radio clicked");
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
				chart.addSeries(group2_series);
			} else {
				$('.group2-filter').addClass('hidden');
				$('.group1-label').addClass('hidden');
				$('.group2-label').addClass('hidden');
				$('.compared-to').removeClass('grey-bg');
				chart.series[1].remove();
			}
		});
	}	
});