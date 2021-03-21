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
 * Servlet implementation class AddItemServlet
 */
@WebServlet("/AddItemServlet")
public class AddItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public AddItemServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Database db = new Database();
		Data obj=new Data();
		String val=request.getParameter("submit");
		boolean flag=false;
		obj.itemcode=(String)request.getParameter("item_code");
		obj.itemtype=(String)request.getParameter("item_name");

		if(val.equals("add")) {

			 flag=db.addItem(obj);
			if(flag) {

				request.setAttribute("success","Item Added");	
			}
			else {
				request.setAttribute("failed","Item Already In List");	

			}
		}
		if(val.equals("update")) {
			 flag=db.updateItem(obj);
				if(flag) {

					request.setAttribute("success","Item Updated");	
				}
				else {
					request.setAttribute("failed","Invalid Entry");	

				}
		}

		if(val.equals("delete")) {
			 flag=db.deleteItem(obj);
				if(flag) {

					request.setAttribute("success","Item Deleted");	
				}
				else {
					request.setAttribute("failed","Item does not exist");	

				}
		}
		RequestDispatcher d = getServletContext().getRequestDispatcher("/AddItem.jsp");
		d.forward(request, response);


	}

}
