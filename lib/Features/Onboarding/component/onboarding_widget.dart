import 'package:workforce/Core/app_core.dart';

class OnboardingScreen extends StatefulWidget {
  final String lottiePath;
  final String title;
  final String subtext;

  const OnboardingScreen({
    super.key,
    required this.lottiePath,
    required this.title,
    required this.subtext,
  });

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slide = Tween<Offset>(begin: Offset(0, 0.2), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Lottie.asset(widget.lottiePath, width: 0.8.sw, height: 0.4.sh),
        SlideTransition(
          position: _slide,
          child: FadeTransition(
            opacity: _fade,
            child: Text(
              widget.title,
              style: AppTextStyles.heading,
            ),
          ),
        ),
        SizedBox(height: 0.02.sh),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: FadeTransition(
            opacity: _fade,
            child: Text(
              widget.subtext,
              textAlign: TextAlign.center,
              style: AppTextStyles.subtext,
            ),
          ),
        )
      ],
    );
  }
}
