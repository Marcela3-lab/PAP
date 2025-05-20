<?php
include('db.php');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'GET'){
    $iduser = mysqli_real_escape_string($conexao, $_GET['id_user']);
    

$sql = "SELECT COUNT(*) AS concluida FROM agenda where estado ='concluida' and id_user='$iduser' and dia = CURDATE()" ;
    $resultado = mysqli_query($conexao, $sql);
        $dados=[];

if ($resultado && mysqli_num_rows($resultado) > 0) {
    $row = mysqli_fetch_assoc($resultado);
    $dados = ['total2' => $row['concluida']]; 
    echo json_encode($dados);
} else {
    echo json_encode(['total' => 0]);
}
}

?>