$( document ).ready(function(){
	console.log("READY");

	var $radios = $('input:radio[name=trip]');
    if($radios.is(':checked') === false) {
        $radios.filter('[value=oneway]').prop('checked', true);
    }
    
    var category=[{ label: "BOSTON", value: "BOS" },
                  { label: "ORLANDO", value: "ORD" }];
    
    $( '#origin' ).autocomplete({source: category});	
    		
    
    
    var $radios = $('input:radio[name=dateFlexibilty]');
    if($radios.is(':checked') === false) {
        $radios.filter('[value=flexible]').prop('checked', true);
    }
    
	$("#getFlightDetailsBtnId").click(function(){
		
		$("#displayDiv #resultRow").html("");
		$("#displayDiv").slideUp(1000);
		$.post( "predictprice.htm",$("#formDetailId").serialize(),function(response){displayTheContent(response);});
	}); 
	
	function displayTheContent(response){
		console.log(response);
		var obj = JSON.parse(response);
		console.log(obj);
		var size=obj.Results.output1.value.Values.length;
		console.log("size"+size);
		var count = 0;
		$("#displayDiv #resultHead").html("<tr><th>Origin</th> <th>Destination</th><th>Carrier</th><th>Departure date</th><th>Average Ticket Price</th></tr>");
		
		if($("#exactId").is(':checked') === true) {
			for(var i=0; i<size;i++){
				var price=Math.round(Number(obj.Results.output1.value.Values[i][9]));
				var origin=obj.Results.output1.value.Values[i][6];
				var dest=obj.Results.output1.value.Values[i][7];
				var carrier=obj.Results.output1.value.Values[i][5];
				var startDate=obj.Results.output1.value.Values[i][2]+"/"+obj.Results.output1.value.Values[i][3]+"/"+obj.Results.output1.value.Values[i][0];
				var prevHtml=$("#displayDiv #resultRow").html();
				$("#displayDiv #resultRow").html(prevHtml+"<tr> <td>"+origin+"</td><td>"+dest+"</td><td>"+carrier+"</td><td>"+startDate+"</td><td>$"+price+"</td></tr>");
				count=count+Number(price);
			}
			prevHtml=$("#displayDiv #resultRow").html();
			$("#displayDiv #resultRow").html(prevHtml+"<tr> <td></td><td></td><td></td><td><label class='textColorYellow'>Total</label></td><td>$"+count+"</td></tr>");
		}else if($("#flexibleId").is(':checked') === true){
			if(size<=3){
				for(var i=0; i<size;i++){
					var price=Math.round(Number(obj.Results.output1.value.Values[i][9]));
					var origin=obj.Results.output1.value.Values[i][6];
					var dest=obj.Results.output1.value.Values[i][7];
					var carrier=obj.Results.output1.value.Values[i][5];
					var startDate=obj.Results.output1.value.Values[i][2]+"/"+obj.Results.output1.value.Values[i][3]+"/"+obj.Results.output1.value.Values[i][0];
					var prevHtml=$("#displayDiv #resultRow").html();
					$("#displayDiv #resultRow").html(prevHtml+"<tr> <td>"+origin+"</td><td>"+dest+"</td><td>"+carrier+"</td><td>"+startDate+"</td><td>$"+price+"</td></tr>");
					
				}
				prevHtml=$("#displayDiv #resultRow").html();
			}else{
				$("#displayDiv #resultHead").html("");
				$("#displayDiv #resultHead").html("<tr><th>Origin</th> <th>Destination</th><th>Carrier</th><th>Departure date</th><th>Arrival date</th><th>Roundtrip Total Ticket</th></tr>");
				var destination = $("#destination").val();
				var origin = $("#origin").val();
				
				for(var i=0; i<size;i++){
					if(obj.Results.output1.value.Values[i][7]===destination){
						var price=Math.round(Number(obj.Results.output1.value.Values[i][9]));
						var origin=obj.Results.output1.value.Values[i][6];
						var dest=obj.Results.output1.value.Values[i][7];
						var carrier=obj.Results.output1.value.Values[i][5];
						var departDate=obj.Results.output1.value.Values[i][2]+"/"+obj.Results.output1.value.Values[i][3]+"/"+obj.Results.output1.value.Values[i][0];
						for(var j=0; j<size;j++){	
							if(!(obj.Results.output1.value.Values[j][7]===destination)){
								var arrivalDate=obj.Results.output1.value.Values[j][2]+"/"+obj.Results.output1.value.Values[j][3]+"/"+obj.Results.output1.value.Values[j][0];
								var newprice=Number(price)+Math.round(Number(obj.Results.output1.value.Values[j][9]));
								var prevHtml=$("#displayDiv #resultRow").html();
								$("#displayDiv #resultRow").html(prevHtml+"<tr> <td>"+origin+"</td><td>"+dest+"</td><td>"+carrier+"</td><td>"+departDate+"</td><td>"+arrivalDate+"</td><td>$"+newprice+"</td></tr>");
							}
						}
					}
				}
			}
		}
		$('#dataTable').DataTable();
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
	

	