<?php
include('db.php');
header('Content-Type: application/json');


$dia = mysqli_real_escape_string($conexao, $_GET['dia']);
$idUser = isset($_GET['id_user']) ? mysqli_real_escape_string($conexao, $_GET['id_user']) : '';

if ($dia) {
    $sql = "SELECT id_agenda, titulo, inicio, fim,estado FROM agenda WHERE DATE(dia) = '$dia' and id_user='$idUser'";
    $resultado = mysqli_query($conexao, $sql);

    $dados = [];

    if ($resultado && mysqli_num_rows($resultado) > 0) {
        while ($row = mysqli_fetch_assoc($resultado)) {
            $dados[] = $row;
        }
    }

    echo json_encode($dados);
}

mysqli_close($conexao);
?>