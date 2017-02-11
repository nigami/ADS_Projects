<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Flight</title>

    <!-- Bootstrap Core CSS -->
    <link href="<c:url value="/resources/vendor/bootstrap/css/bootstrap.min.css"/>" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="<c:url value="/resources/vendor/font-awesome/css/font-awesome.min.css"/>" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700" rel="stylesheet" type="text/css">
    <link href='https://fonts.googleapis.com/css?family=Kaushan+Script' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
    <link href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700' rel='stylesheet' type='text/css'>
    <!-- Theme CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  
    <link href="<c:url value="/resources/css/agency.min.css"/>" rel="stylesheet">
    <link href="https://cdn.datatables.net/1.10.12/css/dataTables.bootstrap.min.css" rel="stylesheet">
    <link href="http://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css" rel="stylesheet">
      
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
    <script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.0/themes/base/jquery-ui.css">
    
   
    <script src="resources/js/flightPrediction.js"></script>
     <link href="resources/css/flightPrediction.css" rel="stylesheet">
     <!-- JQuery UI.Addon to Jquery Library -->
<link href="http://code.jquery.com/ui/1.10.2/themes/smoothness/jquery-ui.css" rel="Stylesheet">

      
</head>



<body id="page-top" class="index">

    <!-- Navigation -->
    <nav id="mainNav" class="navbar navbar-default navbar-custom navbar-fixed-top">
        <div class="container">
            <!-- Brand and toggle get grouped for better mobile display -->
            <div class="navbar-header page-scroll">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                    <span class="sr-only">Toggle navigation</span> Menu <i class="fa fa-bars"></i>
                </button>
                <a class="navbar-brand page-scroll" href="home.htm">FlightAnalyst.com</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                <ul class="nav navbar-nav navbar-right">
                    <li class="hidden">
                        <a href="#page-top"></a>
                    </li>
             
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>
   
    
    <section id="contact" class="bg-darkest-gray">
    <div class="container">
   
    <h3 class="section-heading" >Predict the Prices for your trip!</h3>
    <br/>
    <form  class="form-inline" id="formDetailId" action="predictprice" method="post" >
		 <div class="form-group col-lg-3">
	     <input type="radio" name="trip" class="radio"   value="round" id="roundRadioId"  /> <label  class="textColorYellow">Round Trip</label>
	     <input type="radio" name="trip" class="radio"  value="oneway" id="onewayRadioId"   /> <label class="textColorYellow">Oneway Trip</label>
		 </div>
		 
		 <div class="form-group col-lg-3">
	     <input type="radio" name="dateFlexibilty" class="radio" value="flexible" id="flexibleId"  /> <label  class="textColorYellow">Flexible</label>
	     <input type="radio" name="dateFlexibilty" class="radio"  value="exact" id="exactId"   /> <label class="textColorYellow">Exact</label>
		 </div>
		 
		  <div class="form-group col-lg-6" id="carrierDiv">
	     
			<select name="carrier" class="form-control" id="carrier">
			<!--    <option value=""></option> -->
			   <option value=" AA">American Airlines</option>
			   <option value=" AS">Alaska Airlines</option>
				                    	<option value="B6">JetBlue Airways</option>
				                    	<option value="DL">Delta Airlines</option>
				                    	<option value="EV">ExpressJet Airlines</option>
				                    	<option value="F9">Frontier Airlines</option>
				                    	<option value="HA">Hawaiian Airlines</option>
				                    	<option value="MQ">Eovny Airline</option>
				                    	<option value="NK">Spirit Airlines</option>
				                    	<option value="OO">SkyWest Airlines</option>
				                    	<option value="UA">United Airlines</option>
				                    	<option value="US">US Airlines</option>
				                    	<option value="VX">Virgin Airlines</option>
				                    	<option value="WN">SouthWest Airlines</option>
				                    	<option value="EK">Emirtes Airlines</option>
				                    	
				                    </select>
			    					</div>
		
		 
         <div class="form-group"  class="ui-widget" >
	     <input type="text" name="origin" id="origin" placeholder="Origin" value="" required/> 
		 </div>
		 <div class="form-group">
	     <input type="text" name="destination"  id="destination" placeholder="Destination" value=""  required/> 
		 </div>
	         
	         <div class="form-group">
			 
			 <input type="text" id="dt1" name="startDate" placeholder="Start Date"></input>
			 </div>
			 
			 <div class="form-group">
			 
			 <input type="text" id="dt2" name="endDate"  placeholder="End Date"></input>
			 </div>
	    
	      <div class="form-group">
	    <input type="button"  id="getFlightDetailsBtnId" class="btn btn-xl" value="Submit">																
	 		</div>
      </form>
   
    </div>  
    
    
    <div id ="displayDiv" class="panel panel-warning">
    	
    	<!-- 
    	<div class="progress">
		  <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="40" aria-valuemin="0" aria-valuemax="100" style="width: 40%">
		    <span class="sr-only">40% Complete (success)</span>
		  </div>
		</div> -->
    	
    	  <div class="panel-heading noPadding text-center">Flight Search Results</div>
		  <div id="result" class="panel-body">
		   		<table id="dataTable" class="table table-striped table-bordered" cellspacing="0" width="100%">
			     
			        <thead id="resultHead">
			            <tr>
			                <th>Origin</th>
			                <th>Destination</th>
			                <th>Carrier</th>
			             	<th>Start date</th>
			                <th>Average Ticket Price</th>
			            </tr>
			        </thead>
			     
			        <tbody id="resultRow">
			            
			        </tbody>
			    </table>
		  </div> 	
    </div>
    </section>
    
    
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <span class="copyright">Copyright &copy; Your Website 2016</span>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline social-buttons">
                        <li><a href="#"><i class="fa fa-twitter"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-facebook"></i></a>
                        </li>
                        <li><a href="#"><i class="fa fa-linkedin"></i></a>
                        </li>
                    </ul>
                </div>
                <div class="col-md-4">
                    <ul class="list-inline quicklinks">
                        <li><a href="#">Privacy Policy</a>
                        </li>
                        <li><a href="#">Terms of Use</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>

    <!-- Bootstrap Core JavaScript -->
    <script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.min.js"/>"></script>

    <!-- Contact Form JavaScript -->
    <script src="<c:url value="/resources/js/jqBootstrapValidation.js"/>"></script>
    <script src="<c:url value="/resources/js/contact_me.js"/>"></script>

    <!-- Theme JavaScript -->
    <script src="<c:url value="/resources/js/agency.min.js"/>"></script>
    
      <script src="https://cdn.datatables.net/1.10.12/js/jquery.dataTables.min.js"></script>
</body>
</html>