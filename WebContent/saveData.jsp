<%@ page import="java.sql.*,com.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	long mob = 0l;
	String name = (String) request.getParameter("val1");
	String mobtemp = (String) request.getParameter("val2");
	if (mobtemp == "") {
	} else {
		mob = Long.parseLong(mobtemp);
	}
	long billno = Long.parseLong(request.getParameter("val3"));
	boolean flag = false;
	boolean existFlag = false;
	Connection con = null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/rajratna?user=root&password=");
		PreparedStatement pss = con.prepareStatement("select * from customer where customermobile=?");
		pss.setLong(1, mob);
		ResultSet rs = pss.executeQuery();
		if (rs.next()) {
			existFlag = true;

			PreparedStatement pss1 = con
					.prepareStatement("update recentactivity set customername=?, customermobile=?");
			pss1.setString(1, name);
			pss1.setLong(2, mob);
			ResultSet rs1 = pss1.executeQuery();
			if (rs1.next()) {
				flag = true;
			}

		} else {
			PreparedStatement ps = con.prepareStatement(
					"insert into customer (customername,customermobile) values ('" + name + "','" + mob + "')");
			PreparedStatement ps2 = con
					.prepareStatement("update recentactivity set customername=?,customermobile=?");
			ps2.setString(1, name);
			ps2.setLong(2, mob);
			int x = ps.executeUpdate();
			int y = ps2.executeUpdate();
			if (x > 0 && y < 0) {
				flag = true;
			}

		}
		con.close();

	} catch (Exception e) {

	}
%>
