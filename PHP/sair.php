<?php
include('db.php');
header('Content-Type: application/json');
if ($_SERVER['REQUEST_METHOD'] == 'GET'){

 $iduser = mysqli_real_escape_string($conexao, $_GET['id_user']);
     $sql = "DELETE FROM utilizador WHERE id_user = '$iduser'";
       $resultado = mysqli_query($conexao,$sql);
    $dados=false;

    if ($resultado && mysqli_affected_rows($conexao) > 0){
        
$dados = true;
    }

    echo json_encode($dados);

}
?>
