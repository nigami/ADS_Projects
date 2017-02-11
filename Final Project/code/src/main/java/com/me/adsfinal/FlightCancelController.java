package com.me.adsfinal;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

@Controller
public class FlightCancelController {

	public FlightCancelController() {
		// TODO Auto-generated constructor stub
	}


	@RequestMapping(value = "predictCancel.htm", method = RequestMethod.POST)
	public void predictDelay(HttpServletRequest request, HttpServletResponse response) {
		HashMap<String, String> paramhMap= new HashMap<String, String>();
		
		paramhMap.put("origin", request.getParameter("origin"));
		paramhMap.put("destination", request.getParameter("destination"));
		paramhMap.put("carrier",request.getParameter("carrier"));
		paramhMap.put("departDate",request.getParameter("departDate"));
		
		
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
		 
		String urlRestWebService= "https://ussouthcentral.services.azureml.net/workspaces/855d6eb6f36e47eeaebfc6a8241e7cf2/services/a8c4638662c14fe8ad0196b5fcb6f460/execute?api-version=2.0&details=true" ;
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer xRXqfSudmjq9GZXmqo/KpnHxgA/fYuKKRwRtIlFcFvhPRoN3EUEOM4ukmDQ63N/dJPeNjUJPu/NjKi9VG+L7Yg==");
		headers.add("Content-Length", "100000");
		headers.add("Content-Type", "application/json");
		String requestJson=null;
		
		
		requestJson = "{'Inputs': {'input1': {'ColumnNames': ['YEAR','QUARTER','MONTH', 'DAY_OF_MONTH', 'DAY_OF_WEEK','CARRIER','ORIGIN','DEST','CANCELLED'],'Values':[['"+hmap.get("Year")+"','"+hmap.get("Quarter")+"','"+hmap.get("Month")+"','"+hmap.get("DayOfMon")+"','"+hmap.get("Quarter")+"','"+hmap.get("carrier")+"','"+hmap.get("origin")+"','"+hmap.get("destination")+"','0']]}},'GlobalParameters': {}}";
		
		
		HttpEntity<String> entity = new HttpEntity<String>(requestJson,headers);
		System.out.println("entity" + entity);
		
		RestTemplate restTemplate = new RestTemplate();
		String restData = restTemplate.postForObject(urlRestWebService, entity, String.class);
		System.out.println("Data" + restData);
		return restData;
	}
	
	private HashMap retrieveInputParameter(HashMap hmap){
		String departDate= (String) hmap.get("departDate");
		hmap.putAll(setStartDate(departDate));	
		return hmap;
		
	}
	
	private HashMap setStartDate(String newDate){
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
			
				
			hmap.put("Year", year);
			hmap.put("Month", month);
			hmap.put("DayOfMon", dayOfMon);
			hmap.put("Quarter", quarter);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return hmap;
	}
	
	
}
