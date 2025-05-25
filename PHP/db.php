<?php
$host = "127.0.0.1:3306";
$utilizador = "root"; 
$senha = ""; 
$base_dados = "pap";

$conexao = mysqli_connect($host, $utilizador, $senha, $base_dados);

if (!$conexao) {
    die("<p>Erro ao ligar a base de dados: " . mysqli_connect_error() . "</p>");
};