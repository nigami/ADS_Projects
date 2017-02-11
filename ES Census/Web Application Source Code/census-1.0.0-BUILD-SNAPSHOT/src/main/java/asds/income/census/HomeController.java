package asds.income.census;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import org.springframework.web.servlet.ModelAndView;

import ads.income.utils.CSVDownloadProcessor;
import ads.income.utils.IncomeCensus;

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
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "index";
	}
	
	
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index(Locale locale, Model model) {
		return "index";
	}
	
	@RequestMapping(value = "/about", method = RequestMethod.GET)
	public String about(Locale locale, Model model) {
		return "about";
	}
	

	@RequestMapping(value = "/work_1", method = RequestMethod.GET)
	public String work_1(Locale locale, Model model) {
		return "work_1";
	}
	
	@RequestMapping(value = "/analysis", method = RequestMethod.GET)
	public String analysis(Locale locale, Model model) {
		return "analysis";
	}
	
	@RequestMapping(value = "/dataSet", method = RequestMethod.GET)
	public String dataSet(Locale locale, Model model) {
		return "dataSet";
	}
	
	@RequestMapping(value = "/inputData", method = RequestMethod.GET)
	public ModelAndView downloadCSV(HttpServletRequest req, HttpServletResponse response) {
		
		ModelAndView mv= new ModelAndView();
		//CSVDownloadProcessor csvProc = new CSVDownloadProcessor();
		//System.out.println(csvProc.downloadCSV());
		mv.setViewName("inputData");
	return mv;

  }

	
	@RequestMapping(value="/incomeSubmit", method= RequestMethod.POST)
	public String dataMapping(HttpServletRequest request,HttpServletResponse response) throws IOException {

		PrintWriter out = response.getWriter();
		
		String age = request.getParameter("age");
		String workClass = request.getParameter("workClass");
		//String fnlwgt = request.getParameter("fnlwght");
		String education = request.getParameter("education");
		
	/*	String education_num = "13";*/
		String marital_status = request.getParameter("maritalStatus");
		String occupation = request.getParameter("occupation");
		String relationship = request.getParameter("relationship");
	/*	String race = request.getParameter("race");
		String sex = request.getParameter("sex");*/
		String capital_gain = request.getParameter("capitalGain");
		String capital_loss = request.getParameter("capitalLoss");
		String hours_per_week = request.getParameter("hoursWeek");
		//String native_country = request.getParameter("country");
		
		//you may want to visit this website to see the structure of the data being returned by this URL
		String urlOfTheRestService = "https://ussouthcentral.services.azureml.net/workspaces/855d6eb6f36e47eeaebfc6a8241e7cf2/services/a2159cb8885a4d94887ee0b04094baa7/execute?api-version=2.0&details=true";
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Bearer 1FJX6BJeeEi9nW921Kuy2zaMRTnP0xelyXN6dnmGdLmTGXS5WPF2QoSWST6iogAB4UsmJp1sbR1mohy/XVEyqA==");
		headers.add("Content-Length", "100000");
		headers.add("Content-Type", "application/json");
		
		//MultiValueMap<String, Integer> body = new LinkedMultiValueMap<String, Integer>();
		
		String requestJson = "{'Inputs': {'input1': {'ColumnNames': ['age','workclass','education','marital-status','occupation','relationship','capital-gain','capital-loss','hours-per-week','result'],'Values': [['"+age+"','"+workClass+"','"+education+"','"+marital_status+"','"+occupation+"','"+relationship+"','"+capital_gain+"','"+capital_loss+"','"+hours_per_week+"','<=50K']]}},'GlobalParameters': {} }";
		HttpEntity<String> entity = new HttpEntity<String>(requestJson,headers);

		System.out.println("entity..............."+entity);
		//It simplifies communication with HTTP servers, and enforces RESTful principles
		RestTemplate restTemplate = new RestTemplate();

		String restData = restTemplate.postForObject(urlOfTheRestService, entity, String.class);
		
		System.out.println("Data" + restData);
		
		JSONObject obj  = new JSONObject(restData);
		
		out.print(obj);
		
		return null;
	}

}
