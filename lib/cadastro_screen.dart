import 'package:flutter/material.dart';
import 'manejo_screen.dart'; 

/// raça dos animais
final Map<String, List<String>> opcoesRacasPorAnimal = {
  'Cavalo': ['Cavalo-Raça1', 'Cavalo-Raça2', 'Cavalo-Raça3'],
  'Vaca': ['Vaca-Raça1', 'Vaca-Raça2', 'Vaca-Raça3'],
  'Porco': ['Porco-Raça1', 'Porco-Raça2', 'Porco-Raça3'],
};

final Map<String, List<String>> opcoesLote = {
  'Lote': ['LOTE1', 'LOTE2', 'LOTE3'],
};

class CadastroScreen extends StatefulWidget {
  const CadastroScreen({Key? key}) : super(key: key);

  @override
  State<CadastroScreen> createState() => _CadastroScreenState();
}

class _CadastroScreenState extends State<CadastroScreen> {
  // cores principais
  final Color primaryGreen = const Color(0xFF71A139);
  final Color borderGray = const Color(0xFFBDBDBD);

  // animais e caminhos das imagens 
  final List<String> animaisKeys = ['Cavalo', 'Vaca', 'Porco'];
  final List<String> animaisImagemPaths = [
    'assets/images/cavalo.jpg', 
    'assets/images/vaca.jpg',   
    'assets/images/porco.jpg',   
  ];

  int destaqueIndex = 0; // qual animal está em destaque

  // controllers do formulário
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController pesoController = TextEditingController();
  final TextEditingController idadeController = TextEditingController();

  // estado do formulário
  String? racaSelecionada;
  String? loteSelecionado;
  String? tipoSelecionado; // Macho ou Fêmea
  bool castrado = false;

  @override
  void initState() {
    super.initState();
    final opcoes = opcoesRacasPorAnimal[animaisKeys[destaqueIndex]];
    racaSelecionada = (opcoes != null && opcoes.isNotEmpty) ? opcoes.first : null;
  }

  void _atualizarDestaque(int index) {
    setState(() {
      destaqueIndex = index;
      final opcoes = opcoesRacasPorAnimal[animaisKeys[destaqueIndex]];
      racaSelecionada = (opcoes != null && opcoes.isNotEmpty) ? opcoes.first : null;
    });
  }

  void _cadastrar() {
    final nome = nomeController.text.trim();
    final peso = pesoController.text.trim();
    final idade = idadeController.text.trim();

    if (nome.isEmpty || peso.isEmpty || idade.isEmpty || racaSelecionada == null || tipoSelecionado == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos obrigatórios'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // confirnma
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cadastro confirmado: $nome (${animaisKeys[destaqueIndex]})'),
        backgroundColor: Colors.green,
      ),
    );
  }

  // decoração padrão para os inputs 
  InputDecoration _inputDecoration({
    required String hint,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.black54),
      suffixIcon: suffix,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: borderGray, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(color: primaryGreen, width: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final String animalAtual = animaisKeys[destaqueIndex];
    final List<String> opcoesRacas = opcoesRacasPorAnimal[animalAtual] ?? [];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Column(
            children: [
              // HEADER
              Column(
                children: [
                  const SizedBox(height: 6),
                  Image.asset('assets/images/logo.png', height: 35), 
                  const SizedBox(height: 8),
            Container(height: 3, color: Colors.black),
            const SizedBox(height: 16),
                ],
              ),

              const SizedBox(height: 18),

              // TITULO
              Column(
                children: [
                  Text(
                    'CADASTRO DE ANIMAIS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: "MontserratBold",
                      letterSpacing: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                  // linha fina
                  Container(
                    margin: const EdgeInsets.only(top: 1),
                    width: 140,
                    height: 1,
                    color: Colors.black,
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Informações Básicas',
                    style: TextStyle(color: Colors.black54, fontSize: 14, fontFamily: "MontserratMedium"),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              // fts
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(animaisImagemPaths.length, (i) {
                  final bool selecionado = i == destaqueIndex;
                  return GestureDetector(
                    onTap: () => _atualizarDestaque(i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: selecionado ? Border.all(color: Colors.black, width: 3) : Border.all(color: Colors.transparent),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Image.asset(
                        animaisImagemPaths[i],
                        width: selecionado ? 92 : 72,
                        height: selecionado ? 92 : 72,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 22),

              // Nome do Animal
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Nome do Animal', style: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: "MontserratMedium")),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: nomeController,
                decoration: _inputDecoration(
                  hint: 'Digite o nome do animal',
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.pets, color: Colors.grey, size: 22),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              //  KG
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Pesagem em KG', style: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: "MontserratMedium")),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: pesoController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: _inputDecoration(
                  hint: 'Digite o peso...',
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.monitor_weight, color: Colors.grey, size: 22),
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Raça 
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Raça', style: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: "MontserratMedium")),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: borderGray, width: 1.5),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonFormField<String>(
                  value: racaSelecionada,
                  decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  items: opcoesRacas.map((r) => DropdownMenuItem(value: r, child: Text(r))).toList(),
                  onChanged: (v) => setState(() => racaSelecionada = v),
                ),
              ),

              const SizedBox(height: 16),

              // Tipoo
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Tipo', style: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: "MontserratMedium")),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Macho',
                        groupValue: tipoSelecionado,
                        activeColor: primaryGreen,
                        onChanged: (v) => setState(() => tipoSelecionado = v),
                      ),
                      const SizedBox(width: 4),
                      const Text('Macho'),
                    ],
                  ),
                  const SizedBox(width: 24),
                  Row(
                    children: [
                      Radio<String>(
                        value: 'Fêmea',
                        groupValue: tipoSelecionado,
                        activeColor: primaryGreen,
                        onChanged: (v) => setState(() => tipoSelecionado = v),
                      ),
                      const SizedBox(width: 4),
                      const Text('Fêmea'),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 6),

              // checkbox
              Row(
                children: [
                  Checkbox(
                    value: castrado,
                    activeColor: primaryGreen,
                    onChanged: (v) => setState(() => castrado = v ?? false),
                  ),
                  const SizedBox(width: 8),
                  const Expanded(child: Text('Animal castrado/ inseminado', style: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: "MontserratMedium")) ),
                ],
              ),

              const SizedBox(height: 8),

              // Idade
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Idade em anos', style: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: "MontserratMedium")),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: idadeController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  hint: 'Digite a idade do animal',
                  suffix: Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(Icons.calendar_today, color: Colors.grey, size: 20),
                  ),
                ),
              ),
const SizedBox(height: 16),

              // lOTE
              Align(
                alignment: Alignment.centerLeft,
                child: Text('Lote', style: TextStyle(fontSize: 14, color: Colors.black87, fontFamily: "MontserratMedium")),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: borderGray, width: 1.5),
                  color: Colors.white,
                ),


                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonFormField<String>(
                  value: loteSelecionado,
                  decoration: const InputDecoration(border: InputBorder.none, contentPadding: EdgeInsets.zero),
                  isExpanded: true,
                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  items: opcoesLote['Lote']!
                      .map((l) => DropdownMenuItem(value: l, child: Text(l)))
                      .toList(),
                  onChanged: (v) => setState(() => loteSelecionado= v),
                ),
              ),


              const SizedBox(height: 22),

              // Botão cadastrar
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      // msg de ok
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Cadastro realizado com sucesso!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      //  2s p outra tela
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ManejoScreen(),
          ),
        );
      });
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: primaryGreen,
      padding: const EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      elevation: 0,
    ),
    child: const Text(
      'Cadastrar',
      style: TextStyle(
        fontSize: 18,
        fontFamily: "MontserratBold",
        color: Colors.white,
      ),
    ),
  ),
),


              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
