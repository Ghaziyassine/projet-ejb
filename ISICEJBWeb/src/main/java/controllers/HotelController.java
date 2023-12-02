package controllers;

import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

import dao.IDaoHotel;
import dao.IDaoVille;
import entities.Hotel;
import entities.Ville;

/**
 * Servlet implementation class HotelController
 */
public class HotelController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB
	private IDaoVille daoV;
	@EJB
	private IDaoHotel daoH;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HotelController() {
		super();
		// TODO Auto-generated constructor stub
		
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// Retrieve parameters for hotel attributes
		String op = request.getParameter("op");
		// Fetch the updated list of hotels after the creation
		List<Hotel> hotels = daoH.findAll();
		List<Ville> villes = daoV.findAll();
		if (op != null) {
			if (op.equals("Envoyer")) {
				String nom = request.getParameter("nom");
				String adresse = request.getParameter("adresse");
				String telephone = request.getParameter("telephone");

				// Retrieve the villeId from the request parameter
				String villeId = request.getParameter("villeId");

				if (villeId != null) {
					Ville ville = daoV.findById(Integer.parseInt(villeId));

					daoH.create(new Hotel(nom, adresse, telephone, ville));

				} else {
					Ville ville = null;
					daoH.create(new Hotel(nom, adresse, telephone, ville));

				}
				
				// Set the list of hotels as an attribute for the JSP
				request.setAttribute("hotels", hotels);
				request.setAttribute("villes", villes);
				System.out.println(villes);
				// Forward the request to the hotel.jsp page
				RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
				dispatcher.forward(request, response);

			} else if (request.getParameter("op").equals("delete")) {
				int id = Integer.parseInt(request.getParameter("id"));
				daoH.delete(daoH.findById(id));
				RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
				dispatcher.forward(request, response);
			} else if (request.getParameter("op").equals("update")) {
				try {
					int id = Integer.parseInt(request.getParameter("id"));
					String nom = request.getParameter("nom");
					String adresse = request.getParameter("adresse");
					String telephone = request.getParameter("telephone");
					String villeId = request.getParameter("villeId");
					Ville ville = daoV.findById(Integer.parseInt(villeId));

					// Create the updated object
					Hotel updatedHotel = new Hotel(nom, adresse, telephone, ville);
					updatedHotel.setId(id);

					// Perform the update operation
					Hotel result = daoH.update(updatedHotel);

					// Log information after the update
					System.out.println("Update successful - Updated Hotel: " + result);
				} catch (Exception e) {
					e.printStackTrace(); // Handle the exception appropriately, log it, or send a response to the
											// client.
				}RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
				dispatcher.forward(request, response);
			}else if(op.equals("selectedCityId")) {
				 // Get the selected city ID from the request parameters
			    String selectedCityIdParam = request.getParameter("selectedCityId");
			    
			    if (selectedCityIdParam != null && !selectedCityIdParam.isEmpty()) {
			        try {
			            int selectedCityId = Integer.parseInt(selectedCityIdParam);
			            
			            // Retrieve the selected city
			            Ville selectedCity = daoV.findById(selectedCityId);
			            
			            if (selectedCity != null) {
			                // If a city is selected, filter hotels by city
			                List<Hotel> filteredHotelList = daoH.findHotelsByCity(selectedCity);
			                request.setAttribute("hotels", filteredHotelList);
			            } else {
			                // Handle the case where the selected city is not found
			                request.setAttribute("error", "Selected city not found");
			            }
			        } catch (NumberFormatException e) {
			            // Handle the case where the selectedCityIdParam is not a valid integer
			            request.setAttribute("error", "Invalid city ID");
			        }
			    } else {
			        // If no city is selected, show all hotels
			        List<Hotel> HotelList = daoH.findAll();
			        request.setAttribute("hotels", HotelList);
			    }
			}
		} else {
			op = "yasssine";
		}

		
	
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
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