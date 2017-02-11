<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Case</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css"></script>
  	<link rel="stylesheet" href="resources/css/analysis.css">
  	<script src="resources/js/analysis.js"></script>
</head>
<body>

<nav class="navbar navbar-inverse navbar-fixed-top">
  <div class="container-fluid">
    <div class="navbar-header">
      <a class="navbar-brand" href="#">Census Income</a>
    </div>
    <ul class="nav navbar-nav">
      <li><a href="/">Home</a></li>
      <li  class="active"><a href="/analysis">Predication Analysis</a></li>
      <li><a href="/dataSet">Business Intelligence</a></li>
        <li><a href="/inputData">Input DataSet</a></li>
      <li><a href="/about">About</a></li>
    </ul>
  </div>
</nav>
<div class="container-fluid">
  <h3>Inverted Navbar</h3>
   <div class="col-lg-8 div75">
   	<div class="container">
	<h3>Estimate Living Standard for US population:</h3>
        <div class="row centered-form">
          <div class="col-xs-12 col-sm-8 col-md-8 col-sm-offset-2 col-md-offset-2">
        	<div class="panel panel-default">
        		<div class="panel-heading">
			    		<h3 class="panel-title text-center"><b>Predict Income Classification</b> <!-- <small>Categorical prediction</small> --></h3>
			 			</div>
			 			<div class="panel-body">
			    		<form role="form"  method="post" id="analyseForm">
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Age</label>
			                <input type="number" name="age" id="age" class="form-control input-sm" placeholder="Age">
			    					</div>
			    				</div>
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Work Class</label>
			    					<select name="workClass" class="form-control input-sm" id="workClass">
			    						<option value=""></option>
				                    	<option value=" Private">Private</option>
				                    	<option value=" Self-emp-not-inc"> Self-emp-not-inc</option>
				                    	<option value=" Self-emp-inc"> Self-emp-inc</option>
				                    	<option value=" Federal-gov"> Federal-gov</option>
				                    	<option value=" Local-gov"> Local-gov</option>
				                    	<option value=" State-gov"> State-gov</option>
				                    	<option value=" Without-pay"> Without-pay</option>
				                    	<option value=" Never-worked"> Never-worked</option>
				                   		</select>
			    					</div>
			    				</div>
			    			</div>
<!-- 
			    			<div class="form-group">
                                    <label>Email address</label>
			    				<input type="email" name="email" id="email" class="form-control input-sm" placeholder="Email Address">
			    			</div> -->

			    			<div class="row">
			    				<!-- <div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Final Weight:</label>
			    						<input type="number" name="fnlwght" id="fnlwght" class="form-control input-sm" placeholder="Final Weight">
			    					</div>
			    				</div> -->
			    				<!-- <div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Education</label>
			    						 <select name="education" class="form-control input-sm" id="education">
			    						 <option value=""></option>
				                    	<option value=" Bachelors"> Bachelors</option>
				                    	<option value=" Some-college"> Some-college</option>
				                    	<option value=" 11th"> 11th</option>
				                    	<option value=" HS-grad"> HS-grad</option>
				                    	<option value=" Prof-school"> Prof-school</option>
				                    	<option value=" Assoc-acdm"> Assoc-acdm</option>
				                    	<option value=" Assoc-voc"> Assoc-voc</option>
				                    	<option value=" 9th"> 9th</option>
				                    	<option value=" 7th-8th"> 7th-8th</option>
				                    	<option value=" 12th"> 12th</option>
				                    	<option value=" Masters"> Masters</option>
				                    	<option value=" 1st-4th"> 1st-4th</option>
				                    	<option value=" 10th"> 10th</option>
				                    	<option value=" Doctorate"> Doctorate</option>
				                    	<option value=" 5th-6th"> 5th-6th</option>
				                    	<option value=" Preschool"> Preschool</option>
				                    </select>
			    					</div>
			    				</div> -->
			    			</div>
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Marital Status</label>
			         				 <select name="maritalStatus" class="form-control input-sm" id="maritalStatus">
			         				 <option value=""></option>
				                   		<option value=" Married-civ-spouse"> Married-civ-spouse		   </option>
										<option value=" Divorced"> Divorced                              </option>
										<option value=" Never-married"> Never-married                    </option>
										<option value=" Separated"> Separated                            </option>
										<option value=" Widowed"> Widowed                                </option>
										<option value=" Married-spouse-absent"> Married-spouse-absent    </option>
										<option value=" Married-AF-spouse"> Married-AF-spouse            </option>
									  </select>
			    					</div>
			    				</div>
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Occupation</label>
			    						<select name="occupation" class="form-control input-sm" id="occupation">
			    						<option value=""></option>
					                  	<option value=" Tech-support">Tech-support</option>
										<option value=" Craft-repair">Craft-repair</option>
										<option value=" Other-service">Other-service</option>
										<option value=" Sales">Sales</option>
										<option value=" Exec-managerial">Exec-managerial</option>
										<option value=" Prof-specialty">Prof-specialty</option>
										<option value=" Handlers-cleaners">Handlers-cleaners</option>
										<option value=" Machine-op-inspct">Machine-op-inspct</option>
										<option value=" Adm-clerical">Adm-clerical</option>
										<option value=" Farming-fishing">Farming-fishing</option>
										<option value=" Transport-moving">Transport-moving</option>
										<option value=" Priv-house-serv">Priv-house-serv</option>
										<option value=" Protective-serv">Protective-serv</option>
										<option value=" Armed-Forces">Armed-Forces</option>
									 </select>
			    					</div>
			    				</div>
			    			</div>
			    			<div class="row">
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Relationship</label>
			                 		<select name="relationship" class="form-control input-sm" id="relationship">
			                 		<option value=""></option>
					                  	<option value=" Wife">Wife</option>
										<option value=" Own-child">Own-child</option>
										<option value=" Husband">Husband</option>
										<option value=" Sales">Sales</option>
										<option value=" Not-in-family">Not-in-family</option>
										<option value=" Other-relative">Other-relative</option>
										<option value=" Unmarried">Unmarried</option>
										<option value=" Machine-op-inspct">Machine-op-inspct</option>
										<option value=" Adm-clerical">Adm-clerical</option>
										<option value=" Farming-fishing">Farming-fishing</option>
										<option value=" Transport-moving">Transport-moving</option>
										<option value=" Priv-house-serv">Priv-house-serv</option>
										<option value=" Protective-serv">Protective-serv</option>
										<option value=" Armed-Forces">Armed-Forces</option>
									 </select>
			    					</div>
			    				</div>
			    				<!-- <div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Race</label>
			    						<select name="race" class="form-control input-sm" id="race">
			    						<option value=""></option>
						                <option value=" White">White</option>
										<option value=" Asian-Pac-Islander">Asian-Pac-Islander</option>
										<option value=" Amer-Indian-Eskimo">Amer-Indian-Eskimo</option>
										<option value=" Other">Other</option>
										<option value=" Black">Black</option>
									</select>
			    					</div>
			    				</div> -->
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Education</label>
			    						 <select name="education" class="form-control input-sm" id="education">
			    						 <option value=""></option>
				                    	<option value=" Bachelors"> Bachelors</option>
				                    	<option value=" Some-college"> Some-college</option>
				                    	<option value=" 11th"> 11th</option>
				                    	<option value=" HS-grad"> HS-grad</option>
				                    	<option value=" Prof-school"> Prof-school</option>
				                    	<option value=" Assoc-acdm"> Assoc-acdm</option>
				                    	<option value=" Assoc-voc"> Assoc-voc</option>
				                    	<option value=" 9th"> 9th</option>
				                    	<option value=" 7th-8th"> 7th-8th</option>
				                    	<option value=" 12th"> 12th</option>
				                    	<option value=" Masters"> Masters</option>
				                    	<option value=" 1st-4th"> 1st-4th</option>
				                    	<option value=" 10th"> 10th</option>
				                    	<option value=" Doctorate"> Doctorate</option>
				                    	<option value=" 5th-6th"> 5th-6th</option>
				                    	<option value=" Preschool"> Preschool</option>
				                    </select>
			    					</div>
			    				</div>
			    			</div>
			    			
			    			<div class="row">
			    				<!-- <div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Sex</label>
			                 		<select name="sex" class="form-control input-sm"  id="sex">
			                 		<option value=""></option>
						                <option value=" Female">Female</option>
										<option value=" Male">Male</option>
									</select>
			    					</div>
			    				</div>
			    				<div class="col-xs-6 col-sm-6 col-md-6">
			    					<div class="form-group">
                                    <label>Native Country</label>
			    					<input type="text" name="country" class="form-control input-sm" id="country">
			    					</div>
			    				</div> -->
			    			</div>
			    			
			    			<div class="row">
			    				<div class="col-xs-4 col-sm-4 col-md-4">
			    					<div class="form-group">
                                    <label>Capital Gain</label>
			                 		<input type="number" name="capitalGain" class="form-control input-sm" id="capitalGain" placeholder="0.00$">
			    					</div>
			    				</div>
			    				<div class="col-xs-4 col-sm-4 col-md-4">
			    					<div class="form-group">
                                    <label>Capital Loss</label>
			    					 <input type="number" name="capitalLoss" class="input-sm form-control" id="capitalLoss" placeholder="0.00$">
			    					</div>
			    				</div>
			    				<div class="col-xs-4 col-sm-4 col-md-4">
			    					<div class="form-group">
                                    <label>Hours per week</label>
			    					 <input type="number" name="hoursWeek" class="input-sm form-control" id="hoursWeek">
			    					</div>
			    				</div>
			    			</div>
			    			<div class="row">
			    				<div class="col-xs-12 col-sm-12 col-md-12">
			    					<div class="form-group">
                                    <label>Result</label>
			                 		<input type="text" name="result" class="form-control input-sm" id="result" placeholder="">
			    					</div>
			    				</div>
			    				
			    			
			    			</div>
			    			<!-- <input type="submit" class="btn btn-warning btn-block" value="Submit"> -->
			    			<button type="button" class="btn btn-warning btn-block" id="submitBtn">Submit</button>
			    			
			    		
			    		</form>
			    	</div>
	    		</div>
    		</div>
    	</div>
 
	 	 	</div>
	 	 	</div>
	 	 	 <div class="col-lg-4 div25">
  <!-- start feedwind code --><script type="text/javascript">document.write('\x3Cscript type="text/javascript" src="' + ('https:' == document.location.protocol ? 'https://' : 'http://') + 'feed.mikle.com/js/rssmikle.js">\x3C/script>');</script><script type="text/javascript">(function() {var params = {rssmikle_url: "http://economictimes.indiatimes.com/jobs/rssfeeds/107115.cms",rssmikle_frame_width: "280",rssmikle_frame_height: "100%",frame_height_by_article: "5",rssmikle_target: "_blank",rssmikle_font: "Arial, Helvetica, sans-serif",rssmikle_font_size: "12",rssmikle_border: "off",responsive: "off",rssmikle_css_url: "",text_align: "left",text_align2: "left",corner: "off",scrollbar: "on",autoscroll: "on",scrolldirection: "up",scrollstep: "3",mcspeed: "20",sort: "Off",rssmikle_title: "on",rssmikle_title_sentence: "",rssmikle_title_link: "",rssmikle_title_bgcolor: "#CDAE14",rssmikle_title_color: "#171717",rssmikle_title_bgimage: "",rssmikle_item_bgcolor: "#FFFFFF",rssmikle_item_bgimage: "",rssmikle_item_title_length: "55",rssmikle_item_title_color: "#C79408",rssmikle_item_border_bottom: "on",rssmikle_item_description: "on",item_link: "off",rssmikle_item_description_length: "150",rssmikle_item_description_color: "#666666",rssmikle_item_date: "gl1",rssmikle_timezone: "Etc/GMT",datetime_format: "%b %e, %Y %l:%M %p",item_description_style: "text+tn",item_thumbnail: "full",item_thumbnail_selection: "auto",article_num: "15",rssmikle_item_podcast: "off",keyword_inc: "",keyword_exc: ""};feedwind_show_widget_iframe(params);})();</script><div style="font-size:10px; text-align:center; width:350px;"><a href="http://feed.mikle.com/" target="_blank" style="color:#CCCCCC;">RSS Feed Widget</a><!--Please display the above link in your web page according to Terms of Service.--></div><!--  end  feedwind code --></div>
   
	 	 	
</div>
</body>
</html>
