$ ->
	$("#test-start").mouseup ->
		$("#pre-test-instructions").addClass("hide");

$ ->
	$("#trial-start").mouseup ->
		$("#target-icon-box").addClass("hide");
		start_time = new Date().getTime();
		console.log("Start time = " + start_time);
		$(".icon").mouseup ->
			end_time = new Date().getTime();
			task_time = end_time-start_time;
			$(".task-time").attr('value', task_time);
			this.parentNode.submit();
			console.log("Task time recorded: " + task_time);