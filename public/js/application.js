$(document).ready(function() {
	var jobStatus = "false";

	var jobChecker = function(jobId) {
		$.post('/job/' + jobId.job, function(response) {
			setJobStatus(response.finished);
		});
	};

	var setJobStatus = function(status) {
		jobStatus = status;
	};

	$('textarea').keydown(function() {
		if (event.keyCode === 13) 
		{
			event.preventDefault();
			var data = $('form').serialize();
			$('body').animate({backgroundColor: '#FFEE22'}, 'slow');

			$.ajax({
				url: '/tweet',
				type: 'post',
				data: data,
				success: function(jId) {

					intervalID = setInterval(function() {
						if (jobStatus === "false") {
							$('h1').html("Tweeting...");
							jobChecker(jId);
						} else {
							$('textarea').val("");
							$('body').animate({backgroundColor: '#66DD33'}, 'slow');
							$('h1').html("Oi Sent").delay(1000);
							clearInterval(intervalID);
						}
					}, 100);		
				},
				error: function() {
					$('body').animate({backgroundColor: '#CC0022'}, 'slow');
				},
				complete: function() {
					setTimeout( function(){
						$('body').animate({backgroundColor: '#8EC1DA'}, 'slow');
						$('h1').html("Tweetr");
					},3000);
				}
			});
		}
	});
});

						// // jobChecker(jId);
						// intervalID = setInterval(
						// 	if (status==="true") {
						// 		clearInterval(intervalID)
						// 		console.log("finished")
						// 	} else {
						// 		jobChecker(jId) 
						// 	}, 1000);
						// console.log(jobStatus);
						// }
