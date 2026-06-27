// nome do programa. % Mateus 13/06
Program GerenciadorDespensa; 

const
// constante para limitar a quantidade máxima de produtos. % Mateus 13/06
MAX_PRODUTOS = 100; 

type
// cria uma estrutura para representar um produto. % Mateus 13/06
produto = record 
  id : integer;
  nome : string;
  categoria : string;
  quantidade : integer;
end;
//**SIMPLIFICAR CODIGO Hayanne 14/06**
tipoVetor =  array[1..MAX_PRODUTOS] of produto; 

var
// vetor que armazena todos os produtos. % Mateus 13/06 **Hayanne 14/06**
estoque : tipoVetor; 
// vetor para os produtos que precisam ser comprados. % Mateus 13/06 **Hayanne 14/06**
listaCompras : tipoVetor; 
// quantidade de produtos cadastrados no estoque. % Mateus 13/06
totalEstoque : integer; 
// quantidade de produtos na lista de compras. % Mateus 13/06
totalListaCompras : integer; 
// para poder fazer as buscas e gerar IDs únicos para os produtos cadastrados ##Vanderlei 20/06
proximo_ID: integer; 

// =======================================================================
// ** FUNÇÕES DE BUSCA E ENTRADA (Movidas para cima para evitar erros de compilação) ** Hay 17/06
// =======================================================================

// Gera um identificador único para cada novo produto cadastrado ##Vanderlei 20/06
function Novo_ID: integer; 
begin
  Novo_ID := proximo_ID;
  proximo_ID := proximo_ID + 1;
end;
// ### Vanderlei 15/06 ###
function buscarProduto(id: integer; var vetor: tipoVetor; total: integer):integer; 
var
i:integer;
begin
  //função apenas para funções que precisam, não aparecerá no menu  //  ## Vanderlei 20/06 ##
  buscarProduto := 0;
  // Percorre o vetor procurando o produto pelo ID informado ##Vanderlei 23/06
  for i := 1 to total do 
  //atualizei para ser universal **Hay 19/06 //## // Atualização: inclusão de ID ##Vanderlei 20/06
  if vetor[i].id = id then 
  begin
    buscarProduto := i;
    exit;
  end;
end;

//**FUNÇÕES DE CADASTRO *Hayanne 14/06**
// **Hayanne 14/06**
function Nome:string;	
var
n:string;
begin
  writeln('informe o nome: ');
  readln(n);
  
  Nome:=n;
end;
// **Hayanne 14/06**
function Categoria:string;	
var
c:string;
begin
  writeln('informe a categoria: [ex: limpeza, alimento, pet]');
  readln(c);
  
  Categoria:=c;
end;
// **Hayanne 14/06**
function Quantidade: integer;	
var
q:integer;
begin
  writeln('informe a quantidade: ');
  readln(q);
  
  Quantidade:=q;
end;

// =======================================================================
// ** BANCO DE DADOS LOCAL (TXT) ** Hay 26/06 **
// =======================================================================

//**Hay 26/06**
procedure salvarDados; 
var
arq:text;
i: integer;
begin
  assign(arq, 'banco_despensa.txt');
  //O rewrite apaga o arquivo anterior e cria um nodo do zero
  rewrite(arq);
  
  //1. Salva a quantidade e os itens do Estoque
  writeln(arq, totalEstoque);
  for i:= 1 to totalEstoque do
  begin
    writeln(arq, estoque[i].id);
    writeln(arq, estoque[i].nome);
    writeln(arq, estoque[i].categoria);
    writeln(arq, estoque[i].quantidade);
  end;
  
  //2. Salva a quatidade e os itens da Lista de Compras
  writeln(arq, totalListaCompras);
  for i:= 1 to totalListaCompras do
  begin
    writeln(arq, listaCompras[i].id);
    writeln(arq, listaCompras[i].nome);
    writeln(arq, listaCompras[i].categoria);
    writeln(arq, listaCompras[i].quantidade);
  end;
  
  close(arq);
  writeln('Dados salvos no "banco de dados" com sucesso!');
end;
//**Hay 26/06**
procedure carregarDados;
var
arq: text;
i: integer;
begin
  assign(arq,'banco_despensa.txt');
  
  //tratamento de erro caso o arquivo ainda não exista(primeira execução)
  {$I-}
  reset(arq);
  {$I+}
  
  if IOResult <> 0 then
  begin
    //se o arquivo não existir, inicia as variaveis em zero e sai
    totalEstoque:=0;
    totalListaCompras:=0;
    exit;
  end;
  
  //1.Carrega os itens do estoque
  readln(arq, totalEstoque);
  for i:= 1 to totalEstoque do
  begin
    readln(arq, estoque[i].id);
    readln(arq, estoque[i].nome);
    readln(arq, estoque[i].categoria);
    readln(arq, estoque[i].quantidade);
  end;
  
  //2.Carrega os itens da lista de compras
  readln(arq, totalListaCompras);
  for i:= 1 to totalListaCompras do
  begin
    readln(arq, listaCompras[i].id);
    readln(arq, listaCompras[i].nome);
    readln(arq, listaCompras[i].categoria);
    readln(arq, listaCompras[i].quantidade);
  end;
    // Descobre qual o próximo ID disponível baseado no que foi carregado
	proximo_ID := 1; 
  for i := 1 to totalEstoque do
    begin
			if estoque[i].id >= proximo_ID then proximo_ID := estoque[i].id + 1;
    end;
  for i := 1 to totalListaCompras do
    begin
			if listaCompras[i].id >= proximo_ID then proximo_ID := listaCompras[i].id + 1;
    end;
    
	close(arq);
  writeln('Dados carregados com sucesso!');
  
end;

// =======================================================================
// ** PROCEDIMENTOS DE INSERÇÃO E ATUALIZAÇÃO ** manter organização para funcionar **Hay 17/06
// =======================================================================

//* PROCEDIMENTO DE INSERÇÃO DAS LISTAS **Hayanne 14/06**
procedure adicionarNoEstoque(p:produto); 
begin
  if(totalEstoque<MAX_PRODUTOS)then
  begin
    totalEstoque:= totalEstoque + 1;
    estoque[totalEstoque]:= p;
    writeln('Produto adicionado ao estoque com sucesso!');
  end
  else
  writeln('Erro: O estoque esta cheio!');
end;

procedure adicionarNaLista(p: produto);
begin
  if (totalListaCompras < MAX_PRODUTOS) then
  begin
    totalListaCompras := totalListaCompras + 1;
    listaCompras[totalListaCompras] := p;
    writeln('Produto adicionado a lista de compras!');
  end
  else
  writeln('Erro: A lista de compras esta cheia!');
end;

//+++ PROCEDIMENTO DE EXCLUIR PRODUTOS NO ESTOQUE  +++ Júlia 16/06+++
procedure excluirProdutoEstoque;
var
// add ID ##Vanderlei 20/06
p,i,id: integer;  
begin
  writeln('Digite o ID do produto que deseja excluir do estoque: ');
  readln(id);
  //agora procura por vetor **Hay 19/06
  p := buscarProduto(id, estoque, totalEstoque);
  
  if (p > 0) then
  begin
    // Reorganiza o vetor após exclusão, deslocando os elementos para preencher o espaço vazio ##Vanderlei 23/06
    for i := p to totalEstoque - 1 do
    begin
	// add begin e end para evitar confusão visual ##Vanderlei 23/06
    estoque[i] := estoque[i + 1]; 
    end;
    
    totalEstoque := totalEstoque - 1;
    
    writeln('Produto excluido do estoque com sucesso!');
    
  end
  else
  writeln('Produto nao encontrado no estoque.');
end;

//+++ PROCEDIMENTO DE EXCLUIR PRODUTOS NA LISTA DE COMPRAS  +++ Júlia 19/06+++
procedure excluirProdutoLista;
var
// add ID ##Vanderlei 20/06
p,i,id: integer; 

begin
  
  writeln('Digite o ID do produto que deseja excluir da lista: ');
  readln(id);
  //atualizado, agora procura no buscador universal **Hay 19/06**
  p := buscarProduto(id, listaCompras, totalListaCompras); 
  // Se a quantidade for maior que zero, atualiza o estoque, já se for zero ou menor, envia o produto para a lista de compras ##Vanderlei 23/06
  if (p > 0) then 
  begin
    // Remove o item da lista e reorganiza o vetor para manter a sequência sem "buracos" ##Vanderlei 23/06
    for i := p to totalListaCompras - 1 do
    begin
	// add begin e end para evitar confusão visual ##Vanderlei 23/06
    listaCompras[i] := listaCompras[i+1]; 
    end;
    
    totalListaCompras := totalListaCompras - 1;
    
    writeln('Produto excluido da lista de compras com sucesso!');
    
  end
  else
  writeln('Produto nao encontrado na lista de compras.');
end;
// ### atualizar estoque. Obs.: Apenas altera a quantidade! ### Vanderlei 15/06 ###
procedure atualizarEstoque; 
var
posicao:integer;
novaQtd:integer;
i:integer;
// add ID ##Vanderlei 20/06
id: integer;

begin
  writeln('ID do produto: ');
  readln(id);
  //atualizado **Hay 19/06**
  posicao := buscarProduto(id, estoque, totalEstoque);
  
  if posicao <> 0 then
  begin
    writeln('Nova quantidade: ');
    readln(novaQtd);
	// agora vai automaticamente para lista se quantidade negativa **Hay 17/06
    if(novaQtd > 0)then 
    begin
      estoque[posicao].quantidade := novaQtd;
      writeln('Estoque atualizado com sucesso!');
    end
  else     
  // move o item para a lista de compras mantendo o mesmo ID ##Vanderlei 23/06
  begin 
    //EXCLUI DO ESTOQUE: Puxa os produtos da frente uma posição para trás **Hay 19/06**
    adicionarNaLista(estoque[posicao]);
    for i := posicao to totalEstoque - 1 do
    begin
	// add begin e end para evitar confusão visual ##Vanderlei 23/06
    estoque[i] := estoque[i+1]; 
    end;
    
    totalEstoque := totalEstoque - 1;
    
    writeln('Quantidade negativa detectada! Produto enviado para a lista de compras.');
  end;
end
else
writeln('Erro! Produto nao encontrado.');
end;
//## Vanderlei 15/06 ##
procedure atualizarListaCompras;
var
//add ID ##Vanderlei 20/06
i, j, id: integer; 
qtdComprada: integer;
posicaoEstoque: integer;
begin
  writeln('Digite o ID do produto comprado: ');
  readln(id);
  
  for i := 1 to totalListaCompras do
  begin
    if listaCompras[i].id = id then
    begin
      writeln('Digite a quantidade que foi comprada: ');
      readln(qtdComprada);
      // atualizado **Hay 19/06** // atualizado ##Vanderlei 20/06##
      posicaoEstoque := buscarProduto(listaCompras[i].id, estoque, totalEstoque);
      // **agora adiciona automaticamente no estoque de acordo com a quantidade comprada. **Hay 17/06**
      if posicaoEstoque <> 0 then 
      begin
	  //atualizei **Hay 19/06**
        estoque[posicaoEstoque].quantidade := estoque[posicaoEstoque].quantidade + qtdComprada; 
      end
      else 
	  //adicionei **Hay 19/06**
      begin
        listaCompras[i].quantidade := qtdComprada;
        adicionarNoEstoque(listaCompras[i]);
      end;
      // Remove da lista reorganizando o vetor
      for j := i to totalListaCompras - 1 do
      begin
        listaCompras[j] := listaCompras[j + 1];
      end;
      
      totalListaCompras := totalListaCompras - 1;
      
      writeln('Produto removido da lista de compras!');
      exit;
    end;
  end;
  
  writeln('Produto nao encontrado na lista de compras.');
end;

//### PROCEDIMENTO DE ALTERAR NOME E CATEGORIA NO ESTOQUE ### Vanderlei 21/06 ###
procedure alterarProdutoEstoque;
var
id: integer;
posicao: integer;
begin
  
  writeln('Digite o ID do produto: ');
  readln(id);
  // encontra em que posição do vetor está o produto com aquele ID ##Vanderlei 21/06
  posicao := buscarProduto(id, estoque, totalEstoque); 
  
  if posicao <> 0 then
  begin
    
    writeln('Novo nome: ');
	// atualiza o nome do produto ##Vanderlei 21/06
    readln(estoque[posicao].nome); 
    
    writeln('Nova categoria: ');
	// atualiza a categoria do produto ##Vanderlei 21/06
    readln(estoque[posicao].categoria); 
    
    writeln('Produto atualizado com sucesso!');
    
  end
  else
  writeln('Produto nao encontrado.');
end;

//### PROCEDIMENTO DE ALTERAR NOME E CATEGORIA NA LISTA DE COMPRAS ### Vanderlei 21/06 ###
procedure alterarProdutoLista;
var
id: integer;
posicao: integer;
begin
  
  writeln('Digite o ID do produto: ');
  readln(id);
  // encontra em que posição do vetor está o produto com aquele ID ##Vanderlei 21/06
  posicao := buscarProduto(id, listaCompras, totalListaCompras);
  
  if posicao <> 0 then
  begin
    
    writeln('Novo nome: ');
	// atualiza o nome do produto ##Vanderlei 21/06
    readln(listaCompras[posicao].nome); 
    
    writeln('Nova categoria: ');
	// atualiza a categoria do produto ##Vanderlei 21/06
    readln(listaCompras[posicao].categoria); 
    
    writeln('Produto atualizado com sucesso!');
    
  end
  else
  writeln('Produto nao encontrado.');
end;

// =======================================================================
// ** PROCEDIMENTOS DE LISTAGEM ** Hay 17/06
// =======================================================================

//**PROCEDIMENTO DE LISTAGEM *Hayanne 14/06**
Procedure listarEstoque;
var
i:integer;
begin
  writeln('--- PRODUTOS NO ESTOQUE ---');
  if totalEstoque = 0 then
  writeln('Estoque vazio.')
  else
  begin
    for i := 1 to totalEstoque do
	// Atualizado! exibe ID  ##Vanderlei 20/06 // ## troquei write por writeln## Vanderlei 15/06
    writeln('ID: ', estoque[i].id, ' - ', estoque[i].nome, ' (Cat: ', estoque[i].categoria, ') - Qtd: ', estoque[i].quantidade); 
  end;
end;
///***Hayanne 14/06***
procedure listarListaCompras;
var i: integer;
begin
  writeln('--- LISTA DE COMPRAS ---');
  if totalListaCompras = 0 then
  writeln('Nenhum item na lista de compras.')
  else
  begin
    for i := 1 to totalListaCompras do
	// Atualizado! exibe ID ##Vanderlei 20/06
    writeln('ID: ', listaCompras[i].id, ' - ', listaCompras[i].nome, ' (Cat: ', listaCompras[i].categoria,')'); 
  end;
  writeln;
end;

// =======================================================================
// ** MENUS DO SISTEMA **
// =======================================================================

//**FUNÇÃO MENU *Hayanne 14/06** MODIFICAR DE ACORDO COM A NECESSIDADE
function Menu:Byte; 
var
op:byte;
begin
  writeln;
  repeat
    writeln('================= MENU ==================');
    writeln('1. Cadastrar Produto');
    writeln('2. Estoque');
    writeln('3. Lista de Compras');
    writeln('0. Sair');
    writeln('=========================================');
    readln(op);
  until(op in[0..3]);
  
  Menu:=op;
end;

// Função menu estoque. % Mateus 17/06
function MenuEstoque:Byte;
var
op1:byte;
begin
  writeln;
  repeat
    writeln('========== Estoque ==========');
    writeln('1. Listar produtos');
    writeln('2. Alterar Nome e Categoria');
    writeln('3. Atualizar quantidade');
    writeln('4. Excluir produto');
    writeln('0. Voltar ao Menu');
    writeln('==============================');
    readln(op1);
  until(op1 in [0..4]);
  
  MenuEstoque := op1;
end;
//**FUNÇÃO MENU lista de compras *Hay 17/06**
var
function MenuLista:Byte;
op2:byte;
begin
  writeln;
  repeat
    writeln('============== Lista de Compras ===============');
    writeln('1. Listar todos');
    writeln('2. Alterar Nome e Categoria');
    writeln('3. Adicionar quantidade comprar');
    writeln('4. excluir');
    writeln('0. Voltar ao Menu');
    writeln('===============================================');
    readln(op2);
  until(op2 in[0..4]);
  
  MenuLista:=op2;
end;

// * FUNÇÃO GETREGISTRO **Hayanne 14/06**
function Registro:produto; 
var
p:produto;
qtd:byte;
begin
//atribui o ID atual ao produto ##Vanderlei 20/06
  p.id := Novo_ID; 
  
  p.nome := Nome;
  p.categoria:= Categoria;
  //**Guarda o valor em uma variável para não chamar a função duas vezes *Hayanne 14/06**
  qtd:= Quantidade;
  p.quantidade:= qtd;
  
  if(qtd > 0)then
  adicionarNoEstoque(p)
  else
  adicionarNaLista(p);
  
  Registro:= p;
end;
// =======================================================================
// ** FLUXO PRINCIPAL **
// =======================================================================

//**ONDE A MAGICA ACONTECE/PROCEMINTO DE INICIO *Hayanne 14/06**
procedure inicio; 
var
op,op1,op2:byte;
begin
  op:= Menu;
  while(op<>0)do
  begin
    case(op)of
      1:begin
	  //**CHAMA A FUNÇÃO DE CADASTRO *Hayanne 14/06** ## Apenas atualizando na ordem do menu ## Vanderlei 15/06 ##
        Registro;
      end;
      2:begin
	   //%Mateus 17/06%
        op1 := MenuEstoque;
        while(op1 <> 0) do
        begin
          case(op1) of
            1:begin
              listarEstoque;
            end;
            2:begin
              alterarProdutoEstoque;
            end;
            3:begin
              atualizarEstoque;
            end;
            4:begin
              excluirProdutoEstoque;
            end;
          end;
          op1 := MenuEstoque;
        end;
      end;
      3:begin
	  //CHAMA SUB-MENU DA LISTA DE COMPRAS *** HAY 17/06 ***
        op2:= MenuLista;
        while(op2<>0)do
        begin
          case(op2)of
            1:begin
              listarListaCompras;
            end;
            2:begin
              alterarProdutoLista;
            end;
            3:begin
              atualizarListaCompras;
            end;
            4:begin
              excluirProdutoLista;
            end;
          end;
          op2 := MenuLista;
        end;
      end;
    end;
	//**EVITAR LOOP INFINITO **Hayanne 14/06
    op:= Menu; 
  end;
end;


//**CORPO PRINCIPAL*Hayanne 14/06**
begin
  //Em vez de zerar na mão, chamamos o carregador do banco de dados
  carregarDados;
  
  writeln('Pressione Enter para entrar no sistema...');
  readln;
  //**INICIALIZA executando os menus do sistema **Hayanne 14/06**
  inicio;
  
  //quando o usuario escolhe '0.sair', o fluxo volta para cá e salva tudo!
  salvarDados;
end.
