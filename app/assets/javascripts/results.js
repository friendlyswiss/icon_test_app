$(document).ready(function() {
	
	if ($('#results').length){
		
		var axisImages = function() { 
			$('.solid-black').after('<img class="axis-image" src="/assets/eye-icon-solid-white_bg.png" />')
			$('.hollow-black').after('<img class="axis-image" src="/assets/eye-icon-hollow-white_bg.png" />')
			$('.solid-white').after('<img class="axis-image" src="/assets/eye-icon-solid-black_bg.png" />')
			$('.hollow-white').after('<img class="axis-image" src="/assets/eye-icon-hollow-black_bg.png" />')
			$('.solid').after('<img class="axis-image double" src="/assets/eye-icon-solid.png" />')
			$('.hollow').after('<img class="axis-image double" src="/assets/eye-icon-hollow.png" />')
			$('.black').after('<img class="axis-image double" src="/assets/eye-icon-white_bg.png" />')
			$('.white').after('<img class="axis-image double" src="/assets/eye-icon-black_bg.png" />')
		};
		var group1_is = 'me';
		var no_groups = '1';
		var sid = $('#results').attr("class");

		//Get default data to create chart
		$.getJSON(
			"/sessions",
			{
				sid: sid,
				no_groups: 1,
				group1_is: 'me',
				speed_accuracy_select:
					($('.speed_accuracy_select').val()),
				style_select:
					($('.style_select').val()),
				color_select:
					($('.color_select').val())
			},
			function(chart_options) {
			$(function() {
				$('#chart-container').highcharts(chart_options);
				console.log(chart_options);
				axisImages();
			});
		});

		//Pluralize text for both and either
		$('.style_select, .color_select').on('change', (function() {
			
			if ($('.style_select').val() == 'either') {
				$('span.style-text').replaceWith('<span class="style-text">style</span>')
			}	else if ($('.style_select').val() == 'both'){
				$('span.style-text').replaceWith('<span class="style-text">styles</span>')
			}

			if ($('.color_select').val() == 'either') {

				$('span.color-text').replaceWith('<span class="color-text">color</span>')
			} else if ($('.style_select').val() == 'both'){
				$('span.color-text').replaceWith('<span class="color-text">colors</span>')
			}

	  }));

		//Redraw chart when dropdowns are clicked
		$("select").on('change', (function(e) {
			$.getJSON(
				"/sessions",
				{
					sid: sid,
					no_groups: no_groups,
					group1_is: group1_is,
					speed_accuracy_select: ($('.speed_accuracy_select').val()),
					style_select: ($('.style_select').val()),
					color_select: ($('.color_select').val()),
					group1_age_multiselect:
						($('.group1-age-multiselect').val()),
					group1_test_browser_multiselect:
						($('.group1-test-browser-multiselect').val()),
					group1_test_os_multiselect:
						($('.group1-test-os-multiselect').val()),
					group1_primary_os_multiselect:
						($('.group1-primary-os-multiselect').val()),
					group1_primary_mobile_multiselect:
						($('.group1-primary-mobile-multiselect').val()),
					group2_age_multiselect:
						($('.group2-age-multiselect').val()),
					group2_test_browser_multiselect:
						($('.group2-test-browser-multiselect').val()),
					group2_test_os_multiselect:
						($('.group2-test-os-multiselect').val()),
					group2_primary_os_multiselect:
						($('.group2-primary-os-multiselect').val()),
					group2_primary_mobile_multiselect:
						($('.group2-primary-mobile-multiselect').val())
				},
				function(chart_options) {
				$('#chart-container').highcharts(chart_options);
				axisImages();
			});
		}));
		

		//Expand and Contract Group 1 Filters
		$('.group1-input').click(function() {
			if ($('.all-people').is(':checked')){
				group1_is = 'all_people';
	      $('.group1-filter').removeClass('hidden');
	      $('span.elipses').addClass('hidden');
	      $.getJSON(
					"/sessions",
					{
						sid: sid,
						no_groups: no_groups,
						group1_is: group1_is,
						speed_accuracy_select: ($('.speed_accuracy_select').val()),
						style_select: ($('.style_select').val()),
						color_select: ($('.color_select').val()),
						group1_age_multiselect:
							($('.group1-age-multiselect').val()),
						group1_test_browser_multiselect:
							($('.group1-test-browser-multiselect').val()),
						group1_test_os_multiselect:
							($('.group1-test-os-multiselect').val()),
						group1_primary_os_multiselect:
							($('.group1-primary-os-multiselect').val()),
						group1_primary_mobile_multiselect:
							($('.group1-primary-mobile-multiselect').val()),
						group2_age_multiselect:
							($('.group2-age-multiselect').val()),
						group2_test_browser_multiselect:
							($('.group2-test-browser-multiselect').val()),
						group2_test_os_multiselect:
							($('.group2-test-os-multiselect').val()),
						group2_primary_os_multiselect:
							($('.group2-primary-os-multiselect').val()),
						group2_primary_mobile_multiselect:
							($('.group2-primary-mobile-multiselect').val())
					},
					function(chart_options) {
					$('#chart-container').highcharts(chart_options);
					axisImages();
				});
	    }
	    else {
	    	group1_is = 'me';
				$('.group1-filter').addClass('hidden');
				$('span.elipses').removeClass('hidden');
				$.getJSON(
					"/sessions",
					{
						sid: sid,
						no_groups: no_groups,
						group1_is: group1_is,
						speed_accuracy_select: ($('.speed_accuracy_select').val()),
						style_select: ($('.style_select').val()),
						color_select: ($('.color_select').val()),
						group1_age_multiselect:
							($('.group1-age-multiselect').val()),
						group1_test_browser_multiselect:
							($('.group1-test-browser-multiselect').val()),
						group1_test_os_multiselect:
							($('.group1-test-os-multiselect').val()),
						group1_primary_os_multiselect:
							($('.group1-primary-os-multiselect').val()),
						group1_primary_mobile_multiselect:
							($('.group1-primary-mobile-multiselect').val()),
						group2_age_multiselect:
							($('.group2-age-multiselect').val()),
						group2_test_browser_multiselect:
							($('.group2-test-browser-multiselect').val()),
						group2_test_os_multiselect:
							($('.group2-test-os-multiselect').val()),
						group2_primary_os_multiselect:
							($('.group2-primary-os-multiselect').val()),
						group2_primary_mobile_multiselect:
							($('.group2-primary-mobile-multiselect').val())
					},
					function(chart_options) {
					$('#chart-container').highcharts(chart_options);
					axisImages();
				});
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
						sid: sid,
						no_groups: 2,
						group1_is: group1_is,
						speed_accuracy_select: ($('.speed_accuracy_select').val()),
						style_select: ($('.style_select').val()),
						color_select: ($('.color_select').val()),
						group1_age_multiselect:
							($('.group1-age-multiselect').val()),
						group1_test_browser_multiselect:
							($('.group1-test-browser-multiselect').val()),
						group1_test_os_multiselect:
							($('.group1-test-os-multiselect').val()),
						group1_primary_os_multiselect:
							($('.group1-primary-os-multiselect').val()),
						group1_primary_mobile_multiselect:
							($('.group1-primary-mobile-multiselect').val()),
						group2_age_multiselect:
							($('.group2-age-multiselect').val()),
						group2_test_browser_multiselect:
							($('.group2-test-browser-multiselect').val()),
						group2_test_os_multiselect:
							($('.group2-test-os-multiselect').val()),
						group2_primary_os_multiselect:
							($('.group2-primary-os-multiselect').val()),
						group2_primary_mobile_multiselect:
							($('.group2-primary-mobile-multiselect').val())
					},
					function(chart_options) {
					$('#chart-container').highcharts(chart_options);
					axisImages();
				});
			} else {
				no_groups = 1;
				$('.group1-label, .group2-filter, .group2-label').addClass('hidden');
				$('.compared-to').removeClass('grey-bg');
				$.getJSON(
					"/sessions",
					{
						sid: sid,
						no_groups: 1,
						group1_is: group1_is,
						speed_accuracy_select: ($('.speed_accuracy_select').val()),
						style_select: ($('.style_select').val()),
						color_select: ($('.color_select').val()),
						group1_age_multiselect:
							($('.group1-age-multiselect').val()),
						group1_test_browser_multiselect:
							($('.group1-test-browser-multiselect').val()),
						group1_test_os_multiselect:
							($('.group1-test-os-multiselect').val()),
						group1_primary_os_multiselect:
							($('.group1-primary-os-multiselect').val()),
						group1_primary_mobile_multiselect:
							($('.group1-primary-mobile-multiselect').val()),
						group2_age_multiselect:
							($('.group2-age-multiselect').val()),
						group2_test_browser_multiselect:
							($('.group2-test-browser-multiselect').val()),
						group2_test_os_multiselect:
							($('.group2-test-os-multiselect').val()),
						group2_primary_os_multiselect:
							($('.group2-primary-os-multiselect').val()),
						group2_primary_mobile_multiselect:
							($('.group2-primary-mobile-multiselect').val())
					},
					function(chart_options) {
					$('#chart-container').highcharts(chart_options);
					axisImages();
				});
			}
		});
		
		

	}	
});