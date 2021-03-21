<%@ page import="java.sql.*,com.*"%>

<%  
String s=request.getParameter("val");  
boolean flag=false;
if(s==null || s.trim().equals("")){  

}else{  
 
try{  
Database db=new Database();  
PreparedStatement ps=Data.con.prepareStatement("select * from item where ItemType= ?");  

ps.setString(1,s); 

ResultSet rs=ps.executeQuery(); 
	
if(rs.next()){
	out.print(rs.getString(2));
}
else{
	out.print(" ");
}

}catch(Exception e){e.printStackTrace();}  
}  
%>
