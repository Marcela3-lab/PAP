<?php
include('db.php');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'GET'){
    $nome=mysqli_real_escape_string($conexao, $_GET['nome']);
    $senha=mysqli_real_escape_string($conexao, $_GET['senha']);

     $sql = "SELECT  id_user,nome,senha FROM utilizador WHERE nome = '$nome' ";
      $resultado = mysqli_query($conexao,$sql);
    $dados=[];
    if ($resultado && mysqli_num_rows($resultado)>0){
                $row = mysqli_fetch_assoc($resultado);

            if (password_verify($senha, $row['senha'])) {
              

            $dados[]=[
             'id' => $row['id_user'],
              'nome' => $row['nome'],
              

            ];
            }
            echo json_encode($dados); 
        
    } else {
        echo json_encode(null);
    }

    };

?>