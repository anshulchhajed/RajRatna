<%@page import="com.Database"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<div class="col-sm-2 sidenav">

<% 

String billcount=(String)request.getAttribute("billcount");
Database db=new Database();
db.getTotalSale();
%>
      <div class="well">
        <p>Total Sale: &#8377;<%=db.getTotalSale() %>/-</p>
        <button type="button" class="btn btn-primary">
  		Total Bill <span class="badge badge-light"><%=billcount%></span>
		</button>
      </div>
      <div class="well">
        <p>View Last Bill</p>
      </div>
    </div>