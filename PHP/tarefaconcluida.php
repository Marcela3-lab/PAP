<?php
header('Content-Type: application/json');

include('db.php');
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
   
    $estado=mysqli_real_escape_string($conexao, $_POST['estado']);
    $id_agenda = mysqli_real_escape_string($conexao, $_POST['id_agenda']);
$update = "UPDATE agenda SET estado = '$estado' WHERE id_agenda = '$id_agenda'";


if (mysqli_query($conexao, $update)) {
    $response = [
        'status' => 'sucesso',
        'mensagem' => 'Tarefa adicionada com sucesso!',
        'data' => [
            'estado' => $estado]];
        } else {
            $response = [
                'status' => 'erro',
                'mensagem' => 'Erro ao concluir a tarefa: ' . mysqli_error($conexao)
            ];
        }
    }
    echo json_encode($response);

    ?>