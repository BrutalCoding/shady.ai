import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:slick_slides/slick_slides.dart';
import 'package:url_launcher/url_launcher.dart';

class SlideDeckPage extends StatefulHookConsumerWidget {
  const SlideDeckPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SlideDeckState();
}

const _defaultTransition = SlickFadeTransition(
  color: Colors.black,
  duration: Duration(seconds: 1),
);

class _SlideDeckState extends ConsumerState<SlideDeckPage> {
  final _slides = [
    Slide(
      builder: (context) {
        return TitleSlide(
          background: FadeIn(
            duration: const Duration(seconds: 1),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.shadow.withOpacity(0.3),
                BlendMode.srcATop,
              ),
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: Container(
                  // Decoration with an image. Radial gradient to make the image
                  // have a vignette effect.
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/background_beach.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Title with Text() widget that jumps in from the bottom.
          title: FadeIn(
            duration: const Duration(seconds: 2),
            child: Text(
              'ShadyAI',
            ),
          ),
          subtitle: FadeIn(
            duration: const Duration(seconds: 3),
            child: Text(
              "Making AI accessible to everyone.",
            ),
          ),
        );
      },
      onPrecache: (context) {
        precacheImage(
          const AssetImage('assets/background_beach.jpg'),
          context,
        );
      },
    ),
    Slide(
      transition: _defaultTransition,
      builder: (context) {
        return TitleSlide(
          title: const Text('Features'),
          subtitle: Bullets(
            bullets: const [
              "Nada. Zero.",
              "The very first feature will be a 'question and answer' interaction.",
              "For example, you could ask: 'What is the meaning of life?'",
              "Your AI might reply with: '42', 'To be happy.' or any other answer.",
            ],
          ),
        );
      },
    ),
    Slide(
      transition: _defaultTransition,
      builder: (context) {
        return TitleSlide(
          title: const Text('Why?'),
          subtitle: Bullets(
            bullets: const [
              'To make AI accessible to everyone.',
              'To learn by doing.',
              'To have fun.',
            ],
          ),
        );
      },
    ),
    Slide(
      transition: _defaultTransition,
      builder: (context) {
        return TitleSlide(
          title: const Text('Vision'),
          subtitle: Bullets(
            bullets: const [
              'Limited scope, but high quality.',
              'A hub of practical examples where local AI can be used.',
              'To be a tool that is used by people who like to learn by doing.',
            ],
          ),
        );
      },
    ),
    Slide(
      transition: _defaultTransition,
      builder: (context) {
        return TitleSlide(
          title: const Text("What it's not"),
          subtitle: Bullets(
            bullets: const [
              'Not a tool to train AI.',
              'Not a tool meant to be used in production.',
              'Not a tool to be used as a substitute for professional help.',
            ],
          ),
        );
      },
    ),
    Slide(
      transition: _defaultTransition,
      onPrecache: (context) {
        precacheImage(
          const AssetImage('assets/background_classic.jpg'),
          context,
        );
        precacheImage(
          const AssetImage('assets/daniel_magenta.png'),
          context,
        );
      },
      builder: (context) {
        return TitleSlide(
          title: const Text("Audience"),
          subtitle: Bullets(
            bullets: const [
              'People who like to learn by doing.',
              'People who prefer simplicity over complexity.',
              'People who like to have full control over their privacy.',
            ],
          ),
        );
      },
    ),
    Slide(
      transition: _defaultTransition,
      builder: (context) {
        return TitleSlide(
          title: Text('Support'),
          subtitle: Column(
            children: [
              Text(
                "Small gestures like a star on GitHub, a follow on Twitter, or a mention in a blog post go a long way.",
              ),
            ],
          ),
        );
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    final slideDeckAction = useState<SlideDeckAction>(SlideDeckAction.none);

    return Scaffold(
      body: SlideDeck(
        theme: SlideThemeData.dark(
          backgroundBuilder: (context) {
            return Container(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.bottomCenter,
                  radius: 1.5,
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.tertiary,
                  ],
                ),
              ),
            );
          },
          textTheme: SlideTextThemeData.dark(
            title: TextStyle(
              fontSize: 96,
              fontWeight: FontWeight.bold,
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 2
                ..shader = LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(context).colorScheme.tertiaryContainer,
                  ],
                ).createShader(
                  Rect.zero,
                ),
            ),
            titleGradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.tertiaryContainer,
              ],
            ),
            subtitle: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
            subtitleGradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.secondaryContainer,
                Theme.of(context).colorScheme.tertiaryContainer,
              ],
            ),
          ),
        ),
        slideDeckAction: slideDeckAction.value,
        slides: _slides
          ..add(
            Slide(
              transition: _defaultTransition,
              builder: (context) {
                return PersonSlide(
                  background: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 10,
                      sigmaY: 10,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/background_classic.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  name: FittedBox(
                    child: const Text(
                      'BrutalCoding',
                    ),
                  ),
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      children: [
                        FittedBox(
                          child: const Text(
                            "Flutter Expert & AI Enthusiast",
                          ),
                        ),
                        const SizedBox(height: 32),
                        Container(
                          width: 256,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () {
                              slideDeckAction.value = SlideDeckAction.exit;
                            },
                            child: const Text('Get Started'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  image: Stack(
                    children: [
                      FittedBox(
                        child: Image.asset(
                          'assets/daniel_magenta.png',
                          width: 256,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        left: 0,
                        child: Center(
                          child: ElevatedButton(
                            onPressed: () {
                              launchUrl(
                                Uri.parse(
                                  'https://github.com/BrutalCoding',
                                ),
                              );
                            },
                            child: const Text('Follow me on GitHub'),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              onPrecache: (context) {
                precacheImage(
                  const AssetImage('assets/background_classic.jpg'),
                  context,
                );
                precacheImage(
                  const AssetImage('assets/daniel_magenta.png'),
                  context,
                );
              },
            ),
          ),
      ),
    );
  }
}
