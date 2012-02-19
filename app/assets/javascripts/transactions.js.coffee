jQuery ->
	$('#new_transaction #transaction_event').change () ->
		event = this.value;
		if event == "Transfer"
			$("#payee").hide()
			$("#account").show()
		else
			$("#payee").show()
			$("#account").hide()