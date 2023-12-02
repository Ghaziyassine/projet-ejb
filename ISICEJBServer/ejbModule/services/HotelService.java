package services;

import java.util.List;
import java.util.Objects;

import dao.IDaoHotel;
import dao.IDaoRemote;
import entities.Hotel;
import entities.Ville;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityNotFoundException;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "yassine")
@PermitAll
public class HotelService implements IDaoHotel, IDaoRemote<Hotel> {

	@PersistenceContext
	private EntityManager em;

	@Override

	public Hotel create(Hotel o) {
		em.persist(o);
		return o;
	}

	@Override
	public boolean delete(Hotel o) {
		if (o != null) {
			// Check if the entity is managed before trying to remove it
			if (em.contains(o)) {
				em.remove(o);
			} else {
				// If the entity is detached, merge it first and then remove
				Hotel managedEntity = em.merge(o);
				em.remove(managedEntity);
			}
			return true;
		}
		return false;
	}

	@Override
	public Hotel update(Hotel updatedHotel) {
	    Objects.requireNonNull(updatedHotel.getId(), "Hotel ID must not be null");

	    Hotel attachedHotel = em.find(Hotel.class, updatedHotel.getId());

	    if (attachedHotel == null) {
	        throw new EntityNotFoundException("Hotel with ID " + updatedHotel.getId() + " not found");
	    }

	    // Update all relevant attributes
	    attachedHotel.setNom(updatedHotel.getNom());
	    attachedHotel.setAdresse(updatedHotel.getAdresse());
	    attachedHotel.setTelephone(updatedHotel.getTelephone());
	    attachedHotel.setVille(updatedHotel.getVille());
	    // Update other attributes as needed

	    return em.merge(attachedHotel);
	}

	@Override
	public Hotel findById(int id) {
		// TODO Auto-generated method stub
		return em.find(Hotel.class, id);
	}

	@Override
	public List<Hotel> findAll() {
		Query query = em.createQuery("select v from Hotel v");
		return query.getResultList();
	}
     @Override
	public List<Hotel> findHotelsByCity(Ville v){
		return v.getHotels();	
	}
	
}