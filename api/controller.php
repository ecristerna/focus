<?php

header('Content-type: application/json');
require_once 'model.php';
require_once 'upload.php';

switch ($_POST['action']) {
    case 'WEB_LOG_IN':
        signinToDatabase(0);
        break;
    case 'PANELISTA_LOG_IN':
        signinToDatabase(2);
        break;
    case 'ALTA_ADMIN':
        newUser(0);
        break;
    case 'ALTA_CLIENTE':
        newUser(1);
        break;
    case 'ALTA_PANELISTA':
        newPanelista();
        break;
    case 'ALTA_PANEL':
        newPanel();
        break;
    case 'ALTA_ENCUESTA':
        newEncuesta();
        break;
    case 'ALTA_RECURSO':
        newResource();
        break;
    case 'GET_ADMINS':
        getRecords('ADMINS');
        break;
    case 'GET_CLIENTES':
        getRecords('CLIENTES');
        break;
    case 'GET_PANELES':
        getRecords('PANELES');
        break;
    case 'GET_PANELISTAS':
        getRecords('PANELISTAS');
        break;
    case 'GET_ENCUESTAS':
        getRecords('ENCUESTAS');
        break;
    case 'GET_PREGUNTAS':
        getRecords('PREGUNTAS');
        break;
    case 'GET_MOBILE_DATA':
        getRecords('MOBILE');
        break;
    case 'GET_RECURSOS':
        getRecords('RESOURCES');
        break;
    case 'GET_MUNICIPIOS':
        echo json_encode(getMunicipiosFromFile(), JSON_UNESCAPED_UNICODE);
        break;
    case 'SET_PANELISTAS_PANEL':
        setPanelistasPanel();
        break;
    case 'SET_PREGUNTAS_ENCUESTA':
        setPreguntasEncuesta();
        break;
    case 'START_ENCUESTA':
        initEncuesta();
        break;
    case 'SAVE_RESPUESTAS':
        setRespuestas();
        break;
    case 'DELETE_ADMIN':
        deleteRecord('Usuario');
        break;
    case 'DELETE_CLIENTE':
        deleteRecord('Usuario');
        break;
    case 'DELETE_PANELISTA':
        deleteRecord('Panelista');
        break;
    case 'DELETE_PANEL':
        deleteRecord('Panel');
        break;
    case 'DELETE_ENCUESTA':
        deleteRecord('Encuesta');
        break;
    case 'DELETE_RECURSO':
        deleteRecord('Recurso');
        break;
    case 'VERIFY_SESSION':
        verifyActiveSession();
        break;
    case 'REGISTER_DEVICE':
        registerDevice();
        break;
    case 'UNREGISTER_DEVICE':
        unregisterDevice();
        break;
    case 'ANSWERS_SUMMARY':
        echo json_encode(getSummary($_POST['encuesta']));
        break;
    case 'REPORT_DATA':
        getReportData();
        break;
    case 'DOWNLOAD_DATA':
        getDownloadData();
        break;
    case 'CURRENT_ANSWERS':
        getCurrentAnswers();
        break;
    case 'CHANGE_PANELISTA_PASSWORD':
        echo json_encode(changePanelistaPassword($_POST['panelista'], $_POST['old'], $_POST['new']));
        break;
    case 'FORGOT_PANELISTA_PASSWORD':
        recoverPasword();
        break;
    case 'LOG_OUT':
        logOut();
        break;
    case 'PRIVACY_POLICY':
        fetchFromFile('privacy.txt');
        break;
    default:
        echo json_encode(array('status' => 'INVALID_ACTION', 'action' => $_POST['action']));
        break;
}

function startSession ($id, $tipo, $username, $email, $nombre) {
    session_start();

    $_SESSION['id'] = $id;
    $_SESSION['tipo'] = $tipo;
    $_SESSION['username'] = $username;
    $_SESSION['email'] = $email;
    $_SESSION['nombre'] = $nombre;
}

function hasActiveSession () {
    session_start();

    if (isset($_SESSION['id'])) {
        return array('status' => 'SUCCESS', 'id' => $_SESSION['id'], 'tipo' => $_SESSION['tipo'], 'username' => $_SESSION['username'], 'email' => $_SESSION['email'], 'nombre' => $_SESSION['nombre']);
    }

    return array('status' => 'ERROR');
}

function destroySession () {
    session_start();

    if (isset($_SESSION['id'])) {
        $_SESSION = array();

        session_destroy();
    }
}

function signinToDatabase ($tipo) {
    if ($tipo === 0) {
        $signinResult = validateWebCredentials($_POST['username'], $_POST['password']);

        if ($signinResult['status'] === 'SUCCESS') {
            startSession($signinResult['id'], $signinResult['tipo'], $signinResult['username'], $signinResult['email'], $signinResult['nombre']);
        }

    } else if ($tipo === 2) {
        $signinResult = validatePanelistaCredentials($_POST['username'], $_POST['password']);
    }

    echo json_encode($signinResult);
}

function newPanelista () {
    if (isset($_POST['id'])) {
        $registrationResult = updatePanelista($_POST['id'], $_POST['username'], $_POST['nombre'], $_POST['apellidos'], $_POST['email'], $_POST['genero'], $_POST['fechaNacimiento'], $_POST['educacion'], $_POST['calleNumero'], $_POST['colonia'], $_POST['municipio'], $_POST['estado'], $_POST['cp']);
    } else {
        $registrationResult = registerPanelista($_POST['username'], $_POST['password'], $_POST['nombre'], $_POST['apellidos'], $_POST['email'], $_POST['genero'], $_POST['fechaNacimiento'], $_POST['educacion'], $_POST['calleNumero'], $_POST['colonia'], $_POST['municipio'], $_POST['estado'], $_POST['cp']);
    }

    echo json_encode($registrationResult);
}

function newUser ($tipo) {
    if (isset($_POST['id'])) {
        $registrationResult = updateUser($_POST['id'], $_POST['username'], $_POST['nombre'], $_POST['apellidos'], $_POST['email']);
    } else {
        $registrationResult = registerUser($tipo, $_POST['username'], $_POST['password'], $_POST['nombre'], $_POST['apellidos'], $_POST['email']);
    }

    echo json_encode($registrationResult);
}

function newPanel () {
    if (isset($_POST['id'])) {
        $registrationResult = updatePanel($_POST['id'], $_POST['nombre'], $_POST['descripcion'], $_POST['fechaInicio'], $_POST['fechaFin'], $_POST['numParticipantes'], $_POST['cliente']);
    } else {
        session_start();
        $registrationResult = registerPanel($_POST['nombre'], $_POST['descripcion'], $_POST['fechaInicio'], $_POST['fechaFin'], $_POST['numParticipantes'], $_POST['cliente'], $_SESSION['id']);
    }

    echo json_encode($registrationResult);
}

function newEncuesta () {
    if (isset($_POST['id'])) {
        $registrationResult = updateEncuesta($_POST['id'], $_POST['nombre'], $_POST['fechaInicio'], $_POST['fechaFin'], $_POST['panel']);
    } else {
        $registrationResult = registerEncuesta($_POST['nombre'], $_POST['fechaInicio'], $_POST['fechaFin'], $_POST['panel']);

        if ($registrationResult['status'] === 'SUCCESS') {
            foreach ($registrationResult['deviceTokens'] as $deviceToken) {
                sendPushNotification('¡Nueva Encuesta Disponible!', $deviceToken);
            }
        }
    }

    echo json_encode($registrationResult);
}

function newResource() {
    $uploadResult = uploadFile($_POST['file-name'] . '.' . $_POST['fileType'], $_POST['tipo']);

    if ($uploadResult['status'] === 'SUCCESS') {
        registerResource($_POST['file-name'] . '.' . $_POST['fileType'], $_POST['tipo']);
    }

    echo json_encode($uploadResult);
}

function getRecords ($type) {
    switch ($type) {
        case 'ADMINS':
            if (isset($_POST['id'])) {
                echo json_encode(fetchUser(0, $_POST['id']));
                return;
            }

            echo json_encode(fetchUsers(0));
            break;
        case 'CLIENTES':
            if (isset($_POST['id'])) {
                echo json_encode(fetchUser(1, $_POST['id']));
                return;
            }

            echo json_encode(fetchUsers(1));
            break;
        case 'PANELISTAS':
            if (isset($_POST['panel'])) {
                echo json_encode(fetchPanelistasPanel($_POST['panel']));
                return;
            }

            if (isset($_POST['id'])) {
                echo json_encode(fetchPanelista($_POST['id']));
                return;
            }

            echo json_encode(fetchPanelistas());
            break;
        case 'PANELES':
            if (isset($_POST['id'])) {
                echo json_encode(fetchPanel($_POST['id']));
                return;
            }

            if (isset($_POST['cliente'])) {
                echo json_encode(fetchPanelesForCliente($_POST['cliente']));
                return;
            }

            echo json_encode(fetchPaneles());
            break;
        case 'ENCUESTAS':
            if (isset($_POST['id'])) {
                echo json_encode(fetchEncuesta($_POST['id']));
                return;
            }

            if (isset($_POST['panel'])) {
                echo json_encode(fetchEncuestasForPanel($_POST['panel']));
                return;
            }

            $sessionData = hasActiveSession();
            if ($sessionData['tipo'] == 1) {
                echo json_encode(fetchEncuestasForCliente($sessionData['id']));
                return;
            }

            echo json_encode(fetchEncuestas());
            break;
        case 'PREGUNTAS':
            if (isset($_POST['encuesta'])) {
                echo json_encode(fetchPreguntasEncuesta($_POST['encuesta']));
                return;
            }

            break;
        case 'MOBILE':
            echo json_encode(fetchMobileData($_POST['panelista']));
            break;
        case 'RESOURCES':
            if (isset($_POST['tipo'])) {
                echo json_encode(fetchResourcesOfType($_POST['tipo']));
                return;
            }

            echo json_encode(fetchResources());
            break;
    }
}

function setPanelistasPanel () {
    $saveResult = savePanelistasPanel($_POST['panel'], $_POST['panelistas']);

    echo json_encode($saveResult);

    if ($saveResult['status'] === 'SUCCESS') {
        foreach ($saveResult['deviceTokens'] as $deviceToken) {
            sendPushNotification('¡Has sido registrado a un nuevo Panel! Pronto recibirás encuestas para responder.', $deviceToken);
        }
    }
}

function setPreguntasEncuesta () {
    $saveResult = savePreguntasEncuesta($_POST['encuesta'], $_POST['preguntas']);

    echo json_encode($saveResult);
}

function initEncuesta () {
    $saveResult = startEncuesta($_POST['encuesta'], $_POST['panelista']);

    echo json_encode($saveResult);
}

function setRespuestas () {
    $saveResult = saveRespuestas($_POST['id'], $_POST['respuestas']);

    echo json_encode($saveResult);
}

function deleteRecord ($table) {
    if ($table === 'Recurso') {
        $path = '../resources/'.((int)$_POST['tipo'] == 1 ? 'images/' : 'videos/').$_POST['nombre'];
        unlink($path);
    }

    $deleteResult = removeRecord($_POST['id'], $table);

    echo json_encode($deleteResult);
}

function verifyActiveSession () {
    $validationResult = hasActiveSession();

    echo json_encode($validationResult);
}

function getReportData () {
    if ($_POST['numPregunta'] == 0) {
        $reportData = generalReportData($_POST['encuesta']);
    } else {
        $reportData = reportData($_POST['encuesta'], $_POST['numPregunta'], $_POST['genero'], $_POST['edad'], $_POST['estado'], $_POST['educacion']);
    }

    echo json_encode($reportData);
}

function getCurrentAnswers () {
    $reportData = currentAnswers($_POST['encuesta']);

    echo json_encode($reportData);
}

function getDownloadData () {
    $sessionData = hasActiveSession();
    if ($sessionData['tipo'] == 1) {
        echo json_encode(array('status' => 'ERROR', 'message' => 'No tiene permisos para realizar esta acción.'));
        return;
    }

    echo json_encode(downloadData($_POST['encuesta']));
}

function registerDevice () {
    $registrationResult = registerDeviceToken($_POST['id'], $_POST['deviceToken'], $_POST['deviceType']);

    echo json_encode($registrationResult);
}

function unregisterDevice () {
    $registrationResult = unregisterDeviceToken($_POST['id']);

    echo json_encode($registrationResult);
}

function recoverPasword () {
    $passwordResult = fetchPanelistaPassword($_POST['username'], $_POST['email']);

    if ($passwordResult['status'] === 'SUCCESS') {
        $passwordResult['status'] = sendPassword($passwordResult['email'], $passwordResult['nombre'], $passwordResult['password']);
        unset($passwordResult['nombre']);
        unset($passwordResult['password']);
    }

    echo json_encode($passwordResult);
}

function logOut ()  {
    destroySession();

    echo json_encode(array('status' => 'SUCCESS'));
}

function fetchFromFile ($file)  {
    $path = '../resources/';
    $myfile = fopen($path.$file, 'r') or die('Unable to open file!');
    echo json_encode(array('content' => fread($myfile, filesize($path.$file))));
    fclose($myfile);
}

function getMunicipiosFromFile() {
    $currentState = 'Aguascalientes';
    $arrayEstados = array();
    $arrayMunicipios = array();

    $fileMunicipios = fopen('../src/elements/municipios.txt', 'r');

    // $out = fopen('../src/elements/municipios.json', 'w');
    // fwrite($out, '[');
    // fwrite($out, '{"estado": "'.$currentState.'", "abreviacion": ""');
    // fwrite($out, ', "municipios": [');

    while (!feof($fileMunicipios)) {
        $arrayLineRead = explode('_', fgets($fileMunicipios));
        $arrayLineRead[1] = trim($arrayLineRead[1], "\n");

        if ($currentState !== $arrayLineRead[0]) {
            $arrayEstados[$currentState] = $arrayMunicipios;
            $currentState = $arrayLineRead[0];

            $arrayMunicipios = array();
            // fwrite($out, ']}');
            // fwrite($out, ', {"estado": "'.$currentState.'", "abreviacion": ""');
            // fwrite($out, ', "municipios": [');
        } else {
            // fwrite($out, ', ');
        }

        $arrayMunicipios[] = $arrayLineRead[1];
        // fwrite($out, '"'.$arrayLineRead[1].'"');
    }

    // fwrite($out, ']}]');
    // fclose($out);

    fclose($fileMunicipios);

    return array('estados' => $arrayEstados);
}

function sendPassword ($email, $nombre, $password) {
    $subject = 'Recupere su Contraseña';
    $from = 'atencion@focuscg.com.mx';

    $headers =  'From: ' . $from . "\r\n" .
                'Reply-To:' . $from . "\r\n" .
                'Return-Path: ' . $from . "\r\n" .
                'MIME-Version: 1.0.' . "\r\n" .
                'Content-Type: text/html; charset=UTF-8';

    $message =  'Hola ' . $nombre . ',<br><br>' .
                'Hemos recibido su solicitud para recuperar su contraseña de acceso a la app Focus.' . '<br><br>' .
                'Su contraseña es <strong> ' . $password . ' </strong>. Si usted no solicitó este correo, le pedimos haga caso omiso del mismo.' . '<br><br>' .
                'Agradecemos preferencia. ¡Que tenga un excelente día!,' . '<br><br><br>' .
                'Focus Consulting Group';

    $success = mail($email, $subject, $message, $headers);

    return $success ? 'SUCCESS' : 'ERROR';
}

function sendPushNotification ($message, $deviceToken) {
    $ctx = stream_context_create();
    stream_context_set_option($ctx, 'ssl', 'local_cert', 'FocusPushKey.pem');
    stream_context_set_option($ctx, 'ssl', 'passphrase', 'Focuscg233');

    // Open a connection to the APNS server
    $fp = stream_socket_client(
        'ssl://gateway.sandbox.push.apple.com:2195',
        $err,
        $errstr,
        60,
        STREAM_CLIENT_CONNECT|STREAM_CLIENT_PERSISTENT,
        $ctx
    );

    if (!$fp)
      exit('Failed to connect: $err $errstr' . PHP_EOL);

    // echo 'Connected to APNS' . PHP_EOL;

    // Create the payload body
    $body['aps'] = array(
      'alert' => $message,
      'sound' => 'default'
    );

    // Encode the payload as JSON
    $payload = json_encode($body);

    // Build the binary notification
    $msg = chr(0) . pack('n', 32) . pack('H*', $deviceToken) . pack('n', strlen($payload)) . $payload;

    // Send it to the server
    $result = fwrite($fp, $msg, strlen($msg));

    // if (!$result)
    //   echo 'Message not delivered' . PHP_EOL;
    // else
    //   echo 'Message successfully delivered' . PHP_EOL;

    // Close the connection to the server
    fclose($fp);
}

?>
