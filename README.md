
# APLICATIVO DE ESTOQUE - ESTOK_APP

nome: estok_app

Aplicativo para fazer o controle de estoques de produtos de mercearias, lojas e etc, de pequeno porte. 
Isso inclui o cadastro, atualização, busca e exclusão de produtos e estoques por 
um usuário autenticado, além do registro de movimentações no app.


## Funcionalidades

	O aplicativo deve:

	1 - Fazer a autenticação de usuário - 'cadastro' e login, logout;
	3 - Fazer o gerenciamento de estoques - descrição, data de entrada, data de vencimento, quantidade total, tipo (Pacote, Grade, Caixa), valor total, status (EM FALTA, EM ESTOQUE, EM AVISO);
	4 - Fazer o gerenciamento de produtos - nome, descrição, quantidade, valor item, valor unitário e site;
	5 - Exibir histórico de movimentações (codigo, nome, data, tipo);

### 1.1 -  Fazer a autenticação de usuário

	O aplicativo deve efetuar a autenticação do usuario através do servidor de autenticação. 
	Os dados do usuario já estão previamente cadastrados no servidor.
	O usuario efetuará login com o usuario salvo onde receberá um token de autenticação
	que será usado para autenticar o acesso as demais funcionalidades dentro do app. O mesmo também,
	ao sair do app,	O que significa fazer logout com o servidor.
	
### 1.2 - Fazer o gerenciamento de estoques

	O sistema deve oferecer um CRUD de estoques. Deve fornecer a lista de estoques cadastrados, 
	assim como um formulário de cadastro para um novo estoque informando os campos: descrição, 
	data de entrada, data de vencimento, quantidade total, tipo (Pacote, Grade, Caixa), valor total, 
	status (EM FALTA, EM ESTOQUE, EM AVISO).
	Além disso, deve oferecer a possibilidade de atualização e exclusão.
		
### 1.4 - Fazer o gerenciamento de produtos

	O sistema deve oferecer um CRUD de produtos. Deve fornecer a lista de produtos cadastrados, 
	assim como um formulário de cadastro para um novo produto informando os campos: nome, descrição, quantidade, valor item, valor unitário e site.
	Além disso, deve oferecer a possibilidade de atualização e exclusão.

### 1.5 - Exibir histórico de movimentações 
	
	O sistema deve registrar um históricos de movimentações e mudanças dentro do app com os campos 
	(codigo, nome, data, tipo -(PRODUTO, ESTOQUE)), além de exibir o histórico de modificações.
	Os dados de histórico deverão ser salvos localmente - no banco de dados local - 
	e exibidos caso não haja conexão com  a internet.
	
## Regras de negocio

	- O sistema deve exibir o status do estoque dos produto visando a quantidade de acordo com a regra:
	
		- EM FALTA: 0 produtos no estoque;
		- EM AVISO: entre 5 e 1 no estoque;
		- EM ESTOQUE: acima de 5
		
	- Ao excluir um produto, ou o app deve atualizar os valores e quantidades no estoque;
	

- [Link do mockup no figma](https://www.figma.com/file/6GUWjEBZLygSWRC1ueG5CD/estok_app?node-id=1%3A39&t=44oZYe9sTAyUYRgr-1)

## Para os alunos

	- Cada aluno deve criar sua propria branch apartir da main com a seguinte nomeclatura:
	
		nome-do-app/seu-nome
	
	- Não será considerado o projeto que commitar alterações na main, sendo zerado automaticamente. 
	
	- Cada aluno pode fazer suas alterações como desejar na sua branch, ou somente commitar ao concluir seu desenvolvimento, como desejar.
	
	- O projeto de cada branch deve estar totalmente funcional para avaliação, de acordo com o proptotipo no figma, e com os requisitos da avaliação.
	
	
