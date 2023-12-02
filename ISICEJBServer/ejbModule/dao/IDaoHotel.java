package dao;

import java.util.List;

import entities.Hotel;
import entities.Ville;
import jakarta.ejb.Local;

@Local
public interface IDaoHotel extends IDaoLocale<Hotel> {

	List<Hotel> findHotelsByCity(Ville selectedCity);

}