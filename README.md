# Gerenciador de Despensa Doméstica 🛒

Um sistema em linha de comando (CLI) desenvolvido em **Pascal** projetado para ajudar no controle de estoque de itens residenciais e na geração automatizada de listas de compras.

O projeto foi desenvolvido de forma colaborativa como parte de uma atividade prática/acadêmica, aplicando conceitos de estruturas de dados e modularização.

---

## 🚀 Funcionalidades

- **Cadastro Inteligente:** Ao cadastrar um produto, o sistema avalia a quantidade. Se for maior que zero, vai para o Estoque; se for zero, entra automaticamente na Lista de Compras.
- **Gestão de Estoque:** Listagem de itens, inserção manual e atualização de quantidades. Se o estoque de um item ficar negativo, o sistema o move automaticamente para a lista de compras.
- **Lista de Compras Automatizada:** Permite listar as necessidades e atualizar o status quando um item é comprado, migrando-o de volta para o estoque de forma dinâmica.
- **Interface CLI Dinâmica:** Menus e submenus interativos para navegação intuitiva.

---

## 🛠️ Tecnologias e Conceitos Utilizados

- **Linguagem:** Pascal
- **Estruturas de Dados:** `Records` (para modelagem dos produtos) e Vetores/Arrays (para armazenamento local).
- **Lógica de Programação:** Modularização com funções e procedimentos (`procedures`), passagem de parâmetros, manipulação e reorganização de vetores (reordenamento pós-exclusão) e tratamento de loops estruturados.

---

## 👥 Contribuidores do Projeto

Este projeto foi construído a várias mãos! Agradecimento especial à equipe envolvida no desenvolvimento e revisões:
- **Hayanne Adryelle** (Modularização, criação dos submenus, regras de automação de fluxo e correções).
- **Mateus** (Estrutura inicial do programa, constantes e controle dos menus de estoque).
- **Vanderlei** (Funções de busca e ajustes visuais de formatação no console).
- **Júlia** (Lógica inicial para os módulos de exclusão de produtos).

---

## 🔧 Como Executar o Projeto

Para compilar e rodar o programa, você precisará de um compilador Pascal (como o Free Pascal / FPC) ou uma IDE como o Lazarus.

1. Baixe o arquivo `GerenciadorDespensa.pas`.
2. Abra o terminal na pasta do arquivo e compile:
   ```bash
   fpc GerenciadorDespensa.pas
