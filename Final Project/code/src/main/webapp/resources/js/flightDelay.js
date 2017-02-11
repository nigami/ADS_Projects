$( document ).ready(function(){
	console.log("READY");
	
	var $radios = $('input:radio[name=trip]');
    if($radios.is(':checked') === false) {
        $radios.filter('[value=no]').prop('checked', true);
    }    

     $("#roundRadioId").click(function(){
    	//alert("visible");
        $("#delayedTime").css("visibility","visible");
    });
        
    $("#onewayRadioId").click(function(){
    	//alert("not visible ");
    	$("#delayedTime").val("0");
        $("#delayedTime").css("visibility", "hidden");
    });
    
    $("#getFlightDetailsBtnId").click(function(){
		$("#displayDiv #resultRow").html("");
		$("#displayDiv").slideUp(1000);
		$.post("predictDelay.htm",$("#formDetailId").serialize(),function(response){displayTheContent(response);});
	}); 
	
	function displayTheContent(response){
		console.log(response);
		var obj = JSON.parse(response);
		console.log(obj);
		var size=obj.Results.output1.value.Values.length;
		console.log("size"+size);
		
		$("#displayDiv #resultHead").html("<tr><th>Origin</th> <th>Destination</th><th>Carrier</th><th>Flight Number</th><th>Departure date</th><th>Delay Departure in mins</th><th>Estimated Arrival Delay</th></tr>");
		
		for(var i=0; i<size;i++){
				var arrivalDelayResult=Number(obj.Results.output1.value.Values[i][12]).toFixed(2);
				var origin=obj.Results.output1.value.Values[i][7];
				var dest=obj.Results.output1.value.Values[i][8];
				var carrier=obj.Results.output1.value.Values[i][5];
				var depDelayInMins=obj.Results.output1.value.Values[i][9];
				var flightNum=obj.Results.output1.value.Values[i][6];
				var startDate=obj.Results.output1.value.Values[i][2]+"/"+obj.Results.output1.value.Values[i][3]+"/"+obj.Results.output1.value.Values[i][0];
				var prevHtml=$("#displayDiv #resultRow").html();
				$("#displayDiv #resultRow").html(prevHtml+"<tr> <td>"+origin+"</td><td>"+dest+"</td><td>"+carrier+"</td><td>"+flightNum+"</td><td>"+startDate+"</td><td>"+depDelayInMins+"</td><td>"+((arrivalDelayResult<2)?("On Time"):(arrivalDelayResult+" mins"))+" </td></tr>");
		
			}
		$("#displayDiv").slideDown(1000).css({'display' : 'block'});
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
})
	

	