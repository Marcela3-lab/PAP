<?php
// Configuração da base de dados
$host = "127.0.0.1:3306";
$utilizador = "root"; // Substitua pelo seu utilizador MySQL
$senha = ""; // Substituir pela senha do MySQL
$base_dados = "pap";

// Criar ligação ao MySQL
$conexao = mysqli_connect($host, $utilizador, $senha, $base_dados);

// Verificar a ligação
if (!$conexao) {
    die("<p>Erro ao ligar à base de dados: " . mysqli_connect_error() . "</p>");
};