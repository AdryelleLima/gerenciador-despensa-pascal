# Gerenciador de Despensa Doméstica 🛒

Um sistema em linha de comando (CLI) desenvolvido em **Pascal** projetado para ajudar no controle de estoque de itens residenciais e na geração automatizada de listas de compras.

O projeto foi desenvolvido de forma colaborativa como parte de uma atividade prática/acadêmica, aplicando conceitos de estruturas de dados e modularização.

> 🥇 **Status do Projeto:** **v1.0 (Versão Final Acadêmica)**. Projeto concluído, integrado e entregue com sucesso como requisito para a disciplina do 1º semestre de 2026.

---

## 🚀 Funcionalidades Atuais

- **Identificação por Chave Única (ID):** Todos os produtos recebem um identificador numérico gerado automaticamente pelo sistema, servindo como chave primária para buscas, edições e exclusões, eliminando duplicidades ou conflitos por nomes.
- **Cadastro Inteligente:** Ao cadastrar um produto, o sistema avalia a quantidade. Se for maior que zero, vai para o Estoque; se for zero, entra automaticamente na Lista de Compras.
- **Buscador Universal Dinâmico:** Otimização de código através de uma função única de busca indexada por ID que aceita diferentes estruturas de vetores por parâmetro.
- **Gestão Automática de Fluxo:** Se a quantidade de um item no estoque for atualizada para zero ou negativa, o sistema faz o manejo dinâmico: remove o item do estoque físico e o transfere para a lista de compras.
- **CRUD Completo:** Permite a listagem, alteração de dados cadastrais (nome/categoria), atualização de saldo e remoção definitiva de produtos tanto do estoque principal quanto da lista de compras.
- **Interface CLI Dinâmica:** Menus e submenus interativos para navegação intuitiva.
- **Banco de Dados Local (Flat-File):** Integração com arquivo físico (`banco_despensa.txt`). O sistema carrega os dados e reconstrói os vetores e o próximo ID automaticamente ao iniciar, e grava o estado atualizado da memória ao encerrar a aplicação.

---

## 📐 Engenharia de Software e Rastreabilidade do Código

Para este projeto, optamos por não apenas escrever o código, mas documentar visualmente toda a sua arquitetura e ciclo de vida. Mapeamos o fluxo completo de desenvolvimento estruturando os seguintes pilares:

1. **Definição de Escopo:** Divisão clara entre Requisitos Funcionais (RF), Não-Funcionais (RNF), Regras de Negócio (RN) e Requisitos de Validação (RV).
2. **Ciclo de Vida Limpo (MVP):** Descarte consciente de funcionalidades complexas (como sistemas de login ou notificações em tempo real) que comprometeriam o prazo final de entrega acadêmico.
3. **Mapeamento de Módulos:** Conexão direta e visual entre os blocos lógicos do algoritmo em Pascal (`procedures` e `functions`) e os requisitos combinados.

### 🔄 Estratégia de Desenvolvimento Síncrono e Colaborativo

> **Nota de Engenharia:** Como o ambiente de desenvolvimento Pascal não permite a edição simultânea do mesmo arquivo de código por múltiplos usuários em tempo real, utilizamos um Whiteboard Interativo como nossa ferramenta de **Live Share / Pair Programming Visual**. 
>
> Isso permitiu que toda a equipe visualizasse, debatesse e fizesse modificações na estrutura lógica do algoritmo ao mesmo tempo, mitigando conflitos de código (*merge conflicts*) e garantindo o aprendizado coletivo antes da consolidação do arquivo final.

![Documentação Técnica e Mapeamento do Código](img/documentacao-completa-1.png)

---

## 🔮Possíveis Evoluções (Melhorias Sugeridas)

[cite_start]Caso o projeto seja retomado em semestres futuros ou expandido de forma independente, as seguintes melhorias são recomendadas:
- [cite_start]**Interface Gráfica (GUI):** Migrar a interface de linha de comando (CLI) para uma aplicação visual (utilizando Lazarus/LCL).
- [cite_start]**Banco de Dados Relacional:** Substituir o armazenamento em arquivo texto por um banco de dados relacional embarcado (como SQLite ou MySQL).
- **Arquitetura Modular:** Separação física do código em unidades (`Units` do Pascal) para isolar completamente a lógica de persistência de dados da camada de interface.

---

## 🛠️ Tecnologias e Conceitos Utilizados

- **Linguagem:** Pascal
- **Estruturas de Dados:** `Records` (para modelagem complexa dos produtos) e Vetores/Arrays dinâmicos indexados.
- **Persistência de Dados:** Manipulação de Arquivos de Texto (`Assign`, `Reset`, `Rewrite`, `Append` e tratamento de exceções de I/O com diretivas `{$I-}` / `{$I+}`).
- **Lógica de Programação:** Modularização avançada com funções e procedimentos, passagem de parâmetros por referência (`var`), geração de chaves primárias, reorganização física de vetores (deslocamento de índices pós-exclusão) e tratamento de loops estruturados.

---

## 👥 Gestão e Contribuidores do Projeto

Este projeto foi desenvolvido de forma colaborativa utilizando o framework **Scrum** para garantir o alinhamento da equipe, a divisão eficiente de tarefas e a entrega dos resultados dentro do prazo acadêmico. 

A engenharia de processos e a facilitação do time foram lideradas por nossa integrante já graduada em Gestão de TI.

- **[Hayanne Adryelle](https://github.com/AdryelleLima) — Product Owner, Scrum Master & Tech Lead**
  Responsável pela governança do projeto, organização do backlog, facilitação das reuniões de alinhamento de objetivos e garantia das entregas. Atuou também no desenvolvimento técnico na modularização, submenus, arquitetura da persistência em arquivos TXT, criação do buscador universal de vetores por parâmetro, regras de automação de fluxo do sistema e revisão final do código de versionamento.
  
- **[Mateus](https://github.com/usuario-do-mateus) — Desenvolvedor de Infraestrutura**
  Responsável pela arquitetura e estrutura inicial do programa,definição das constantes de limites, mitigação de impedimentos técnicos do time, controle dos fluxos do menu de estoque e loops de validação do menu principal.

- **[Vanderlei](https://github.com/usuario-do-vanderlei) — Desenvolvedor de Lógica**
  Responsável pela implementação do sistema de identificação única (ID), criação do buscador, desenvolvimento dos módulos de alteração cadastral, mitigação de impedimentos técnicos do time e refatoração visual do console.

- **[Júlia](https://github.com/JuliaLimaB007) — Desenvolvedora de Módulos**
  Responsável pelo escopo focado na arquitetura e lógica inicial dos módulos de exclusão física de produtos e organização do fluxo de limpeza de vetores.

---

## 🔧 Como Executar o Projeto

Para compilar e rodar o programa, você precisará de um compilador Pascal (como o Free Pascal / FPC) ou uma IDE como o Lazarus.

1. Baixe o arquivo `GerenciadorDespensa.pas`.
2. Abra o terminal na pasta do arquivo e compile:
   ```bash
   fpc GerenciadorDespensa.pas
