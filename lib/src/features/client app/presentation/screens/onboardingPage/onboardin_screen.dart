import 'package:maintenance_app/src/core/export%20file/exportfiles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  final VoidCallback onFinish;
  const OnboardingScreen({super.key, required this.onFinish});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _slides = [
      SianaIntroPage(
        title: "SIANA PLUS",
        subtitle: "Welcome to Siana Plus\nمرحباً بك في صيانة بلس",
        description:
            "Your trusted partner for fast and reliable maintenance services\nشريكك الموثوق لخدمات صيانة سريعة وموثوقة",
      ),
      const OnboardingPage(
        image: 'assets/images/2.png',
        subtitleAr: "نأتــي إليــك",
        subtitleEn: "We Come to You",
        descriptionAr: "حدد موعد الاستلام \n نأتي لاستلام جهازك من موقعك",
        descriptionEn:
            "Schedule a pickup - we collect your \n device from your location",
      ),
      const OnboardingPage(
        image: 'assets/images/3.png',
        subtitleAr: "إصلاح من الخبراء",
        subtitleEn: "Fixed by experts",
        descriptionAr:
            "يتم إصلاح جهازك في ورشتنا المعتمدة\n  باستخدام أدوات عالية الجودة",
        descriptionEn:
            "Your device is repaired in our certified \n workshop using top-quality tools",
      ),
      const OnboardingPage(
        image: 'assets/images/4.png',
        subtitleAr: "تسليم كالجديد",
        subtitleEn: "Delivered like new",
        descriptionAr: "تسلم جهازك في حالة ممتازة\n وجاهز للاستخدام",
        descriptionEn:
            "We deliver your device back in excellent\n condition and ready to use",
      ),
      OnboardingFinalPage(
        image: 'assets/images/5.png',
        subtitleAr: "تسوق معنا ايضا",
        subtitleEn: "Shop with us too",
        descriptionAr: "تسوق قطع غيار اجهزه\n مجدده بحاله ممتازه",
        descriptionEn:
            "Shop for refurbished appliance parts\nin excellent condition",
        onFinish: widget.onFinish,
      ),
    ];

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _slides,
          ),
          Positioned(
            bottom: 40.0,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _slides.length,
                effect: const WormEffect(
                  dotHeight: 10,
                  dotWidth: 10,
                  activeDotColor: AppColors.secondaryColor,
                ),
              ),
            ),
          ),
          if (_currentPage < _slides.length - 1)
            Positioned(
              bottom: 20.0,
              right: 20.0,
              child: TextButton(
                onPressed: () {
                  _pageController.animateToPage(
                    _slides.length - 1,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeIn,
                  );
                },
                child: const CustomStyledText(
                  text: 'تخطي',
                  fontSize: 18,
                  textColor: AppColors.secondaryColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final String image;

  final String subtitleAr;

  final String subtitleEn;

  final String descriptionAr;

  final String descriptionEn;

  const OnboardingPage({
    super.key,
    required this.image,
    required this.subtitleAr,
    required this.subtitleEn,
    required this.descriptionAr,
    required this.descriptionEn,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          bottom: 100,
          left: 24,
          right: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomStyledText(
                text: subtitleEn,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                textColor: AppColors.secondaryColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              CustomStyledText(
                text: subtitleAr,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.secondaryColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomStyledText(
                text: descriptionEn,
                fontSize: 14,
                textColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              CustomStyledText(
                text: descriptionAr,
                fontSize: 14,
                textColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OnboardingFinalPage extends StatelessWidget {
  final String image;

  final String subtitleAr;

  final String subtitleEn;

  final String descriptionAr;

  final String descriptionEn;

  final VoidCallback onFinish;

  const OnboardingFinalPage({
    super.key,
    required this.image,
    required this.subtitleAr,
    required this.subtitleEn,
    required this.descriptionAr,
    required this.descriptionEn,
    required this.onFinish,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // الخلفية

        Positioned.fill(
          child: Image.asset(
            image,
            fit: BoxFit.cover,
          ),
        ),

        // النصوص + الزر

        Positioned(
          bottom: 80,
          left: 24,
          right: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomStyledText(
                text: subtitleEn,
                fontSize: 24,
                fontWeight: FontWeight.w500,
                textColor: AppColors.secondaryColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              CustomStyledText(
                text: subtitleAr,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textColor: AppColors.secondaryColor,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomStyledText(
                text: descriptionEn,
                fontSize: 14,
                textColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              CustomStyledText(
                text: descriptionAr,
                fontSize: 14,
                textColor: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomButton(
                text: "ابدأ الآن",
                onPressed: () {
                  onFinish;
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SianaIntroPage extends StatelessWidget {
  const SianaIntroPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
  });

  final String title;
  final String subtitle;
  final String description;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.transparent,
              ],
            ),
          ),
        ),
        ..._buildAnimatedCircles(screenSize),
        Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildAnimatedLogo(context),
                const SizedBox(height: 40),
                Column(
                  children: [
                    TweenAnimationBuilder(
                      duration: const Duration(milliseconds: 1000),
                      tween: Tween<double>(begin: 0, end: 1),
                      builder: (context, value, child) {
                        return Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, 20 * (1 - value)),
                            child: child,
                          ),
                        );
                      },
                      child: CustomStyledText(
                        text: subtitle,
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.secondaryColor,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: CustomStyledText(
                        text: description,
                        fontSize: 18,
                        textColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                        fontWeight: FontWeight.bold,
                        height: 1.6,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedLogo(BuildContext context) {
    return TweenAnimationBuilder(
      duration: const Duration(milliseconds: 1000),
      tween: Tween<double>(begin: 0, end: 1),
      builder: (contextAnim, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryColor.withOpacity(0.2),
              blurRadius: 30,
              spreadRadius: 5,
            ),
          ],
        ),
        child: Theme.of(context).brightness == Brightness.dark
            ? Image.asset(
                'assets/images/logoWhit.png',
                height: 150,
              )
            : Image.asset(
                'assets/images/logo.png',
                height: 150,
              ),
      ),
    );
  }

  List<Widget> _buildAnimatedCircles(Size screenSize) {
    final circles = <Widget>[];

    final colors = [
      AppColors.secondaryColor.withOpacity(0.08),
      AppColors.primaryColor.withOpacity(0.08),
    ];

    circles.add(
      Positioned(
        top: screenSize.height * 0.1,
        right: screenSize.width * 0.2,
        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 2000),
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(
                scale: value,
                child: child,
              ),
            );
          },
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colors[0],
            ),
          ),
        ),
      ),
    );

    // دوائر متوسطة

    for (int i = 0; i < 5; i++) {
      circles.add(
        Positioned(
          top: screenSize.height * 0.3 + (i * 60),
          left: screenSize.width * 0.1 + (i * 30),
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 1500 + i * 300),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: value,
                  child: child,
                ),
              );
            },
            child: Container(
              width: 40 + (i * 10),
              height: 40 + (i * 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[i % colors.length],
              ),
            ),
          ),
        ),
      );
    }

    // دوائر صغيرة

    for (int i = 0; i < 8; i++) {
      circles.add(
        Positioned(
          bottom: screenSize.height * 0.2 + (i * 40),
          right: screenSize.width * 0.1 + (i * 30),
          child: TweenAnimationBuilder(
            duration: Duration(milliseconds: 1200 + i * 200),
            tween: Tween<double>(begin: 0, end: 1),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.scale(
                  scale: value,
                  child: child,
                ),
              );
            },
            child: Container(
              width: 20 + (i % 3) * 10,
              height: 20 + (i % 3) * 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colors[i % colors.length],
              ),
            ),
          ),
        ),
      );
    }

    return circles;
  }
}
