<?php
header('Content-Type: application/json');
include('db.php');

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $nome = mysqli_real_escape_string($conexao, $_POST['nome']);
    $email = mysqli_real_escape_string($conexao, $_POST['email']);
    $senha = mysqli_real_escape_string($conexao, $_POST['senha']);


    // Inserir os dados na base de dados
    $sql_utilizador = "INSERT INTO utilizador (nome, email, senha,Datad) VALUES ('$nome', '$email', '$senha',NOW())";

    if (mysqli_query($conexao, $sql_utilizador)) {
        // Buscar o ID do usuário recém-criado
        $sql = "SELECT id_user FROM utilizador WHERE nome='$nome' and email='$email' AND senha='$senha'";
        $resultado = mysqli_query($conexao, $sql);
        

        if ($resultado && mysqli_num_rows($resultado) > 0) {
            $uti = mysqli_fetch_assoc($resultado);
            echo json_encode([
                "sucesso" => true,
                "mensagem" => "Conta criada com sucesso!",
                "id_user" => $uti["id_user"]
            ]);
        } else {
            echo json_encode([
                "sucesso" => false,
                "erro" => "Erro ao buscar ID do usuário."
            ]);
        }
    } else {
        echo json_encode([
            "sucesso" => false,
            "erro" => "Erro ao adicionar registro: " . mysqli_error($conexao)
        ]);
    }
}

mysqli_close($conexao);
?>
