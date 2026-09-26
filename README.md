# ☕ Migração de Banco de Dados para Amazon RDS (MariaDB)

Projeto prático de arquitetura e infraestrutura em nuvem focado na migração de um banco de dados relacional local (executado em instância Amazon EC2) para um serviço de banco de dados totalmente gerenciado no **Amazon RDS (Relational Database Service)**.

---

## 📐 Arquitetura da Solução

* **Cenário Inicial:** Aplicação web monolítica em pilha LAMP (Linux, Apache, MariaDB, PHP) rodando em uma única instância Amazon EC2 (`CafeInstance`).
* **Cenário Final (Migração):** Desacoplamento da camada de dados. A aplicação web em PHP permanece na EC2 em uma sub-rede pública, enquanto o banco de dados MariaDB passa a rodar em uma instância gerenciada **Amazon RDS** em sub-redes privadas dentro de uma VPC personalizada.

---

## 🛠️ Tecnologias e Serviços Utilizados

* **AWS Services:**
  * **Amazon RDS:** Instância gerenciada MariaDB 12.3 (`cafedbinstance`).
  * **Amazon EC2:** Servidor web da aplicação (`CafeInstance`).
  * **Amazon VPC:** Sub-redes privadas e públicas, Security Groups (`CafeDatabaseSG`).
  * **AWS Systems Manager (Parameter Store):** Gerenciamento centralizado da URL de conexão (`/cafe/dbUrl`).
  * **Amazon CloudWatch:** Monitoramento de métricas de desempenho e conexões (`DatabaseConnections`, `CPUUtilization`).
* **Ferramentas & Linguagens:** MariaDB / MySQL, SQL, `mysqldump`, AWS CLI v2, Bash, Git e GitHub.

---

## 🚀 Etapas do Projeto

### 1. Provisionamento de Infraestrutura via AWS CLI
* Criação do Security Group do banco de dados (`CafeDatabaseSG`) autorizando tráfego de entrada na porta TCP `3306` apenas a partir da sub-rede/SG do servidor web.
* Criação do **DB Subnet Group** (`CafeDB Subnet Group`) abrangendo sub-redes privadas em múltiplas Zonas de Disponibilidade (AZs).
* Implantação da instância **Amazon RDS MariaDB 12.3**.

### 2. Resolução de Problemas de Compatibilidade e Conexão (SSL/TLS)
* **Desafio:** A aplicação PHP legada apresentou erro de transporte/SSL ao tentar se conectar à nova instância RDS devido ao parâmetro padrão `require_secure_transport=ON`.
* **Solução:** Criação e associação de um **DB Parameter Group** customizado (`cafedb-params-v12`) definindo `require_secure_transport=0`. Após a reinicialização da instância RDS, a conexão foi restabelecida com sucesso.

### 3. Migração e Validação de Dados
* Extração do backup da base de dados local na EC2 utilizando `mysqldump`.
* Importação da estrutura e dados para a instância RDS (`cafe_db`).
* Validação de integridade via consultas SQL (*JOINs* entre as tabelas `order`, `order_item` e `product`) para garantir a consistência do histórico de pedidos.

### 4. Desacoplamento da Aplicação
* Atualização do parâmetro no **AWS Systems Manager Parameter Store** (`/cafe/dbUrl`) com o endpoint DNS do Amazon RDS.
* A aplicação web em PHP passou a se conectar ao novo banco de dados sem a necessidade de alteração ou refatoração do código-fonte.

### 5. Monitoramento no CloudWatch
* Verificação do comportamento da infraestrutura e registro de métricas em tempo real no **Amazon CloudWatch**, validando conexões ativas na métrica `DatabaseConnections`.

---

## 📊 Estrutura do Banco de Dados (`cafe_db`)

* `product`: Catálogo de produtos, preços e categorias (`product_group`).
* `order`: Registro dos pedidos efetuados (`order_number`, `order_date_time`, `amount`).
* `order_item`: Detalhamento dos itens pertencentes a cada pedido (`order_number`, `product_id`, `quantity`, `amount`)., `product_id`, `quantity`, `amount`).

---
## 📸 Evidências de Validação e Sucesso da Migração

### 1. Interface da Aplicação Web (Visão do Usuário)
Exibição dos pedidos realizados através do site da aplicação do Café. A interface confirma que a aplicação em PHP está se conectando com sucesso ao banco de dados Amazon RDS, registrando e listando os pedidos em ordem cronológica de realização.

<img width="1137" height="721" alt="Captura de tela 2026-09-26 021408" src="https://github.com/user-attachments/assets/2561b909-c37c-4e51-a905-795e55cf49e2" />

### 2. Validação dos Dados via CLI no Amazon RDS (Visão do Banco de Dados)
Consulta SQL realizada diretamente na instância do **Amazon RDS MariaDB** (`cafe_db`) através da interface de linha de comando (CLI). O retorno em tabela demonstra os relacionamentos de *JOIN* entre as tabelas `order`, `order_item` e `product`, validando a integridade dos dados, a estrutura dos registros e a correta atribuição dos valores e quantidades do pedido.

<img width="1027" height="462" alt="Captura de tela 2026-09-26 021609" src="https://github.com/user-attachments/assets/235d0825-5472-489d-b5a8-ed969d878a45" />



## 👤 Autora

**Simone Raeder**  

* GitHub: [@simoneraeder](https://github.com/simoneraeder)
