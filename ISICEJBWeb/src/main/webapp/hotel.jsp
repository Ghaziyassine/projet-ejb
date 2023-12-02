<%@page import="entities.Hotel"%>
<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>
<head>

<meta charset="ISO-8859-1">
<title>Gestion des hotels</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style>
body {
    font-family: Arial, sans-serif;
    margin: 20px;
}
h1 {
  color: black; /* Set the text color to a shade of blue (you can change the color code) */
  font-size: 2em; /* Adjust the font size */
  font-family: 'Arial', sans-serif; /* Specify the font family */
  text-align: center; /* Align the text to the center */
  /* Add more styles as needed */
}
 form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        input, select {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        label {
            margin-top: 10px;
            display: block;
        }

        select {
            cursor: pointer;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

th, td {
    border: 1px solid #ddd;
    padding: 8px;
    text-align: left;
}

thead {
    background-color: #f2f2f2;
}

.bndelete {
    display: inline-block;
    padding: 8px 12px;
    text-decoration: none;
    background-color: #FA2909;
    color: #fff;
    border: 1px solid #f44336;
    border-radius: 4px;
    transition: background-color 0.3s;
}
.bnupdate{
display: inline-block;
    padding: 8px 12px;
    text-decoration: none;
    background-color: #BD3266 ;
    color:   #fff ;
    border: 1px solid #f44336;
    border-radius: 4px;
    transition: background-color 0.3s;
}
.bndelete:hover{
    background-color: #d32f2f;
    border-color: #d32f2f;
}
 .bnupdate:hover {
  background-color: blue ;
    border-color: blue ;
 }
.swal2-popup {
    font-size: 14px;
}

.swal2-input, .swal2-select {
    margin-bottom: 10px;
    width: 100%;
}

.swal2-validation-message {
    font-size: 14px;
}


</style>
</head>

<script>
        function confirmDelete(id) {
            var confirmation = confirm("Voulez-vous vraiment supprimer cet Hotel ?");
            if (confirmation) {
                window.location.href = "HotelController?op=delete&id=" + id;
            } else {
                // Annulation de la suppression
            }
        }
        function modifierEtudiant(id) {
            Swal.fire({
                title: 'Modifier un Hotel',
                html:
                    '<input id="nom" class="swal2-input" placeholder="Nom">' +
                    '<input id="adresse" class="swal2-input" placeholder="Adresse">' +
                    '<input id="telephone" class="swal2-input" placeholder="Telephone">' +
                    '<select id="villeId" class="swal2-select" style="width: 100%;">' +
                    '   <c:forEach items="${villes}" var="v">' +
                    '       <option value="${v.id}">${v.nom}</option>' +
                    '   </c:forEach>' +
                    '</select>',
                    showCancelButton: true,
                confirmButtonText: 'Modifier',
                preConfirm: () => {
                    const nom = Swal.getPopup().querySelector('#nom').value;
                    const adresse = Swal.getPopup().querySelector('#adresse').value;
                    const telephone = Swal.getPopup().querySelector('#telephone').value;
                    const villeId = Swal.getPopup().querySelector('#villeId').value;

                    if (!nom || !adresse || !telephone || !villeId) {
                        Swal.showValidationMessage('Veuillez remplir tous les champs.');
                    }

                    return { nom, adresse, telephone, villeId };
                }
            }).then((result) => {
                if (!result.dismiss) {
                    const { nom, adresse, telephone, villeId } = result.value;
                    // Construisez l'URL avec les données
                    const url = "HotelController?op=update&id=" + id +
                        "&nom=" + nom + "&adresse=" + adresse +
                        "&telephone=" + telephone  +
                        "&villeId=" + villeId;

                    // Redirigez l'utilisateur vers l'URL
                    window.location.href = url;
                }
            });
        }
 </script>

<body>
<h1>Gestion des Hotels</h1>
	<form action="${pageContext.request.contextPath}/HotelController"
		method="get">
		Nom : <input type="text" name="nom" /> <br> Adresse : <input
			type="text" name="adresse" /> <br> Téléphone : <input
			type="text" name="telephone" /> <br> <label for="Ville">Ville
			:</label> <select id="ville" name="villeId">
			<c:forEach var="v" items="${villes}">
				<option value="${v.id}">${v.nom}</option>
			</c:forEach>
		</select><br> <input name="op" type="submit" value="Envoyer" />

	</form>

 <form action="HotelController" method="get">
        <label for="selectedCityId">Select a City:</label>
        <select name="selectedCityId" id="selectedCityId">
            <option value="">choisir une ville</option>
            <c:forEach var="ville" items="${villes}">
                <option value="${ville.id}">${ville.nom}</option>
            </c:forEach>
        </select>
        <input type="submit" value="Filter">
    </form>

<div id="hotelTable">

	<h2>Liste des hotels :</h2>
	<table border="1">
		<thead>
			<tr>
				<th>ID</th>
				<th>Nom</th>
				<th>Adresse</th>
				<th>Téléphone</th>
				<th>Ville</th>
				<th>Supprimer</th>
				<th>Modifier</th>

			</tr>
		</thead>
		<tbody>
			<c:forEach items="${hotels}" var="v">
				<tr>
					<td>${v.id}</td>
					<td>${v.nom}</td>
					<td>${v.adresse}</td>
					<td>${v.telephone}</td>
					<td>${v.ville}</td>
					<td><a class="bndelete" href="#"
						onclick="confirmDelete(${v.id})">Supprimer</a></td>
					<td><a class="bnupdate" href="javascript:void(0);"
						onclick="modifierEtudiant(${v.id})">Modifier</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
</html>

