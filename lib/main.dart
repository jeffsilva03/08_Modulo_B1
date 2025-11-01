import 'package:flutter/material.dart';
import 'cadastro_screen.dart'; 
import 'manejo_screen.dart';

void main() => runApp(AgroTechApp());

class AgroTechApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}



//cerebro

//dados do login
class _LoginScreenState extends State<LoginScreen> {
  final String emailCorreto = "agrotech@gmail.com";
  final String senhaCorreta = "123456";

  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();



//cores
  final Color backgroundCard = const Color(0xFF435E20);
  final Color primaryGreen = const Color(0xFF71A139);
  final Color blackButton = const Color(0xFF101010);





//se login tá certo ou nn
  void _verificarLogin() {
    String emailDigitado = emailController.text.trim();
    String senhaDigitada = senhaController.text.trim();

    if (emailDigitado == emailCorreto && senhaDigitada == senhaCorreta) {
      _mostrarMensagem("Login bem-sucedido!", Colors.green);
      Future.delayed(const Duration(seconds: 2), () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ManejoScreen(),
          ),
        );
      }
      );
    } else {
      _mostrarMensagem("Dados de acesso inválidos!", Colors.red);
    }
  }

  void _mostrarMensagem(String mensagem, Color cor) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          mensagem,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
        ),
        backgroundColor: cor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 2),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;



//parte de cima
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background_image.png',
              fit: BoxFit.cover,
              colorBlendMode: BlendMode.modulate,
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: size.height,
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.06),
                  Column(
                    children: [
                      const SizedBox(height: 130),
                      Image.asset(('assets/images/logo.png'),
                      width:350,),
                      const SizedBox(height: 30),
                      const Text(
                        'Uma nova forma de cuidar de\nsua fazenda!',
                        textAlign: TextAlign.center,
                        style: TextStyle (
                          fontFamily: "MontserratMedium",
                          color: Colors.black54,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),




                  //parte de baixo
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(22, 24, 22, 32),
                    decoration: BoxDecoration(
                      color: backgroundCard,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(36),
                        topRight: Radius.circular(36),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'Insira suas credenciais',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "MontserratBold",
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildRoundedField(
                          controller: emailController,
                          hint: 'Email',
                          icon: Icons.mail,
                          obscure: false,
                        ),
                        const SizedBox(height: 20),
                        _buildRoundedField(
                          controller: senhaController,
                          hint: 'Senha',
                          icon: Icons.visibility,
                          obscure: true,
                        ),
                        const SizedBox(height: 60),
                        ElevatedButton(
                          onPressed: _verificarLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryGreen,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Logar',
                            style: TextStyle(
                              fontFamily: "MontserratBold",
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const CadastroScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: blackButton,
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Cadastre seu animal',
                            style: TextStyle(
                              fontFamily: "MontserratBold",
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoundedField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required bool obscure,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                hintText: hint,
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Icon(icon, size: 22),
          ),
        ],
      ),
    );
  }
}
