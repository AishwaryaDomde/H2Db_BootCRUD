package CoffeeBeans.CoffeeBeans.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Paths;

import javax.print.attribute.standard.RequestingUserName;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	@Autowired
	ResourceLoader resourceLoader;
	
	@RequestMapping(value="/")
	public ModelAndView test(HttpServletResponse response) throws IOException{
		return new ModelAndView("home");
	}
	
	/**************Fetching Data***********************/
	@RequestMapping(value = { "/GetData" }, method = RequestMethod.POST, produces = {"application/json; charset=UTF-8" })
	@ResponseBody
	public String GetData(HttpServletRequest request, HttpServletResponse res) throws IOException  {
		String mystring;
			Resource resource = resourceLoader.getResource("/resources/JSON/EmpData.json");
			InputStream in = resource.getInputStream();		
			StringBuilder empData = new StringBuilder();	 
	        BufferedReader reader = new BufferedReader(new InputStreamReader(in));	 
            while ((mystring = reader.readLine()) != null) { 
                empData.append(mystring);
            } 
        	return empData.toString();
	}
	/**********************************************************************/
	@RequestMapping(value = { "/SetData" }, method = RequestMethod.POST, produces = {"application/json"})
	
	public @ResponseBody String SetData(HttpServletRequest request, HttpServletResponse res) throws IOException, URISyntaxException {
		String Result="Success";	
		JSONObject requestedJSONObject = new JSONObject(request.getParameter("dataStore"));
		System.out.println(requestedJSONObject.get("dataToSend"));
		Resource resource = resourceLoader.getResource("/resources/JSON/EmpData.json");
		System.out.println("ji");
		FileWriter fw= new FileWriter(resource.getFile().getAbsolutePath());
		fw.write(requestedJSONObject.get("dataToSend").toString());
		fw.close();
		
	return Result.toString();	
	}	
	/***********************************************************************/
	@RequestMapping(value="fetchView", method = RequestMethod.GET)
	@ResponseBody 
	public String View(HttpServletRequest request,HttpServletResponse response) throws JSONException, IOException {
		Resource resource = resourceLoader.getResource("resources/JSON/Graph1.json");
		File file = resource.getFile();
		String content = new String(Files.readAllBytes(file.toPath()));	//Read File Content
		return content;
	}
}
