<%@ page import="java.sql.*,com.*"%>
<%@page import="java.io.IOException"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.io.FileWriter"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>


<%
Database db=new Database();
Data.con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");  
PreparedStatement ps=Data.con.prepareStatement("select * from purchasebook");  
ResultSet rs=ps.executeQuery();
JSONObject jsonObject = new JSONObject();
int count=0;
while(rs.next()){
	
	JSONArray array = new JSONArray();
	array.add("itemcode: "+rs.getString(1));
	array.add("itemname: "+rs.getString(2));
	array.add("rate: "+rs.getInt(3));
	array.add("color: "+rs.getString(4));
	array.add("designcode: "+rs.getString(5));
	array.add("profile: "+rs.getInt(6));
	array.add("ratediff: "+rs.getInt(7));
	array.add("quantity: "+rs.getInt(8));
	array.add("amount: "+rs.getLong(9));
	count++;
	jsonObject.put("data"+count,array);

} 
//Inserting key-value pairs into the json object

try {
	out.print(jsonObject);
	out.flush();
   /* FileWriter file = new FileWriter("C:/Users/ac736068/Desktop/Tutorials/json_array_output.json");
   file.write(jsonObject.toJSONString());
   file.close(); */
} catch (IOException e) {
   // TODO Auto-generated catch block
   e.printStackTrace();
}

%>