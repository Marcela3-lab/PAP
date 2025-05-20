<?php
include('db.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST'){
    $id = $_POST['id_agenda'];

    $sql = "DELETE FROM agenda WHERE id_agenda = '$id'";

    if (mysqli_query($conexao, $sql)){
        echo json_encode(["sucess" => true]);
    } else {
        echo json_encode(["sucess" => false, "error" => mysqli_error($conexao)]);
    }

}

?>