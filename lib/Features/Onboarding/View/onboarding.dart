import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:workforce/Core/app_core.dart';
import 'package:workforce/shared/Widgets/navigation_btn.dart';

class MainOnboarding extends StatefulWidget {
  const MainOnboarding({super.key});

  @override
  State<MainOnboarding> createState() => _MainOnboardingState();
}

class _MainOnboardingState extends State<MainOnboarding>
    with SingleTickerProviderStateMixin {
  final _controller = Get.find<OnboardingController>();
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Stack(
            children: [
              Positioned(
                right: 0.w,
                top: 40.h,
                child: SecondaryBtn(
                  text: 'Skip',
                  bg: AppColors.primaryColor,
                  onTap: () {
                    Get.offAll(() => Login());
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0.2.sh,
                child: SizedBox(
                  height: 0.6.sh,
                  child: PageView(
                    controller: _controller.pageController,
                    onPageChanged: _controller.onPageChanged,
                    children: [
                      OnboardingScreen(
                        lottiePath: 'assets/animations/TeamWork.json',
                        title: 'Team Collaboration',
                        subtext:
                            'Work together efficiently and manage your team’s tasks in one centralized platform.',
                      ),
                      OnboardingScreen(
                        lottiePath: 'assets/animations/Task.json',
                        title: 'Task Tracking',
                        subtext:
                            'Stay on top of your team`s progress with real-time task updates and smart scheduling.',
                      ),
                      OnboardingScreen(
                        lottiePath: 'assets/animations/productivity.json',
                        title: 'Mobile Productivity',
                        subtext:
                            'Manage tasks, monitor progress, and stay connected — all from your mobile device.',
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  bottom: 20.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      navArrowButton(
                          onTap: () {
                            _controller.prevPage();
                          },
                          icon: FontAwesomeIcons.arrowLeft),
                      SmoothPageIndicator(
                        controller: _controller.pageController,
                        count: 3,
                        effect: ExpandingDotsEffect(
                          dotColor: AppColors.grey,
                          activeDotColor: AppColors.primaryColor,
                          dotWidth: 8.w,
                          dotHeight: 5.h,
                        ),
                      ),
                      Obx(
                        () => navArrowButton(
                            onTap: () {
                              _controller.nextPage();
                            },
                            icon: _controller.currentPage.value ==
                                    _controller.totalPages - 1
                                ? FontAwesomeIcons.check
                                : FontAwesomeIcons.arrowRight),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

// SmoothPageIndicator(
//                         controller: _controller.pageController,
//                         count: _controller.totalPages,
//                         effect: ExpandingDotsEffect(
//                           dotColor: AppColors.grey,
//                           activeDotColor: AppColors.primaryColor,
//                           dotWidth: 8.w,
//                           dotHeight: 5.h,
//                         ),
//                       ),
