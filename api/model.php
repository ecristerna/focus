<?php

date_default_timezone_set('America/Mexico_City');

function connect() {
    // servername, username, password, dbname
    $connection = new mysqli('localhost', 'root', 'root', 'focus');
    $connection->set_charset('utf8');

    # Check connection
    if ($connection->connect_error) {
        return null;
    }

    return $connection;
}

// -------------------------------
// Log In
// -------------------------------

function validateWebCredentials ($username, $password) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username, nombre, apellidos, email, tipo FROM Usuario WHERE username = '$username' AND password = '$password'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'SUCCESS', 'id' => (int)$row['id'], 'tipo' => (int)$row['tipo'], 'username' => $row['username'], 'email' => $row['email'], 'nombre' => $row['nombre'], 'apellidos' => $row['apellidos']);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function validatePanelistaCredentials ($username, $password) {
    $conn = connect();

    if ($conn != null) {
        $sql0 = "SELECT id, username, genero, email, nombre, apellidos FROM Panelista WHERE username = '$username' AND password = '$password'";
        $result0 = $conn->query($sql0);

        if ($result0->num_rows > 0) {
            $row0 = $result0->fetch_assoc();
            $panelista = $row0['id'];

            $conn->close();
            $response = array('status' => 'SUCCESS', 'id' => (int)$row0['id'], 'username' => $row0['username'], 'genero' => (int)$row0['genero'], 'email' => $row0['email'], 'nombre' => $row0['nombre']." ".$row0['apellidos']);
            $paneles = fetchMobileData($panelista);

            return array_merge($response, $paneles);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Registration
// -------------------------------

function registerUser ($tipo, $username, $password, $nombre, $apellidos, $email) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username FROM Usuario WHERE username = '$username'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'USER_EXISTS', 'id' => (int)$row['id'], 'username' => $row['username']);
        }

        $sql = "INSERT INTO Usuario (username, password, nombre, apellidos, email, tipo) VALUES ('$username', '$password', '$nombre', '$apellidos', '$email', '$tipo')";

        if ($conn->query($sql) === TRUE) {
            $lastId = mysqli_insert_id($conn);
            $conn->close();
            return array('status' => 'SUCCESS', 'id' => $lastId);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function registerPanelista ($username, $password, $nombre, $apellidos, $email, $genero, $fechaNacimiento, $educacion, $calleNumero, $colonia, $municipio, $estado, $cp) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username, email FROM Panelista WHERE username = '$username' OR email = '$email'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'USER_EXISTS', 'id' => (int)$row['id'], 'username' => $row['username'], 'email' => $row['email']);
        }

        $date = date('Y-m-d');

        $sql = "INSERT INTO Panelista (username, password, nombre, apellidos, email, genero, fechaNacimiento, educacion, calleNumero, colonia, municipio, estado, cp, fechaRegistro) VALUES ('$username', '$password', '$nombre', '$apellidos', '$email', '$genero', '$fechaNacimiento', '$educacion', '$calleNumero', '$colonia', '$municipio', '$estado', '$cp', '$date')";

        if ($conn->query($sql) === TRUE) {
            $lastId = mysqli_insert_id($conn);
            $conn->close();
            return array('status' => 'SUCCESS', 'id' => $lastId);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function registerPanel ($nombre, $descripcion, $fechaInicio, $fechaFin, $numParticipantes, $cliente, $creador) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre FROM Panel WHERE nombre = '$nombre'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'RECORD_EXISTS', 'id' => (int)$row['id'], 'nombre' => $row['nombre']);
        }

        $sql = "INSERT INTO Panel (nombre, descripcion, fechaInicio, fechaFin, numParticipantes, cliente, creador) VALUES ('$nombre', '$descripcion', '$fechaInicio', '$fechaFin', '$numParticipantes', $cliente, '$creador')";

        if ($conn->query($sql) === TRUE) {
            $lastId = mysqli_insert_id($conn);
            $conn->close();
            return array('status' => 'SUCCESS', 'id' => $lastId, 'numParticipantes' => (int)$numParticipantes);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function registerEncuesta ($nombre, $fechaInicio, $fechaFin, $panel) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, panel FROM Encuesta WHERE nombre = '$nombre' AND panel = '$panel'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'RECORD_EXISTS', 'id' => (int)$row['id'], 'nombre' => $row['nombre'], 'panel' => (int)$row['panel']);
        }

        $sql = "INSERT INTO Encuesta (nombre, fechaInicio, fechaFin, panel) VALUES ('$nombre', '$fechaInicio', '$fechaFin', '$panel')";

        if ($conn->query($sql) === TRUE) {
            $encuestaId = mysqli_insert_id($conn);
            registerEncuestaHistory($encuestaId, $nombre, $fechaInicio, $fechaFin, $panel);

            return array('status' => 'SUCCESS', 'id' => $encuestaId);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function registerEncuestaHistory ($encuesta, $nombreEncuesta, $fechaInicioEncuesta, $fechaFinEncuesta, $panel) {
    $conn = connect();

    if ($conn != null) {
        $nombrePanelista = '';
        $nombrePanel = '';
        $fechaInicioPanel = NULL;
        $fechaFinPanel = NULL;

        $sql = "SELECT nombre, fechaInicio, fechaFin FROM Panel WHERE id = '$panel'";
        $result = $conn->query($sql);
        if ($row = $result->fetch_assoc()) {
            $nombrePanel = $row['nombre'];
            $fechaInicioPanel = $row['fechaInicio'];
            $fechaFinPanel = $row['fechaFin'];
        }

        $sql = "SELECT Panelista.id, Panelista.nombre, Panelista.apellidos, PanelistaEnPanel.estado FROM Panelista INNER JOIN PanelistaEnPanel ON Panelista.id = PanelistaEnPanel.panelista WHERE PanelistaEnPanel.panel = '$panel'";
        $result = $conn->query($sql);
        while ($row = $result->fetch_assoc()) {
            $panelista = $row['id'];
            $nombrePanelista = $row['nombre'].' '.$row['apellidos'];
            $estado = $row['estado'];

            $sql2 = "INSERT INTO Historial (panelista, nombrePanelista, panel, nombrePanel, fechaInicioPanel, fechaFinPanel, encuesta, nombreEncuesta, fechaInicioEncuesta, fechaFinEncuesta, estado) VALUES ('$panelista', '$nombrePanelista', '$panel', '$nombrePanel', '$fechaInicioPanel', '$fechaFinPanel', '$encuesta', '$nombreEncuesta', '$fechaInicioEncuesta', '$fechaFinEncuesta', '$estado')";
            $conn->query($sql2);
        }

        $conn->close();
        return array('status' => 'SUCCESS');
    }

    return array('status' => 'DATABASE_ERROR');
}

function registerResource ($nombre, $tipo) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre FROM Recurso WHERE nombre = '$nombre'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'RECORD_EXISTS', 'id' => (int)$row['id'], 'nombre' => $row['nombre']);
        }

        $sql = "INSERT INTO Recurso (nombre, tipo) VALUES ('$nombre', '$tipo')";

        if ($conn->query($sql) === TRUE) {
            $lastId = mysqli_insert_id($conn);
            $conn->close();
            return array('status' => 'SUCCESS', 'id' => $lastId);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function changePanelistaPassword ($panelista, $old, $new) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, password FROM Panelista WHERE id = '$panelista'";
        $result = $conn->query($sql);

        if ($result->num_rows <= 0) {
            return array('status' => 'WRONG_USER');
        } else {
            $row = $result->fetch_assoc();

            if ($old != $row['password']) {
                return array('status' => 'WRONG_PASSWORD');
            }
        }

        $sql2 = "UPDATE Panelista SET password = '$new' WHERE id = '$panelista'";

        if ($conn->query($sql2) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }
    }

    return array('status' => 'DATABASE_ERROR');
}

function invitationResponse ($panelista, $panel, $estado) {
    $conn = connect();

    if ($conn != null) {
        $sql = "UPDATE PanelistaEnPanel SET estado = '$estado' WHERE panelista = '$panelista' AND panel = '$panel'";
        $conn->query($sql);

        $sql = "UPDATE Historial SET estado = '$estado' WHERE panelista = '$panelista' AND panel = '$panel'";
        $conn->query($sql);

        return array('status' => 'SUCCESS', 'panel' => $panel, 'estado' => $estado);
    }

    return array('status' => 'DATABASE_ERROR');
}

function updateEncuestaStatus ($idEncuesta, $panel, $publish) {
    $conn = connect();

    if ($conn != null) {
        $sql = "UPDATE Encuesta SET disponible = '$publish' WHERE id = '$idEncuesta'";
        $tokens = array();

        if ($conn->query($sql) === TRUE && $publish === 1) {
            $sql2 = "SELECT deviceToken FROM Panelista INNER JOIN PanelistaEnPanel ON Panelista.id = PanelistaEnPanel.panelista WHERE PanelistaEnPanel.estado = 1 AND PanelistaEnPanel.panel = '$panel' AND Panelista.deviceToken != ''";

            $result = $conn->query($sql2);
            while ($row = $result->fetch_assoc()) {
                array_push($tokens, $row['deviceToken']);
            }
        }

        $conn->close();
        return array('status' => 'SUCCESS', 'encuesta' => $idEncuesta, 'panel' => $panel, 'disponible' => $publish, 'deviceTokens' => $tokens);
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Fetch
// -------------------------------

function fetchUsers ($tipo) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username, nombre, apellidos, email FROM Usuario WHERE tipo = '$tipo'";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $user = array('id' => (int)$row['id'], 'username' => $row['username'], 'email' => $row['email'], 'nombre' => $row['nombre'], 'apellidos' => $row['apellidos']);
            $response[] = $user;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchUser ($tipo, $id) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username, nombre, apellidos, email FROM Usuario WHERE tipo = '$tipo' AND id = '$id'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $user = array('id' => (int)$row['id'], 'username' => $row['username'], 'email' => $row['email'], 'nombre' => $row['nombre'], 'apellidos' => $row['apellidos']);
        }

        $conn->close();
        return array('result' => $user);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchPaneles () {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, fechaInicio, fechaFin, numParticipantes, cliente FROM Panel ORDER BY fechaInicio DESC, id DESC";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $cliente = $row['cliente'];
            $sql2 = "SELECT nombre, apellidos FROM Usuario WHERE id = '$cliente'";
            $result2 = $conn->query($sql2);
            $row2 = $result2->fetch_assoc();

            $panel = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'numParticipantes' => $row['numParticipantes'], 'cliente' => $row2['nombre'].' '.$row2['apellidos']);
            $response[] = $panel;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchPanelesForCliente ($client) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, fechaInicio, fechaFin, numParticipantes, cliente FROM Panel WHERE cliente = '$client' ORDER BY fechaInicio DESC, id DESC";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $cliente = $row['cliente'];
            $sql2 = "SELECT nombre, apellidos FROM Usuario WHERE id = '$cliente'";
            $result2 = $conn->query($sql2);
            $row2 = $result2->fetch_assoc();

            $panel = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'numParticipantes' => $row['numParticipantes'], 'cliente' => $row2['nombre'].' '.$row2['apellidos']);
            $response[] = $panel;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchPanel ($id) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, descripcion, fechaInicio, fechaFin, numParticipantes, cliente FROM Panel WHERE id = '$id'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $panel = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'descripcion' => $row['descripcion'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'numParticipantes' => (int)$row['numParticipantes'], 'cliente' => (int)$row['cliente'], 'creador' => (int)$row['creador']);
        }

        $conn->close();
        return array('result' => $panel);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchPanelistas () {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, apellidos, email, username, genero, TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) AS edad, educacion, calleNumero, colonia, municipio, estado, cp, fechaRegistro FROM Panelista ORDER BY fechaRegistro DESC";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $idPanelista = (int)$row['id'];
            $panelesCount = panelistaPanelesCount($idPanelista);

            $panelista = array('id' => $idPanelista, 'username' => $row['username'], 'nombre' => $row['nombre'], 'apellidos' => $row['apellidos'], 'email' => $row['email'], 'genero' => (int)$row['genero'], 'edad' => (int)$row['edad'], 'educacion' => (int)$row['educacion'], 'calleNumero' => $row['calleNumero'], 'colonia' => $row['colonia'], 'municipio' => $row['municipio'], 'estado' => $row['estado'], 'cp' => (int)$row['cp'], 'fechaRegistro' => $row['fechaRegistro'], 'paneles' => (int)$panelesCount);
            $response[] = $panelista;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function panelistaPanelesCount ($panelista) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT COUNT(DISTINCT panel) AS count FROM Historial WHERE panelista = '$panelista'";
        $result = $conn->query($sql);
        $row = $result->fetch_assoc();

        $conn->close();
        return $row['count'];
    }

    return 0;
}

function fetchPanelista ($id) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username, nombre, apellidos, email, genero, fechaNacimiento, educacion, calleNumero, colonia, municipio, estado, cp FROM Panelista WHERE id = '$id'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $panelista = array('id' => (int)$row['id'], 'username' => $row['username'], 'nombre' => $row['nombre'], 'apellidos' => $row['apellidos'], 'email' => $row['email'], 'genero' => (int)$row['genero'], 'edad' => (int)$row['edad'], 'fechaNacimiento' => $row['fechaNacimiento'], 'educacion' => (int)$row['educacion'], 'calleNumero' => $row['calleNumero'], 'colonia' => $row['colonia'], 'municipio' => $row['municipio'], 'estado' => $row['estado'], 'cp' => (int)$row['cp']);
        }

        $conn->close();
        return array('result' => $panelista);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchEncuestas () {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, fechaInicio, fechaFin, panel, disponible FROM Encuesta ORDER BY fechaInicio DESC, id DESC";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $panel = $row['panel'];
            $sql2 = "SELECT nombre FROM Panel WHERE id = '$panel'";
            $result2 = $conn->query($sql2);
            $row2 = $result2->fetch_assoc();

            $encuesta = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'panel' => $row2['nombre'], 'disponible' => $row['disponible']);
            $response[] = $encuesta;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchEncuestasForPanel ($panel) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, fechaInicio, fechaFin, panel, disponible FROM Encuesta WHERE panel = '$panel' ORDER BY fechaInicio DESC, id DESC";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $panel = $row['panel'];
            $sql2 = "SELECT nombre FROM Panel WHERE id = '$panel'";
            $result2 = $conn->query($sql2);
            $row2 = $result2->fetch_assoc();

            $encuesta = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'panel' => $row2['nombre'], 'disponible' => $row['disponible']);
            $response[] = $encuesta;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchEncuestasForCliente ($cliente) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT Encuesta.id as id, Encuesta.nombre as nombre, Encuesta.fechaInicio as fechaInicio, Encuesta.fechaFin as fechaFin, panel, disponible FROM Encuesta INNER JOIN Panel ON Encuesta.panel = Panel.id WHERE Panel.cliente = '$cliente'";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $panel = $row['panel'];
            $sql2 = "SELECT nombre FROM Panel WHERE id = '$panel'";
            $result2 = $conn->query($sql2);
            $row2 = $result2->fetch_assoc();

            $encuesta = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'panel' => $row2['nombre'], 'disponible' => $row['disponible']);
            $response[] = $encuesta;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchEncuesta ($id) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, fechaInicio, fechaFin, panel, disponible FROM Encuesta WHERE id = '$id'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $panel = $row['panel'];
            $sql2 = "SELECT id FROM Panel WHERE id = '$panel'";
            $result2 = $conn->query($sql2);
            $row2 = $result2->fetch_assoc();

            $encuesta = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'panel' => $row2['id'], 'disponible' => $row['disponible']);
        }

        $conn->close();
        return array('result' => $encuesta);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchPanelistasPanel ($panel) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, apellidos, genero, TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) AS edad, educacion, fechaRegistro, municipio, estado FROM Panelista ORDER BY fechaRegistro DESC";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $id = $row['id'];
            $sql2 = "SELECT id FROM PanelistaEnPanel WHERE panel = '$panel' AND panelista = '$id'";
            $result2 = $conn->query($sql2);
            $checked = FALSE;
            $panelesCount = panelistaPanelesCount($id);

            if ($result2->num_rows > 0) {
                $checked = TRUE;
            }

            $panelista = array('id' => (int)$row['id'], 'nombre' => $row['nombre'] . ' ' . $row['apellidos'], 'genero' => (int)$row['genero'], 'edad' => (int)$row['edad'], 'educacion' => (int)$row['educacion'], 'fechaRegistro' => $row['fechaRegistro'], 'municipio' => $row['municipio'], 'estado' => $row['estado'], 'checked' => $checked, 'paneles' => (int)$panelesCount);
            $response[] = $panelista;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchPreguntasEncuesta ($encuesta) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT * FROM Pregunta WHERE encuesta = '$encuesta'";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $opciones = explode('&', $row['opciones']);
            $opciones = array_filter($opciones, 'emptyString');

            $subPreguntas = explode('&', $row['subPreguntas']);
            $subPreguntas = array_filter($subPreguntas, 'emptyString');

            $pregunta = array('id' => (int)$row['id'], 'encuesta' => (int)$encuesta, 'numPregunta' => (int)$row['numPregunta'], 'titulo' => $row['titulo'], 'tipo' => (int)$row['tipo'], 'pregunta' => $row['pregunta'], 'video' => $row['video'], 'imagen' => $row['imagen'], 'combo' => $row['combo'], 'opciones' => $opciones, 'subPreguntas' => $subPreguntas);
            $response[] = $pregunta;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchMobileData ($panelista) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT Panel.id, Panel.nombre, Panel.fechaInicio, Panel.fechaFin, Panel.descripcion, PanelistaEnPanel.estado FROM Panel INNER JOIN PanelistaEnPanel ON Panel.id = PanelistaEnPanel.panel WHERE PanelistaEnPanel.estado != 2 AND Panel.fechaInicio <= CURDATE() AND Panel.fechaFin >= CURDATE() AND PanelistaEnPanel.panelista = '$panelista' ORDER BY Panel.fechaInicio DESC, Panel.id DESC";
        $result = $conn->query($sql);

        $paneles = array();

        while ($row = $result->fetch_assoc()) {
            $panelId = $row['id'];
            $sql2 = "SELECT id, nombre, fechaInicio, fechaFin FROM Encuesta WHERE disponible = '1' AND panel = '$panelId' AND fechaInicio <= CURDATE() AND fechaFin >= CURDATE() ORDER BY fechaInicio DESC, id DESC";
            $result2 = $conn->query($sql2);

            $encuestas = array();

            while ($row2 = $result2->fetch_assoc()) {
                $encuestaId = $row2['id'];
                $sql3 = "SELECT id, tipo, numPregunta, titulo, pregunta, video, imagen, combo, opciones, subPreguntas FROM Pregunta WHERE encuesta = '$encuestaId' ORDER BY numPregunta";
                $result3 = $conn->query($sql3);

                $preguntas = array();

                while ($row3 = $result3->fetch_assoc()) {
                    $opciones = explode('&', $row3['opciones']);
                    $opciones = array_filter($opciones, 'emptyString');

                    $subPreguntas = explode('&', $row3['subPreguntas']);
                    $subPreguntas = array_filter($subPreguntas, 'emptyString');

                    $asCombo = (int)$row3['combo'] === 0 ? FALSE : TRUE;

                    $pregunta = array('id' => (int)$row3['id'], 'tipo' => (int)$row3['tipo'], 'numPregunta' => (int)$row3['numPregunta'], 'titulo' => $row3['titulo'], 'pregunta' => $row3['pregunta'], 'video' => $row3['video'], 'imagen' => $row3['imagen'], 'combo' => $asCombo, 'opciones' => $opciones, 'subPreguntas' => $subPreguntas);
                    $preguntas[] = $pregunta;
                }

                $contestada = FALSE;

                $sql4 = "SELECT id FROM Respuesta WHERE encuesta = '$encuestaId' AND panelista = '$panelista'";
                $result4 = $conn->query($sql4);

                if ($result4->num_rows > 0) {
                    $contestada = TRUE;
                }

                if ($panelista == 1) {
                    $contestada = FALSE;
                }

                $encuesta = array('id' => (int)$row2['id'], 'nombre' => $row2['nombre'], 'fechaInicio' => $row2['fechaInicio'], 'fechaFin' => $row2['fechaFin'], 'contestada' => $contestada, 'preguntas' => $preguntas);
                $encuestas[] = $encuesta;
            }

            $panel = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'descripcion' => $row['descripcion'], 'estado' => (int)$row['estado'], 'encuestas' => $encuestas);
            $paneles[] = $panel;
        }

        $conn->close();
        return array('paneles' => $paneles);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchHistorial ($panelista) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT nombrePanel, fechaInicioPanel, fechaFinPanel, nombreEncuesta, fechaInicioEncuesta, fechaFinEncuesta, fechaRespuesta, horaRespuesta FROM Historial WHERE panelista = '$panelista' AND encuesta != 0 AND estado != 0";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $record = array('nombrePanel' => $row['nombrePanel'], 'fechaInicioPanel' => $row['fechaInicioPanel'], 'fechaFinPanel' => $row['fechaFinPanel'], 'nombreEncuesta' => $row['nombreEncuesta'], 'fechaInicioEncuesta' => $row['fechaInicioEncuesta'], 'fechaFinEncuesta' => $row['fechaFinEncuesta'], 'fechaRespuesta' => $row['fechaRespuesta'], 'horaRespuesta' => $row['horaRespuesta']);
            $response[] = $record;
        }

        $conn->close();
        return array('status' => 'SUCCESS', 'results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function emptyString ($string) {
    return($string !== '');
}

function fetchPanelistaPassword ($username, $email) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username, email, nombre, password FROM Panelista WHERE username = '$username' OR email = '$email'";
        $result = $conn->query($sql);

        if ($result->num_rows <= 0) {
            return array('status' => 'WRONG_USER');
        } else {
            $row = $result->fetch_assoc();

            return array('status' => 'SUCCESS', 'id' => (int)$row['id'], 'username' => $row['username'], 'email' => $row['email'], 'nombre' => $row['nombre'], 'password' => $row['password']);
        }
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Save
// -------------------------------

function savePanelistasPanel ($panel, $panelistas) {
    $conn = connect();

    $added = 0;
    $deleted = 0;

    if ($conn != null) {
        $sql = "SELECT panelista FROM PanelistaEnPanel WHERE panel = '$panel'";
        $result = $conn->query($sql);

        $currentIds = array();
        $tokens = array();

        while ($row = $result->fetch_assoc()) {
            $currentIds[] = (int)$row['panelista'];
        }

        for ($i = 0; $i < count($currentIds); $i++) {
            $panelista = $currentIds[$i];

            if (!in_array($panelista, $panelistas)) {
                $sql = "DELETE FROM PanelistaEnPanel WHERE panel = '$panel' AND panelista = '$panelista'";
                $conn->query($sql);
                $deleted += 1;
            }
        }

        for ($i = 0; $i < count($panelistas); $i++) {
            $panelista = $panelistas[$i];

            if (!in_array($panelista, $currentIds)) {
                $sql = "INSERT INTO PanelistaEnPanel (panelista, panel, estado) VALUES ('$panelista', '$panel', 0)";
                $sql2 = "SELECT deviceToken FROM Panelista WHERE id = '$panelista' AND deviceToken != ''";

                $conn->query($sql);

                $result = $conn->query($sql2);
                if ($row = $result->fetch_assoc()) {
                    array_push($tokens, $row['deviceToken']);
                }

                $added += 1;

                addToHistory($panelista, $panel);
            }
        }

        $conn->close();
        return array('status' => 'SUCCESS', 'added' => $added, 'deleted' => $deleted, 'deviceTokens' => $tokens);
    }

    return array('status' => 'DATABASE_ERROR');
}

function addToHistory ($panelista, $panel) {
    $conn = connect();

    if ($conn != null) {
        $nombrePanelista = '';
        $nombrePanel = '';
        $fechaInicioPanel = NULL;
        $fechaFinPanel = NULL;

        $sql = "SELECT nombre, apellidos FROM Panelista WHERE id = '$panelista'";
        $result = $conn->query($sql);
        if ($row = $result->fetch_assoc()) {
            $nombrePanelista = $row['nombre'].' '.$row['apellidos'];
        }

        $sql = "SELECT nombre, fechaInicio, fechaFin FROM Panel WHERE id = '$panel'";
        $result = $conn->query($sql);
        if ($row = $result->fetch_assoc()) {
            $nombrePanel = $row['nombre'];
            $fechaInicioPanel = $row['fechaInicio'];
            $fechaFinPanel = $row['fechaFin'];
        }

        $sql = "INSERT INTO Historial (panelista, nombrePanelista, panel, nombrePanel, fechaInicioPanel, fechaFinPanel, estado) VALUES ('$panelista', '$nombrePanelista', '$panel', '$nombrePanel', '$fechaInicioPanel', '$fechaFinPanel', 0)";
        $conn->query($sql);

        $sql = "SELECT id, nombre, fechaInicio, fechaFin FROM Encuesta WHERE panel = '$panel'";
        $result = $conn->query($sql);

        while ($row = $result->fetch_assoc()) {
            $encuesta = $row['id'];
            $nombreEncuesta = $row['nombre'];
            $fechaInicioEncuesta = $row['fechaInicio'];
            $fechaFinEncuesta = $row['fechaFin'];

            $sql = "INSERT INTO Historial (panelista, nombrePanelista, panel, nombrePanel, fechaInicioPanel, fechaFinPanel, encuesta, nombreEncuesta, fechaInicioEncuesta, fechaFinEncuesta, estado) VALUES ('$panelista', '$nombrePanelista', '$panel', '$nombrePanel', '$fechaInicioPanel', '$fechaFinPanel', '$encuesta', '$nombreEncuesta', '$fechaInicioEncuesta', '$fechaFinEncuesta', 0)";
            $conn->query($sql);
        }

        $conn->close();
        return array('status' => 'SUCCESS');
    }

    return array('status' => 'DATABASE_ERROR');
}

function savePreguntasEncuesta ($encuesta, $preguntas) {
    $conn = connect();

    $inserts = 0;
    $errors = 0;
    $deletes = 0;

    if ($conn != null) {
        $sql = "SELECT * FROM Pregunta WHERE encuesta = '$encuesta'";
        $result = $conn->query($sql);
        $deletes = $result->num_rows;
        $sql = "DELETE FROM Pregunta WHERE encuesta = '$encuesta'";
        $result = $conn->query($sql);

        foreach ($preguntas as &$pregunta) {
            $titulo = $pregunta['titulo'];
            $tipo = $pregunta['tipo'];
            $numPregunta = $pregunta['numPregunta'];
            $preguntaText = $pregunta['pregunta'];
            $video = $pregunta['video'];
            $imagen = $pregunta['imagen'];
            $combo = $pregunta['combo'];
            $opciones = $pregunta['opciones'];
            $subPreguntas = $pregunta['subPreguntas'];

            $opcionesString = "";
            $subPreguntasString = "";
            $numOpciones = count($opciones);
            $numSubPreguntas = count($subPreguntas);

            for ($x = 0; $x < $numOpciones; $x++) {
                $opcionesString = $opcionesString.$opciones[$x]."&";
            }

            for ($x = 0; $x < $numSubPreguntas; $x++) {
                $subPreguntasString = $subPreguntasString.$subPreguntas[$x]."&";
            }

            $opcionesString = rtrim($opcionesString, "&");
            $subPreguntasString = rtrim($subPreguntasString, "&");

            $sql = "INSERT INTO Pregunta (encuesta, tipo, numPregunta, pregunta, video, imagen, numOpciones, numSubPreguntas, titulo, combo, opciones, subPreguntas) VALUES ('$encuesta', $tipo, '$numPregunta', '$preguntaText', '$video', '$imagen', '$numOpciones', '$numSubPreguntas', '$titulo', '$combo', '$opcionesString', '$subPreguntasString')";

            if ($conn->query($sql) === TRUE) {
                $inserts = $inserts + 1;
            } else {
                $errors = $errors + 1;
            }
        }

        $deletes = $deletes - $errors - $inserts;

        $conn->close();
        return array('status' => 'SUCCESS', 'inserts' => $inserts, 'errors' => $errors, 'deletes' => $deletes);
    }

    return array('status' => 'DATABASE_ERROR');
}

function startEncuesta ($encuesta, $panelista) {
    $conn = connect();

    if ($conn != null) {
        $date = date('Y-m-d');
        $hour = date('H:i:s');

        $sql = "INSERT INTO Respuesta (encuesta, panelista, fechaIni, horaIni) VALUES ('$encuesta', '$panelista', '$date', '$hour')";

        if ($conn->query($sql) === TRUE) {
            $lastId = mysqli_insert_id($conn);
            $conn->close();
            return array('status' => 'SUCCESS', 'id' => $lastId);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function saveRespuestas ($id, $respuestas, $panelista, $encuesta) {
    $conn = connect();

    if ($conn != null) {
        $date = date('Y-m-d');
        $hour = date('H:i:s');

        $sql = "UPDATE Respuesta SET respuestas = '$respuestas', fechaFin = '$date', horaFin = '$hour' WHERE id = '$id'";
        $conn->query($sql);

        $sql = "UPDATE Historial SET fechaRespuesta = '$date', horaRespuesta = '$hour' WHERE panelista = '$panelista' AND encuesta = '$encuesta'";
        $conn->query($sql);

        $conn->close();
        return array('status' => 'SUCCESS');
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Update
// -------------------------------

function updatePanelista ($id, $username, $nombre, $apellidos, $email, $genero, $fechaNacimiento, $educacion, $calleNumero, $colonia, $municipio, $estado, $cp) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username, email FROM Panelista WHERE username = '$username' OR email = '$email'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            if ((int)$row['id'] != $id) {
                $conn->close();
                return array('status' => 'USER_EXISTS', 'id' => (int)$row['id'], 'username' => $row['username'], 'email' => $row['email']);
            }
        }

        $sql = "UPDATE Panelista SET username = '$username', nombre = '$nombre', apellidos = '$apellidos', email = '$email', genero = '$genero', fechaNacimiento = '$fechaNacimiento', educacion = '$educacion', calleNumero = '$calleNumero', colonia = '$colonia', municipio = '$municipio', estado = '$estado', cp = '$cp' WHERE id = '$id'";

        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function updateUser ($id, $username, $nombre, $apellidos, $email) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username FROM Usuario WHERE username = '$username'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            if ((int)$row['id'] != $id) {
                $conn->close();
                return array('status' => 'USER_EXISTS', 'id' => (int)$row['id'], 'username' => $row['username']);
            }
        }

        $sql = "UPDATE Usuario SET username = '$username', nombre = '$nombre', apellidos = '$apellidos', email = '$email' WHERE id = '$id'";

        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function updatePanel ($id, $nombre, $descripcion, $fechaInicio, $fechaFin, $numParticipantes, $cliente) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre FROM Panel WHERE nombre = '$nombre'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            if ((int)$row['id'] != $id) {
                $conn->close();
                return array('status' => 'RECORD_EXISTS', 'id' => (int)$row['id'], 'nombre' => $row['nombre']);
            }
        }

        $sql = "UPDATE Panel SET nombre = '$nombre', descripcion = '$descripcion', fechaInicio = '$fechaInicio', fechaFin = '$fechaFin', numParticipantes = '$numParticipantes', cliente = '$cliente' WHERE id = '$id'";

        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function updateEncuesta ($id, $nombre, $fechaInicio, $fechaFin, $panel) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, panel FROM Encuesta WHERE nombre = '$nombre' AND panel = '$panel'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            if ((int)$row['id'] != $id) {
                $conn->close();
                return array('status' => 'RECORD_EXISTS', 'id' => (int)$row['id'], 'nombre' => $row['nombre'], 'panel' => (int)$row['panel']);
            }
        }

        $sql = "UPDATE Encuesta SET nombre = '$nombre', fechaInicio = '$fechaInicio', fechaFin = '$fechaFin', panel = '$panel' WHERE id = '$id'";

        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Delete
// -------------------------------

function removeRecord ($id, $table) {
    $conn = connect();

    if ($conn != null) {
        $sql = "DELETE FROM $table WHERE id = '$id'";

        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Devices
// -------------------------------

function registerDeviceToken ($id, $token, $type) {
    $conn = connect();

    if ($conn != null) {
        $sql = "UPDATE Panelista SET deviceToken = '$token', deviceType = '$type' WHERE id = '$id'";

        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function unregisterDeviceToken ($id) {
    $conn = connect();

    if ($conn != null) {
        $sql = "UPDATE Panelista SET deviceToken = '', deviceType = '' WHERE id = '$id'";

        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Reports
// -------------------------------

function getSummary ($encuesta) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT COUNT(*) as total FROM Panelista INNER JOIN PanelistaEnPanel ON Panelista.id = PanelistaEnPanel.panelista WHERE PanelistaEnPanel.estado = 1 AND PanelistaEnPanel.panel = (SELECT panel FROM Encuesta WHERE id = '$encuesta')";
        $result = $conn->query($sql);
        $total = 0;
        $answers = 0;

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $total = (int)$row['total'];
        }

        if ($total === 0) {
            $conn->close();
            return array('status' => 'NO_DATA');
        }

        $sql = "SELECT COUNT(*) as answers, Encuesta.fechaInicio, Encuesta.fechaFin, TIMESTAMPDIFF(DAY, CURDATE(), Encuesta.fechaFin) AS dias FROM Respuesta INNER JOIN Encuesta ON Respuesta.encuesta = Encuesta.id WHERE Respuesta.encuesta = '$encuesta'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $answers = (int)$row['answers'];
        }

        return array('status' => 'SUCCESS', 'respuestas' => $answers, 'porcentaje' => $answers / $total, 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'dias' => (int)$row['dias']);
    }

    return array('status' => 'DATABASE_ERROR');
}

function generalReportData ($encuesta) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT panel FROM Encuesta WHERE id = '$encuesta'";
        $result = $conn->query($sql);
        $panel = 0;

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $panel = (int)$row['panel'];
        }

        $sql = "SELECT COUNT(*) as total FROM PanelistaEnPanel WHERE panel = '$panel' AND estado = 1";
        $result = $conn->query($sql);
        $total = 0;
        $answers = 0;

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $total = (int)$row['total'];
        }

        if ($total === 0) {
            $conn->close();
            return array('status' => 'NO_DATA');
        }

        $sql = "SELECT COUNT(*) as answers FROM Respuesta WHERE encuesta = '$encuesta' AND respuestas != ''";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $answers = (int)$row['answers'];
        }

        $byGender = array();
        $byAge = array();
        $byState = array();

        if ($answers === 0) {
            $byGender = generalReportByGender($encuesta, $answers, TRUE);
            $byAge = generalReportByAge($encuesta, $answers, TRUE);
            $byEducation = generalReportByEducation($encuesta, $answers, TRUE);

            $byStateData = generalReportByState($encuesta, $answers, TRUE);
            $byState = $byStateData[0];
            $byStatePercentage = $byStateData[1];

            $conn->close();
            return array('status' => 'NO_DATA', 'respuestas' => 0, 'porcentaje' => 0, 'genero' => $byGender, 'edad' => $byAge, 'educacion' => $byEducation, 'estado' => $byState, 'estadoPercentage' => $byStatePercentage);
        }

        $byGender = generalReportByGender($encuesta, $answers, FALSE);
        $byAge = generalReportByAge($encuesta, $answers, FALSE);
        $byEducation = generalReportByEducation($encuesta, $answers, FALSE);

        $byStateData = generalReportByState($encuesta, $answers, FALSE);
        $byState = $byStateData[0];
        $byStatePercentage = $byStateData[1];

        return array('status' => 'SUCCESS', 'respuestas' => $answers, 'porcentaje' => $answers / $total, 'genero' => $byGender, 'edad' => $byAge, 'educacion' => $byEducation, 'estado' => $byState, 'estadoPercentage' => $byStatePercentage);
    }

    return array('status' => 'DATABASE_ERROR');
}

function generalReportByGender ($encuesta, $total, $default) {
    $conn = connect();

    if ($conn != null && !$default) {
        $sql = "SELECT COUNT(*) as h FROM Respuesta INNER JOIN Panelista ON Panelista.id = Respuesta.panelista WHERE Panelista.genero = 0 AND Respuesta.encuesta = '$encuesta' AND Respuesta.respuestas != ''";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $conn->close();
            return array('H' => (int)$row['h'], 'M' => ($total - (int)$row['h']));
        }
    }

    $conn->close();
    return array('H' => 0, 'M' => 0);
}

function generalReportByEducation ($encuesta, $total, $default) {
    $conn = connect();

    if ($conn != null && !$default) {
        $sql = "SELECT educacion, COUNT(*) as count FROM Respuesta INNER JOIN Panelista ON Panelista.id = Respuesta.panelista WHERE Respuesta.encuesta = '$encuesta' AND Respuesta.respuestas != '' GROUP BY educacion";
        $result = $conn->query($sql);

        $response = array();
        $flags = [false, false, false, false, false, false];

        while ($row = $result->fetch_assoc()) {
            $response[$row['educacion']] = (int)$row['count'];
            $flags[(int)$row['educacion'] - 1] = true;
        }

        if (!$flags[0]) {
            $response['1'] = 0;
        }

        if (!$flags[1]) {
            $response['2'] = 0;
        }

        if (!$flags[2]) {
            $response['3'] = 0;
        }

        if (!$flags[3]) {
            $response['4'] = 0;
        }

        if (!$flags[4]) {
            $response['5'] = 0;
        }

        if (!$flags[5]) {
            $response['6'] = 0;
        }

        $conn->close();
        return $response;
    }

    $conn->close();
    return array(array(), array());
}

function generalReportByAge ($encuesta, $total, $default) {
    $conn = connect();

    if ($conn != null && !$default) {
        $dateNow = date('Y-m-d');
        $date25 = date('Y-m-d', strtotime("-25 year", time()));
        $date35 = date('Y-m-d', strtotime("-35 year", time()));
        $date45 = date('Y-m-d', strtotime("-45 year", time()));
        $date55 = date('Y-m-d', strtotime("-55 year", time()));

        $response = array();
        $count = 0;

        $sql = "SELECT COUNT(*) as count FROM Respuesta INNER JOIN Panelista ON Panelista.id = Respuesta.panelista WHERE Respuesta.encuesta = '$encuesta' AND Respuesta.respuestas != '' AND Panelista.fechaNacimiento >= '$date25'";
        $result = $conn->query($sql);

        if ($row = $result->fetch_assoc()) {
            $response['25'] = (int)$row['count'];
            $count = $count + (int)$row['count'];
        }

        $sql = "SELECT COUNT(*) as count FROM Respuesta INNER JOIN Panelista ON Panelista.id = Respuesta.panelista WHERE Respuesta.encuesta = '$encuesta' AND Respuesta.respuestas != '' AND Panelista.fechaNacimiento >= '$date35' AND Panelista.fechaNacimiento < '$date25'";
        $result = $conn->query($sql);

        if ($row = $result->fetch_assoc()) {
            $response['35'] = (int)$row['count'];
            $count = $count + (int)$row['count'];
        }

        $sql = "SELECT COUNT(*) as count FROM Respuesta INNER JOIN Panelista ON Panelista.id = Respuesta.panelista WHERE Respuesta.encuesta = '$encuesta' AND Respuesta.respuestas != '' AND Panelista.fechaNacimiento >= '$date45' AND Panelista.fechaNacimiento < '$date35'";
        $result = $conn->query($sql);

        if ($row = $result->fetch_assoc()) {
            $response['45'] = (int)$row['count'];
            $count = $count + (int)$row['count'];
        }

        $sql = "SELECT COUNT(*) as count FROM Respuesta INNER JOIN Panelista ON Panelista.id = Respuesta.panelista WHERE Respuesta.encuesta = '$encuesta' AND Respuesta.respuestas != '' AND Panelista.fechaNacimiento >= '$date55' AND Panelista.fechaNacimiento < '$date45'";
        $result = $conn->query($sql);

        if ($row = $result->fetch_assoc()) {
            $response['55'] = (int)$row['count'];
            $count = $count + (int)$row['count'];
        }

        $response['100'] = $total - $count;

        $conn->close();
        return $response;
    }

    $conn->close();
    return array('25' => 0, '35' => 0, '45' => 0, '55' => 0, '100' => 0);
}

function generalReportByState ($encuesta, $total, $default) {
    $conn = connect();

    if ($conn != null && !$default) {
        $sql = "SELECT estado, COUNT(*) as count FROM Respuesta INNER JOIN Panelista ON Panelista.id = Respuesta.panelista WHERE Respuesta.encuesta = '$encuesta' AND Respuesta.respuestas != '' GROUP BY estado";
        $result = $conn->query($sql);

        $response = array();
        $responsePercentage = array();

        while ($row = $result->fetch_assoc()) {
            $response[$row['estado']] = (int)$row['count'];
            $responsePercentage[$row['estado'].'%'] = (int)$row['count'] / $total;
        }

        $conn->close();
        return array($response, $responsePercentage);
    }

    $conn->close();
    return array(array(), array());
}

function currentAnswers ($encuesta) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT Panelista.id, Panelista.nombre, Panelista.apellidos, Panelista.genero, TIMESTAMPDIFF(YEAR, Panelista.fechaNacimiento, CURDATE()) AS edad, Panelista.educacion, Panelista.municipio, Panelista.estado, PanelistaEnPanel.id AS idRecord FROM Panelista LEFT JOIN PanelistaEnPanel ON Panelista.id = PanelistaEnPanel.panelista WHERE PanelistaEnPanel.estado = 1 AND PanelistaEnPanel.panel = (SELECT Encuesta.panel FROM Encuesta WHERE id = '$encuesta')";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $panelistaId = $row['id'];
            $idRespuesta = -1;
            $fechaIni = NULL;
            $horaIni = NULL;
            $fechaFin = NULL;
            $horaFin = NULL;

            $sql2 = "SELECT id, fechaIni, horaIni, fechaFin, horaFin FROM Respuesta WHERE panelista = '$panelistaId' AND encuesta = '$encuesta'";
            $result2 = $conn->query($sql2);

            if ($result2->num_rows > 0) {
                $row2 = $result2->fetch_assoc();
                $idRespuesta = $row2['id'];
                $fechaIni = $row2['fechaIni'];
                $horaIni = $row2['horaIni'];
                $fechaFin = $row2['fechaFin'];
                $horaFin = $row2['horaFin'];
            }

            $panelista = array('idRecord' => (int)$row['idRecord'], 'idRespuesta' => (int)$idRespuesta, 'nombre' => $row['nombre'].' '.$row['apellidos'], 'genero' => (int)$row['genero'], 'edad' => (int)$row['edad'], 'educacion' => (int)$row['educacion'], 'municipio' => $row['municipio'], 'estado' => $row['estado'], 'fechaIni' => $fechaIni, 'horaIni' => $horaIni, 'fechaFin' => $fechaFin, 'horaFin' => $horaFin);
            $response[] = $panelista;
        }

        $conn->close();

        usort($response, function ($item1, $item2) {
            if ($item2['fechaFin'] == NULL && $item1['fechaFin'] == NULL) {
                return $item2['fechaIni'] >= $item1['fechaIni'];
            }

            return $item2['fechaFin'] >= $item1['fechaFin'];
        });

        $panelistas = array('panelistas' => $response);
        return array_merge(getSummary($encuesta), $panelistas);
    }

    return array();
}

function reportData ($encuesta, $numPregunta, $genero, $edad, $estado, $educacion) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT tipo, numOpciones, opciones, numSubPreguntas, subPreguntas FROM Pregunta WHERE encuesta = '$encuesta' AND numPregunta = '$numPregunta'";
        $result = $conn->query($sql);
        $tipo = 0;
        $options = array();
        $subPreguntas = array();
        $votes = array();

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();
            $tipo = $row['tipo'];

            $options = explode('&', $row['opciones']);
            $options = array_filter($options, 'emptyString');

            if ($tipo == 5) {
                $subPreguntas = explode('&', $row['subPreguntas']);
                $subPreguntas = array_filter($subPreguntas, 'emptyString');

                for ($x = 1; $x <= count($subPreguntas); $x++) {
                    $votosInner = array();

                    for ($y = 1; $y <= count($options); $y++) {
                        $votosInner[] = 0;
                    }

                    $votes[] = $votosInner;
                }
            } else {
                for ($x = 1; $x <= count($options); $x++) {
                    $votes[] = 0;
                }
            }
        }

        if ($genero === null && $edad === null && $estado === null && $educacion === null) {
            $sql = "SELECT respuestas FROM Respuesta WHERE encuesta = '$encuesta' AND respuestas != ''";
        } else {
            $sql = "SELECT respuestas FROM Respuesta INNER JOIN Panelista ON Panelista.id = Respuesta.panelista WHERE Respuesta.encuesta = '$encuesta' AND Respuesta.respuestas != ''";

            if ($genero !== null) {
                $sql = $sql." AND Panelista.genero = '$genero'";
            }

            if ($edad !== null) {
                $dateNow = date('Y-m-d');
                $date25 = date('Y-m-d', strtotime("-25 year", time()));
                $date35 = date('Y-m-d', strtotime("-35 year", time()));
                $date45 = date('Y-m-d', strtotime("-45 year", time()));
                $date55 = date('Y-m-d', strtotime("-55 year", time()));

                if ($edad == 25) {
                    $sql = $sql." AND Panelista.fechaNacimiento >= '$date25'";
                } else if ($edad == 35) {
                    $sql = $sql." AND Panelista.fechaNacimiento >= '$date35' AND Panelista.fechaNacimiento < '$date25'";
                } else if ($edad == 45) {
                    $sql = $sql." AND Panelista.fechaNacimiento >= '$date45' AND Panelista.fechaNacimiento < '$date35'";
                } else if ($edad == 55) {
                    $sql = $sql." AND Panelista.fechaNacimiento >= '$date55' AND Panelista.fechaNacimiento < '$date45'";
                } else if ($edad == 100) {
                    $sql = $sql." AND Panelista.fechaNacimiento < '$date55'";
                }
            }

            if ($estado !== null) {
                $sql = $sql." AND Panelista.estado = '$estado'";
            }

            if ($educacion !== null) {
                $sql = $sql." AND Panelista.educacion = '$educacion'";
            }
        }

        $result = $conn->query($sql);
        $values = array();
        $total = 0;

        while ($row = $result->fetch_assoc()) {
            $total = $total + 1;
            $answers = explode('|', $row['respuestas']);

            if ($tipo == 1) {
                $votes[] = $answers[$numPregunta - 1];
            } else if ($tipo == 2) {
                for ($x = 0; $x < count($options); $x++) {
                    if ($answers[$numPregunta - 1] == $options[$x]) {
                        $votes[$x] = $votes[$x] + 1;
                        break;
                    }
                }
            } else if ($tipo == 3) {
                $multipleAnswers = explode('&', $answers[$numPregunta - 1]);

                for ($x = 0; $x < count($options); $x++) {
                    for ($y = 0; $y < count($multipleAnswers); $y++) {
                        if ($multipleAnswers[$y] == $options[$x]) {
                            $votes[$x] = $votes[$x] + 1;
                            break;
                        }
                    }
                }
            } else if ($tipo == 4) {
                $multipleAnswers = explode('&', $answers[$numPregunta - 1]);

                for ($x = 0; $x < count($options); $x++) {
                    for ($y = 0; $y < count($multipleAnswers); $y++) {
                        if ($multipleAnswers[$y] == $options[$x]) {
                            $votes[$x] = $votes[$x] + $y + 1;
                            break;
                        }
                    }
                }
            } else if ($tipo == 5) {
                $multipleAnswers = explode('&', $answers[$numPregunta - 1]);

                for ($x = 0; $x < count($multipleAnswers); $x++) {
                    for ($y = 0; $y < count($options); $y++) {
                        if ($multipleAnswers[$x] == $options[$y]) {
                            $votes[$x][$y] = $votes[$x][$y] + 1;
                            break;
                        }
                    }
                }
            } else if ($tipo == 6) {
                $votes[0] = $votes[0] + (int)$answers[$numPregunta - 1];
            }
        }

        if ($total == 0) {
            $conn->close();
            return array('status' => 'NO_DATA');
        }

        if ($tipo == 5) {
            for ($x = 0; $x < count($subPreguntas); $x++) {
                $valuesInner = array();
                $votesInner = $votes[$x];

                for ($y = 0; $y < count($options); $y++) {
                    $valuesInner[] = $votesInner[$y] / $total;
                }

                $values[] = $valuesInner;
            }
        } else {
            for ($x = 0; $x < count($options); $x++) {
                $values[] = $votes[$x] / $total;
            }
        }

        $conn->close();
        return array('status' => 'SUCCESS', 'tipo' => (int)$tipo, 'opciones' => $options, 'subPreguntas' => $subPreguntas, 'votos' => $votes, 'porcentajes' => $values);
    }

    return array('status' => 'DATABASE_ERROR');
}

function downloadData ($encuesta) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT pregunta, tipo, numSubPreguntas, subPreguntas, numOpciones FROM Pregunta WHERE encuesta = '$encuesta'";
        $result = $conn->query($sql);
        $columnas = array('Nombre', 'Género', 'Edad', 'Educación', 'Municipio', 'Estado', 'Fecha de Inicio', 'Hora de Inicio', 'Fecha de Fin', 'Hora de Fin');
        $types = [];

        while ($row = $result->fetch_assoc()) {
            $types[] = (int)$row['tipo'];
            $numSubPreguntas = (int)$row['numSubPreguntas'];

            if ($numSubPreguntas > 0) {
                $subPreguntas = explode('&', $row['subPreguntas']);

                for ($i = 0; $i < $numSubPreguntas; $i++) {
                    $columnas[] = $row['pregunta'].' - '.$subPreguntas[$i];
                }
            } else if ((int)$row['tipo'] === 4) {
                $numOpciones = (int)$row['numOpciones'];

                for ($i = 1; $i <= $numOpciones; $i++) {
                    $columnas[] = $row['pregunta'].' - '.$i;
                }
            } else {
                $columnas[] = $row['pregunta'];
            }
        }

        $sql = "SELECT Panelista.id as id, nombre, apellidos, genero, TIMESTAMPDIFF(YEAR, fechaNacimiento, CURDATE()) AS edad, educacion, municipio, Panelista.estado FROM Panelista LEFT JOIN PanelistaEnPanel ON Panelista.id = PanelistaEnPanel.panelista WHERE PanelistaEnPanel.estado = 1 AND PanelistaEnPanel.panel = (SELECT panel FROM Encuesta WHERE id = '$encuesta')";
        $result = $conn->query($sql);
        $filas = array();

        while ($row = $result->fetch_assoc()) {
            $fila = array('nombre' => $row['nombre'].' '.$row['apellidos'], 'genero' => (int)$row['genero'], 'edad' => (int)$row['edad'], 'educacion' => (int)$row['educacion'], 'municipio' => $row['municipio'], 'estado' => $row['estado']);
            $id = $row['id'];

            $sql = "SELECT respuestas, fechaIni, horaIni, fechaFin, horaFin FROM Respuesta WHERE encuesta = '$encuesta' AND respuestas != '' AND panelista = '$id'";
            $result2 = $conn->query($sql);

            if ($result2->num_rows > 0) {
                $row2 = $result2->fetch_assoc();
                $fila['fechaIni'] = $row2['fechaIni'];
                $fila['horaIni'] = $row2['horaIni'];
                $fila['fechaFin'] = $row2['fechaFin'];
                $fila['horaFin'] = $row2['horaFin'];

                $answer = str_replace('&', ', ', rtrim($row2['respuestas'], '|'));
                $answers = explode('|', $answer);
                $realAnswers = [];

                for ($i = 0; $i < count($answers); $i++) {
                    $answers[$i] = rtrim($answers[$i], ', ');

                    if ($types[$i] === 4 || $types[$i] === 5) {
                        $subAnswers = explode(', ', $answers[$i]);

                        for ($j = 0; $j < count($subAnswers); $j++) {
                            $realAnswers[] = $subAnswers[$j];
                        }
                    } else {
                        $realAnswers[] = $answers[$i];
                    }
                }

                $fila['respuestas'] = $realAnswers;
                $filas[] = $fila;
            }
        }

        usort($filas, function ($item1, $item2) {
            return $item2['fechaFin'] >= $item1['fechaFin'];
        });

        return array('status' => 'SUCCESS', 'columnas' => $columnas, 'filas' => $filas);
    }

    return array('status' => 'DATABASE_ERROR');
}

?>
