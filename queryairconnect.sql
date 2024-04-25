use airconnect;

create table cliente (
    id int auto_increment primary key,
    nome_completo varchar(400),
    tipo_identificacao varchar(20),
    numero_identificacao varchar(15),
    nacionalidade varchar(100),
    data_nascimento date,
    sexo varchar(2),
    categoria_fidelidade varchar(100),
    pontos_acumulados int
);

create table contato_cliente (
    id int auto_increment primary key,
    cliente_id int,
    foreign key (cliente_id) references cliente(id),
    tipo_contato varchar(45),
    valor varchar(45)
);

create table endereco_cliente (
    id int auto_increment primary key,
    cliente_id int,
    foreign key (cliente_id) references cliente(id),
    tipo_endereco varchar(100),
    logradouro varchar(200),
    numero int,
    complemento varchar(100),
    bairro varchar(100),
    cidade varchar(45),
    estado varchar(45),
    pais varchar(45),
    cep varchar(45)
);

create table aeronave (
    id int auto_increment primary key,
    modelo varchar(100),
    fabricante varchar(100),
    ano_fabricacao int,
    ultima_manutencao datetime,
    horas_voo int,
    status_operacional varchar(100)
);

create table voo (
    id int auto_increment primary key,
    aeronave_id int,
    foreign key (aeronave_id) references aeronave(id),
    codigo varchar(100),
    destino varchar(45),
    data_hora_partida datetime,
    data_hora_chegada datetime,
    status varchar(45),
    tipo_voo varchar(45)
);

create table log_voo (
    id int auto_increment primary key,
    voo_id int,
    foreign key (voo_id) references voo(id),
    observacoes varchar(500),
    incidentes varchar(200),
    medidas_corretivas varchar(200)
);

create table cargo_voo (
    id int auto_increment primary key,
    voo_id int,
    foreign key (voo_id) references voo(id),
    descricao_cargo varchar(45),
    peso varchar(45),
    tipo_cargo varchar(45),
    status_seguranca varchar(45)
);

create table detalhes_voo (
    id int auto_increment primary key,
    voo_id int,
    foreign key (voo_id) references voo(id),
    aeronave_id int,
    foreign key (aeronave_id) references aeronave(id),
    tipo_aeronave varchar(70),
    configuracao_assentos varchar(100),
    distancia_km double,
    tempo_estimado varchar(50),
    consumo_estimado_combustivel double,
    consumo_real_combustivel double,
    emissoes_estimadas_co2 varchar(100),
    data DATE
);

create table programacao_voo (
    id int auto_increment primary key,
    voo_id int,
    foreign key (voo_id) references voo(id),
    frequencia varchar(45),
    temporada varchar(45)
);

create table funcionario (
    id int auto_increment primary key,
    funcao varchar(100),
    data_admissao date,
    departamento varchar(45),
    status_emprego varchar(45)
);

create table qualificacoes (
    id int auto_increment primary key,
    funcionario_id int,
    foreign key (funcionario_id) references funcionario(id),
    tipo_qualificacao varchar(45),
    data_qualificacao date,
    data_expiracao date
);

create table treinamento_funcionario (
    id int auto_increment primary key,
    funcionario_id int,
    foreign key (funcionario_id) references funcionario(id),
    data_inicio date,
    data_conclusao date,
    resultado varchar(45),
    tipo_treinamento varchar(100)
);

create table escala_tripulacao (
    id int auto_increment primary key,
    funcionario_id int,
    foreign key (funcionario_id) references funcionario(id),
    voo_id int,
    foreign key (voo_id) references voo(id),
    data date,
    posicao varchar(45)
);

create table historico_tripulacao (
    id int auto_increment primary key,
    funcionario_id int,
    foreign key (funcionario_id) references funcionario (id),
    voo_id int,
    foreign key (voo_id) references voo (id),
    data_voo datetime,
    funcao_desempenhada varchar(200),
    avaliacao_desempenho varchar(400)
);

create table registro_manutencao (
    id int auto_increment primary key,
    aeronave_id int,
    foreign key (aeronave_id) references aeronave(id),
    tipo varchar(100),
    descricao varchar(200),
    data date,
    horas_trabalho int,
    custo double
);

create table log_inspecao (
    id int auto_increment primary key,
    aeronave_id int,
    foreign key (aeronave_id) references aeronave(id),
    data date,
    tipo_inspecao varchar(45),
    resultados varchar(200),
    recomendacoes varchar(100)
);

create table inventario_pecas (
    id int auto_increment primary key,
    aeronave_id int,
    foreign key (aeronave_id) references aeronave(id),
    descricao varchar(100),
    numero_serie int,
    quantidade_estoque int,
    localizacao_deposito varchar(100),
    data_ultima_inspecao datetime
);

create table transacao_financeira (
    id int auto_increment primary key,
    voo_id int,
    foreign key (voo_id) references voo(id),
    cliente_id int,
    foreign key (cliente_id) references cliente(id),
    registro_manutencao_id int,
    foreign key (registro_manutencao_id) references registro_manutencao(id),
    tipo_transacao varchar(50),
    descricao varchar(100),
    valor double,
    data datetime
);

create table preferencia_refeicao (
    id int auto_increment primary key,
    tipo varchar(45)
);

create table preferencia_assento (
    id int auto_increment primary key,
    tipo varchar(45)
);

create table preferencia_viagem (
    id int auto_increment primary key,
    cliente_id int,
    foreign key (cliente_id) references cliente(id),
    preferencia_refeicao_id int,
    foreign key (preferencia_refeicao_id) references preferencia_refeicao(id),
    preferencia_assento_id int,
    foreign key (preferencia_assento_id) references preferencia_assento(id),
    necessidades_especiais varchar(45)
);

create table reserva (
    id int auto_increment primary key,
    voo_id int,
    foreign key (voo_id) references voo(id),
    cliente_id int,
    foreign key (cliente_id) references cliente(id),
    data_reserva datetime,
    categoria_assento varchar(45),
    preco double,
    status varchar(45)
);

create table historico_pagamento (
    id int auto_increment primary key,
    reserva_id int,
    foreign key (reserva_id) references reserva(id),
    data_pagamento date,
    metodo_pagamento varchar(45),
    status_pagamento varchar(45)
);

create table compensacao (
    id int auto_increment primary key,
    cliente_id int,
    foreign key (cliente_id) references cliente(id),
    reserva_id int,
    foreign key (reserva_id) references reserva(id),
    motivo varchar(200),
    valor double,
    data_emissao date
);

-- Inserts

INSERT INTO cliente (nome_completo, tipo_identificacao, numero_identificacao, nacionalidade, data_nascimento, sexo, categoria_fidelidade, pontos_acumulados) VALUES
('João Silva', 'CPF', '123.456.789-00', 'Brasileira', '1980-05-21', 'M', 'Ouro', 15000),
('Maria Oliveira', 'RG', 'MG-11.222.333', 'Brasileira', '1992-07-15', 'F', 'Prata', 9000),
('Carlos Souza', 'Passaporte', 'BRA1234567', 'Brasileira', '1975-03-30', 'M', 'Bronze', 5000);

INSERT INTO contato_cliente (cliente_id, tipo_contato, valor) VALUES
(1, 'Email', 'joao.silva@example.com'),
(2, 'Telefone', '31 98765-4321'),
(3, 'Email', 'carlos.souza@example.net');

INSERT INTO endereco_cliente (cliente_id, tipo_endereco, logradouro, numero, complemento, bairro, cidade, estado, pais, cep) VALUES
(1, 'Residencial', 'Rua das Flores', 123, 'Apt 101', 'Centro', 'Belo Horizonte', 'MG', 'Brasil', '31000-000'),
(2, 'Comercial', 'Av. Paulista', 987, 'Sala 200', 'Paulista', 'São Paulo', 'SP', 'Brasil', '01311-100'),
(3, 'Residencial', 'Rua das Palmeiras', 76, 'Casa', 'Jardim', 'Rio de Janeiro', 'RJ', 'Brasil', '21040-720');

INSERT INTO voo (codigo, destino, data_hora_partida, data_hora_chegada, status, tipo_voo) VALUES
('VOO1234', 'Rio de Janeiro', '2024-04-21 09:00:00', '2024-04-21 11:30:00', 'Confirmado', 'Nacional'),
('VOO2345', 'São Paulo', '2024-04-22 15:00:00', '2024-04-22 16:30:00', 'Atrasado', 'Nacional'),
('VOO3456', 'Lisboa', '2024-04-23 23:00:00', '2024-04-24 11:00:00', 'Cancelado', 'Internacional');

INSERT INTO log_voo (voo_id, observacoes, incidentes, medidas_corretivas) VALUES
(1, 'Voo ocorreu sem intercorrências', 'Nenhum', 'Nenhuma'),
(2, 'Atraso devido a condições meteorológicas adversas', 'Atraso', 'Reprogramação de horário'),
(3, 'Cancelado devido a greve geral', 'Cancelamento', 'Reagendamento de passageiros');

INSERT INTO cargo_voo (voo_id, descricao_cargo, peso, tipo_cargo, status_seguranca) VALUES
(1, 'Bagagens', '1000 kg', 'Comum', 'Aprovado'),
(2, 'Carga comercial', '2000 kg', 'Comercial', 'Aprovado'),
(3, 'Correspondências', '500 kg', 'Postal', 'Aprovado');

INSERT INTO detalhes_voo (voo_id, tipo_aeronave, configuracao_assentos, distancia_km, tempo_estimado, consumo_estimado_combustivel, consumo_real_combustivel, emissoes_estimadas_co2) VALUES
(1, 'Boeing 737', 'Econômica: 140, Executiva: 16', 500, '2 horas', 800, 850, '200 kg CO2'),
(2, 'Airbus A320', 'Econômica: 165', 400, '1.5 horas', 600, 590, '150 kg CO2'),
(3, 'Boeing 777', 'Econômica: 250, Executiva: 50, Primeira Classe: 12', 8000, '10 horas', 5000, 5100, '1200 kg CO2');

INSERT INTO programacao_voo (voo_id, frequencia, temporada) VALUES
(1, 'Diária', 'Alta'),
(2, 'Semanal', 'Baixa'),
(3, 'Mensal', 'Média');

INSERT INTO funcionario (funcao, data_admissao, departamento, status_emprego) VALUES
('Piloto', '2019-03-01', 'Operações de Voo', 'Ativo'),
('Comissário de Bordo', '2020-05-15', 'Serviço de Cabine', 'Ativo'),
('Mecânico', '2018-07-20', 'Manutenção', 'Ativo');

INSERT INTO qualificacoes (funcionario_id, tipo_qualificacao, data_qualificacao, data_expiracao) VALUES
(1, 'Licença de Piloto', '2019-04-01', '2024-04-01'),
(2, 'Treinamento de Segurança', '2020-06-01', '2023-06-01'),
(3, 'Certificação Técnica', '2018-08-10', '2023-08-10');

INSERT INTO treinamento_funcionario (funcionario_id, data_inicio, data_conclusao, resultado, tipo_treinamento) VALUES
(1, '2023-01-10', '2023-01-20', 'Aprovado', 'Simulação de Voo'),
(2, '2023-02-15', '2023-02-25', 'Aprovado', 'Atendimento ao Passageiro'),
(3, '2023-03-05', '2023-03-15', 'Aprovado', 'Manutenção de Motores');

INSERT INTO escala_tripulacao (funcionario_id, voo_id, data, posicao) VALUES
(1, 1, '2024-04-21', 'Piloto'),
(2, 1, '2024-04-21', 'Chefe de Cabine'),
(2, 2, '2024-04-22', 'Chefe de Cabine');

INSERT INTO historico_tripulacao (funcionario_id, voo_id, data_voo, funcao_desempenhada, avaliacao_desempenho) VALUES
(1, 1, '2024-04-21 09:00:00', 'Piloto', 'Excelente'),
(2, 1, '2024-04-21 09:00:00', 'Comissário de Bordo', 'Boa'),
(2, 2, '2024-04-22 15:00:00', 'Comissário de Bordo', 'Excelente');

INSERT INTO aeronave (modelo, fabricante, ano_fabricacao, ultima_manutencao, horas_voo, status_operacional) VALUES
('737-800', 'Boeing', 2015, '2023-11-20 09:00:00', 15000, 'Operacional'),
('A320', 'Airbus', 2016, '2023-12-15 10:00:00', 13000, 'Operacional'),
('777-300ER', 'Boeing', 2014, '2023-12-01 08:00:00', 20000, 'Manutenção Necessária');

INSERT INTO registro_manutencao (aeronave_id, tipo, descricao, data, horas_trabalho, custo) VALUES
(1, 'Revisão Geral', 'Revisão completa do sistema hidráulico', '2023-11-20', 48, 20000),
(2, 'Manutenção Preventiva', 'Checagem dos sistemas de navegação', '2023-12-15', 36, 15000),
(3, 'Manutenção Corretiva', 'Substituição de turbinas', '2023-12-01', 72, 45000);

INSERT INTO log_inspecao (aeronave_id, data, tipo_inspecao, resultados, recomendacoes) VALUES
(1, '2023-11-20', 'Anual', 'Aprovado sem ressalvas', 'Nenhuma'),
(2, '2023-12-15', 'Anual', 'Aprovado com observações', 'Verificar sensores de temperatura'),
(3, '2023-12-01', 'Urgente', 'Falhas detectadas', 'Recomenda-se revisão do motor');

INSERT INTO inventario_pecas (aeronave_id, descricao, numero_serie, quantidade_estoque, localizacao_deposito, data_ultima_inspecao) VALUES
(1, 'Pneu de Aterrissagem', 123456, 10, 'Depósito A', '2023-10-10 10:00:00'),
(2, 'Sensor de Altitude', 234567, 20, 'Depósito B', '2023-09-20 09:00:00'),
(3, 'Turbina CFM56', 345678, 5, 'Depósito C', '2023-08-30 08:00:00');

INSERT INTO transacao_financeira (voo_id, cliente_id, registro_manutencao_id, tipo_transacao, descricao, valor, data) VALUES
(1, 1, 1, 'Compra de Bilhete', 'Compra de bilhete para Rio de Janeiro', 800.00, '2024-04-20 12:00:00'),
(2, 2, 2, 'Compra de Bilhete', 'Compra de bilhete para São Paulo', 500.00, '2024-04-21 13:00:00'),
(3, 3, 3, 'Compra de Bilhete', 'Compra de bilhete para Lisboa', 1500.00, '2024-04-22 14:00:00');

INSERT INTO preferencia_refeicao (tipo) VALUES
('Vegetariana'),
('Kosher'),
('Padrão');

INSERT INTO preferencia_assento (tipo) VALUES
('Janela'),
('Corredor'),
('Saída de Emergência');

INSERT INTO preferencia_viagem (cliente_id, preferencia_refeicao_id, preferencia_assento_id, necessidades_especiais) VALUES
(1, 1, 1, 'Nenhuma'),
(2, 2, 2, 'Assistência em aeroporto'),
(3, 3, 3, 'Cadeira de rodas');

INSERT INTO reserva (voo_id, cliente_id, data_reserva, categoria_assento, preco, status) VALUES
(1, 1, '2024-04-19 10:00:00', 'Econômica', 800.00, 'Confirmada'),
(2, 2, '2024-04-20 11:00:00', 'Executiva', 1200.00, 'Confirmada'),
(3, 3, '2024-04-21 09:00:00', 'Primeira Classe', 3000.00, 'Confirmada');

INSERT INTO historico_pagamento (reserva_id, data_pagamento, metodo_pagamento, status_pagamento) VALUES
(1, '2024-04-19', 'Cartão de Crédito', 'Pago'),
(2, '2024-04-20', 'PayPal', 'Pago'),
(3, '2024-04-21', 'Transferência Bancária', 'Pago');

INSERT INTO compensacao (cliente_id, reserva_id, motivo, valor, data_emissao) VALUES
(1, 1, 'Voo Cancelado', 100.00, '2024-04-22'),
(2, 2, 'Atraso Significativo', 50.00, '2024-04-23'),
(3, 3, 'Perda de Bagagem', 200.00, '2024-04-24');

UPDATE detalhes_voo
SET data = '2024-04-19'
WHERE voo_id = 1;

UPDATE detalhes_voo
SET data = '2024-04-20'
WHERE voo_id = 2;

UPDATE detalhes_voo
SET data = '2024-04-21'
WHERE voo_id = 3;

UPDATE voo
SET aeronave_id = 1
WHERE id = 1;

UPDATE voo
SET aeronave_id = 2
WHERE id = 2;

UPDATE voo
SET aeronave_id = 3
WHERE id = 3;

INSERT INTO voo (codigo, destino, data_hora_partida, data_hora_chegada, status, tipo_voo, aeronave_id) VALUES
('VOO7890', 'Porto Alegre', '2024-05-01 07:00:00', '2024-05-01 09:30:00', 'Confirmado', 'Nacional', 1),
('VOO8901', 'Curitiba', '2024-05-02 14:00:00', '2024-05-02 15:30:00', 'Confirmado', 'Nacional', 2),
('VOO9012', 'Fortaleza', '2024-05-03 21:00:00', '2024-05-04 01:30:00', 'Confirmado', 'Nacional', 3);

INSERT INTO detalhes_voo (voo_id, tipo_aeronave, configuracao_assentos, distancia_km, tempo_estimado, consumo_estimado_combustivel, consumo_real_combustivel, emissoes_estimadas_co2, data) VALUES
(4, 'Boeing 737', 'Econômica: 138, Executiva: 20', 852, '2 horas 30 minutos', 500, 520, '240 kg CO2', '2024-05-01'),
(5, 'Airbus A320', 'Econômica: 150', 408, '1 hora 30 minutos', 300, 310, '130 kg CO2', '2024-05-02'),
(6, 'Boeing 777', 'Econômica: 264, Executiva: 48, Primeira Classe: 14', 2850, '3 horas 30 minutos', 2100, 2200, '1000 kg CO2', '2024-05-03');

INSERT INTO historico_tripulacao (funcionario_id, voo_id, data_voo, funcao_desempenhada, avaliacao_desempenho) VALUES
(1, 4, '2024-05-01 07:00:00', 'Piloto', 'Excelente'),
(1, 5, '2024-05-01 07:00:00', 'Co-Piloto', 'Muito Bom'),
(2, 6, '2024-05-01 07:00:00', 'Chefe de Cabine', 'Bom');


-- view


create view dashboard_operacional as
select
    a.modelo,
    v.codigo,
    v.tipo_voo,
    v.data_hora_partida,
    v.data_hora_chegada,
    ht.avaliacao_desempenho as status_tripulacao,
    a.ultima_manutencao
    from voo v
inner join detalhes_voo dv on v.id = dv.voo_id
inner join aeronave a on v.aeronave_id = a.id
inner join historico_tripulacao ht on v.id = ht.voo_id;

select * from dashboard_operacional;

-- function

CREATE FUNCTION CalcularEficienciaCombustivel(id_voo INT)
RETURNS DOUBLE
DETERMINISTIC
BEGIN
    DECLARE eficiencia DOUBLE;
    -- Garantindo que apenas o registro mais recente é usado
    SELECT ((consumo_estimado_combustivel / consumo_real_combustivel) * 100) INTO eficiencia
    FROM detalhes_voo
    WHERE voo_id = id_voo;
    RETURN eficiencia;
END;

select CalcularEficienciaCombustivel(2) as Eficiencia_voo;

-- listar todos os voos

SELECT voo_id,
       consumo_estimado_combustivel,
       consumo_real_combustivel,
       data,
       CalcularEficienciaCombustivel(voo_id) as eficiencia
FROM detalhes_voo
ORDER BY voo_id, data DESC;

CREATE FUNCTION pontualidade(id_voo INT)
RETURNS varchar(100)
DETERMINISTIC
BEGIN
    DECLARE pontual varchar(100);
    -- Garantindo que apenas o registro mais recente é usado
    SELECT (CASE WHEN v.data_hora_partida <= v.data_hora_chegada THEN 'No Horário' ELSE 'Atrasado' END) INTO pontual
    FROM voo v
    WHERE id = id_voo;
    RETURN pontual;
END;
-- relatorio

SELECT
    a.modelo,
    v.codigo AS CodigoVoo,
    v.destino,
    v.data_hora_partida,
    v.data_hora_chegada,
    pontualidade(v.id) AS Pontualidade,
    dv.configuracao_assentos AS AssentosOcupados,
    dv.consumo_estimado_combustivel,
    dv.consumo_real_combustivel,
    CalcularEficienciaCombustivel(v.id),
    (dv.consumo_real_combustivel / dv.distancia_km) AS Km_litro,
    dv.emissoes_estimadas_co2
FROM voo v
JOIN detalhes_voo dv ON v.id = dv.voo_id
inner join aeronave a on dv.aeronave_id = a.id
LEFT JOIN reserva r ON v.id = r.voo_id
ORDER BY v.id;

SELECT
    c.nome_completo,
    c.nacionalidade AS Nacionalidade,
    c.sexo AS Sexo,
    c.categoria_fidelidade AS CategoriaFidelidade,
    v.tipo_voo AS TipoVoo,
    c.pontos_acumulados AS Pontuacao,
    cmp.motivo AS MotivoCompesacao

FROM cliente c
INNER JOIN reserva r ON c.id = r.cliente_id
INNER JOIN voo v ON r.voo_id = v.id
LEFT JOIN compensacao cmp ON c.id = cmp.cliente_id;

