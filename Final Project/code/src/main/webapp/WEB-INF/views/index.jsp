<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
    <link href="<c:url value="/resources/css/agency.min.css"/>" rel="stylesheet">
	<link href="<c:url value="/resources/css/index.css"/>" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

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
                    <li>
                        <a class="page-scroll" href="#services">Services</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#portfolio">Algorithms</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#team">Team</a>
                    </li>
                    <li>
                        <a class="page-scroll" href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container-fluid -->
    </nav>

    <!-- Header -->
    <header>
        <div class="container">
            <div class="intro-text">
                <div class="intro-lead-in">Welcome To Our Flight Analyst Studio!</div>
                <div class="intro-heading">Analyze before you fly</div>
                <a href="#services" class="page-scroll btn btn-xl">Know About us More</a>
            </div>
        </div>
    </header>

    <!-- Services Section -->
    <section id="services">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Services</h2>
                    <h3 class="section-subheading text-muted">Select Your Option</h3>
                </div>
            </div>
            <div class="row text-center">
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-primary"></i>
                        <i class="fa fa-dollar fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading"><a href="flightPrediction.htm">Flight Price Predictions</a></h4>
                    <p class="text-muted">Know the best prices for your perfect trip!</p>
                </div>
                 <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-primary"></i>
                        <i class="fa fa-times fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading"><a href="flightCancel.htm">Flight Cancellation Classification</a></h4>
                    <p class="text-muted">Classify the flights into different Groups</p>
                </div>
                <div class="col-md-4">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-primary"></i>
                        <i class="fa fa-plane fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading"><a href="flightDelay.htm">Flight Delay Prediction</a></h4>
                    <p class="text-muted">Know estimated delay in arrival flights</p>
                </div>
               
                
               
                <div class="col-md-8">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-primary"></i>
                        <i class="fa fa-bar-chart fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading"><a href="datavisual.htm">Data Visualization</a></h4>
                    <p class="text-muted">See the trends in data of different flights</p>
                </div>
               
                
                <div class="col-md-4" id="twitterId">
                    <span class="fa-stack fa-4x">
                        <i class="fa fa-circle fa-stack-2x text-primary"></i>
                        <i class="fa fa-twitter fa-stack-1x fa-inverse"></i>
                    </span>
                    <h4 class="service-heading"><a href="twittervisual.htm">Twitter Flight Analysis</a></h4>
                    <p class="text-muted">See the trends in data of different flights</p>
                </div>
               
                
            </div>
    
            
        </div>
    </section>
    

    <!-- Portfolio Grid Section -->
    <section id="portfolio" class="bg-light-gray">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Algorithms</h2>
                    <h3 class="section-subheading text-muted">Algorithms Used for Data Analysis Under our Studio</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal1" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="<c:url value="/resources/img/portfolio/flightPrice.jpg"/>" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Flight Price Predication</h4>
                        <p class="text-muted">Neural Network Analysis</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal2" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="<c:url value="/resources/img/portfolio/flightDelay.jpg"/>" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Flight Delay Predication</h4>
                        <p class="text-muted">Bayesian Model Analysis</p>
                    </div>
                </div>
                <div class="col-md-4 col-sm-6 portfolio-item">
                    <a href="#portfolioModal3" class="portfolio-link" data-toggle="modal">
                        <div class="portfolio-hover">
                            <div class="portfolio-hover-content">
                                <i class="fa fa-plus fa-3x"></i>
                            </div>
                        </div>
                        <img src="<c:url value="/resources/img/portfolio/fcancelledOntime.jpg"/>" class="img-responsive" alt="">
                    </a>
                    <div class="portfolio-caption">
                        <h4>Flight Cancellation Classification</h4>
                        <p class="text-muted">Bayesian Model Analysis</p>
                    </div>
                </div>
                
            </div>
        </div>
    </section>
    <!-- Team Section -->
    <section id="team" class="bg-light-white">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Our Amazing Team</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-4">
                    <div class="team-member">
                        <img src="<c:url value="/resources/img/team/ila.jpg"/>" class="img-responsive img-circle" alt="">
                        <h4>Ila Nigam</h4>
                      <p></p>
                        <ul class="list-inline social-buttons">
                            <li><a href="#"><i class="fa fa-twitter"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-facebook"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="team-member">
                        <img src="<c:url value="/resources/img/team/2.jpg"/>" class="img-responsive img-circle" alt="">
                        <h4>Ayushi Srivastava</h4>
                        <p></p>
                        <ul class="list-inline social-buttons">
                            <li><a href="#"><i class="fa fa-twitter"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-facebook"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="col-sm-4">
                    <div class="team-member">
                        <img src="<c:url value="/resources/img/team/3.jpg"/>" class="img-responsive img-circle" alt="">
                        <h4>Bhavesh Patel</h4>
                        <p class="text-muted"></p>
                        <ul class="list-inline social-buttons">
                            <li><a href="#"><i class="fa fa-twitter"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-facebook"></i></a>
                            </li>
                            <li><a href="#"><i class="fa fa-linkedin"></i></a>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
         
        </div>
    </section>

  

    <!-- Contact Section -->
    <section id="contact">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Contact Us</h2>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <form name="sentMessage" id="contactForm" novalidate>
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <input type="text" class="form-control" placeholder="Your Name *" id="name" required data-validation-required-message="Please enter your name.">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control" placeholder="Your Email *" id="email" required data-validation-required-message="Please enter your email address.">
                                    <p class="help-block text-danger"></p>
                                </div>
                                <div class="form-group">
                                    <input type="tel" class="form-control" placeholder="Your Phone *" id="phone" required data-validation-required-message="Please enter your phone number.">
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <textarea class="form-control" placeholder="Your Message *" id="message" required data-validation-required-message="Please enter a message."></textarea>
                                    <p class="help-block text-danger"></p>
                                </div>
                            </div>
                            <div class="clearfix"></div>
                            <div class="col-lg-12 text-center">
                                <div id="success"></div>
                                <button type="submit" class="btn btn-xl">Send Message</button>
                            </div>
                        </div>
                    </form>
                </div>
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

    <!-- Portfolio Modals -->
    <!-- Use the modals below to showcase details about your portfolio projects! -->

    <!-- Portfolio Modal 1 -->
    <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal" data-dismiss="modal">
                    <div class="lr">
                        <div class="rl">
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2">
                            <div class="modal-body">
                                <!-- Project Details Go Here -->
                                <h2>Flight Price Predication Analysis</h2>
                                <p class="item-intro text-muted">Business Problem:To provide the user with estimated price on the future dated flight</p>
                                <img class="img-responsive img-centered" src="<c:url value="resources/img/portfolio/predictionAlgo.jpg"/>" alt="">
                                <img class="img-responsive img-centered" src="<c:url value="resources/img/portfolio/priceTable.jpg"/>" alt="">
                                <p>On evaluating the data,the feature selected for price prediction were Origin, destination, start date, end date, carrier. Algorithms used for analysis: <b>Neural Network Regression, Linear regression, Boosted Decision Tree Regression, Poisson Regression, Decision Forest Regression and Bayesian Linear Regression</b></p>
								<p>Models are analyzed on the score evaluated from microsoft azure studio data modeling and with Graphical analysis using to monitor effect of each feature on performance of the models.
                                </p>
                                <p>
                                    <strong>Neural Network algorithm performance matrix for price prediction turns out to be the best model for BTS dataset </strong>Coefficient of Determination: 85 <a href="https://studio.azureml.net/Home/ViewWorkspaceCached/855d6eb6f36e47eeaebfc6a8241e7cf2?#Workspaces/Experiments/Experiment/855d6eb6f36e47eeaebfc6a8241e7cf2.f-id.8fa78d3691e4491cb5ac434c42505a03/ViewExperiment">Flight Predication Experiment Modeling</a></p>
                               <!--  <ul class="list-inline">
                                    <li>Percentage Coefficient of Determination:</li>
                                    <li>Neural Network Algorithm: 85.1</li>
                                    <li>Linear Regression Algorithm: 59.1</li>
                                    <li>Linear Regression Algorithm: 59.1</li>
                                    <li>Boosted Decision Tree Regression Algorithm: 78.6</li>
                                    <li>Poisson Regression Algorithm: 62.6</li>
                                    <li>Decision Forest Regression Algorithm: 82.0</li>
                                    <li>Bayesian Linear Regression Algorithm: 59.1</li>
                                </ul> -->
                                <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 2 -->
    <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal" data-dismiss="modal">
                    <div class="lr">
                        <div class="rl">
                        </div>
                    </div>
                </div>
                 <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2">
                            <div class="modal-body">
                                <!-- Project Details Go Here -->
                                      <h2>Flight Delay Prediction Analysis</h2>
                                <p class="item-intro text-muted">Business Problem: To predict arrival delay for the departed flights.</p>
                                <img class="img-responsive img-centered" src="<c:url value="/resources/img/portfolio/flightDelayModel.jpg"/>" alt="">
                                <img class="img-responsive img-centered" src="<c:url value="/resources/img/portfolio/arrivalDelayModel.jpg"/>" alt="">
                                
                                <p>Flight Delay Predication modeling uses were Origin, destination, Date, carrier, DepDelay15 and Flight Number features to predict the arrival delay time after visiualizing impacts and evaluating correlations for all the factors in RITA BTS Dataset.</p>
                                <p>Models used for analysis are: Linear regression, Boosted Decision Tree Regression, Decision Forest Regression, Bayesian Linear Regression in <a href="https://studio.azureml.net/Home/ViewWorkspaceCached/855d6eb6f36e47eeaebfc6a8241e7cf2?#Workspaces/Experiments/Experiment/855d6eb6f36e47eeaebfc6a8241e7cf2.f-id.a27f1d13389940db8252e1bb3ad2eb76/ViewExperiment">Flight Delay Predication</a> in Microsoft azure.</p>
                                
                                <p>After detailed analysis <b>Boosted Decision Tree Model</b> turns out to be the best model for evaluating arrival time delay for departed flights. </p>
                                <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                            </div>
                        </div>
                    </div>
                </div>
               
            </div>
        </div>
    </div>

    <!-- Portfolio Modal 3 -->
    <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="close-modal" data-dismiss="modal">
                    <div class="lr">
                        <div class="rl">
                        </div>
                    </div>
                </div>
                 <div class="container">
                    <div class="row">
                        <div class="col-lg-8 col-lg-offset-2">
                            <div class="modal-body">
                                <h2>Flight Cancellation Classification Analysis</h2>
                                <p class="item-intro text-muted">Business Problem: To classify whether a flight would be cancelled or not.</p>
                                <img class="img-responsive img-centered" src="<c:url value="/resources/img/portfolio/cancellationModel.jpg"/>" alt="">
                                <img class="img-responsive img-centered" src="<c:url value="/resources/img/portfolio/cancelClassifyGraph.jpg"/>" alt="">
                                <img class="img-responsive img-centered" src="<c:url value="/resources/img/portfolio/cancelMatrix.jpg"/>" alt="">
                                
                                <p>On evaluating the data, we found that the main predictors were Origin, destination, Date, carrier, cancelled to classify the flight status.Next we sampled the data into Test and Train to model the train data and then evaluate our model on based of Test data set. Model used to analyze: Two class Decision Forest, Two class Decision Jungle, Two class Boosted Decision,and Two class Logistic Regression</p>
                                <p>In Azure, the best model is <b>Boosted Decision Classification Algorithm</b> was hosted as web service and was integrated with the front end to classify the cancellation of Flight for the given input for <a href="https://studio.azureml.net/Home/ViewWorkspaceCached/855d6eb6f36e47eeaebfc6a8241e7cf2?#Workspaces/Experiments/Experiment/855d6eb6f36e47eeaebfc6a8241e7cf2.f-id.1f6debb7985a41029d8bb2eb8b6de0b1/ViewExperiment">Flight Cancellation Classification Model</a>.</p>
                                <button type="button" class="btn btn-primary" data-dismiss="modal"><i class="fa fa-times"></i> Close Project</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

   

    <!-- jQuery -->
    <script src="<c:url value="/resources/vendor/jquery/jquery.min.js"/>"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="<c:url value="/resources/vendor/bootstrap/js/bootstrap.min.js"/>"></script>

    <!-- Plugin JavaScript -->
    <script src="<c:url value="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"/>"></script>

    <!-- Contact Form JavaScript -->
    <script src="<c:url value="/resources/js/jqBootstrapValidation.js"/>"></script>
    <script src="<c:url value="/resources/js/contact_me.js"/>"></script>

    <!-- Theme JavaScript -->
    <script src="<c:url value="/resources/js/agency.min.js"/>"></script>

</body>

</html>
