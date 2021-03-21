<%@ page import="java.sql.*,com.*"%>

<%  
try{ 
String s=request.getParameter("val");  
boolean flag=false;

Class.forName("com.mysql.jdbc.Driver");  
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");  
PreparedStatement ps=con.prepareStatement("select * from purchaseentry where voucherno like ?" );  
ps.setString(1,s+"%"); 

ResultSet rs=ps.executeQuery(); 
%>
<DataList id="custdata" style="height:40px;color:blue">
<%
while(rs.next()){
%>
	<option  value="<%=rs.getString(1)%>" >Company:<%=rs.getString(2)%>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	</option>
<%
flag=true;
}
%>
</DataList>
<%
if(flag==false){
out.print("<center><b><p style='font-size:12px;color:red'>No Record Found</p></center>");
}
con.close();  
}catch(Exception e)
{
	
}  
%>
