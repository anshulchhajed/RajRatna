package classes;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.Data;
import com.Database;
/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/AddDataServlet")
public class AddDataServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddDataServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub


		Database db = new Database();
		Data obj=new Data();
		String add=(String)request.getParameter("add");
		String delete=(String)request.getParameter("delete");
		if(add==null && delete==null) {
			obj.empid=(String)request.getParameter("name");
			obj.empname=(String)request.getParameter("department");
			obj.emplocn=(String)request.getParameter("phone");
			obj.empsalary=(String)request.getParameter("email"); 
			db.insertEmpData(obj);
		 }
		 if(add!=null) {
			 System.out.println("Add Not Null");
			 	obj.empid=(String)request.getParameter("name");
				obj.empname=(String)request.getParameter("department");
				obj.emplocn=(String)request.getParameter("phone");
				obj.empsalary=(String)request.getParameter("email");
				db.updateEmpData(obj);
		 }
		if(delete!=null) {
			db.deleteEmpData(delete);		
		} 
		System.out.println(add); 
		System.out.println(delete); 
		
		System.out.println(obj.empid);
		System.out.println(obj.empname);
		System.out.println(obj.emplocn);
		System.out.println(obj.empsalary);

		
			//request.setAttribute("msg","Invalid Login Id & Password");
			RequestDispatcher d = getServletContext().getRequestDispatcher("/dynamic.jsp");
			d.forward(request, response);

		}


	}
