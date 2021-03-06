'use strict';

$(document).on('ready', function () {
    $('#usuarios-header-option').addClass('selected');
    $('#cancel-edit').hide();

    // -----------------------------------------------------------------------------------------------
    // Fetch Administradores
    // -----------------------------------------------------------------------------------------------

    setTimeout(function () {
        $.ajax({
            type: 'POST',
            url: '../api/controller.php',
            data: {
                'action': 'GET_ADMINS'
            },
            dataType: 'json',
            success: function (response) {
                var currentHTML = '<thead>';
                currentHTML += '<tr>';
                currentHTML += '<th>Username</th>';
                currentHTML += '<th>Nombre</th>';
                currentHTML += '<th>Correo</th>';
                currentHTML += '<th colspan="2">Acción</th>';
                currentHTML += '</tr>';
                currentHTML += '</thead>';
                currentHTML += '<tbody>';

                for (var i = 0; i < response.results.length; i++) {
                    var result = response.results[i];

                    currentHTML += '<tr id="'+ result.id +'">';
                    currentHTML += '<td>' + result.username+'</td>';
                    currentHTML += '<td>' + result.nombre+'</td>';
                    currentHTML += '<td>' + result.email+'</td>';
                    currentHTML += '<td class=edit-button><button id=edit type=button>Editar</button></td>';
                    currentHTML += '<td class=deleteButton><button id=delete type=button>Eliminar</button></td>';
                    currentHTML += '</tr>';

                    $('#allAdmins').append(currentHTML);
                    currentHTML = '';
                }

                currentHTML += '</tbody>';
            },
            error: function (error) {
                $('#feedback').html('Error cargando los administradores');
            }
        });
    });

    // -----------------------------------------------------------------------------------------------
    // Save Administrador
    // -----------------------------------------------------------------------------------------------

    $('#save-admin').on('click', function (event) {
        var idAdmin = window.location.search.substring(1);
        idAdmin = idAdmin.substring(3);

        var editing = idAdmin != '';

        var email = $('#email').val();
        var nombre = $('#firstName').val();
        var apellidos = $('#lastName').val();
        var username = $('#username').val();
        var password = $('#password').val();
        var passwordConfirm = $('#passwordConfirm').val();

        if (nombre === '' || apellidos === '' || email === '' || username === '' || (!editing && (password === '' || passwordConfirm === ''))) {
            $('#feedback').html('Favor de llenar todos los campos');
            return;
        }

        if (!editing && (password != passwordConfirm)) {
            $('#feedback').html('Las contraseñas no coinciden');
            return;
        }

        var data = {
            action: 'ALTA_ADMIN',
            nombre: nombre,
            apellidos: apellidos,
            email: email,
            username: username
        };

        if (editing) {
            data.id = idAdmin;
        } else {
            data.password = password
        }

        var actionText = editing ? 'editado' : 'agregado';
        $.ajax({
            type: 'POST',
            url: '../api/controller.php',
            data: data,
            dataType: 'json',
            success: function (response) {
                if (response.status === 'SUCCESS') {
                    alert('Adminsitrador ' + actionText + ' exitosamente.');
                    location.replace('administradores.php');
                } else if (response.status === 'USER_EXISTS') {
                    $('#feedback').html('El usuario ya existe. Por favor, elija otro.');
                } else {
                    $('#feedback').html('Hubo un error al guardar el usuario. Por favor, intente más tarde.');
                }
            },
            error: function (error) {
                $('#feedback').html('Administrador no ' + actionText + '. Ha ocurrido un error.');
            }
        });
    });

    // -----------------------------------------------------------------------------------------------
    // Edit Administrador
    // -----------------------------------------------------------------------------------------------

    $('#allAdmins').on('click', '.edit-button', function ()  {
        var idAdministador = $(this).parent().attr('id');

        $('#header-title').text('Editar Administrador');
        $('#save-admin').text('Editar');

        $('ul.tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $('ul.tabs li').first().addClass('current');
        $("#tab-agregar-administrador").addClass('current');

        $('#admin-password').hide();
        $('#admin-password-confirm').hide();

        $('#cancel-edit').show();

        $.ajax({
            url: '../api/controller.php',
            type: 'POST',
            data: {
                action: 'GET_ADMINS',
                id: idAdministador
            },
            dataType: 'json',
            success: function (response) {
                var result = response.result;

                $('#email').val(result.email);
                $('#firstName').val(result.nombre);
                $('#lastName').val(result.apellidos);
                $('#username').val(result.username);

                var myURL = window.location.href.split('?')[0];
                myURL += '?id=' + result.id;
                history.pushState({}, null, myURL);
            },
            error: function (errorMsg) {
                alert('Error editando administrador.');
            }
        });
    });

    // -----------------------------------------------------------------------------------------------
    // Delete Administrador
    // -----------------------------------------------------------------------------------------------

    $('#allAdmins').on('click', '.deleteButton', function () {
        var self = this;
        if (confirmDelete('este Administrador')) {
          $.ajax({
              url: '../api/controller.php',
              type: 'POST',
              data: {
                  action: 'DELETE_ADMIN',
                  id: $(this).parent().attr('id')
              },
              dataType: 'json',
              success: function (response) {
                  alert('Administrador eliminado exitosamente.');
                  $(self).parent().remove();
              },
              error: function (errorMsg) {
                  alert('Error eliminando administrador.');
              }
          });
        }
    });

    $('#cancel-edit').on('click', function (event) {
        $('#tab-agregar-administrador').find('input').val('');
        $('#header-title').text('Agregar Administrador');
        $('#save-admin').text('Agregar');
        $('#cancel-edit').hide();
        $('#admin-password').show();
        $('#admin-password-confirm').show();

        var myURL = window.location.href.split('?')[0];
        history.pushState({}, null, myURL);

        $('ul.tabs li').removeClass('current');
        $('.tab-content').removeClass('current');

        $('ul.tabs li').last().addClass('current');
        $('#tab-view-administradores').addClass('current');
    });
});
