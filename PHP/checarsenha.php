<?php
include('db.php');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'GET'){
    $nome=mysqli_real_escape_string($conexao, $_GET['nome']);
    $senha=mysqli_real_escape_string($conexao, $_GET['senha']);


     $sql = "SELECT  nome FROM utilizador WHERE nome = '$nome' AND senha = '$senha'";
      $resultado = mysqli_query($conexao,$sql);
    $dados=false;

    if ($resultado && mysqli_num_rows($resultado)>0){
        
$dados=true;
        }
        echo json_encode($dados);
    };

?>