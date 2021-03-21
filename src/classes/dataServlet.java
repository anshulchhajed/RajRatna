package classes;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

@WebServlet(name = "dataServlet", urlPatterns = { "/dataservlet" })
public class dataServlet extends HttpServlet {
	private static final String CONTENT_TYPE = "text/html; charset=windows-1252";
	Connection con;
	public void init(ServletConfig config) throws ServletException {
		super.init(config);
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("enterred servlet...");
		String empID = "";
		try {
			empID = request.getParameter("empID");
			System.out.println("empID is:" + empID);
			Class.forName("com.mysql.jdbc.Driver");
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");
			PreparedStatement ps = con.prepareStatement("select * from emp where empid != ? order by empid");
			ps.setString(1, empID);
			ResultSet rs = ps.executeQuery();
			System.out.println("got response....");

			JSONArray json = new JSONArray();
			ResultSetMetaData metadata = rs.getMetaData();
			int numColumns = metadata.getColumnCount();

			while (rs.next()) //iterate rows
			{
				JSONObject obj = new JSONObject(); //extends HashMap
				for (int i = 1; i <= numColumns; ++i) //iterate columns
				{
					String column_name = metadata.getColumnName(i);
					obj.put(column_name, rs.getObject(column_name));
					System.out.println("rs.getObject('" + column_name + "')........." + rs.getObject(column_name));
				}
				json.add(obj);
				System.out.println("Added JSON object to JSON Array..");

			}

			response.setContentType("application/json;charset=UTF-8");
			String jsonString = json.toJSONString();
			System.out.println("jsonString:" + jsonString);
			response.getWriter().write(jsonString);

			Map<String, Object> jsonMap = new HashMap<String, Object>();
			jsonMap.put("Status", "Success");
			jsonMap.put("Rows", 100);

			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}