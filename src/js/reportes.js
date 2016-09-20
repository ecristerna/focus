'use strict';

var stateObject = {
    AGS: 'Aguascalientes',
    BC: 'Baja California',
    BCS: 'Baja California Sur',
    CAMP: 'Campeche',
    COAH: 'Coahuila',
    COL: 'Colima',
    CHIS: 'Chiapas',
    CDMX: 'Ciudad de México',
    DGO: 'Durango',
    GTO: 'Guanajuato',
    HGO: 'Hidalgo',
    JAL: 'Jalisco',
    EDOMEX: 'Estado de México',
    MICH: 'Michoacán',
    MOR: 'Morelos',
    NAY: 'Nayarit',
    NL: 'Nuevo León',
    OAX: 'Oaxaca',
    PUE: 'Puebla',
    QRO: 'Querétaro',
    QROO: 'Quintana Roo',
    SLP: 'San Luis Potosí',
    SIN: 'Sinaloa',
    TAB: 'Tabasco',
    TAM: 'Tamaulipas',
    TLAX: 'Tlaxcala',
    VER: 'Veracruz',
    YUC: 'Yucatan',
    ZAC: 'Zacatecas'
}

google.charts.load('current', {'packages': ['corechart', 'bar']});

// -----------------------------------------------------------------------------------------------
// Charts
// -----------------------------------------------------------------------------------------------

function pieChart (opciones, votes, chartNumber, title) {
    google.charts.setOnLoadCallback(drawChart);

    function drawChart () {
        var data = new google.visualization.DataTable();
        data.addColumn('string', '');
        data.addColumn('number', 'Votos');

        for (var x = 0; x < opciones.length; x++) {
            data.addRows([[opciones[x], votes[x]]]);
        }

        var options = {
            width: chartNumber === 3 ? 700 : '100%',
            height: 350,
            sliceVisibilityThreshold: 0
        };

        options.title = title;

        var chart = new google.visualization.PieChart(document.getElementById('chart' + chartNumber));
        chart.draw(data, options);
    }
}

function barChart (opciones, votes, chartNumber, title) {
    google.charts.setOnLoadCallback(drawChart);

    function drawChart() {
        var data = new google.visualization.DataTable();
        data.addColumn('string', '');
        data.addColumn('number', 'Posición Promedio');

        for (var x = 0; x < opciones.length; x++) {
            data.addRows([[opciones[x], votes[x]]]);
        }

        var options = {
            width: chartNumber === 3 ? 800 : '100%',
            height: 500,
            bar: {
                groupWidth: '61.48%',
                width: '20%'
            },
            hAxis: {
                format : '#',
                ticks : [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
                viewWindow : {
                    min : 0,
                    max : 10
                }
            }
        };

        options.title = title;

        var chart = new google.visualization.BarChart(document.getElementById('chart' + chartNumber));
        chart.draw(data, options);
    }
}

function columnChart (opciones, votes, percent, chartNumber, title) {
    google.charts.setOnLoadCallback(drawStuff);

    function drawStuff () {
        var data = new google.visualization.DataTable();
        data.addColumn('string', '');
        data.addColumn('number', 'Votos');

        for (var x = 0; x < opciones.length; x++) {
            opciones[x] += '\n(' + String((percent[x] * 100).toFixed(2)) + '%)';

            data.addRows([[opciones[x], votes[x]]]);
        }

        var options = {
            width: chartNumber === 3 ? 700 : '100%',
            height: 400,
            bar: {
                groupWidth: '11.48%',
                width: '40%'
            },
            vAxis: {format: '#%'}
        };

        options.title = title;

        var chart = new google.charts.Bar(document.getElementById('chart' + chartNumber));
        chart.draw(data, options);
    }
}

// -----------------------------------------------------------------------------------------------
// Helper Functions
// -----------------------------------------------------------------------------------------------

function getNumberofArrays (response) {
    var obj;
    var arrayCounter = 0;

    for (obj in response) {
        arrayCounter += typeof response[obj] == 'object' ? 1 : 0;
    }

    return arrayCounter
}

function convertGenderArray (genero) {
    for (var x = 0; x < genero.length; x++) {
        genero[x] = genero[x] == 'H' ? 'Hombres' : 'Mujeres';
    }

    return genero;
}

function convertAgeRange (edad) {
    for (var x = 0; x < edad.length; x++) {
        switch (edad[x]) {
            case '25':
                edad[x] = '18 - 25';
                break;
            case '35':
                edad[x] = '26 - 35';
                break;
            case '45':
                edad[x] = '36 - 45';
                break;
            case '55':
                edad[x] = '46 - 55';
                break;
            case '100':
                edad[x] = '56+';
                break;
            default:
                break;
        }
    }

    return edad;
}

function convertState (estado) {
    for (var x = 0; x < estado.length; x++) {
        estado[x] = stateObject[estado[x]];
    }

    return estado;
}

function getObjectProperties (object) {
    var properties = [];

    for (var key in object) {
        properties.push(object[key]);
    }

    return properties;
}

$(document).on('ready', function () {
    $('#reportes-header-option').addClass('selected');

    setTimeout(function (event) {
        getEncuestas('reportes');
    }, 500);

    $('#preguntas-select').hide();
    $('#edad-select').hide();
    $('#genero-select').hide();
    $('#estado-select').hide();
    $('#educacion-select').hide();
    $('#filtros-button').hide();

    $('#reportes-encuestas-select').on('change', function () {
        var idEncuesta = parseInt($(this).val(), 10);
        $('#preguntas-select').empty();
        $('#preguntas-select').hide();
        $('#edad-select').hide();
        $('#genero-select').hide();
        $('#estado-select').hide();
        $('#educacion-select').hide();
        $('#filtros-button').hide();
        $('#chart1').empty();
        $('#chart2').empty();
        $('#chart3').empty();

        if ($('#reportes-feedback').html()) {
            $('#reportes-feedback').empty();
        }

        if ($('#reportes-filtros-feedback').html()) {
            $('#reportes-filtros-feedback').empty();
        }

        if (idEncuesta < 1) {
            return;
        }

        $.ajax({
            url: '../api/controller.php',
            type: 'POST',
            data: {
                action: 'GET_PREGUNTAS',
                encuesta: idEncuesta
            },
            dataType: 'json',
            success: function (response) {
                $('#preguntas-select').show();

                var currentHTML = '<option value="-1">Selecciona una pregunta</option>';

                for (var i = 0; i < response.results.length; i++) {
                    var result = response.results[i];
                    currentHTML += '<option value="' + result.numPregunta + '">' + result.pregunta + '</option>';
                }

                currentHTML += '<option value="0">General</option>';
                $('#preguntas-select').append(currentHTML);
            },
            error: function (errorMsg) {
                $('#reportes-feedback').html('Ha ocurrido un error. Favor de intentar de nuevo.');
            }
        });
    });

    $('#preguntas-select').on('change', function () {
        var numPregunta = parseInt($(this).val(), 10);
        $('#edad-select').hide();
        $('#genero-select').hide();
        $('#estado-select').hide();
        $('#educacion-select').hide();
        $('#filtros-button').hide();

        if ($('#reportes-feedback').html()) {
            $('#reportes-feedback').empty();
        }

        if ($('#reportes-filtros-feedback').html()) {
            $('#reportes-filtros-feedback').empty();
        }

        if (numPregunta < 0) {
            $('#abiertas-table').empty();
            $('#chart1').empty();
            $('#chart2').empty();
            $('#chart3').empty();
            return;
        }

        var data = {
            action: 'REPORT_DATA',
            encuesta: parseInt($('#reportes-encuestas-select').val(), 10),
            numPregunta: numPregunta
        };

        $.ajax({
            url: '../api/controller.php',
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function (response) {
                if (response.status === 'NO_DATA') {
                    $('#reportes-feedback').html('No hay información para la encuesta y pregunta seleccionadas');
                    return;
                }

                $('#abiertas-table').empty();
                $('#chart1').empty();
                $('#chart2').empty();
                $('#chart3').empty();

                if (response.tipo !== 1) {
                    // Show filter options with default values
                    $('#edad-select').show();
                    $('#edad-select').val('0');

                    $('#genero-select').show();
                    $('#genero-select').val('-1');

                    $('#estado-select').show();
                    $('#estado-select').val('0');

                    $('#educacion-select').show();
                    $('#educacion-select').val('0');

                    $('#filtros-button').show();

                    $('#abiertas-table').hide();
                }

                if (numPregunta === 0) {
                    //General
                    $('#edad-select').hide();
                    $('#genero-select').hide();
                    $('#estado-select').hide();
                    $('#educacion-select').hide();
                    $('#filtros-button').hide();

                    pieChart(convertGenderArray(Object.keys(response.genero)),
                            getObjectProperties(response.genero),
                            1, 'Género');
                    pieChart(convertAgeRange(Object.keys(response.edad)),
                            getObjectProperties(response.edad),
                            2, 'Edad');
                    columnChart(convertState(Object.keys(response.estado)),
                            getObjectProperties(response.estado),
                            getObjectProperties(response.estadoPercentage),
                            3, 'Estado');

                } else {
                    if (response.tipo === 1) {
                        var html = '';
                        $('#abiertas-table').show();
                        for (var i = 0; i < response.votos.length; i++) {
                            var even = i % 2 === 0;
                            html += (even ? '<tr>' : '') + '<td>' + response.votos[i] + '</td>' + (even ? '' : '</tr>');
                        }

                        $('#abiertas-table').append(html);
                    } else if (response.tipo === 4) {
                        barChart(getObjectProperties(response.opciones), response.porcentajes, 1, '');
                    } else if (response.opciones.length < 4) {
                        pieChart(getObjectProperties(response.opciones), response.votos, 1, '');
                    } else {
                        columnChart(getObjectProperties(response.opciones), response.votos, response.porcentajes, 1, '');
                    }
                }
            },
            error: function (errorMsg) {
                $('#reportes-feedback').html('Ha ocurrido un error. Favor de intentar de nuevo.');
            }
        });
    });

    $('#filtros-button').on('click', function () {
        var edad = parseInt($('#edad-select').val(), 10);
        var estado = $('#estado-select').val();
        var genero = parseInt($('#genero-select').val(), 10);
        var educacion = parseInt($('#educacion-select').val(), 10);

        if (edad === 0 && estado === '0' && genero === -1 && educacion === 0) {
            $('#chart2').empty();
            $('#reportes-filtros-feedback').html('Seleccione al menos un filtro a aplicar');
            return;
        }

        var data = {
            action: 'REPORT_DATA',
            encuesta: parseInt($('#reportes-encuestas-select').val(), 10),
            numPregunta: parseInt($('#preguntas-select').val(), 10)
        };

        if (edad > 0) {
            data.edad = edad;
        }

        if (estado !== '0') {
            data.estado = estado;
        }

        if (genero > -1) {
            data.genero = genero;
        }

        if (educacion > 0) {
            data.educacion = educacion;
        }

        $.ajax({
            url: '../api/controller.php',
            type: 'POST',
            data: data,
            dataType: 'json',
            success: function (response) {
                $('#chart2').empty();

                if (response.status === 'NO_DATA') {
                    $('#reportes-filtros-feedback').html('No hay información para los filtros seleccionados');
                    return;
                }

                if (response.tipo === 4) {
                    barChart(getObjectProperties(response.opciones), response.porcentajes, 2, '');
                } else if (response.opciones.length < 4) {
                    pieChart(getObjectProperties(response.opciones), response.votos, 2, '');
                } else {
                    columnChart(getObjectProperties(response.opciones), response.votos, response.porcentajes, 2, '');
                }

                return;
            },
            error: function (errorMsg) {
                $('#reportes-feedback').html('Ha ocurrido un error. Favor de intentar de nuevo.');
            }
        });
    });

    $('#edad-select').on('change', function () {
        if ($('#reportes-filtros-feedback').html()) {
            $('#reportes-filtros-feedback').empty();
        }
    });

    $('#genero-select').on('change', function () {
        if ($('#reportes-filtros-feedback').html()) {
            $('#reportes-filtros-feedback').empty();
        }
    });

    $('#estado-select').on('change', function () {
        if ($('#reportes-filtros-feedback').html()) {
            $('#reportes-filtros-feedback').empty();
        }
    });

    $('#educacion-select').on('change', function () {
        if ($('#reportes-filtros-feedback').html()) {
            $('#reportes-filtros-feedback').empty();
        }
    });
});
