package controllers;

import jakarta.ejb.EJB;
import jakarta.inject.Inject;
import jakarta.persistence.EntityManager;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import services.VilleService;

import java.io.IOException;

import dao.IDaoLocale;
import entities.Ville;

/**
 * Servlet implementation class VilleController
 */
public class VilleController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB
	private IDaoLocale<Ville> ejb;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public VilleController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String op = request.getParameter("op");
		if (request.getParameter("op") != null) {
			if (request.getParameter("op").equals("Envoyer")) {
				String nom = request.getParameter("ville");
				ejb.create(new Ville(nom));

			} else if (request.getParameter("op").equals("delete")) {
				int id = Integer.parseInt(request.getParameter("id"));
				ejb.delete(ejb.findById(id));
			} else if (request.getParameter("op").equals("update")) {
				try {
					int id = Integer.parseInt(request.getParameter("id"));
					String nom = request.getParameter("nom");

					if (id <= 0) {
						throw new IllegalArgumentException("Invalid ID provided for the update operation");
					}

					if (nom == null || nom.trim().isEmpty()) {
						throw new IllegalArgumentException("Nom cannot be empty for the update operation");
					}

					System.out.println("Received update request - ID: " + id + ", Nom: " + nom);

					Ville updatedVille = new Ville(nom);
					updatedVille.setId(id);

					Ville result = ejb.update(updatedVille);

					System.out.println("Update successful - Updated Ville: " + result);
				} catch (Exception e) {
					e.printStackTrace(); 
				}
			}

		}
		request.setAttribute("villes", ejb.findAll());
		RequestDispatcher dispatcher = request.getRequestDispatcher("ville.jsp");
		dispatcher.forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
