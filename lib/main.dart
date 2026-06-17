import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class AppColors {
  static const dark = Color(0xFF030007);
  static const cyan = Color(0xFF00F7FF);
  static const pink = Color(0xFFFF00F7);
  static const green = Color(0xFFB7FF00);
  static const orange = Color(0xFFFF8C00);
  static const purple = Color(0xFF7A00FF);
  static const white = Color(0xFFFFFFFF);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Academic Check',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.purple,
          primary: AppColors.purple,
          secondary: AppColors.cyan,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

/* ===========================
   SPLASH SCREEN PSICODÉLICO
=========================== */

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _scale = Tween<double>(begin: 0.85, end: 1.12).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _fade = Tween<double>(begin: 0.55, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 900),
          pageBuilder: (_, animation, __) {
            return FadeTransition(
              opacity: animation,
              child: const PromedioPage(),
            );
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Stack(
        children: [
          const PsychedelicBackground(),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return Transform.scale(
                  scale: _scale.value,
                  child: Opacity(
                    opacity: _fade.value,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const NoteCheckLogo(size: 150),
                        const SizedBox(height: 32),
                        ShaderMask(
                          shaderCallback: (bounds) {
                            return const LinearGradient(
                              colors: [
                                AppColors.cyan,
                                AppColors.pink,
                                AppColors.green,
                                AppColors.orange,
                              ],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            "Welcome to\nAcademic Check",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 42,
                              fontWeight: FontWeight.w900,
                              height: 1,
                              color: Colors.white,
                              letterSpacing: -1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: Colors.white.withOpacity(0.08),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.25),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.cyan.withOpacity(0.4),
                                blurRadius: 30,
                              ),
                              BoxShadow(
                                color: AppColors.pink.withOpacity(0.35),
                                blurRadius: 50,
                              ),
                            ],
                          ),
                          child: const Text(
                            "Iniciando portal académico 4D...",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/* ===========================
   PÁGINA PRINCIPAL
=========================== */

class PromedioPage extends StatefulWidget {
  const PromedioPage({super.key});

  @override
  State<PromedioPage> createState() => _PromedioPageState();
}

class _PromedioPageState extends State<PromedioPage> {
  bool _pesosExpandidos = false;

  final _u1Es = TextEditingController();
  final _u1Ep = TextEditingController();
  final _u2Es = TextEditingController();
  final _u2Ep = TextEditingController();
  final _u3Es = TextEditingController();
  final _u3Ep = TextEditingController();
  final _ecg = TextEditingController();

  final _wU1Es = TextEditingController(text: "5");
  final _wU1Ep = TextEditingController(text: "15");
  final _wU2Es = TextEditingController(text: "5");
  final _wU2Ep = TextEditingController(text: "30");
  final _wU3Es = TextEditingController(text: "10");
  final _wU3Ep = TextEditingController(text: "25");

  final _wTotalEs = TextEditingController(text: "20");
  final _wTotalEp = TextEditingController(text: "70");
  final _wTotalEcg = TextEditingController(text: "10");

  double? _notaFinal;
  String _mensaje = "";

  void _calcular() {
    setState(() {
      double nU1es = double.tryParse(_u1Es.text) ?? 0;
      double nU1ep = double.tryParse(_u1Ep.text) ?? 0;
      double nU2es = double.tryParse(_u2Es.text) ?? 0;
      double nU2ep = double.tryParse(_u2Ep.text) ?? 0;
      double nU3es = double.tryParse(_u3Es.text) ?? 0;
      double nU3ep = double.tryParse(_u3Ep.text) ?? 0;
      double nEcg = double.tryParse(_ecg.text) ?? 0;

      double wU1es = double.tryParse(_wU1Es.text) ?? 0;
      double wU1ep = double.tryParse(_wU1Ep.text) ?? 0;
      double wU2es = double.tryParse(_wU2Es.text) ?? 0;
      double wU2ep = double.tryParse(_wU2Ep.text) ?? 0;
      double wU3es = double.tryParse(_wU3Es.text) ?? 0;
      double wU3ep = double.tryParse(_wU3Ep.text) ?? 0;

      double wT_Es = (double.tryParse(_wTotalEs.text) ?? 0) / 100;
      double wT_Ep = (double.tryParse(_wTotalEp.text) ?? 0) / 100;
      double wT_Ecg = (double.tryParse(_wTotalEcg.text) ?? 0) / 100;

      double sumaPesosEs = wU1es + wU2es + wU3es;
      double sumaPesosEp = wU1ep + wU2ep + wU3ep;

      double promedioES = sumaPesosEs > 0
          ? (nU1es * wU1es + nU2es * wU2es + nU3es * wU3es) / sumaPesosEs
          : 0;

      double promedioEP = sumaPesosEp > 0
          ? (nU1ep * wU1ep + nU2ep * wU2ep + nU3ep * wU3ep) / sumaPesosEp
          : 0;

      if (promedioEP < 12.50) {
        _notaFinal = promedioEP;
        _mensaje = "Desaprobado: EP < 12.5";
      } else {
        _notaFinal =
            (promedioES * wT_Es) + (promedioEP * wT_Ep) + (nEcg * wT_Ecg);
        _mensaje = _notaFinal! >= 10.5 ? "¡Aprobado!" : "Desaprobado";
      }
    });
  }

  void _reset() {
    setState(() {
      for (var c in [_u1Es, _u1Ep, _u2Es, _u2Ep, _u3Es, _u3Ep, _ecg]) {
        c.clear();
      }
      _notaFinal = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Stack(
        children: [
          const PsychedelicBackground(),
          SafeArea(
            child: Column(
              children: [
                _buildAppHeader(),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    child: Column(
                      children: [
                        _buildHeroCard(),
                        const SizedBox(height: 16),

                        _buildGlassCard(
                          child: Column(
                            children: [
                              ListTile(
                                onTap: () => setState(
                                  () => _pesosExpandidos = !_pesosExpandidos,
                                ),
                                leading: const Icon(
                                  Icons.tune,
                                  color: AppColors.green,
                                ),
                                title: const Text(
                                  "CONFIGURACIÓN DE PESOS (%)",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 13,
                                    color: Colors.white,
                                    letterSpacing: 0.4,
                                  ),
                                ),
                                trailing: Icon(
                                  _pesosExpandidos
                                      ? Icons.keyboard_arrow_up
                                      : Icons.keyboard_arrow_down,
                                  color: AppColors.cyan,
                                ),
                                dense: true,
                              ),
                              AnimatedCrossFade(
                                firstChild: const SizedBox.shrink(),
                                secondChild: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(12, 0, 12, 12),
                                  child: Column(
                                    children: [
                                      _buildWeightRow("U1", _wU1Es, _wU1Ep),
                                      _buildWeightRow("U2", _wU2Es, _wU2Ep),
                                      _buildWeightRow("U3", _wU3Es, _wU3Ep),
                                      const SizedBox(height: 8),
                                      Divider(
                                        color: Colors.white.withOpacity(0.2),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: _buildSmallInput(
                                              _wTotalEs,
                                              "T. ES %",
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: _buildSmallInput(
                                              _wTotalEp,
                                              "T. EP %",
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: _buildSmallInput(
                                              _wTotalEcg,
                                              "T. ECG %",
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                crossFadeState: _pesosExpandidos
                                    ? CrossFadeState.showSecond
                                    : CrossFadeState.showFirst,
                                duration: const Duration(milliseconds: 350),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        _buildUnidadCard(
                          "UNIDAD 1",
                          _u1Es,
                          "Nota ES",
                          _u1Ep,
                          "Nota EP",
                          Icons.looks_one,
                        ),
                        _buildUnidadCard(
                          "UNIDAD 2",
                          _u2Es,
                          "Nota ES",
                          _u2Ep,
                          "Nota EP",
                          Icons.looks_two,
                        ),
                        _buildUnidadCard(
                          "UNIDAD 3",
                          _u3Es,
                          "Nota ES",
                          _u3Ep,
                          "Nota EP",
                          Icons.looks_3,
                        ),

                        _buildGlassCard(
                          margin: const EdgeInsets.only(bottom: 14),
                          child: Padding(
                            padding: const EdgeInsets.all(14),
                            child: TextField(
                              controller: _ecg,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                              decoration: _psyInputDecoration(
                                "Nota ECG (Competencia Genérica)",
                                Icons.star,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          children: [
                            Expanded(
                              child: _psyButton(
                                text: "CALCULAR",
                                icon: Icons.flash_on,
                                onPressed: _calcular,
                                filled: true,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _psyButton(
                                text: "RESET",
                                icon: Icons.restart_alt,
                                onPressed: _reset,
                                filled: false,
                              ),
                            ),
                          ],
                        ),

                        if (_notaFinal != null) ...[
                          const SizedBox(height: 18),
                          _buildResultCard(),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white.withOpacity(0.08),
          border: Border.all(color: Colors.white.withOpacity(0.18)),
          boxShadow: [
            BoxShadow(
              color: AppColors.cyan.withOpacity(0.22),
              blurRadius: 25,
            ),
            BoxShadow(
              color: AppColors.pink.withOpacity(0.18),
              blurRadius: 35,
            ),
          ],
        ),
        child: Row(
          children: [
            const NoteCheckLogo(size: 54),
            const SizedBox(width: 12),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Academic Check",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ),
                  Text(
                    "Calculadora académica psicodélica 4D",
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(999),
                gradient: const LinearGradient(
                  colors: [AppColors.cyan, AppColors.pink],
                ),
              ),
              child: const Text(
                "4D",
                style: TextStyle(
                  color: AppColors.dark,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroCard() {
    return _buildGlassCard(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const SweepGradient(
                  colors: [
                    AppColors.cyan,
                    AppColors.pink,
                    AppColors.green,
                    AppColors.orange,
                    AppColors.cyan,
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.pink.withOpacity(0.45),
                    blurRadius: 35,
                  ),
                ],
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: AppColors.dark,
                size: 34,
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Portal de notas activado",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Ingresa tus notas, ajusta pesos y calcula tu promedio final.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard() {
    final bool aprobado = _notaFinal! >= 10.5 && !_mensaje.contains("EP < 12.5");

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          colors: aprobado
              ? [
                  AppColors.green.withOpacity(0.95),
                  AppColors.cyan.withOpacity(0.9),
                  AppColors.pink.withOpacity(0.85),
                ]
              : [
                  AppColors.orange.withOpacity(0.95),
                  AppColors.pink.withOpacity(0.9),
                  AppColors.purple.withOpacity(0.85),
                ],
        ),
        boxShadow: [
          BoxShadow(
            color: aprobado
                ? AppColors.green.withOpacity(0.45)
                : AppColors.pink.withOpacity(0.45),
            blurRadius: 45,
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            aprobado ? Icons.verified : Icons.warning_amber_rounded,
            size: 46,
            color: AppColors.dark,
          ),
          const SizedBox(height: 8),
          const Text(
            "PROMEDIO FINAL",
            style: TextStyle(
              color: AppColors.dark,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
          Text(
            _notaFinal!.toStringAsFixed(2),
            style: const TextStyle(
              fontSize: 58,
              fontWeight: FontWeight.w900,
              color: AppColors.dark,
              height: 1,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _mensaje,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w900,
              color: AppColors.dark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeightRow(
    String label,
    TextEditingController c1,
    TextEditingController c2,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [AppColors.pink, AppColors.cyan],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.cyan.withOpacity(0.25),
                  blurRadius: 18,
                ),
              ],
            ),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                color: AppColors.dark,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: _buildSmallInput(c1, "ES %")),
          const SizedBox(width: 10),
          Expanded(child: _buildSmallInput(c2, "EP %")),
        ],
      ),
    );
  }

  Widget _buildSmallInput(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 13,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      decoration: _psyInputDecoration(label, Icons.percent, small: true),
    );
  }

  Widget _buildUnidadCard(
    String titulo,
    TextEditingController c1,
    String l1,
    TextEditingController c2,
    String l2,
    IconData icon,
  ) {
    return _buildGlassCard(
      margin: const EdgeInsets.only(bottom: 14),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.green),
                const SizedBox(width: 8),
                Text(
                  titulo,
                  style: const TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    fontSize: 14,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: c1,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: _psyInputDecoration(l1, Icons.edit_note),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextField(
                    controller: c2,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: _psyInputDecoration(l2, Icons.school),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassCard({
    required Widget child,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.16),
            Colors.white.withOpacity(0.06),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: Colors.white.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: AppColors.cyan.withOpacity(0.14),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: AppColors.pink.withOpacity(0.10),
            blurRadius: 35,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      child: child,
    );
  }

  InputDecoration _psyInputDecoration(
    String label,
    IconData icon, {
    bool small = false,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.white.withOpacity(0.75),
        fontSize: small ? 12 : 14,
        fontWeight: FontWeight.w700,
      ),
      prefixIcon: small
          ? null
          : Icon(
              icon,
              color: AppColors.cyan,
            ),
      filled: true,
      fillColor: Colors.black.withOpacity(0.22),
      isDense: true,
      contentPadding: EdgeInsets.symmetric(
        vertical: small ? 12 : 15,
        horizontal: 12,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.20),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(
          color: AppColors.green,
          width: 2,
        ),
      ),
    );
  }

  Widget _psyButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
    required bool filled,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        gradient: filled
            ? const LinearGradient(
                colors: [
                  AppColors.cyan,
                  AppColors.pink,
                  AppColors.green,
                ],
              )
            : null,
        border: filled
            ? null
            : Border.all(color: Colors.white.withOpacity(0.35), width: 1.3),
        boxShadow: [
          BoxShadow(
            color: filled
                ? AppColors.pink.withOpacity(0.35)
                : Colors.white.withOpacity(0.10),
            blurRadius: 28,
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: filled ? AppColors.dark : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w900,
            letterSpacing: 0.8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(999),
          ),
        ),
      ),
    );
  }
}

/* ===========================
   LOGO: HOJA DE NOTAS CON CHECKS
=========================== */

class NoteCheckLogo extends StatelessWidget {
  final double size;

  const NoteCheckLogo({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _NoteCheckLogoPainter(),
    );
  }
}

class _NoteCheckLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final glowPaint = Paint()
      ..color = AppColors.cyan.withOpacity(0.45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18);

    final paperRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(w * 0.19, h * 0.10, w * 0.62, h * 0.78),
      Radius.circular(w * 0.13),
    );

    canvas.drawRRect(paperRect, glowPaint);

    final paperPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFFE9FBFF),
          Color(0xFFFFE6FF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawRRect(paperRect, paperPaint);

    final foldPath = Path()
      ..moveTo(w * 0.63, h * 0.10)
      ..lineTo(w * 0.81, h * 0.28)
      ..lineTo(w * 0.63, h * 0.28)
      ..close();

    final foldPaint = Paint()
      ..shader = const LinearGradient(
        colors: [AppColors.cyan, AppColors.pink],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    canvas.drawPath(foldPath, foldPaint);

    final linePaint = Paint()
      ..color = AppColors.dark.withOpacity(0.45)
      ..strokeWidth = w * 0.035
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < 3; i++) {
      final y = h * (0.38 + i * 0.16);
      canvas.drawLine(
        Offset(w * 0.38, y),
        Offset(w * 0.68, y),
        linePaint,
      );
    }

    final checkPaint = Paint()
      ..color = AppColors.green
      ..strokeWidth = w * 0.055
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < 3; i++) {
      final y = h * (0.36 + i * 0.16);
      final check = Path()
        ..moveTo(w * 0.28, y + h * 0.04)
        ..lineTo(w * 0.33, y + h * 0.09)
        ..lineTo(w * 0.43, y - h * 0.02);
      canvas.drawPath(check, checkPaint);
    }

    final borderPaint = Paint()
      ..shader = const SweepGradient(
        colors: [
          AppColors.cyan,
          AppColors.pink,
          AppColors.green,
          AppColors.orange,
          AppColors.cyan,
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h))
      ..strokeWidth = w * 0.035
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(paperRect, borderPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/* ===========================
   FONDO PSICODÉLICO 4D
=========================== */

class PsychedelicBackground extends StatefulWidget {
  const PsychedelicBackground({super.key});

  @override
  State<PsychedelicBackground> createState() => _PsychedelicBackgroundState();
}

class _PsychedelicBackgroundState extends State<PsychedelicBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            size: Size.infinite,
            painter: _PsychedelicPainter(_controller.value),
          );
        },
      ),
    );
  }
}

class _PsychedelicPainter extends CustomPainter {
  final double progress;

  _PsychedelicPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final t = progress * 2 * pi;
    final rect = Offset.zero & size;

    final background = Paint()
      ..shader = RadialGradient(
        center: Alignment(
          sin(t) * 0.45,
          cos(t * 0.8) * 0.55,
        ),
        radius: 1.25,
        colors: const [
          Color(0xFF32004D),
          Color(0xFF001E2B),
          Color(0xFF180025),
          Color(0xFF030007),
        ],
      ).createShader(rect);

    canvas.drawRect(rect, background);

    final center = Offset(size.width / 2, size.height / 2);

    for (int i = 0; i < 9; i++) {
      final radius = size.shortestSide * (0.12 + i * 0.075);
      final paint = Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4
        ..color = HSVColor.fromAHSV(
          0.35,
          ((progress * 360) + i * 36) % 360,
          1,
          1,
        ).toColor()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2);

      final rotation = t + i * pi / 7;
      final path = Path();

      for (int p = 0; p <= 120; p++) {
        final angle = (p / 120) * 2 * pi;
        final wave = sin(angle * 5 + t + i) * 18;
        final x = center.dx + cos(angle + rotation) * (radius + wave);
        final y = center.dy + sin(angle + rotation) * (radius + wave);

        if (p == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }

      path.close();
      canvas.drawPath(path, paint);
    }

    for (int i = 0; i < 34; i++) {
      final angle = t + i * pi / 17;
      final distance = size.shortestSide * (0.18 + (i % 7) * 0.07);
      final x = center.dx + cos(angle * 1.4 + i) * distance;
      final y = center.dy + sin(angle * 1.2 + i) * distance;

      final particlePaint = Paint()
        ..color = HSVColor.fromAHSV(
          0.75,
          ((progress * 360) + i * 20) % 360,
          1,
          1,
        ).toColor()
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7);

      canvas.drawCircle(
        Offset(x, y),
        3 + (i % 5) * 1.6,
        particlePaint,
      );
    }

    final gridPaint = Paint()
      ..color = Colors.white.withOpacity(0.055)
      ..strokeWidth = 1;

    const spacing = 42.0;
    final offset = progress * spacing;

    for (double x = -spacing; x < size.width + spacing; x += spacing) {
      canvas.drawLine(
        Offset(x + offset, 0),
        Offset(x - offset, size.height),
        gridPaint,
      );
    }

    for (double y = -spacing; y < size.height + spacing; y += spacing) {
      canvas.drawLine(
        Offset(0, y + offset),
        Offset(size.width, y - offset),
        gridPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _PsychedelicPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}