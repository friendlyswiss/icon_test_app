$ ->
	$("#test-start").mouseup ->
		$(".top").addClass("hide");

$ ->
	$("#trial-start").mouseup ->
		$(".middle").addClass("hide");
		start_time = new Date().getTime();
		$(".icon").mouseup ->
			end_time = new Date().getTime();
			task_time = end_time-start_time;
			$(".task-time").attr('value', task_time);
			this.parentNode.submit();