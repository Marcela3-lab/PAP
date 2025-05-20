<?php
include('db.php');
header('Content-Type: application/json');
if ($_SERVER['REQUEST_METHOD'] == 'GET'){
    
    $iduser = mysqli_real_escape_string($conexao, $_GET['id_user']);

    $sql = "SELECT id_objetivo, titulo, meta,tipo FROM objetivos where id_user ='$iduser'";
    $resultado = mysqli_query($conexao,$sql);
    $dados=[];

    if ($resultado && mysqli_num_rows($resultado)>0){
        while($row = mysqli_fetch_assoc($resultado)){
$dados[] = [
    'id_objetivo'=>$row['id_objetivo'],
    'titulo'=>$row['titulo'],
    'meta' => $row['meta'],
    'tipo'=>$row['tipo'],

];
        }
        echo json_encode($dados);
    };
}
?>