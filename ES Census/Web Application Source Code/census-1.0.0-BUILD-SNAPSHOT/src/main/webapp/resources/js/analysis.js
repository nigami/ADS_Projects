$( document ).ready(function() {
    console.log( "ready!" );
    
    $("#submitBtn").click(function(){
    	
    	$.post( "incomeSubmit",$("#analyseForm").serialize(), function( data ) {
    		 
    		 var json = JSON.parse(data);
				console.log(json);
				
				
				var data1=json.Results.output1.value.Values[0][10];
				
				$("#result").val(data1);
				$("#result").css({'background-color' : '#b2ffb2'});
				
    		});
    });
});