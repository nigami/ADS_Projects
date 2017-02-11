$( document ).ready(function(){
	console.log("READY");
	
	
    
    $("#getFlightDetailsBtnId").click(function(){
		$("#displayDiv #resultRow").html("");
		$("#displayDiv").slideUp(1000);
		$.post("predictCancel.htm",$("#formDetailId").serialize(),function(response){displayTheContent(response);});
	}); 
	
	function displayTheContent(response){
		console.log(response);
		var obj = JSON.parse(response);
		console.log(obj);
		var size=obj.Results.output1.value.Values.length;
		console.log("size"+size);
		
		for(var i=0; i<size;i++){
				var arrivalCancelResult=Number(obj.Results.output1.value.Values[i][10]).toFixed(2);
				var origin=obj.Results.output1.value.Values[i][6];
				var dest=obj.Results.output1.value.Values[i][7];
				var carrier=obj.Results.output1.value.Values[i][5];
				var flightStatus=obj.Results.output1.value.Values[i][9];
				
				var startDate=obj.Results.output1.value.Values[i][2]+"/"+obj.Results.output1.value.Values[i][3]+"/"+obj.Results.output1.value.Values[i][0];
				var prevHtml=$("#displayDiv #resultRow").html();
				$("#displayDiv #resultRow").html(prevHtml+"<tr> <td>"+origin+"</td><td>"+dest+"</td><td>"+carrier+"</td><td>"+startDate+"</td><td>"+flightStatus+"</td><td>"+arrivalCancelResult+"</td></tr>");
		
			}
		$("#displayDiv").slideDown(1000).css({'display' : 'block'});
	}
	
	 $("#dt1").datepicker({
	        
	        minDate: 0,
	        required: true,
	        onSelect: function (date) {
	            var date2 = $('#dt1').datepicker('getDate');
	       }
	    });
})
	

	