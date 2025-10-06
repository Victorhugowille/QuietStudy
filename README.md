# 🤫 QuietStudy

*Um aplicativo para encontrar e gerenciar locais de estudo silenciosos, com foco total em privacidade.*

![Capa do App QuietStudy](https://imgur.com/a/mi4qCek) 
## 🚀 Sobre o Projeto

O **QuietStudy** foi desenvolvido para resolver um desafio comum entre estudantes: a dificuldade de encontrar um ambiente tranquilo e propício para a concentração. Este aplicativo atua como um "gerenciador de refúgios de estudo", permitindo que o usuário mapeie e analise locais de forma pessoal e segura.

O projeto foi construído seguindo as melhores práticas de desenvolvimento mobile com Flutter, incluindo uma arquitetura limpa, gerenciamento de estado e um fluxo de consentimento robusto (LGPD).

---

## ✨ Funcionalidades Principais

* **Fluxo de Onboarding e Consentimento:** Uma experiência inicial clara que respeita a privacidade do usuário desde o primeiro momento.
* **Análise Inteligente de Localização:** Utiliza o GPS e a API do Google para identificar o tipo de local atual e classificar se o ambiente é silencioso ou barulhento.
* **Visualização com Mapa:** Exibe um mapa estático da área analisada para dar um contexto visual ao usuário.
* **Privacidade em Primeiro Lugar:** Nenhum dado de localização é armazenado e o app não exige criação de contas.
* **Revogação de Consentimento:** O usuário pode revogar o aceite das políticas a qualquer momento.

---

## 🛠️ Tecnologias Utilizadas

O projeto foi desenvolvido com as seguintes tecnologias e pacotes:

* **[Flutter](https://flutter.dev/)**: Framework principal para o desenvolvimento multiplataforma.
* **[Provider](https://pub.dev/packages/provider)**: Para gerenciamento de estado.
* **[Geolocator](https://pub.dev/packages/geolocator)**: Para obter as coordenadas de GPS do dispositivo.
* **[HTTP](https://pub.dev/packages/http)**: Para fazer as chamadas às APIs do Google.
* **[Google Places API](https://developers.google.com/maps/documentation/places/web-service)**: Para identificar os tipos de estabelecimentos.
* **[Google Maps Static API](https://developers.google.com/maps/documentation/maps-static/overview)**: Para gerar a imagem do mapa.
* **[shared_preferences](https://pub.dev/packages/shared_preferences)**: Para persistir o estado de consentimento do usuário.
* **[flutter_markdown](https://pub.dev/packages/flutter_markdown)**: Para exibir os documentos de políticas.

---

## ⚙️ Como Executar o Projeto

Siga os passos abaixo para rodar o QuietStudy localmente:

```bash
# 1. Clone o repositório
git clone [https://github.com/Victorhugowille/QuietStudy.git](https://github.com/Victorhugowille/QuietStudy.git)

# 2. Entre na pasta do projeto
cd QuietStudy

# 3. Instale as dependências
flutter pub get

# 4. Adicione sua chave de API do Google
# Abra o arquivo `lib/core/services/location_service.dart` e insira sua chave na variável `_apiKey`.

# 5. Execute o aplicativo
flutter run
