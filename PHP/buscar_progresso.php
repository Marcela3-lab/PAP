<?php
include('db.php');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'GET'){
    
    $iduser = mysqli_real_escape_string($conexao, $_GET['id_user']);
    $dia = mysqli_real_escape_string($conexao, $_GET['dia']);

    $sql = "SELECT objetivo, avanco, tipoavanco, meta, tipometa, dia, progresso FROM progresso where  DATE(dia)='$dia' and id_user ='$iduser'";
    $resultado = mysqli_query($conexao,$sql);
    $dados=[];

    if ($resultado && mysqli_num_rows($resultado)>0){
        while($row = mysqli_fetch_assoc($resultado)){
$dados[] = [
    'objetivo'=>$row['objetivo'],
    'progresso' => $row['progresso'],
    'avanco'=>$row['avanco'],
    'tipoavanco' => $row['tipoavanco'],
    'meta' => $row['meta'],
    'tipometa' => $row['tipometa'],
    'dia' => $row['dia'],
    
    

];
        }
        echo json_encode($dados);
    };
}
?>