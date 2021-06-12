<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<form action="CustomerServlet" method="post">

    <nav class="navbar navbar-inverse">
  <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" href="#">
    <%
					String sessionUser = (String) request.getSession().getAttribute("msg");
					if (sessionUser != null) {
				%>
			<p onclick="home()"><%=sessionUser%></p>
			
				<%
					}
				%>
      </a>
  </div>

    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="home.jsp">Home</a></li>
         <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
      Invoice <span class="caret"></span></a>
       <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
       <li role="presentation" class="dropdown-header">Billing</li>
      <li role="presentation"><a role="menuitem" tabindex="-1"  href="test.jsp">New Bill</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Credit Bill</a></li>
       <li role="presentation"><a role="menuitem" tabindex="-1" href="#">View Bill</a></li>
    
    </ul>
    </li>
   
      <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
      Transactions <span class="caret"></span></a>
       <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
      <li role="presentation" class="dropdown-header">Purchase</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="newpurchase.jsp">New Purchase</a></li>
      <li role="presentation" class="divider"></li>
      <li role="presentation" class="dropdown-header">Sale</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">View Sale</a></li>
          <li role="presentation" class="divider"></li>
       <li role="presentation" class="dropdown-header">Stocks</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Check Stock</a></li>
       <li role="presentation" class="divider"></li>
       <li role="presentation" class="dropdown-header">Reports</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Sale Report</a></li>
       <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Purchase Report</a></li>
    </ul>
    </li>
            
        <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
      Reports <span class="caret"></span></a>
       <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
      <li role="presentation" class="dropdown-header">Dealer</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="Search.jsp">Check Stock</a></li>
      <li role="presentation" class="divider"></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="SearchDealer.jsp">Search Dealer Info</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="SearchCustomerPurchase.jsp">Search Customer Purchase</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="SearchItem.jsp">Search Item</a></li>
     
      <li role="presentation" class="divider"></li>
      <li role="presentation" class="dropdown-header">User Profile</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">User Profile Setup</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Modify User</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Delete User</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Change Password</a></li>
    </ul>
    </li>
      
        <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
      Setup <span class="caret"></span></a>
       <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
      <li role="presentation" class="dropdown-header">Dealer</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="AddDealer.jsp">Dealer Profile Setup</a></li>
      <li role="presentation" class="divider"></li>
      <li role="presentation" class="dropdown-header">Items</li>
        <li role="presentation"><a role="menuitem" tabindex="-1" href="AddItem.jsp">Item Setup</a></li>
      <li role="presentation" class="divider"></li>
         <li role="presentation" class="dropdown-header">Customers</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Customer Data</a></li>
      <li role="presentation" class="divider"></li>
      <li role="presentation" class="dropdown-header">User Profile</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Profile Settings</a></li>
    
    </ul>
    </li>
      
        <li class="dropdown">
      <a class="dropdown-toggle" data-toggle="dropdown" href="#">
      Utilities <span class="caret"></span></a>
       <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
      <li role="presentation" class="dropdown-header">Dealer</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="AddDealer.jsp">Add Dealer</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="ModifyDealerInfo.jsp">Search/Modify Dealer</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Delete Dealer</a></li>
      <li role="presentation" class="divider"></li>
      <li role="presentation" class="dropdown-header">Items</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Add Item</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Modify Item</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Delete Item</a></li>
      <li role="presentation" class="divider"></li>
      <li role="presentation" class="dropdown-header">User Profile</li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Add User</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Modify User</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Delete User</a></li>
      <li role="presentation"><a role="menuitem" tabindex="-1" href="#">Change Password</a></li>
    </ul>
    </li>
   </ul>
      <ul class="nav navbar-nav navbar-right">
        <li><a href="#" id="clockButton" value="Loading..." onload="showDate()" onclick="myFunction()" active/></a></li>
        <li><a onclick="validate()"><span class="glyphicon glyphicon-log-in"></span> Logout</a></li>
      </ul>
    </div>
  </div>
</nav>
</form>

 <div id="loader" class="pageloader"></div> 