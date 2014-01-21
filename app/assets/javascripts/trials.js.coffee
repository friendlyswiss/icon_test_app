$ ->
	$("#test-start").mouseup ->
		$("#pre-test-instructions").addClass("hide");

$ ->
	$("#trial-start").mouseup ->
		$("#target-icon-box").addClass("hide");
		start_time = new Date().getTime();

$ ->
	$(".icon").mouseup ->
		end_time = new Date().getTime();
		duration = end - start;