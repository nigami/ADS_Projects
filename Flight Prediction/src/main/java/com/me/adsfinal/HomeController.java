package com.me.adsfinal;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
	
		return "index";
	}
	
	@RequestMapping(value = "home.htm", method = RequestMethod.GET)
	public String home(){
		
		return "index";
		
	}
	
	@RequestMapping(value = "flightPrediction.htm", method = RequestMethod.GET)
	public String flightpredict(){
		
		return "flightPrediction";
		
	}
	
	@RequestMapping(value = "predictprice.htm", method = RequestMethod.POST)
	public void sampleAjax(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, String> paramhMap= new HashMap<String, String>();
		paramhMap.put("origin", request.getParameter("origin"));
		String trip =request.getParameter("trip");
		paramhMap.put("trip",  request.getParameter("trip"));
		paramhMap.put("destination", request.getParameter("destination"));
		paramhMap.put("startDate",request.getParameter("startDate"));
		if(null!=trip && ("round").equalsIgnoreCase(trip)){
			paramhMap.put("endDate",request.getParameter("endDate"));
		}	
		
		String jsonReturn= createRequest(paramhMap);
		JSONObject json= null;
		PrintWriter out = null;
		try {
			json = new JSONObject(jsonReturn);
			out = response.getWriter();
		} catch (JSONException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		out.println(json);
		
		
	}

	

	private String createRequest(HashMap hmap) {
		 hmap=retrieveInputParameter(hmap);
		 
		String urlRestWebService= "https://ussouthcentral.services.azureml.net/workspaces/855d6eb6f36e47eeaebfc6a8241e7cf2/services/2bf3aa24000c4c86a7150a9512b7dfd5/execute?api-version=2.0&details=true" ;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer OJNSFLNEm5n9PzUmFF6hZWFt92Hc0gNzqpcejOTADTXmNpa2P5w1+OuYgynpC30VUmiWaY8Y8cFY4BjGogxsSA==");
		headers.add("Content-Length", "100000");
		headers.add("Content-Type", "application/json");
		
		String requestJson = "{'Inputs': {'input1': {'ColumnNames': [ 'YEAR','QUARTER','MONTH','DAY_OF_MONTH','DAY_OF_WEEK', 'CARRIER','ORIGIN','DEST','AVG_TICKET_PRICE'],'Values':[['"+hmap.get("sYear")+"','"+hmap.get("sQuarter")+"','"+hmap.get("sMonth")+"','"+hmap.get("sDayOfMon")+"','"+hmap.get("sQuarter")+"','AA','"+hmap.get("origin")+"','"+hmap.get("destination")+"','0']]}},'GlobalParameters': {}}";
		HttpEntity<String> entity = new HttpEntity<String>(requestJson,headers);
		System.out.println("entity" + entity);
		RestTemplate restTemplate = new RestTemplate();

		String restData = restTemplate.postForObject(urlRestWebService, entity, String.class);
		System.out.println("Data" + restData);
		return restData;
	}
	
	private HashMap retrieveInputParameter(HashMap hmap){
		String startDate= (String) hmap.get("startDate");
		hmap.putAll(setStartDate(startDate,"s"));	
		if(hmap.containsKey("endDate")){
			String endDate= (String) hmap.get("endDate");
			hmap.putAll(setStartDate(endDate,"e"));	
		}
		return hmap;
		
	}
	
	private HashMap setStartDate(String newDate,String prefix){
		SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
		HashMap hmap = new HashMap();
		try {
			Date sDate=formatter.parse(newDate);
			Calendar cal = Calendar.getInstance();
			cal.setTime(sDate);
			int year = cal.get(Calendar.YEAR);
			int month = cal.get(Calendar.MONTH)+1;
			 
			
			int dayOfMon= cal.get(Calendar.DAY_OF_MONTH);
			int quarter = (1<=month && month<4)?(1):((4<=month && month<7)?2:((7<=month && month<10)?3:4));
			
				
			hmap.put(prefix+"Year", year);
			hmap.put(prefix+"Month", month);
			hmap.put(prefix+"DayOfMon", dayOfMon);
			hmap.put(prefix+"Quarter", quarter);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return hmap;
	}
}
