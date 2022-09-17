-- Criação do banco de dados para o cenário de E-commerce
create database ecommerce;
use ecommerce;

-- drop database ecommerce;

-- Criar tabela cliente
create table clients(
	idClients INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(10),
    Mname VARCHAR(3),
    Lname VARCHAR(20),
    CPF CHAR(11) not null,
	adress VARCHAR(45),
    constraint unique_cpf_clients unique(CPF)
);

desc clients;

-- Criar tabela produto
-- Size = Dimensão do produto
create table product (
	idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(10) not null,
    classification_kids bool default false,
    category enum('Eletronico','Vestimenta','Brinquedos','Alimentos','moveis')not null, 
	avaliacao float default 0,
    size varchar(10)
);

-- Criar tabela Payments
create table payments(
    idclient int,
    id_payment int,
    id_card int,
	limitAvailable float,
    primary key(idclient, id_payment)
);	


-- Criar tabela card
create table card(
    id_card int primary key auto_increment,
    typepay enum('credit_card','debit_card','two card') not null, 
    name_card varchar(25),
	number_card int,
    cvv varchar(5),
    valid_number_card varchar(4)
);	


-- Criar tabela pedido
create table orders(
	idOrder INT AUTO_INCREMENT PRIMARY KEY,
	idOrderClient INT,
	idPaymentClient INT,
    statuspedido enum('Cancelado','Confirmado','Em processamento') not null, 
	Orderdescription varchar(45),
    sendValue float default 10,
	paymentCash boolean default false,
    
    constraint fk_order_client foreign key (idOrderClient) references clients(idClients)
		on update cascade
);	

desc orders;

-- criar tabela estoque
create table productStorage(
	idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
	storageLocation varchar(255),
	quantity int default 0
);	
-- criar tabela fornecedor

create table supplier(
	idSupplier INT AUTO_INCREMENT PRIMARY KEY,
	social_name varchar(45) not null,
	CNPJ char(45) not null,
    contact char(12) not null,
	constraint unique_cnpj_provider unique(CNPJ)

);	

-- criar tabela vendedor
create table seller(
	idSeller INT AUTO_INCREMENT PRIMARY KEY,
	social_name varchar(45) not null,
    AbstName varchar(255) not null,
	CNPJ char(45) not null,
    CPF char(9),
    location varchar(255),
    contact char(12) not null,
	constraint unique_cpf_seller unique(CPF),
	constraint unique_cnpj_seller unique(CNPJ)
);	

-- criar tabela produto vendedor
create table productSeller(
	idPseller INT,
	idPproducts INT,
    prodQuantity int default 1,
    primary key(idPseller, idPproducts),
    
    constraint fk_product_seller foreign key (idPseller) references seller(idSeller),
    constraint fk_product_product foreign key (idPproducts) references product(idProduct)
    
);

desc productSeller;


-- criar tabela ordem de produtos
create table productOrder(
	idPOproduct int,
    idPOorder int,
    posQuantity int default 1,
    posStatus enum('Disponivel','Sem estoque') default 'Disponivel',
    primary key(idPOproduct, idPOorder),
	
    
    constraint fk_product__product_seller foreign key (idPOproduct) references product(idProduct),
    constraint fk_product_Orders foreign key (idPOorder) references orders(idOrder)
);


-- criar tabela Storage Location
create table storageLocation(
	idLproduct int,
    idLstorage int,
    location varchar(255) not null,
    primary key(idLproduct, idLstorage),

    constraint fk_storage_Location_seller foreign key (idLproduct) references product(idProduct),
    constraint fk_storage_location_storage foreign key (idLstorage) references productStorage(idProdStorage)
);





-- criar tabela Products Supplier
create table productSupplier(
	idPsSuplier int,
    idPsProduct int,
    quantity int not null,
    primary key(idPsSuplier, idPsProduct),


    constraint fk_product_supplier_supplier foreign key (idPsSuplier) references supplier(idSupplier),
    constraint fk_product_supplier_prodcut foreign key (idPsProduct) references product(idProduct)
);


