<?php

function connect() {
    $servername = "localhost";
    $username = "root";
    $password = "root";
    $dbname = "focus";

    $connection = new mysqli($servername, $username, $password, $dbname);

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
        $sql = "SELECT id, username, email, nombre, apPaterno, apMaterno, tipo FROM Usuario WHERE username = '$username' AND password = '$password'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'SUCCESS', 'id' => (int)$row['id'], 'tipo' => (int)$row['tipo'], 'username' => $row['username'], 'email' => $row['email'], 'nombre' => $row['nombre']." ".$row['apPaterno']." ".$row['apMaterno']);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function validatePanelistaCredentials ($email, $password) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, email, nombre, apPaterno, apMaterno FROM Panelista WHERE email = '$email' AND password = '$password'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'SUCCESS', 'id' => (int)$row['id'], 'email' => $row['email'], 'nombre' => $row['nombre']." ".$row['apPaterno']." ".$row['apMaterno']);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Registration
// -------------------------------

function registerUser ($tipo, $username, $password, $nombre, $apPaterno, $apMaterno, $email) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username FROM Usuario WHERE username = '$username'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'USER_EXISTS', 'id' => (int)$row['id'], 'username' => $row['username']);
        }

        $sql = "INSERT INTO Usuario (username, password, nombre, apPaterno, apMaterno, email, tipo) VALUES ('$username', '$password', '$nombre', '$apPaterno', '$apMaterno', '$email', '$tipo')";

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

function registerPanelista ($email, $nombre, $apPaterno, $apMaterno, $genero, $educacion, $edad, $edoCivil, $estado, $municipio, $cuartos, $banios, $regadera, $focos, $piso, $autos, $estudiosProv, $estufa, $movil, $fotoINE) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, email FROM Panelista WHERE email = '$email'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'USER_EXISTS', 'id' => (int)$row['id'], 'email' => $row['email']);
        }

        $sql = "INSERT INTO Panelista (email, nombre, apPaterno, apMaterno, genero, educacion, edad, edoCivil, estado, municipio, cuartos, banios, regadera, focos, piso, autos, estudiosProv, estufa, movil, fotoINE) VALUES ('$email', '$nombre', '$apPaterno', '$apMaterno', $genero, '$educacion', '$edad', '$edoCivil', '$estado', '$municipio', '$cuartos', '$banios', '$regadera', '$focos', '$piso', '$autos', '$estudiosProv', '$estufa', '$movil', '$fotoINE')";

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

function registerPanel ($nombre, $fechaInicio, $fechaFin, $cliente, $creador) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre FROM Panel WHERE nombre = '$nombre'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            $conn->close();
            return array('status' => 'RECORD_EXISTS', 'id' => (int)$row['id'], 'nombre' => $row['nombre']);
        }

        $sql = "INSERT INTO Panel (nombre, fechaInicio, fechaFin, cliente, creador) VALUES ('$nombre', '$fechaInicio', '$fechaFin', $cliente, '$creador')";

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
            $lastId = mysqli_insert_id($conn);
            $conn->close();
            return array('status' => 'SUCCESS', 'id' => $lastId);
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Fetch
// -------------------------------

function fetchUsers ($tipo) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, username, nombre, apPaterno, apMaterno, email FROM Usuario WHERE tipo = '$tipo'";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $client = array('id' => (int)$row['id'], 'username' => $row['username'], 'email' => $row['email'], 'nombre' => $row['nombre'].' '.$row['apPaterno'].' '.$row['apMaterno']);
            $response[] = $client;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchPaneles () {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, fechaInicio, fechaFin, cliente, creador FROM Panel";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $client = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'cliente' => (int)$row['cliente'], 'creador' => (int)$row['creador']);
            $response[] = $client;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchPanelistas () {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, apPaterno, apMaterno, genero, edad, edoCivil, estado, municipio FROM Panelista";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $panelista = array('id' => (int)$row['id'], 'nombre' => $row['nombre'].' '.$row['apPaterno'].' '.$row['apMaterno'], 'genero' => (int)$row['genero'], 'edad' => (int)$row['edad'], 'edoCivil' => (int)$row['edoCivil'], 'municipio' => $row['municipio'], 'estado' => $row['estado']);
            $response[] = $panelista;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchEncuestas () {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, fechaInicio, fechaFin, panel FROM Encuesta";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $panelista = array('id' => (int)$row['id'], 'nombre' => $row['nombre'], 'fechaInicio' => $row['fechaInicio'], 'fechaFin' => $row['fechaFin'], 'panel' => (int)$row['panel']);
            $response[] = $panelista;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

function fetchPanelistasPanel ($panel) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, nombre, apPaterno, apMaterno, genero, edad, edoCivil, estado, municipio FROM Panelista";
        $result = $conn->query($sql);

        $response = array();

        while ($row = $result->fetch_assoc()) {
            $id = $row['id'];
            $sql2 = "SELECT id FROM PanelistaEnPanel WHERE panel = '$panel' AND panelista = '$id'";
            $result2 = $conn->query($sql2);
            $checked = FALSE;

            if ($result2->num_rows > 0) {
                $checked = TRUE;
            }

            $panelista = array('id' => (int)$row['id'], 'nombre' => $row['nombre'].' '.$row['apPaterno'].' '.$row['apMaterno'], 'genero' => (int)$row['genero'], 'edad' => (int)$row['edad'], 'edoCivil' => (int)$row['edoCivil'], 'municipio' => $row['municipio'], 'estado' => $row['estado'], 'checked' => $checked);
            $response[] = $panelista;
        }

        $conn->close();
        return array('results' => $response);
    }

    return array('status' => 'DATABASE_ERROR');
}

// -------------------------------
// Save
// -------------------------------

function savePanelistasPanel ($panel, $panelistas) {
    $conn = connect();

    $inserts = 0;
    $errors = 0;
    $deletes = 0;

    if ($conn != null) {
        $sql = "SELECT * FROM PanelistaEnPanel WHERE panel = '$panel'";
        $result = $conn->query($sql);
        $deletes = $result->num_rows;
        $sql = "DELETE FROM PanelistaEnPanel WHERE panel = '$panel'";
        $result = $conn->query($sql);

        foreach ($panelistas as &$panelista) {
            $sql = "INSERT INTO PanelistaEnPanel (panelista, panel) VALUES ('$panelista', '$panel')";

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

// -------------------------------
// Alter
// -------------------------------

function updatePanelista ($id, $email, $nombre, $apPaterno, $apMaterno, $genero, $educacion, $edad, $edoCivil, $estado, $municipio, $cuartos, $banios, $regadera, $focos, $piso, $autos, $estudiosProv, $estufa, $movil, $fotoINE) {
    $conn = connect();

    if ($conn != null) {
        $sql = "SELECT id, email FROM Panelista WHERE email = '$email'";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            $row = $result->fetch_assoc();

            if ((int)$row['id'] != $id) {
                $conn->close();
                return array('status' => 'USER_EXISTS', 'id' => (int)$row['id'], 'email' => $row['email']);
            }
        }

        $sql = "UPDATE Panelista SET email = '$email', nombre = '$nombre', apPaterno = '$apPaterno', apMaterno = '$apMaterno', genero = '$genero', educacion = '$educacion', edad = '$edad', edoCivil = '$edoCivil', estado = '$estado', municipio = '$municipio', cuartos = '$cuartos', banios = '$banios', regadera = '$regadera', focos = '$focos', piso = '$piso', autos = '$autos', estudiosProv = '$estudiosProv', estufa = '$estufa', movil = '$movil', fotoINE = '$fotoINE' WHERE id = '$id'";

        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function updateUser ($id, $username, $password, $nombre, $apPaterno, $apMaterno, $email) {
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

        $sql = "UPDATE Usuario SET username = '$username', password = '$password', nombre = '$nombre', apPaterno = '$apPaterno', apMaterno = '$apMaterno', email = '$email' WHERE id = '$id'";

        if ($conn->query($sql) === TRUE) {
            $conn->close();
            return array('status' => 'SUCCESS');
        }

        $conn->close();
        return array('status' => 'ERROR');
    }

    return array('status' => 'DATABASE_ERROR');
}

function updatePanel ($id, $nombre, $fechaInicio, $fechaFin, $cliente) {
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

        $sql = "UPDATE Panel SET nombre = '$nombre', fechaInicio = '$fechaInicio', fechaFin = '$fechaFin', cliente = '$cliente' WHERE id = '$id'";

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

?>