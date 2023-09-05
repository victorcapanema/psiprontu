# PsiProntu

Prontuário para psicólogos, desenvolvido em flutter web.

![sistema](https://i.ibb.co/zxGCJDN/prontu.png)

## Introdução

PsiProntu é um projeto de prontuário, por enquanto podemos:
- Gerenciar pacientes e consultas;
- Agendar consultas;
- Imprimir histórico de consultas de um paciente;
- Consultar e filtrar as informações cadastradas;

Versão para testes pode ser acessada com:
- Usuario: usertest@prontuteste.com
-  Senha: 123456
-  Disponível [aqui](https://prontuario-7614a.web.app/#/).

### <span style="color: red">Atenção</span>
Para reproduzir localmente é nescessário configurar sua própria chave do firebase no arquivo main.dart.

## Sobre a Arquitetura
Esse é um sistema Flutter web que foi construido utilizando uma arquitetura MVC adaptada para manter o código simples.
Para isso, foi utilizado alguns pacotes, estes são os mais relevantes:
- Modular (navegação e injeção de dependência)
- MobX (gerenciamento de estado)
- Firebase (banco de dados)

Esta imagem demonstra a arquitetura:  
|![chart.png](https://i.ibb.co/ChC2sSz/Flowchart-2.jpg)|
|:--:|

## Desenvolvedor
- [Victor Capanema](https://www.linkedin.com/in/victor-carvalho-capanema-437387126/)