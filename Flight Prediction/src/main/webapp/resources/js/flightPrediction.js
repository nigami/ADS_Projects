$( document ).ready(function(){
	console.log("READY");
	
	var $radios = $('input:radio[name=trip]');
    if($radios.is(':checked') === false) {
        $radios.filter('[value=oneway]').prop('checked', true);
    }
    
	$("#getFlightDetailsBtnId").click(function(){
		$("#displayDiv").slideUp(1000);
		$("#displayDiv #resultRow").html("");
		$.post( "predictprice.htm",$("#formDetailId").serialize(),function(response){displayTheContent(response);});
	}); 
	
	function displayTheContent(response){
		console.log(response);
		var obj = JSON.parse(response);
		console.log(obj);
		var size=obj.Results.output1.value.Values.length;
		console.log("size"+size);
		
		for(var i=0; i<size;i++){
			var price=obj.Results.output1.value.Values[i][9];
			var origin=obj.Results.output1.value.Values[i][6];
			var dest=obj.Results.output1.value.Values[i][7];
			var carrier=obj.Results.output1.value.Values[i][5];
			var startDate=obj.Results.output1.value.Values[i][2]+"/"+obj.Results.output1.value.Values[i][3]+"/"+obj.Results.output1.value.Values[i][0];
			var prevHtml=$("#displayDiv #resultRow").html();
			$("#displayDiv #resultRow").html(prevHtml+"<tr> <td>"+origin+"</td><td>"+dest+"</td><td>"+carrier+"</td><td>"+startDate+"</td><td>"+price+"</td></tr>");
		}
		
		$("#displayDiv").slideDown(1000).css({'display' : 'block'});
		console.log(data1);		
	}
	
	  $("#dt1").datepicker({
	        
	        minDate: 0,
	        required: true,
	        onSelect: function (date) {
	            var date2 = $('#dt1').datepicker('getDate');
	            date2.setDate(date2.getDate() + 1);
	            $('#dt2').datepicker('setDate', date2);
	            //sets minDate to dt1 date + 1
	            $('#dt2').datepicker('option', 'minDate', date2);
	        }
	    });
	    $('#dt2').datepicker({
	       
	        required: true,
	        onClose: function () {
	            var dt1 = $('#dt1').datepicker('getDate');
	            var dt2 = $('#dt2').datepicker('getDate');
	            //check to prevent a user from entering a date below date of dt1
	            if (dt2 <= dt1) {
	                var minDate = $('#dt2').datepicker('option', 'minDate');
	                $('#dt2').datepicker('setDate', minDate);
	            }
	        }
	    });
})
	

	