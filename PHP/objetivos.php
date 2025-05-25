<?php
include 'db.php';
header('Content-Type: application/json');

$response = [];

if ($_SERVER['REQUEST_METHOD'] == 'POST'){

    $titulo = mysqli_real_escape_string($conexao, $_POST['titulo']);

    $descricao = mysqli_real_escape_string($conexao, $_POST['descricao']);
    $meta = mysqli_real_escape_string($conexao, $_POST['meta']);
    $tipo = mysqli_real_escape_string($conexao, $_POST['tipo']);
    if ($meta == 1){
        $tipo = ucfirst('hora');

    }

    $cor = mysqli_real_escape_string($conexao, $_POST['cor']);
    $id_user = mysqli_real_escape_string($conexao, $_POST['id_user']);
    

    $sql_objetivo= "INSERT INTO objetivos (titulo, descricao, meta, tipo, cor, id_user) VALUES ( '$titulo','$descricao', '$meta', '$tipo', '$cor', '$id_user')";
if (mysqli_query($conexao,$sql_objetivo)){
$response['status'] = 'sucesso';
$response['mensagem'] = 'objetivo adicionado com sucesso';
$response['data']=[
    'titulo'=>$titulo,
    'descricao'=>$descricao,
    'meta'=>$meta,
    'tipo'=>$tipo,
    'cor'=>$cor,
    'id_user'=>$id_user
];
} else {
    $response = [
        'status' => 'erro',
        'mensagem'=> mysqli_error($conexao)
        

    ];
    
}

    }
 

    echo json_encode($response);

?>