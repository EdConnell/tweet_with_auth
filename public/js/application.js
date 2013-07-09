$(document).ready(function() {

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
				success: function() {
					$('body').animate({backgroundColor: '#66DD33'}, 'slow');
					$('textarea').val("");
				},
				error: function() {
					$('body').animate({backgroundColor: '#CC0022'}, 'slow');
				},
				complete: function() {
					setTimeout( function(){
						$('body').animate({backgroundColor: '#8EC1DA'}, 'slow');
					},2000);
				}
			});
		}
	});
});
