$(document).ready(function() {
	$('form#new_transaction')
		.bind('ajax:beforeSend', function(evt, xhr, settings) {
			var $submitButton = $(this).find('input[name="commit"]');
			$submitButton.button('toggle');
		})
		.bind('ajax:error', function(evt, xhr, status, error) {
  		var $form = $(this),
				errors,
				errorText,
				alert;
				
    	try {
    		errors = $.parseJSON(xhr.responseText);
    	} catch(err) {
      	errors = {message: "Please reload the page and try again"};
    	}

    	errorText = "There were errors with the submission: \n<ul>";
    	for ( error in errors ) {
      	errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
    	}
    	errorText += "</ul>";
			
			alert = '<div class="alert alert-danger">';
			alert += '<a class="close" data-dismiss="alert" href="#">&times;</a>' + errorText + '</div>';
    	$form.find('div.modal-body').prepend(alert);
		})
		.bind('ajax:complete', function(evt, xhr, status) {
			var $submitButton = $(this).find('input[name="commit"]');
			$submitButton.button('toggle');
		});
});