<?php
include('db.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST'){
    $id = $_POST['id_objetivo'];

    $sql = "DELETE FROM objetivos WHERE id_objetivo = '$id'";

    if (mysqli_query($conexao, $sql)){
        echo json_encode(["sucess" => true]);
    } else {
        echo json_encode(["sucess" => false, "error" => mysqli_error($conexao)]);
    }

}

?>