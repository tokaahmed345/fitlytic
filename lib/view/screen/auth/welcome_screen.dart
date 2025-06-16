// Welcome/Onboarding Screen
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_depi/utils/constants/custom_colors.dart';
import 'package:flutter_application_depi/view/screen/Home/start_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF141B2D),
      body: Stack(
        children: [
          // Animated confetti background
          const ConfettiBackground(),

          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Green checkmark icon - keeping green for success symbolism
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.blue, width: 3),
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 30),

                // Welcome text - using white for visibility on dark background
                const Text(
                  'Welcome to Fitlytic!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 15),

                // Subtitle - using light gray for secondary text
                const Text(
                  'Your account has been created successfully.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFB8BDC8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Let\'s start your fitness journey!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFB8BDC8),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),

                // Continue button - using a vibrant color for the button
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05),
                  decoration: BoxDecoration(
                    gradient: MyColors.customGradient,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const HomePage()),
                        (routes) =>false, // Removes all previous routes
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Continue to Dashboard',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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
}

// Animated confetti for the welcome screen
class ConfettiBackground extends StatefulWidget {
  const ConfettiBackground({super.key});

  @override
  State<ConfettiBackground> createState() => _ConfettiBackgroundState();
}

class _ConfettiBackgroundState extends State<ConfettiBackground>
    with TickerProviderStateMixin {
  late List<ConfettiPiece> confetti;
  late AnimationController controller;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    confetti = List.generate(50, (_) {
      return ConfettiPiece(
        position: Offset(
          random.nextDouble() * 400,
          random.nextDouble() * 800 - 400,
        ),
        color: _getRandomColor(),
        size: random.nextDouble() * 10 + 5,
        speed: random.nextDouble() * 2 + 0.5,
        shape: random.nextBool() ? ConfettiShape.square : ConfettiShape.line,
      );
    });

    // Initialize the animation controller
    controller = AnimationController(
      duration: const Duration(milliseconds: 50),
      vsync: this,
    );

    controller.addListener(() {
      if (!mounted) return; // Prevent accessing MediaQuery when unmounted

      for (var piece in confetti) {
        piece.position = Offset(
          piece.position.dx,
          piece.position.dy + piece.speed,
        );

        // Reset if off screen
        if (piece.position.dy > MediaQuery.of(context).size.height) {
          piece.position = Offset(
            random.nextDouble() * MediaQuery.of(context).size.width,
            -random.nextDouble() * 100,
          );
        }
      }
      setState(() {});
    });

    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Color _getRandomColor() {
    final colors = [
      Colors.red[300]!,
      Colors.blue[300]!,
      Colors.green[300]!,
      Colors.yellow[300]!,
      Colors.purple[300]!,
      Colors.orange[300]!,
      Colors.teal[300]!,
      Colors.pink[300]!,
    ];
    return colors[random.nextInt(colors.length)];
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      painter: ConfettiPainter(confetti),
    );
  }
}


// Confetti painter
class ConfettiPainter extends CustomPainter {
  final List<ConfettiPiece> confetti;

  ConfettiPainter(this.confetti);

  @override
  void paint(Canvas canvas, Size size) {
    for (var piece in confetti) {
      final paint = Paint()
        ..color =
            piece.color.withOpacity(0.8) // Adding opacity for softer effect
        ..style = PaintingStyle.fill;

      if (piece.shape == ConfettiShape.square) {
        canvas.drawRect(
          Rect.fromCenter(
            center: piece.position,
            width: piece.size,
            height: piece.size,
          ),
          paint,
        );
      } else {
        canvas.drawLine(
          piece.position,
          Offset(piece.position.dx, piece.position.dy + piece.size),
          paint..strokeWidth = 2,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Confetti piece
class ConfettiPiece {
  Offset position;
  Color color;
  double size;
  double speed;
  ConfettiShape shape;

  ConfettiPiece({
    required this.position,
    required this.color,
    required this.size,
    required this.speed,
    required this.shape,
  });
}

enum ConfettiShape { square, line }
