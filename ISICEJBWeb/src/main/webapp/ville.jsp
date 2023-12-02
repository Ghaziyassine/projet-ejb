<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<style >
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
            var confirmation = confirm("Voulez-vous vraiment supprimer cette Ville ?");
            if (confirmation) {
                window.location.href = "VilleController?op=delete&id=" + id;
            } else {
                // Annulation de la suppression
            }
        }
        function modifierEtudiant(id) {
            Swal.fire({
                title: 'Modifier le nom de cette ville',
                html:
                    '<input id="nom" class="swal2-input" placeholder="Nom">' ,
                showCancelButton: true,
                confirmButtonText: 'Modifier',
                preConfirm: () => {
                    const nom = Swal.getPopup().querySelector('#nom').value;
                   

                    if (!nom ) {
                        Swal.showValidationMessage('Veuillez remplir tous les champs.');
                    }

                    return { nom };
                }
            }).then((result) => {
                if (!result.dismiss) {
                    const { nom } = result.value;
                    // Construisez l'URL avec les données
                    const url = "VilleController?op=update&id=" + id +
                        "&nom=" + nom ;

                    // Redirigez l'utilisateur vers l'URL
                    window.location.href = url;
                }
            });
        }
        </script>

<body>
<h1>Gestion des Villes</h1>
	<form action="VilleController" method="get">
		
		<table border="0">
            <tr>
            <td>Ville</td>
            <td><input id="ville" type="text" name="ville" value=""  required=""/></td>
            <td>
            <input name="op" type="submit" value="Envoyer" />
            </td>
            </tr>
        
    </table>
	</form>

	
	
	
    
    <h2>Liste des villes :</h2>
	<table border="1">
		<thead>
			<tr>
				<th>ID</th>
				<th>Nom</th>
				<th>Supprimer</th>
				<th>Modifier</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${villes}" var="v">
				<tr>
					<td>${v.id}</td>
					<td>${v.nom}</td>
					
					<td><a class="bndelete" href="#"
						onclick="confirmDelete(${v.id})">Supprimer</a></td>
					<td><a class="bnupdate" href="javascript:void(0);"
						onclick="modifierEtudiant(${v.id})">Modifier</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
    
</body>
</html>