<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.*,java.sql.*,com.*"%>

<%

Database db=new Database();

int billcount=0;
PreparedStatement ps3=Data.con.prepareStatement("select * from purchasebilldetail where itempurchased !=0");

ResultSet rs3=ps3.executeQuery();
while(rs3.next()){
	billcount++;
}

request.setAttribute("billcount",String.valueOf(billcount));

%>
