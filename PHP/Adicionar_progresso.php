<?php
include 'db.php';
header('Content-Type: application/json');

$response = [];

if ($_SERVER['REQUEST_METHOD'] == 'POST'){

    $objetivo = mysqli_real_escape_string($conexao, $_POST['objetivo']);
    $progresso = mysqli_real_escape_string($conexao, $_POST['progresso']);

    $avanco = mysqli_real_escape_string($conexao, $_POST['avanco']);
    $tipoavanco = mysqli_real_escape_string($conexao, $_POST['tipoavanco']);

    $meta = mysqli_real_escape_string($conexao, $_POST['meta']);
    $tipometa = mysqli_real_escape_string($conexao, $_POST['tipometa']);

    $dia = mysqli_real_escape_string($conexao, $_POST['dia']);
    $dia = date("Y-m-d", strtotime( $dia)); 

    $id_user = mysqli_real_escape_string($conexao, $_POST['id_user']);
    

    $sql= "INSERT INTO progresso (objetivo,progresso, avanco, tipoavanco,meta,tipometa, dia, id_user) VALUES ( '$objetivo','$progresso','$avanco','$tipoavanco', '$meta', '$tipometa', '$dia', '$id_user')";
if (mysqli_query($conexao,$sql)){
$response['status'] = 'sucesso';
$response['mensagem'] = 'objetivo adicionado com sucesso';
$response['data']=[
    'objetivo'=>$objetivo,
    'progresso'=>$progresso,

    'avanco'=>$avanco,
    'tipoavanco'=>$tipoavanco,

    'meta'=>$meta,
    'tipometa'=>$tipometa,

    'dia'=>$dia,
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