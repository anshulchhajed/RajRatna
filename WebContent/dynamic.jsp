<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="com.*,java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round|Open+Sans">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="http://code.jquery.com/jquery-migrate-1.1.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<link href="css/dynamic.css" rel="stylesheet">
</head>
<body>
<form action="AddDataServlet" id="form1" method="post">

<div class="container-lg">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-8"><h2>Employee <b>Details</b></h2></div>
                    <div class="col-sm-4">
                        <button type="button" class="btn btn-info add-new"><i class="fa fa-plus"></i> Add New</button>
                    </div>
                </div>
            </div>
        
            <table class="table table-bordered">
             
                    <tr>
                        <th>EMPID</th>
                        <th>EMPNAME</th>
                        <th>EMPLOC</th>
                        <th>EMPSALARY</th>
                        <th>Action</th>
                    </tr>
         
                    <%
           Database db=new Database();
           ArrayList al=db.getEmpData();    
            for(int i=0;i<al.size();i++){
            	Data data=(Data)al.get(i);
            %> 
                    <tr>
                        <td><%=data.empid %></td>
                        <td><%=data.empname %></td>
                        <td><%=data.emplocn %></td>
                        <td><%=data.empsalary %></td>
                        <td>
                        	
                           <button type="submit" name="add" value=<%=data.empid %> class="add" title="Add" data-toggle="tooltip"><i class="material-icons">&#xE03B;</i></a>
                            <button type="button" name="edit" class="edit" title="Edit" data-toggle="tooltip"><i class="material-icons">&#xE254;</i></a>
                            <button type="submit" name="delete" value=<%=data.empid %> class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a>
                        </td>
                    </tr>
                    <% 
     
            }
                    %>   
              
            </table>

        </div>
    </div>
</div> 
</form>
<script>
$(document).ready(function(){
	$('[data-toggle="tooltip"]').tooltip();
	var actions = $("table td:last-child").html();
	// Append table with add row form on add new button click
    $(".add-new").click(function(){
		$(this).attr("disabled", "disabled");
		var index = $("table tbody tr:last-child").index();
        var row = '<tr>' +
            '<td><input type="text" class="form-control" name="name" id="empid"></td>' +
            '<td><input type="text" class="form-control" name="department" id="empname"></td>' +
            '<td><input type="text" class="form-control" name="phone" id="emplocn"></td>' +
            '<td><input type="text" class="form-control" name="email" id="empsalary"></td>' +
			'<td>' + actions + '</td>' +
        '</tr>';
    	$("table").append(row);
		$("table tbody tr").eq(index + 1).find(".add, .edit").toggle();
        $('[data-toggle="tooltip"]').tooltip();
    });
    	
	// Edit row on edit button click
	$(document).on("click", ".edit", function(){
        $(this).parents("tr").find("td:not(:last-child)").each(function(){
			$(this).html('<input type="text" class="form-control" value="' + $(this).text() + '">');
		});
		$(this).parents("tr").find(".add, .edit").toggle();
		$(".add-new").attr("disabled", "disabled");
    });

});

</script>
</body>
</html>