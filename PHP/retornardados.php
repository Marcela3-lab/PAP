<?php
include('db.php');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $idUser = mysqli_real_escape_string($conexao, $_GET['id_user']);

$sql = "SELECT nome,email,datad FROM utilizador where id_user='$idUser'";
$resultado = mysqli_query($conexao, $sql);

$dados = [];

if ($resultado && mysqli_num_rows($resultado)>0){
    while ($row = mysqli_fetch_assoc($resultado)){
        $dados[]=[
            'nome'=>$row['nome'],
            'email'=>$row['email'],
            'datad'=>$row['datad'],
            

        ];

    }
    echo json_encode($dados);


}
}
?>