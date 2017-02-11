package ads.income.utils;
/**
 * 
 */

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;



/**
 * @author inigam
 *
 */

@Controller
public class CSVDownloadProcessor {

	public CSVDownloadProcessor() {
		// TODO Auto-generated constructor stub
	}
	
	
    public ArrayList<IncomeCensus> downloadCSV() {

		String csvFile = "";
		//InputStream input=getClass().getClassLoader().getResourceAsStream(csvFile);
        BufferedReader br = null;
        String line = "";
        String cvsSplitBy = ",";
        ArrayList<IncomeCensus> inputData = new ArrayList<IncomeCensus>();
               try {

            br = new BufferedReader(new FileReader("/dataset/adultData.csv"));
           
            while ((line = br.readLine()) != null) {

                // use comma as separator
                String[] dataArr = line.split(cvsSplitBy);

               System.out.println(dataArr);
               IncomeCensus data = new IncomeCensus();
               data.setAge(dataArr[0]);
               data.setWorkclass(dataArr[1]);
               data.setFnlwgt(dataArr[2]);
               data.setEducation(dataArr[3]);
               data.setEducation_num(dataArr[4]);
               data.setMarital_status(dataArr[5]);
               data.setOccupation(dataArr[6]);
               data.setRelationship(dataArr[7]);
               data.setRace(dataArr[8]);
               data.setSex(dataArr[9]);
               data.setCapital_gain(dataArr[10]);
               data.setCapital_loss(dataArr[11]); 
               data.setHours_per_week(dataArr[12]);
               data.setNative_country(dataArr[13]);
               data.setResult(dataArr[14]);
             
              inputData.add(data);
               
            }
           
           
           
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (br != null) {
                try {
                    br.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
		return inputData;

    }

}



