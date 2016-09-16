'use strict';

$(document).on('ready', function () {
    $('#paneles-header-option').addClass('selected');

    // -----------------------------------------------------------------------------------------------
    // Fetch Clientes
    // -----------------------------------------------------------------------------------------------

    $.ajax({
        type: 'POST',
        url: '../api/controller.php',
        data: {'action': 'GET_CLIENTES'},
        dataType: 'json',
        success: function (response) {
            var currentHTML = '<thead>';
            currentHTML += '<tr>';
            currentHTML += '<th>Nombre</th>';
            currentHTML += '<th>Correo</th>';
            currentHTML += '<th class="centered">Seleccionar</th>';
            currentHTML += '</tr>';
            currentHTML += '</thead>';
            currentHTML += '<tbody>';

            for (var i = 0; i < response.results.length; i++) {
                var result = response.results[i];

                currentHTML += '<tr id="' + result.id + '">';
                currentHTML += "<td>" + result.nombre + " " + result.apellidos + "</td>";
                currentHTML += "<td>" + result.email + "</td>";
                currentHTML += '<td class="centered"><input type="radio" value=' + result.id + ' name="id"></td>';
                currentHTML += "</tr>";

                $('#tableClientes').append(currentHTML);
                currentHTML = '';
            }

            currentHTML += '</tbody>';
        },
        error: function (error) {
            $('#feedback').html('Error cargando los clientes');
        }
    });

    // -----------------------------------------------------------------------------------------------
    // Fetch Paneles
    // -----------------------------------------------------------------------------------------------

    setTimeout(function (event) {
        $.ajax({
            type: 'POST',
            url: '../api/controller.php',
            data: {'action': 'GET_PANELES'},
            dataType: 'json',
            success: function (response) {
                fillSelects(1, 0);
                fillSelects(2, 0);
                fillSelects(3, 0);

                var currentHTML = '<thead>';
                currentHTML += '<tr>';
                currentHTML += '<th>Nombre</th>';
                currentHTML += '<th>Fecha Inicio</th>';
                currentHTML += '<th>Fecha Fin</th>';
                currentHTML += '<th>Cliente</th>';
                currentHTML += '<th colspan="2">Acción</th>';
                currentHTML += '</tr>';
                currentHTML += '</thead>';
                currentHTML += '<tbody>';

                for (var i = 0; i < response.results.length; i++) {
                    var result = response.results[i];

                    currentHTML += '<tr id="'+ result.id +'">';
                    currentHTML += '<td><a href="liga-panel-panelista.php?id=' + result.id +'">' + result.nombre +"</a></td>";
                    currentHTML += "<td>" + result.fechaInicio + "</td>";
                    currentHTML += "<td>" + result.fechaFin + "</td>";
                    currentHTML += "<td>" + result.cliente + "</td>";
                    currentHTML += '<td class=edit-button><button id=edit type=button>Editar</button></td>';
                    currentHTML += '<td class=deleteButton><button id=delete type=button>Eliminar</button></td>';
                    currentHTML += "</tr>";

                    $('#allPanels').append(currentHTML);
                    currentHTML = '';
                }

                currentHTML += '</tbody>';
                $('#cancel-edit').hide();
            },
            error: function (error) {
                $('#feedback').html('Error cargando los paneles');
            }
        });
    }, 500);

    // -----------------------------------------------------------------------------------------------
    // Save Panel
    // -----------------------------------------------------------------------------------------------

    $('#save-panel').on('click', function (event) {
        event.preventDefault();

        var idPanel = window.location.search.substring(1);
        idPanel = idPanel.substring(3);

        var nombre = $('#panelName').val();
        var descripcion = $('#descripcion').val();
        var fechaInicio = getCompleteDate(1);
        var fechaFin = getCompleteDate(2);
        var cliente = $('input[name=id]:checked').val();

        if (nombre === '' || fechaInicio === '' || fechaFin === '' || typeof cliente === 'undefined') {
            $('#feedback').html('Favor de llenar todos los campos');
            return;
        }

        var data = {
            action: 'ALTA_PANEL',
            nombre: nombre,
            descripcion: descripcion,
            fechaInicio: fechaInicio,
            fechaFin: fechaFin,
            cliente: cliente
        };

        if (idPanel != '') {
            data.id = idPanel;
        }

        var actionText = idPanel !== '' ? 'editado' : 'agregado';
        $.ajax({
            type: 'POST',
            url: '../api/controller.php',
            data: data,
            dataType: 'json',
            success: function (response) {
                if (response.status == 'SUCCESS') {
                    alert('Panel ' + actionText + ' exitosamente.');
                    location.replace("liga-panel-panelista.php?id=" + response.id);
                } else {
                    $('#feedback').html('Panel no ' + actionText + '. Ha ocurrido un error.');
                }
            },
            error: function (error) {
                $('#feedback').html('Panel no ' + actionText + '. Ha ocurrido un error.');
            }
        });
    });

    // -----------------------------------------------------------------------------------------------
    // Edit Panel
    // -----------------------------------------------------------------------------------------------

    $('#allPanels').on('click', '.edit-button', function () {
        var idPanel = $(this).parent().attr('id');

        $('ul.tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $('ul.tabs li').first().addClass('current');
        $("#tab-agregar-panel").addClass('current');

        $('#headerTitle').text('Editar Panel');
        $('#save-panel').text('Editar');
        $('#cancel-edit').show();

        $.ajax({
            url: '../api/controller.php',
            type: 'POST',
            data: {
                action: 'GET_PANELES',
                id: idPanel
            },
            dataType: 'json',
            success: function (response) {
                var result = response.result;

                $('#panelName').val(result.nombre);
                getDatefromString(result.fechaInicio, 0);
                getDatefromString(result.fechaFin, 1);
                $('input[name="id"][value="' + result.cliente + '"]').prop('checked', true);

                var myURL = window.location.href.split('?')[0];
                myURL += '?id=' + result.id;
                history.pushState({}, null, myURL);
            },
            error: function (errorMsg) {
                alert('Error editando panelista.');
            }
        });
    });

    // -----------------------------------------------------------------------------------------------
    // Delete Panel
    // -----------------------------------------------------------------------------------------------

    $('#allPanels').on('click', '.deleteButton', function () {
        var self = this;
        var data = {
            'action': 'DELETE_PANEL',
            'id': $(this).parent().attr('id')
        }

        $.ajax({
            url: '../api/controller.php',
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function (response) {
                alert('Panelista eliminado exitosamente.');
                $(self).parent().remove();
            },
            error: function (errorMsg) {
                alert('Error eliminando panelista.');
            }
        });
    });

    $('#cancel-edit').on('click', function (event) {
        $('#tab-agregar-panel').find('input').val('');
        $('#tableClientes input').removeAttr('checked');
        $('#headerTitle').text('Agregar Panel');
        $('#save-panel').text('Agregar');
        $('#cancel-edit').hide();
        var myURL = window.location.href.split('?')[0];
        history.pushState({}, null, myURL);

        $('ul.tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $('ul.tabs li').last().addClass('current');
        $('#tab-view-paneles').addClass('current');
    });

    $('#mes, #anio').on('change', function () {
        changeSelect('Inicio');
    });

    $('#mes_fin, #anio_fin').on('change', function () {
        changeSelect('Fin');
    });
});
