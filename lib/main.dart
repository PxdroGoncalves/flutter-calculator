import 'package:flutter/material.dart'; // Widgets do Flutter

// Ponto de entrada do aplicativo
void main() {
  runApp(const MyApp()); // Inicia a interface
}

// StatelessWidget: não gerencia estado mutável próprio
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: MyHomePage()); // Tela inicial
  }
}

// StatefulWidget: tela com resultado e histórico que mudam
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _num1 = '';       // Primeiro número digitado
  String _num2 = '';       // Segundo número digitado
  String _operation = '';  // Operação selecionada
  String _result = '';     // Resultado exibido
  final List<String> _history = []; // Contas anteriores

  // Salva a operação; setState atualiza a tela
  void _selectOperation(String op) {
    setState(() {
      _operation = op;
    });
  }

  // Faz a operação matemática (else também recebe operação vazia)
  double calculate(double a, double b, String op) {
    if (op == '+') {
      return a + b; // Soma
    } else if (op == '-') {
      return a - b; // Subtração
    } else if (op == '×') {
      return a * b; // Multiplicação
    } else {
      return a / b; // Divisão
    }
  }

  // Mostra 5 em vez de 5.0
  String _format(double value) {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  // Converte a entrada, calcula e atualiza o histórico
  void _executeCalculation() {
    double n1 = double.tryParse(_num1.replaceAll(',', '.')) ?? 0.0; // Texto -> double
    double n2 = double.tryParse(_num2.replaceAll(',', '.')) ?? 0.0; // Inválido vira zero

    // Não permite dividir por zero ao selecionar ÷
    if (_operation == '÷' && n2 == 0) {
      setState(() {
        _result = 'Cannot divide by zero';
      });
      return;
    }

    // Chama o cálculo e monta a expressão
    double result = calculate(n1, n2, _operation);
    String expression =
        '${_format(n1)} $_operation ${_format(n2)} = ${_format(result)}';

    // Atualiza o resultado e coloca a conta recente no início
    setState(() {
      _result = expression;
      _history.insert(0, expression); // Histórico em ordem recente
    });
  }

  // Limpa histórico e resultado, mas não os campos
  void _clearHistory() {
    setState(() {
      _history.clear();
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Estrutura da página
      appBar: AppBar(title: const Text('Calcular')),
      body: SingleChildScrollView( // Permite rolar a tela
        child: Column( // Organiza os widgets na vertical
          children: [
            TextField( // Campo para digitar um número
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Primeiro número'),
              onChanged: (value) { // Guarda o que foi digitado
                setState(() {
                  _num1 = value;
                });
              },
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(hintText: 'Segundo número'),
              onChanged: (value) {
                setState(() {
                  _num2 = value;
                });
              },
            ),
            Row( // Botões lado a lado
              children: [
                ElevatedButton(
                  onPressed: () => _selectOperation('+'), // Seleciona soma
                  child: const Text('+'),
                ),
                ElevatedButton(
                  onPressed: () => _selectOperation('-'), // Seleciona subtração
                  child: const Text('-'),
                ),
                ElevatedButton(
                  onPressed: () => _selectOperation('×'), // Seleciona multiplicação
                  child: const Text('×'),
                ),
                ElevatedButton(
                  onPressed: () => _selectOperation('÷'), // Seleciona divisão
                  child: const Text('÷'),
                ),
              ],
            ),
            Text('Operação selecionada: $_operation'),
            ElevatedButton(
              onPressed: _executeCalculation, // Faz a conta
              child: const Text('Calcular'),
            ),
            Text(_result), // Mostra resultado
            const Text('Histórico'),
            ElevatedButton(
              onPressed: _clearHistory, // Apaga histórico
              child: const Text('Limpar histórico'),
            ),
            ..._history.map((item) => Text(item)), // Exibe cada conta
          ],
        ),
      ),
    );
  }
}

/*
========================================
 GUIA DE ESTUDOS - PERGUNTAS DO PROFESSOR
========================================

BÁSICO E INTERFACE
1. O que é Flutter?
R: Framework para criar apps multiplataforma com Dart.

2. O que é Dart?
R: Linguagem usada pelo Flutter.

3. O que faz main()?
R: É o ponto inicial do aplicativo.

4. O que faz runApp()?
R: Inicia a árvore de widgets.

5. O que é Widget?
R: Parte da interface, como texto, botão ou tela.

6. Por que MyApp é StatelessWidget?
R: Ele não administra um estado mutável próprio.

7. Por que MyHomePage é StatefulWidget?
R: Operação, resultado e histórico mudam.

8. O que é _MyHomePageState?
R: Classe onde ficam os dados e ações da tela.

9. Para que serve setState()?
R: Pede ao Flutter para reconstruir a interface.

10. O que faz build()?
R: Descreve a interface renderizada.

11. O que é BuildContext?
R: A posição do widget na árvore.

12. Para que serve MaterialApp?
R: Configura a aplicação Material.

13. Para que serve Scaffold?
R: Dá estrutura à tela, incluindo AppBar e body.

14. Qual a diferença entre Column e Row?
R: Column empilha verticalmente; Row organiza na horizontal.

15. Por que SingleChildScrollView?
R: Permite rolar quando o conteúdo não cabe.

16. O que faz TextField?
R: Recebe texto do usuário.

17. O que faz onChanged?
R: É chamado quando o texto muda.

18. O que faz ElevatedButton?
R: Cria um botão que executa onPressed.

19. O que faz onPressed?
R: Executa a função ao apertar o botão.

20. Para que serve const?
R: Permite widgets/valores constantes quando possível.

LÓGICA
21. Por que _num1 e _num2 são String?
R: Porque TextField fornece texto.

22. Por que usamos double?
R: Para calcular também com casas decimais.

23. O que faz tryParse()?
R: Tenta converter sem lançar erro por texto inválido.

24. O que faz ?? 0.0?
R: Usa 0.0 quando a conversão devolve null.

25. Por que replaceAll(',', '.')?
R: Dart converte decimal com ponto, não vírgula.

26. O que faz _selectOperation()?
R: Guarda o símbolo escolhido e atualiza a tela.

27. O que faz calculate()?
R: Executa a operação sobre dois números.

28. O que faz _executeCalculation()?
R: Converte, valida, calcula e exibe.

29. O que faz _format()?
R: Retira o .0 de resultados inteiros.

30. Por que verificar divisão por zero?
R: Para mostrar erro no lugar de dividir por zero.

31. O que faz return na validação?
R: Encerra a execução daquela função.

32. Para que serve a expressão com ${}?
R: Insere valores dentro de uma String.

33. Por que usamos List<String>?
R: Armazena várias contas em texto.

34. Por que insert(0) e não add()?
R: insert(0) coloca a mais recente primeiro.

35. O que faz _clearHistory()?
R: Apaga resultado e histórico.

36. O que faz ..._history.map(...)?
R: Transforma as contas em widgets Text.

37. Por que existe underline antes de _num1?
R: O nome fica privado à biblioteca Dart.

38. Por que separar calculate e _executeCalculation?
R: Uma faz a conta; outra lida com a interface.

39. Por que setState no projeto e não Provider?
R: O estado é simples e está em uma tela.

40. O que acontece sem setState?
R: O valor muda, mas a tela pode não atualizar.

COMO ADICIONAR FUNCIONALIDADES
41. Como adicionar potência?
R: Importar dart:math, usar pow(a,b).toDouble() e criar botão.

42. Como adicionar porcentagem?
R: Criar uma regra, como a * b / 100, e um botão.

43. Como adicionar raiz quadrada?
R: Importar dart:math, usar sqrt(a) e adaptar para um valor.

44. Como limpar os campos?
R: Usar TextEditingController e chamar clear().

45. Como guardar o histórico após fechar o app?
R: Usar shared_preferences ou banco de dados local.

46. Como criar tema escuro?
R: Configurar themeMode e darkTheme no MaterialApp.

47. Como criar outra tela?
R: Criar outro widget e navegar com Navigator.

48. Como separar o arquivo main.dart?
R: Mover telas, widgets e lógica para arquivos próprios.

49. Como evitar os quatro botões repetidos?
R: Gerar botões a partir de uma lista de símbolos.

50. Como aceitar números negativos?
R: Usar numberWithOptions(signed: true) e validar entrada.

51. Como deixar a entrada decimal melhor?
R: Usar numberWithOptions(decimal: true) e validadores.

52. Como melhorar o histórico grande?
R: Usar ListView.builder com altura adequada.

53. Como impedir operação não escolhida?
R: Validar _operation antes de calculate.

54. Como avisar sobre entrada inválida?
R: Checar tryParse == null e exibir erro.

55. Como criar uma nova operação?
R: Adicionar botão e tratamento em calculate.

56. Como reescrever os if/else?
R: Usar switch com caso para cada operação.

PONTOS FRACOS E TESTES
57. O que ocorre se não escolher operação?
R: O else divide; precisa validar antes.

58. O que ocorre se digitar letra?
R: tryParse falha e o valor vira 0.0 sem avisar.

59. Por que onChanged não precisa de setState sempre?
R: Esses valores não são exibidos diretamente enquanto digita.

60. O teste original está correto?
R: Não; ainda é o teste padrão de contador.

61. Como testar 2 + 3 = 5?
R: Testar calculate ou usar WidgetTester na interface.

62. Qual o problema de 0.1 + 0.2 com double?
R: Pode resultar em 0.30000000000000004.

63. Como calcular dinheiro com mais precisão?
R: Usar aritmética decimal adequada.

64. O que você melhoraria?
R: Validação, testes, organização e persistência.

65. Por que 'Cannot divide by zero' está em inglês?
R: O código original mistura idiomas; pode traduzir.

66. O histórico é salvo no aparelho?
R: Não; a lista vive apenas na memória do aplicativo.

========================================
 FIM DO GUIA
========================================
*/
