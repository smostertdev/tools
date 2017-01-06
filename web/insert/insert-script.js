

$(document).delegate('#table', 'keydown', function(e) {
	var keyCode = e.keyCode || e.which;

	if (keyCode == 9) {
		e.preventDefault();
		var start = $(this).get(0).selectionStart;
		var end = $(this).get(0).selectionEnd;

		// set textarea value to: text before caret + tab + text after caret
		$(this).val($(this).val().substring(0, start)
								+ "\t"
								+ $(this).val().substring(end));

		// put caret at right position again
		$(this).get(0).selectionStart =
		$(this).get(0).selectionEnd = start + 1;
	}
});

$( document ).ready(function() {
	$('#view-table').click(function() {
		var t_name = $('#tablename').val();
		var t_data = $('#table').val();

		//alert("tablename: " + t_name + "\ntable: " + t_data);
		if(t_name != "" && t_data != "") {
			$('.table-instructions').first().addClass("hide");
			$('.clusterize').first().removeClass("hide");
		}
		else {
			$('.table-instructions').first().removeClass("hide");
			$('.clusterize').first().addClass("hide");
		}
	});

	function generate() {
		alert("test");
	}

	//JavaScript
	var data = ['<tr><td>abc</td></tr>', '<tr><td>def</td></tr>'];
	var clusterize = new Clusterize({
		rows: data,
		scrollId: 'scrollArea',
		contentId: 'contentArea'
	});


});


