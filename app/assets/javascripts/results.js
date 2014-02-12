$(document).ready(function() {
	
	if ($('#results').length){
		
		var group1_is = 'me';
		var no_groups = '1';

		//Get default data to create chart
		$.getJSON(
			"/sessions",
			{
				no_groups: 1,
				group1_is: 'me',
				speed_accuracy_select: ($('.speed_accuracy-select').val()),
				style_multiselect: ($('.style-multiselect').val()),
				color_multiselect: ($('.color-multiselect').val())
			},
			function(chart_options) {
			$(function() {
				$('#chart-container').highcharts(chart_options);
			});
		});


		//Redraw chart when dropdowns are clicked
		$("select").on('change', (function(e) {
			$.getJSON(
				"/sessions",
				{
					no_groups: no_groups,
					group1_is: group1_is,
					speed_accuracy_select: ($('.speed_accuracy-select').val()),
					style_multiselect: ($('.style-multiselect').val()),
					color_multiselect: ($('.color-multiselect').val())
				},
				function(chart_options) {
				$('#chart-container').highcharts(chart_options);
			});
		}));
		

		//Expand and Contract Group 1 Filters
		$('.group1-input').click(function() {
			if ($('.all-people').is(':checked')){
				group1_is = 'all_people';
	      $('.group1-filter').removeClass('hidden');
	      $('span.elipses').addClass('hidden');
	    }
	    else {
	    	group1_is = 'me';
				$('.group1-filter').addClass('hidden');
				$('span.elipses').removeClass('hidden');
	    }
	  });


		//Expand and Contract Group 2 Filters
		$('.compared-to').click(function() {
	  	if ($('.group2-filter').hasClass('hidden')) {
	  		no_groups = 2;
	  		$('.group1-label, .group2-filter, .group2-label').removeClass('hidden');
	  		$('.compared-to').addClass('grey-bg');
				$.getJSON(
					"/sessions",
					{
						no_groups: 2,
						group1_is: group1_is,
						speed_accuracy_select: ($('.speed_accuracy-select').val()),
						style_multiselect: ($('.style-multiselect').val()),
						color_multiselect: ($('.color-multiselect').val())
					},
					function(chart_options) {
					$('#chart-container').highcharts(chart_options);
				});
			} else {
				no_groups = 1;
				$('.group1-label, .group2-filter, .group2-label').addClass('hidden');
				$('.compared-to').removeClass('grey-bg');
				$.getJSON(
					"/sessions",
					{
						no_groups: 1,
						group1_is: group1_is,
						speed_accuracy_select: ($('.speed_accuracy-select').val()),
						style_multiselect: ($('.style-multiselect').val()),
						color_multiselect: ($('.color-multiselect').val())
					},
					function(chart_options) {
					$('#chart-container').highcharts(chart_options);
				});
			}
		});
	}	
});