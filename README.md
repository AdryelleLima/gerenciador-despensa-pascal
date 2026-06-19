# Gerenciador de Despensa Doméstica 🛒

Um sistema em linha de comando (CLI) desenvolvido em **Pascal** projetado para ajudar no controle de estoque de itens residenciais e na geração automatizada de listas de compras.

O projeto foi desenvolvido de forma colaborativa como parte de uma atividade prática/acadêmica, aplicando conceitos de estruturas de dados e modularização.

> ⚠️ **Nota de Desenvolvimento:** Este projeto está em sua **fase inicial de desenvolvimento (v0.1-alpha)**. Algumas funcionalidades de exclusão e edição ainda estão sendo implementadas e testadas pela equipe.

---

## 🚀 Funcionalidades Atuais

- **Cadastro Inteligente:** Ao cadastrar um produto, o sistema avalia a quantidade. Se for maior que zero, vai para o Estoque; se for zero, entra automaticamente na Lista de Compras.
- **Gestão de Estoque:** Listagem de itens, inserção manual e atualização de quantidades. Se o estoque de um item ficar de forma inválida/negativa, o sistema o move automaticamente para a lista de compras.
- **Lista de Compras Automatizada:** Permite listar as necessidades e atualizar o status quando um item é comprado, migrando-o de volta para o estoque de forma dinâmica.
- **Interface CLI Dinâmica:** Menus e submenus interativos para navegação intuitiva.

---

## 📐 Engenharia de Software e Rastreabilidade do Código

Para este projeto, optamos por não apenas escrever o código, mas documentar visualmente toda a sua arquitetura e ciclo de vida. Mapeamos o fluxo completo de desenvolvimento estruturando os seguintes pilares:

1. **Definição de Escopo:** Divisão clara entre Requisitos Funcionais (RF), Não-Funcionais (RNF), Regras de Negócio (RN) e Requisitos de Validação (RV).
2. **Ciclo de Vida Limpo (MVP):** Descarte consciente de funcionalidades complexas (como sistemas de login ou notificações) que comprometeriam o prazo final de entrega.
3. **Mapeamento de Módulos:** Conexão direta e visual entre os blocos lógicos do algoritmo em Pascal (`procedures` e `functions`) e os requisitos combinados.

### 🔄 Estratégia de Desenvolvimento Síncrono e Colaborativo

> **Nota de Engenharia:** Como o ambiente de desenvolvimento Pascal não permite a edição simultânea do mesmo arquivo de código por múltiplos usuários em tempo real, utilizamos um Whiteboard Interativo como nossa ferramenta de **Live Share / Pair Programming Visual**. 
>
> Isso permitiu que toda a equipe visualizasse, debatesse e fizesse modificações na estrutura lógica do algoritmo ao mesmo tempo, mitigando conflitos de código (*merge conflicts*) e garantindo o aprendizado coletivo antes da consolidação do arquivo final.

![Documentação Técnica e Mapeamento do Código]("C:\Users\adrye\Downloads\documentacao-completa.png")

---

## 🔮 Próximas Implementações (Melhorias Futuras)

O projeto ainda não é uma versão final. Planejamos implementar as seguintes melhorias em breve:
- [ ] **Módulo de Exclusão:** Conclusão da lógica para remover completamente produtos do estoque ou da lista de compras.
- [ ] **Edição de Cadastro:** Permitir alterar o nome e a categoria de um produto sem precisar excluí-lo.
- [ ] **Persistência de Dados:** Implementar gravação e leitura em arquivos de texto (`.txt` ou `.dat`) para que os dados não sejam perdidos ao fechar o programa.
- [ ] **Identificação por ID:** Substituir a busca por nome por um identificador único (ID numérico) para evitar problemas com produtos de nomes parecidos.

---

## 🛠️ Tecnologias e Conceitos Utilizados

- **Linguagem:** Pascal
- **Estruturas de Dados:** `Records` (para modelagem dos produtos) e Vetores/Arrays (para armazenamento local).
- **Lógica de Programação:** Modularização com funções e procedimentos (`procedures`), passagem de parâmetros, manipulação e reorganização de vetores (reordenamento pós-exclusão) e tratamento de loops estruturados.

---

## 👥 Gestão e Contribuidores do Projeto

Este projeto foi desenvolvido de forma colaborativa utilizando o framework **Scrum** para garantir o alinhamento da equipe, a divisão eficiente de tarefas e a entrega dos resultados dentro do prazo acadêmico. 

A engenharia de processos e a facilitação do time foram lideradas por nossa integrante já graduada em Gestão de TI.

- **[Hayanne Adryelle](https://github.com/AdryelleLima) — Product Owner, Scrum Master & Tech Lead**
  Responsável pela governança do projeto, organização do backlog, facilitação das reuniões de alinhamento de objetivos e garantia das entregas. Atuou também no desenvolvimento técnico na modularização, submenus, regras de automação de fluxo do sistema e revisão do código.

- **[Mateus](https://github.com/usuario-do-mateus) — Desenvolvedor**
  Responsável pela arquitetura e estrutura inicial do programa, definição de constantes, mitigação de impedimentos técnicos do time e controle dos fluxos do menu de estoque.

- **[Vanderlei](https://github.com/usuario-do-vanderlei) — Desenvolvedor**
  Responsável pela implementação das funções de busca de produtos e refatoração visual do console para melhor experiência do usuário.

- **[Júlia](https://github.com/JuliaLimaB007) — Desenvolvedora**
  Responsável pelo escopo focado na arquitetura e lógica inicial dos módulos de exclusão de produtos do estoque.

---

## 🔧 Como Executar o Projeto

Para compilar e rodar o programa, você precisará de um compilador Pascal (como o Free Pascal / FPC) ou uma IDE como o Lazarus.

1. Baixe o arquivo `GerenciadorDespensa.pas`.
2. Abra o terminal na pasta do arquivo e compile:
   ```bash
   fpc GerenciadorDespensa.pas
