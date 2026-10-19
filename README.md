# Calculadora Flutter — versão comentada

Calculadora em Flutter com operações básicas e histórico.

**Projeto original:** https://github.com/hgsouz/flutter-calculator

Esta versão mantém a lógica original e acrescenta comentários curtos em `lib/main.dart` e **66 perguntas e respostas** ao final desse arquivo para estudar para a apresentação.

## Como executar

Instale Flutter e execute na pasta do projeto:

```bash
flutter create .
flutter pub get
flutter run
```

O `flutter create .` gera os diretórios de plataforma que não foram enviados aqui.

## Arquivos
- `lib/main.dart` — código comentado e guia.
- `pubspec.yaml` — configurações e dependências.
- `test/widget_test.dart` — teste padrão do contador, ainda não adaptado.

## Limitações mantidas do código original

- Quando o campo está inválido, o valor vira zero.
- Sem operação escolhida, a lógica pode tentar dividir.
- Histórico desaparece ao fechar o aplicativo.

Créditos pelo projeto original: [hgsouz](https://github.com/hgsouz/flutter-calculator).
