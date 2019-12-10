package JsonFiler.JsonFiler.controller;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Type;
import java.net.URISyntaxException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.model.InternalWorkbook;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DataFormatter;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
public class ExcelReadWrite {
	@Autowired
	ResourceLoader resourceLoader;

	@RequestMapping(value = { "/GetExcelData" }, method = RequestMethod.POST, produces = {
			"application/json; charset=UTF-8" })
	@ResponseBody
	public String GetExcelData(HttpServletRequest request, HttpServletResponse res) throws IOException {
		String mystring = "Error";
		try {
			Resource file = resourceLoader.getResource("/resources/JSON/Time_Sheet1.xlsx");
			FileInputStream fis = new FileInputStream(file.getFile()); // obtaining bytes from the file
			XSSFWorkbook wb = new XSSFWorkbook(fis);// creating Workbook instance that refers to .xlsx file
			XSSFSheet sheet = wb.getSheetAt(0); // creating a Sheet object to retrieve object
			Iterator<Row> itr = sheet.iterator(); // iterating over excel file
			while (itr.hasNext()) {
				Row row = itr.next();
				Iterator<Cell> cellIterator = row.cellIterator(); // iterating over each column
				while (cellIterator.hasNext()) {
					mystring = "Success";
					Cell cell = cellIterator.next();
					switch (cell.getCellType()) {
					case Cell.CELL_TYPE_STRING:
						System.out.print(cell.getStringCellValue() + "\t\t");
						break;
					case Cell.CELL_TYPE_NUMERIC:
						SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MMM-yyyy");
						SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss");
						if(cell.getColumnIndex()==0) {
							System.out.print(cell.getNumericCellValue() + "\t\t");
						}
						else if (DateUtil.isCellDateFormatted(cell)) {
							System.out.print(dateFormat.format(cell.getDateCellValue()) + "\t\t");
						} else {
							System.out.print(timeFormat.format(cell.getDateCellValue()) + "\t\t");
						}
						break;
					case Cell.CELL_TYPE_BOOLEAN:
						System.out.print(cell.getBooleanCellValue() + "\t\t");
						break;
					}
				}
				System.out.println("");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return mystring;
	}
	/*******************************************************************/
	@RequestMapping(value = { "/GetJSon" }, method = RequestMethod.POST, produces = {
	"application/json; charset=UTF-8" })
	@ResponseBody
	public String GetJSon(HttpServletResponse res) {
		HashMap<String, String>  map1 = new HashMap<String, String>();
		map1.put("name", "jon");
		map1.put("name","Doe");
		
		Gson gson = new Gson();
        Type gsonType = new TypeToken<HashMap>(){}.getType();
        String gsonString = gson.toJson(map1,gsonType);
        System.out.println(gsonString);
        new JSONObject(map1).toString();
		return gsonString;
		
	}
}
