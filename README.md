---

# Quiz App

Um aplicativo de quiz desenvolvido em Swift utilizando a arquitetura MVVM-C (Model-View-ViewModel-Coordinator) com comunicação com uma API externa e persistência de dados usando CoreData.

## Funcionalidades

- **Tela Inicial**: O usuário pode inserir seu nome ou apelido e iniciar o quiz.
- **Quiz**: Consiste em uma sequência de 10 perguntas de múltipla escolha. O usuário deve responder cada pergunta e receber feedback se a resposta está correta.
- **Pontuação**: Após responder todas as perguntas, o aplicativo exibe a pontuação final e oferece opções para reiniciar o quiz ou voltar à tela inicial.
- **Ranking**: Mostra uma lista de usuários classificados por pontuação em ordem decrescente.
- **Persistência de Dados**: Utiliza CoreData para armazenar o nome do usuário e a pontuação.

## Tecnologias

- **Swift**: Linguagem de programação principal.
- **UIKit**: Framework para construção de interfaces de usuário.
- **CoreData**: Framework para persistência de dados.
- **MVVM-C**: Arquitetura utilizada para organizar o código.
- **URLSession**: Para comunicação com a API externa.

## Estrutura do Projeto

1. **ViewControllers**: 
    - `StartViewController`: Tela inicial onde o usuário insere seu nome e inicia o quiz.
    - `QuizViewController`: Tela que exibe a pergunta atual e as opções de resposta.
    - `FinalScoreViewController`: Tela que mostra a pontuação final do usuário e oferece opções para reiniciar o quiz ou voltar à tela inicial.
    - `RankingViewController`: Tela que exibe o ranking dos usuários em ordem decrescente de pontuação.

2. **ViewModels**:
    - `StartViewModel`: Gerencia a lógica da tela inicial.
    - `QuizViewModel`: Gerencia a lógica do quiz e a comunicação com a API.
    - `RankingViewModel`: Gerencia a lógica da tela de ranking.

3. **Services**:
    - `QuizService`: Responsável pela comunicação com a API externa para obter perguntas e verificar respostas.

4. **CoreData**:
    - `CoreDataManager`: Gerencia a persistência de dados utilizando CoreData.
    - `User`: Entidade de CoreData para armazenar o nome do usuário e a pontuação.

5. **Models**:
    - `Question`: Modelo para representar uma pergunta.
    - `AnswerResponse`: Modelo para representar a resposta da API sobre a correção da resposta do usuário.

## Requisitos

- Xcode 15 ou superior
- Swift 5.7 ou superior

## Como Rodar o Projeto

1. Clone o repositório:
    ```bash
    git clone https://github.com/Otomanim/quiz-app.git
    ```
2. Abra o projeto no Xcode:
    ```bash
    open QuizApp.xcodeproj
    ```
3. Execute o projeto no simulador ou em um dispositivo iOS.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---
