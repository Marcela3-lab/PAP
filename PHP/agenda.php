<?php
header('Content-Type: application/json');

include('db.php');
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
   
    $titulo = mysqli_real_escape_string($conexao, $_POST['titulo']);
    $inicio = date("Y-m-d H:i:s", strtotime($_POST['inicio']));
    $fim = date("Y-m-d H:i:s", strtotime($_POST['fim']));
  
    $id_fk = mysqli_real_escape_string($conexao, $_POST['id_user']);
    $dia = mysqli_real_escape_string($conexao, $_POST['dia']);
    $id_fk = intval($_POST['id_user']);
    $dia = date("Y-m-d", strtotime( $dia)); 

  
    
   


    // Inserir os dados na base de dados
    $sql_agenda = "INSERT INTO agenda (titulo, inicio, fim, dia, id_user) VALUES ('$titulo', '$inicio', '$fim', '$dia','$id_fk')";


    if (mysqli_query($conexao, $sql_agenda)) {
        $response = [
            'status' => 'sucesso',
            'mensagem' => 'Tarefa adicionada com sucesso!',
            'data' => [
                'titulo' => $titulo,
                'inicio' => $inicio,
                'fim' => $fim,
                'dia' => $dia,
                
                'id_user' => $id_fk,
                
            ]
        ];
    } else {
        $response = [
            'status' => 'erro',
            'mensagem' => 'Erro ao adicionar registro: ' . mysqli_error($conexao)
        ];
    }
    
    echo json_encode($response);
    }


?>