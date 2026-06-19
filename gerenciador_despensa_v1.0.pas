Program GerenciadorDespensa; // nome do programa. % Mateus 13/06

const
	MAX_PRODUTOS = 100; // constante para limitar a quantidade máxima de produtos. % Mateus 13/06
	
type
	produto = record // cria uma estrutura para representar um produto. % Mateus 13/06
		nome : string;
		categoria : string;
		quantidade : integer;
	end;
tipoVetor =  array[1..MAX_PRODUTOS] of produto; //**SIMPLIFICAR CODIGO Hayanne 14/06**
	
var
	estoque : tipoVetor; // vetor que armazena todos os produtos. % Mateus 13/06 **Hayanne 14/06**
	listaCompras : tipoVetor; // vetor para os produtos que precisam ser comprados. % Mateus 13/06 **Hayanne 14/06**
	
	totalEstoque : integer; // quantidade de produtos cadastrados no estoque. % Mateus 13/06
	totalListaCompras : integer; // quantidade de produtos na lista de compras. % Mateus 13/06


// =======================================================================
// ** FUNÇÕES DE BUSCA E ENTRADA (Movidas para cima para evitar erros de compilação) ** Hay 17/06
// =======================================================================

function getbuscarProduto(nome:string):integer; // ### uma função para localizar o produto, mas da para inserir tudo no procedure tbm! ### Vanderlei 15/06 ### 
var
  i:integer;
begin
  getbuscarProduto := 0;//função apenas para funções que precisam, não aparecerá no menu

  for i := 1 to totalEstoque do
    if estoque[i].nome = nome then //talvez melhor por ID
    begin
      getbuscarProduto := i;
      exit;
    end;
end;

//**FUNÇÕES DE CADASTRO *Hayanne 14/06**
function getNome:string;	// **Hayanne 14/06**
var
	n:string;
begin
	writeln('informe o nome: ');
	readln(n);
	
	getNome:=n;
end;

function getCategoria:string;	// **Hayanne 14/06**
var
	c:string;
begin
	writeln('informe a categoria: [ex: limpeza, alimento, pet]');
	readln(c);
	
	getCategoria:=c;
end;

function getQuantidade: byte;	// **Hayanne 14/06**
var
	q:byte;
begin
	writeln('informe a quantidade: ');
	readln(q);
	
	getQuantidade:=q;
end;

// =======================================================================
// ** PROCEDIMENTOS DE INSERÇÃO E ATUALIZAÇÃO ** manter organização para funcionar **Hay 17/06
// =======================================================================

procedure adicionarNoEstoque(p:produto); //* PROCEDIMENTO DE INSERÇÃO DAS LISTAS **Hayanne 14/06**
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

//+++ PROCEDIMENTO DE EXCLUIR PRODUTOS NO ESTOQUE E NAS LISTAS+++ Júlia 16/06+++
{procedure excluirProdutoEstoqueLista (nome: string);
var p: integer; 
 begin
 
 p := getbuscarProduto(nome);
 
 if () then }

procedure atualizarEstoque; // ### atualizar estoque. Obs.: Apenas altera a quantidade! ### Vanderlei 15/06 ### 
var
  nome:string;
  posicao:integer;
  novaQtd:integer;
begin
  writeln('Nome do produto: ');
  readln(nome);

  posicao := getbuscarProduto(nome);

  if posicao <> 0 then
  begin
    writeln('Nova quantidade: ');
    readln(novaQtd);
			if(novaQtd >= 0)then // agora vai automaticamente para lista se quantidade negativa **Hay 17/06
	 	 		begin
					estoque[posicao].quantidade := novaQtd;
	 	 			writeln('Estoque atualizado com sucesso!');
	 	 		end
	 		else
	    	begin
					estoque[posicao].quantidade := novaQtd; 
     			adicionarNaLista(estoque[posicao]); 
    	  	writeln('Quantidade negativa detectada! Produto enviado para a lista de compras.');
        end;
	end
  else
    writeln('Erro! Produto nao encontrado.');
end;

procedure atualizarListaCompras; //Obs.: Apenas remove item da lista! ## Vanderlei 15/06 ##
var
  nome:string;
  i,j:integer;
	qtdComprada: integer;
	posicaoEstoque:integer;                                                                                          
begin
  writeln('Digite o nome do produto comprado: ');
  readln(nome);

  for i:= 1 to totalListaCompras do
  begin
    if listaCompras[i].nome = nome then
    begin
    	write('digite a quantidade que foi comprada: ');
    	readln(qtdComprada);
    	
			posicaoEstoque := getbuscarProduto(nome);
      
      if posicaoEstoque <> 0 then //**agora adiciona automaticamente no estoque de acordo com a quantidade comprada. **Hay 17/06**
      	estoque[posicaoEstoque].quantidade := qtdComprada
      else
      	writeln('Aviso: Produto nao encontrado no estoque principal para atualizar.');
			
			// Remove da lista reorganizando o vetor
			for j:=i to totalListaCompras - 1 do
        listaCompras[j] := listaCompras[j+1];

      totalListaCompras := totalListaCompras - 1;
      writeln('Produto removido da lista de compras! ');
      exit;
    end;
  end;
  writeln('Produto nao encontrado na lista de compras.');
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
	  	writeln('- ', estoque[i].nome, ' (Cat: ', estoque[i].categoria, ') - Qtd: ', estoque[i].quantidade); // ## troquei write por writeln para ficar visivelmente melhor no programa## Vanderlei 15/06
	end;
end;

procedure listarListaCompras;///***Hayanne 14/06***
var i: integer;
begin
    writeln('--- LISTA DE COMPRAS ---');
    if totalListaCompras = 0 then
        writeln('Nenhum item na lista de compras.')
    else
    begin
        for i := 1 to totalListaCompras do
            writeln('- ', listaCompras[i].nome, ' (Cat: ', listaCompras[i].categoria, ')');  
    end;
    writeln;
end;

// =======================================================================
// ** MENUS DO SISTEMA **
// =======================================================================


function getMenu:Byte; //**FUNÇÃO MENU *Hayanne 14/06** MODIFICAR DE ACORDO COM A NECESSIDADE 
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
	
	getMenu:=op;
end;

// Função menu estoque. % Mateus 17/06
function getMenuEstoque:Byte;
var
	op1:byte;
begin
	writeln;
	repeat
		writeln('========== Estoque ==========');
		writeln('1. Listar produtos');
		writeln('2. Adicionar produto');
		writeln('3. Atualizar quantidade');
		writeln('4. Excluir produto');
		writeln('0. Voltar');
		writeln('==============================');
	readln(op1);
	until(op1 in [0..4]);
	
	getMenuEstoque := op1;
end;

function getMenuLista:Byte;//**FUNÇÃO MENU lista de compras *Hay 17/06**  
var
	op2:byte;
begin
	writeln;
	repeat
		writeln('============== Lista de Compras ===============');
	  writeln('1. Listar todos');
	  writeln('2. Alterar Nome e Categoria');
	  writeln('3. Atualizar Quatidade');
		writeln('4. excluir'); 
	  writeln('0. Voltar ao Menu');
	  writeln('===============================================');
	readln(op2);
	until(op2 in[0..4]);
	
	getMenuLista:=op2;
end;


function getRegistro:produto; // * FUNÇÃO GETREGISTRO **Hayanne 14/06**
var
	p:produto;
	qtd:byte;
begin
	 p.nome:= getNome;
	 p.categoria:= getCategoria;
	 
	 qtd:= getQuantidade;//**Guarda o valor em uma variável para não chamar a função duas vezes *Hayanne 14/06**
	 p.quantidade:= qtd;
	 	
		 if(qtd > 0)then
	 	  adicionarNoEstoque(p)
	 	else
	    adicionarNaLista(p);
	    
	 getRegistro:=p;
end;

// =======================================================================
// ** FLUXO PRINCIPAL **
// =======================================================================

procedure inicio; //**ONDE A MAGICA ACONTECE/PROCEMINTO DE INICIO *Hayanne 14/06**
var
	op,op1,op2:byte;
begin
	op:= getMenu;
	while(op<>0)do
	begin
		case(op)of
			1:begin
			  	getRegistro;//**CHAMA A FUNÇÃO DE CADASTRO *Hayanne 14/06** ## Apenas atualizando na ordem do menu ## Vanderlei 15/06 ##
				end;
			2:begin //%Mateus 17/06%
			  	op1 := getMenuEstoque;
					
					while(op1 <> 0) do
					begin
						case(op1) of
							1:begin
							 		listarEstoque;
							 	end;	
							2:begin
									getRegistro;
							  end;
							3:begin
									atualizarEstoque;
							  end;
							4:begin
									writeln('Opcao em desenvolvimento...');{ excluir produto}	
								end;							
						end;
						op1 := getMenuEstoque;  
					end;	
				end;
			3:begin
			     op2:= getMenuLista;//CHAMA SUB-MENU DA LISTA DE COMPRAS *** HAY 17/06 ***
			     while(op2<>0)do
						begin
							case(op2)of
								1:begin
								   listarListaCompras;
									end;
								2:begin
								   writeln('Opcao em desenvolvimento...');
									end;
								3:begin
								   atualizarListaCompras;
									end;
								4:begin
								   writeln('Opcao em desenvolvimento...');
									end;		
						 	end;
						 	op2 := getMenuLista;
						end; 	
				end;
		end;
		op:= getMenu; //**EVITAR LOOP INFINITO **Hayanne 14/06
	end;
end;


//**CORPO PRINCIPAL*Hayanne 14/06**	
begin                           
	totalEstoque := 0; // inicializa a quantidade de produtos do estoque. % Mateus 13/06
	totalListaCompras := 0; // inicializa a quantidade de produtos da lista de compras. % Mateus 13/06
	
	inicio; //**INICIALIZA O INICIO **Hayanne14/06
end.