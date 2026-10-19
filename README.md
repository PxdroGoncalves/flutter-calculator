# Flutter Calculator — versão comentada

Calculadora em Flutter com soma, subtração, multiplicação, divisão e histórico.

**Projeto original:** [hgsouz/flutter-calculator](https://github.com/hgsouz/flutter-calculator). Esta cópia foi preparada para estudos, com comentários curtos e perguntas do professor ao final de `lib/main.dart`.

## Executar

Tenha Flutter e Dart instalados. No terminal:

```bash
flutter pub get
flutter create .
flutter run
```

O comando `flutter create .` gera os diretórios de plataformas, caso ainda não existam. Para conferir a configuração: `flutter doctor`.

## Estrutura

- `lib/main.dart`: aplicativo comentado e guia de perguntas.
- `pubspec.yaml`: dependências.
- `test/widget_test.dart`: teste original do projeto, ainda não adaptado para calculadora.

## Observações

A lógica original foi preservada. Ainda há limitações: entrada inválida vira zero; sem operação selecionada o código tenta dividir; o histórico só existe enquanto o app está aberto.

**Crédito:** autoria do aplicativo original: [hgsouz](https://github.com/hgsouz/flutter-calculator). Comentários e material de estudos adicionados nesta versão.
