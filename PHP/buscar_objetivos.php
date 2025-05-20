<?php
include('db.php');
header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] == 'GET') {
    $idUser = mysqli_real_escape_string($conexao, $_GET['id_user']);

$sql = "SELECT id_objetivo, titulo, descricao, meta,  cor, tipo FROM objetivos where id_user='$idUser'";
$resultado = mysqli_query($conexao, $sql);

$dados = [];

if ($resultado && mysqli_num_rows($resultado)>0){
    while ($row = mysqli_fetch_assoc($resultado)){
        $dados[]=[
            'id_objetivo'=>$row['id_objetivo'],
            'titulo'=>$row['titulo'],
            'descricao'=>$row['descricao'],
            'meta'=>$row['meta'],
            'cor'=>$row['cor'],
            'tipo'=>$row['tipo'],

        ];

    }
    echo json_encode($dados);


}
}
?>