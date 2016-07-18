$(document).on('ready', function () {

    parametersSession = }
        'action' : 'VERIFY_SESSION'
    };


    $.ajax({
        type: 'POST',
        url: '../api/controller.php',
        data: parameters,
        dataType: 'json',
        success: function (obj) {
            console.log(obj.username);

        },
        error: function (error) {
            alert("Please login to continue");
            window.location.replace('signin.php');
        }
    });

	parameters = {
		'action': 'GET_CLIENTES'
	};

	$.ajax({
        type: 'POST',
        url: '../api/controller.php',
        data: parameters,
        dataType: 'json',
        success: function (obj) {
            var currentHTML = "";
            var x = 0;

            for(x = 0; x < obj.results.length; x++){
            	currentHTML += '<option value=' + obj.results[x].id + '>' + obj.results[x].username + '</option>';
            }

            $("#clientesDropdown").append(currentHTML);
            currentHTML = "";

        },
        error: function (error) {
             $('#feedback').html("Cliente no añadido, ha ocurrido un error.");
        }
    });

	$('#loginButtonNuevoPanel').on('click', function (event) {
        event.preventDefault();

        var nombre = $('#panelName').val();
        var fechaInicio = $('#dateStarts').val();
        var fechaFin = $('#dateEnds').val();
        var cliente = $("#clientesDropdown").val();

        if (nombre === '' || fechaInicio === '' || fechaFin === '' || cliente === '') {
            $('#feedback').html('Favor de llenar todos los campos');

            return;
        }

        var parameters = {
            'action': 'ALTA_PANEL',
            'nombre': nombre,
            'fechaInicio': fechaInicio,
            'fechaFin': fechaFin,
            'cliente' : cliente
        };

        $.ajax({
            type: 'POST',
            url: '../api/controller.php',
            data: parameters,
            dataType: 'json',
            success: function (obj) {
                alert("Panel creado exitosamente.");
                location.replace("liga-panel-panelista.php");
            },
            error: function (error) {
                 $('#feedback').html("Panel no añadido, ha ocurrido un error.");
            }
        });
    });

    $('#signOutButton').on('click', function (event) {
        event.preventDefault();

        var parameters = {
            'action': 'LOG_OUT '
        };

        $.ajax({
            type: 'POST',
            url: '../api/controller.php',
            data: parameters,
            dataType: 'json',
            success: function (obj) {
                if (obj.status === "SUCCESS") {
                    alert("¡Hasta pronto!");
                    location.replace("signin.php");
                } else {
                    $('#feedback').html("Correo o contraseña incorrectos.");
                }

            },
            error: function (error) {
                $('#feedback').html("Correo o contraseña incorrectos.");
            }
        });
    });

});
