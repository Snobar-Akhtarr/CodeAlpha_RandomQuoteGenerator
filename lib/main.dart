import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const QuoteApp());


class Quote {
  final String text;
  final String author;
  const Quote(this.text, this.author);
}

const List<Quote> quotes = [
  Quote('The only way to do great work is to love what you do.', 'Steve Jobs'),
  Quote('It always seems impossible until it is done.', 'Nelson Mandela'),
  Quote('Well done is better than well said.', 'Benjamin Franklin'),
  Quote('The future belongs to those who believe in the beauty of their dreams.',
      'Eleanor Roosevelt'),
  Quote('Whether you think you can, or you think you can\'t, you\'re right.',
      'Henry Ford'),
  Quote('Do what you can, with what you have, where you are.',
      'Theodore Roosevelt'),
  Quote('We are what we repeatedly do. Excellence, then, is not an act, but a habit.',
      'Will Durant'),
  Quote('A journey of a thousand miles begins with a single step.', 'Lao Tzu'),
  Quote('You miss 100% of the shots you don\'t take.', 'Wayne Gretzky'),
  Quote('An investment in knowledge pays the best interest.',
      'Benjamin Franklin'),
  Quote('Knowledge is power.', 'Francis Bacon'),
  Quote('Fall seven times, stand up eight.', 'Japanese Proverb'),
  Quote('Talk is cheap. Show me the code.', 'Linus Torvalds'),
  Quote('First, solve the problem. Then, write the code.', 'John Johnson'),
  Quote('Code is like humor. When you have to explain it, it\'s bad.',
      'Cory House'),
  Quote('Stay hungry, stay foolish.', 'Steve Jobs'),
];

class QuoteApp extends StatefulWidget {
  const QuoteApp({super.key});

  @override
  State<QuoteApp> createState() => _QuoteAppState();
}

class _QuoteAppState extends State<QuoteApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quote Generator',
      debugShowCheckedModeBanner: false,
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0B132B),
      ),
      home: QuoteScreen(
        isDark: _isDark,
        onToggleTheme: () => setState(() => _isDark = !_isDark),
      ),
    );
  }
}

class QuoteScreen extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const QuoteScreen({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  final Random _random = Random();
  late int _index;

  @override
  void initState() {
    super.initState();
    // Show a random quote as soon as the app opens.
    _index = _random.nextInt(quotes.length);
  }

  void _newQuote() {
    int next;
    // Make sure the same quote never appears twice in a row.
    do {
      next = _random.nextInt(quotes.length);
    } while (next == _index && quotes.length > 1);
    setState(() => _index = next);
  }

  Future<void> _copyQuote() async {
    final q = quotes[_index];
    await Clipboard.setData(ClipboardData(text: '"${q.text}" - ${q.author}'));
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Quote copied'),
          duration: Duration(seconds: 1),
          behavior: SnackBarBehavior.floating,
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final ink = isDark ? const Color(0xFFF1F5F9) : const Color(0xFF14213D);
    final muted = isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
    const accent = Color(0xFFE0A100);
    final quote = quotes[_index];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: IconButton(
                  tooltip: isDark ? 'Light mode' : 'Dark mode',
                  onPressed: widget.onToggleTheme,
                  icon: Icon(
                    isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
                    color: muted,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 560),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 450),
                      switchInCurve: Curves.easeOut,
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: Column(
                        key: ValueKey<int>(_index),
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '\u201C',
                            style: TextStyle(
                              fontFamily: 'serif',
                              fontSize: 120,
                              height: 0.8,
                              color: accent,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            quote.text,
                            style: TextStyle(
                              fontFamily: 'serif',
                              fontSize: 28,
                              height: 1.45,
                              fontWeight: FontWeight.w500,
                              color: ink,
                            ),
                          ),
                          const SizedBox(height: 28),
                          Row(
                            children: [
                              Container(width: 32, height: 2, color: accent),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  quote.author,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                    color: muted,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 8, 32, 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FilledButton.icon(
                    onPressed: _newQuote,
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('New Quote'),
                    style: FilledButton.styleFrom(
                      backgroundColor: ink,
                      foregroundColor: isDark ? const Color(0xFF0B132B) : Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 28, vertical: 16),
                      shape: const StadiumBorder(),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    tooltip: 'Copy quote',
                    onPressed: _copyQuote,
                    icon: Icon(Icons.copy_rounded, color: muted),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}