import 'package:flutter/material.dart';
import 'cadastro_screen.dart';

class ManejoScreen extends StatefulWidget {
  const ManejoScreen({Key? key}) : super(key: key);

  @override
  State<ManejoScreen> createState() => _ManejoScreenState();
}

class _ManejoScreenState extends State<ManejoScreen> {
  // cor principal
  final Color primaryGreen = const Color(0xFF74B64A);

  
  final List<Map<String, dynamic>> animais = List.generate(5, (i) {
    return {
      'id': i,
      'nome': 'Bandido',
      'sub': 'Boi',
      'thumb': 'assets/images/vaca.jpg', 
      'percent': 76,
      'lote': '0000${i + 1}',
      'vacinas': List.generate(40, (v) => v < 32), // true = aplicada 
    };
  });

  

  
  final Map<int, bool> shifted = {};

  @override
  void initState() {
    super.initState();
    for (var a in animais) {
      shifted[a['id']] = false;
    }
  }

  void _toggleShift(int id) {
    setState(() {
      shifted[id] = !(shifted[id] ?? false);
    });
  }

  void _deleteAnimal(int id) {
    setState(() {
      animais.removeWhere((e) => e['id'] == id);
      shifted.remove(id);
    });
  }

  void _openDetalhes(BuildContext context, Map<String, dynamic> animal) {
    showDialog(
      context: context,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: _DetalhesModal(
          animal: animal,
          primaryGreen: primaryGreen,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // header 
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 25),
            Image.asset('assets/images/logo.png', height: 35),
            const SizedBox(height: 8),
            Container(height: 3, color: Colors.black),
            const SizedBox(height: 16),
            


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Text(
                    'MANEJO DE ANIMAIS',
                    style: TextStyle(fontSize: 20,
                      fontFamily: "MontserratBold",
                       letterSpacing: 1.5,
                      color: Colors.black87,),
                  ),
                  Container(width: 140, height: 1, color: Colors.black, margin: const EdgeInsets.only(top: 1)),
                  const SizedBox(height: 8),
                  const Text('Informações Básicas', style: TextStyle(color: Colors.black54, fontFamily: "MontserratMedium")),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // botao cadastrar novo animal
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CadastroScreen(),
                              ),
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    elevation: 0,
                  ),
                  child: const Text('Cadastrar novo animal', style: TextStyle(fontSize: 18, fontFamily: "MontserratBold", color: Colors.white)),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // lista
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ListView.separated(
                  padding: const EdgeInsets.only(bottom: 24, top: 6),
                  itemCount: animais.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final animal = animais[index];
                    final id = animal['id'] as int;
                    final isShifted = shifted[id] ?? false;

                    return Stack(
                      alignment: Alignment.centerRight,
                      children: [
                        //lixeira
                        Positioned(
                          right: 8,
                          child: AnimatedOpacity(
                            opacity: isShifted ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 220),
                            child: GestureDetector(
                              onTap: () => _deleteAnimal(id),
                              child: Container(
                                width: 54,
                                height: 54,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ),
                        ),

                        // card principal 
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 260),
                          transform: Matrix4.translationValues(isShifted ? -80 : 0, 0, 0),
                          child: GestureDetector(
                            onTap: () => _openDetalhes(context, animal),
                            // card 
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: Colors.black26),
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
                              ),
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                              child: Row(
                                children: [
                                  // ft
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.asset(
                                      animal['thumb'],
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // escritas do card de cada anikmal
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          animal['nome'],
                                          style: const TextStyle(fontSize: 18, fontFamily: "MontserratBold"),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(animal['sub'], style: const TextStyle(color: Colors.black54, fontFamily: "MontserratMedium")),
                                        const SizedBox(height: 8),
                                        // barra de progresso
                                        Row(
                                          children: [
                                            Expanded(
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: LinearProgressIndicator(
                                                  value: (animal['percent'] as int) / 100.0,
                                                  minHeight: 8,
                                                  backgroundColor: Colors.black12,
                                                  valueColor: AlwaysStoppedAnimation<Color>(primaryGreen),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text('${animal['percent']}%', style: const TextStyle(fontWeight: FontWeight.w700)),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(width: 8),





                                  // icon  — ao clicar rola o card pra esquerda e mostra lixeira
                                  GestureDetector(
                                    onTap: () => _toggleShift(id),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: primaryGreen,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      width: 42,
                                      height: 42,
                                      child: const Icon(Icons.check, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// abre o modal
class _DetalhesModal extends StatefulWidget {
  final Map<String, dynamic> animal;
  final Color primaryGreen;

  const _DetalhesModal({required this.animal, required this.primaryGreen});

  @override
  State<_DetalhesModal> createState() => _DetalhesModalState();
}

class _DetalhesModalState extends State<_DetalhesModal> {
  late int destaqueIndex;
  late List<String> galeria;
  late List<bool> vacinasAplicadas;
  String habitat = 'Interno';
  final List<String> habitats = ['Interno', 'Externo', 'Misto'];

  // exercicios semanais - true para os marccadps
  Map<String, bool> exercicios = {
    'SEG': true,
    'TER': true,
    'QUA': true,
    'QUI': true,
    'SEX': false,
    'SAB': true,
  };

  @override
  void initState() {
    super.initState();
    destaqueIndex = 1;
    galeria = [
      'assets/images/vaca.jpg',
      'assets/images/vaca.jpg',
      'assets/images/vaca.jpg',
    ];
    vacinasAplicadas = List<bool>.from(widget.animal['vacinas'] ?? List.generate(20, (_) => false));
  }

  @override
  Widget build(BuildContext context) {
    final animal = widget.animal;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 700),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // header 
              const SizedBox(height: 4),
              Text(
                'DETALHES DO MANEJO',
                style: TextStyle(fontSize: 18, fontFamily: "MontserratBold"),
              ),
              Container(width: 140, height: 2, color: Colors.black, margin: const EdgeInsets.only(top: 6, bottom: 12)),
              // nome e lote
              Text(animal['nome'], style: const TextStyle(fontSize: 18, fontFamily: "MontserratBold")),
              const SizedBox(height: 6),
              Text('LOTE: ${animal['lote']}', style: const TextStyle(color: Colors.black54, fontFamily: "MontserratMedium")),

              const SizedBox(height: 12),

              // galeria pequena 
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < galeria.length; i++)
                    GestureDetector(
                      onTap: () => setState(() => destaqueIndex = i),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 6),
                        child: Image.asset(galeria[i], width: i == destaqueIndex ? 92 : 56, height: i == destaqueIndex ? 92 : 56, fit: BoxFit.cover),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 10),


             
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(galeria.length, (i) {
                  final bool ativo = i == destaqueIndex;
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: ativo ? 14 : 10,
                    height: ativo ? 14 : 10,
                    decoration: BoxDecoration(
                      color: ativo ? Colors.black : Colors.white,
                      border: Border.all(color: Colors.black),
                      shape: BoxShape.circle,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 14),




              // habitat 
              Text('Habitat', style: TextStyle(fontSize: 16, fontFamily: "MontserratBold")),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: habitats.map((h) {
                  final bool sel = habitat == h;
                  return GestureDetector(
                    onTap: () => setState(() => habitat = h),
                    child: Column(
                      children: [
                        Text(h, style: TextStyle(color: sel ? Colors.black : Colors.black54, fontWeight: sel ? FontWeight.w700 : FontWeight.normal)),
                      ],
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              // parte das vacinas
              Text('Vacinação', style: TextStyle(fontSize: 16, fontFamily: "MontserratBold")),
              const SizedBox(height: 12),
              Wrap(
                spacing: 15,
                runSpacing: 8,
                children: List.generate(vacinasAplicadas.length, (i) {
                  final applied = vacinasAplicadas[i];
                  return Container(
                    width: 18,
                    height: 18,
                    decoration: BoxDecoration(
                      color: applied ? widget.primaryGreen : Colors.white,
                      border: Border.all(color: widget.primaryGreen),
                    ),
                  );
                }),
              ),

              const SizedBox(height: 18),

              
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Exercícios diários', style: TextStyle(fontSize: 16,  fontFamily: "MontserratBold")),
                  const SizedBox(height: 6),
                  Text('01/11/2024', style: const TextStyle(color: Colors.black54)),
                ],
              ),
              const SizedBox(height: 10),

              // dias da semana com checkbox 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: exercicios.keys.map((d) {
                  final checked = exercicios[d] ?? false;
                  final isSex = d == 'SEX';
                  return Column(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: checked ? widget.primaryGreen : Colors.white,
                          border: Border.all(color: checked ? widget.primaryGreen : Colors.black26),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: checked
                              ? Icon(Icons.check, size: 16, color: Colors.white)
                              : isSex
                                  ? const Icon(Icons.close, size: 14, color: Colors.black)
                                  : const SizedBox.shrink(),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(d, style: const TextStyle(fontSize: 12)),
                    ],
                  );
                }).toList(),
              ),

              const SizedBox(height: 18),

              // fechar
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.primaryGreen,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  child: const Text('Fechar', style: TextStyle(fontSize: 16,  fontFamily: "MontserratBold", color: Colors.white)),
                ),
              ),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}
