'use strict';
$(document).on('ready', function () {

	$.ajax({
        type: 'POST',
        url: '../api/controller.php',
        data: {'action': 'GET_CLIENTES'},
        dataType: 'json',
        success: function (obj) {
            var currentHTML = '<tr>';
            currentHTML += '<th></th>';
            currentHTML += '<th>Username</th>';
            currentHTML += '<th>Nombre</th>';
            currentHTML += '<th>Correo</th>';
            currentHTML += '<th>Seleccionar</th>';
            currentHTML += '</tr>';

            for (var i = 0; i < obj.results.length; i++) {
                currentHTML += '<tr value="' + obj.results[i].id + '">';
                currentHTML += "<td></td>";
                currentHTML += "<td>" + obj.results[i].username+"</td>";
                currentHTML += "<td>" + obj.results[i].nombre+"</td>";
                currentHTML += "<td>" + obj.results[i].email+"</td>";
                currentHTML += '<td><input type="radio" value=' + obj.results[i].id + ' name="id"></td>';
                currentHTML += "</tr>";

                $("#tableClientes").append(currentHTML);
                currentHTML = '';
            }
        },
        error: function (error) {
            $('#feedback').html("Error cargando los clientes.");
        }
    });

    $('#loginButtonNuevoPanel').on('click', function (event) {
        event.preventDefault();

        var idPanel = window.location.search.substring(1)
        idPanel = idPanel.substring(3);

        var nombre = $('#panelName').val();
        var descripcion = $('#descripcion').val();
        var fechaInicio = $('#dateStarts').val();
        var fechaFin = $('#dateEnds').val();
        var cliente = $("input[name=id]:checked").val();

        if (nombre === '' || fechaInicio === '' || fechaFin === '' || typeof cliente === 'undefined') {
            $('#feedback').html('Favor de llenar todos los campos');
            return;
        }

        var parameters = {
            'action': 'ALTA_PANEL',
            'nombre': nombre,
            'descripcion' : descripcion,
            'fechaInicio': fechaInicio,
            'fechaFin': fechaFin,
            'cliente' : cliente
        };

        if (idPanel != '') {
            parameters.id = idPanel;
        }

        $.ajax({
            type: 'POST',
            url: '../api/controller.php',
            data: parameters,
            dataType: 'json',
            success: function (obj) {
                if (obj.status == 'SUCCESS') {
                    alert("Panel creado exitosamente.");
                    location.replace("liga-panel-panelista.php?id=" + obj.id);
                } else {
                    $('#feedback').html("Panel no añadido, ha ocurrido un errorrr.");
                }
            },
            error: function (error) {
                $('#feedback').html("Panel no añadido, ha ocurrido un error.");
            }
        });
    });

    setTimeout(function (event) {
        $.ajax({
            type: 'POST',
            url: '../api/controller.php',
            data: {'action': 'GET_PANELES'},
            dataType: 'json',
            success: function (obj) {
                var currentHTML = '<tr>';
                currentHTML += '<th></th>';
                currentHTML += '<th>Nombre</th>';
                currentHTML += '<th>Fecha Inicio</th>';
                currentHTML += '<th>Fecha Fin</th>';
                currentHTML += '<th>Cliente</th>';
                currentHTML += '<th colspan="2">Acción</th>';
                currentHTML += '</tr>';

                for (var i = 0; i < obj.results.length; i++) {
                    currentHTML += '<tr value="'+ obj.results[i].id +'">';
                    currentHTML += "<td></td>";
                    currentHTML += '<td><a href="liga-panel-panelista.php?id=' + obj.results[i].id +'">' + obj.results[i].nombre +"</a></td>";
                    currentHTML += "<td>" + obj.results[i].fechaInicio + "</td>";
                    currentHTML += "<td>" + obj.results[i].fechaFin + "</td>";
                    currentHTML += "<td>" + obj.results[i].cliente + "</td>";
                    currentHTML += "<td class=modifyButton><input id= modify type=  submit  value= Modificar ></td>"
                    currentHTML += "<td class=deleteButton><input id= delete type=  submit  value= Eliminar ></td>";
                    currentHTML += "</tr>";

                    $("#allPanels").append(currentHTML);
                    currentHTML = '';
                }
            },
            error: function (error) {
                $('#feedback').html("Error cargando los clientes.");
            }
        });
    }, 500);
	
	$('#allPanels').on('click','.deleteButton', function(){
        var parameters = {
            'action': 'DELETE_PANEL',
            'id': $(this).parent().attr('value')
        }
        console.log(parameters);
        $.ajax({
            url: '../api/controller.php',
            type: 'POST',
            data: parameters,
            dataType: 'json',
            success: function (obj) {
                alert('Panelista Eliminado!');
                $(this).parent().find('td.id').remove();
            },
            error: function (errorMsg) {
                alert('Error eliminando Panelista');
            }
        });
    });

    $('#allPanels').on('click','.modifyButton', function(){
        var idPanel = $(this).parent().attr('value');

        $('ul.tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $('ul.tabs li').first().addClass('current');
        $("#tab-agregarPanel").addClass('current');

        $('#headerTitle').text('Modificar Panel');


        var parameters = {
            'action': 'GET_PANELES',
            'id': idPanel
        }
        $.ajax({
            url: '../api/controller.php',
            type: 'POST',
            data: parameters,
            dataType: 'json',
            success: function(obj){
                console.log(obj);
                for(var i = 0; i < obj.results.length; i++) {
                    if(obj.results[i].id == idPanel){
                        $('#panelName').val(obj.results[i].nombre);
                        $('#dateStarts').val(obj.results[i].fechaInicio);
                        $('#dateEnds').val(obj.results[i].fechaFin);
                        $('input[name="id"][value="' + obj.results[i].id + '"]').prop('checked', true);

                        var myURL = window.location.href.split('?')[0];
                        myURL = myURL + '?id=' + obj.results[i].id;
                        history.pushState({}, null, myURL);
                    }
                }
            },
            error: function (errorMsg) {
                alert('Error modificando Panelista');
            }
        });
    });

});