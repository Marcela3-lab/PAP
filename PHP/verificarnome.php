<?php
include('db.php');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    

$sql = "SELECT nome,email FROM utilizador";
$resultado = mysqli_query($conexao, $sql);

$dados = [];

if ($resultado && mysqli_num_rows($resultado)>0){
    while ($row = mysqli_fetch_assoc($resultado)){
        $dados[]=[
            'nome'=>$row['nome'],
            'email'=>$row['email'],
            
            

        ];

    }
    echo json_encode($dados);


}
}
?>