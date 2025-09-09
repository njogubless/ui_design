import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentIndex = 0;
  final int totalPages;

  OnboardingController({required this.totalPages});

  // Call this when the page is scrolled
  void onPageChanged(int index) {
    currentIndex = index;
    notifyListeners();
  }

  // Jump to a specific page (dot selected)
  void jumpToPage(int index) {
    if (index >= 0 && index < totalPages) {
      currentIndex = index;
      pageController.jumpToPage(index);
      notifyListeners();
    }
  }

  // Jump to next page
  void nextPage() {
    if (currentIndex < totalPages - 1) {
      currentIndex++;
      pageController.animateToPage(
        currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
      notifyListeners();
    }
  }

  // Jump to last page
  void jumpToLastPage() {
    currentIndex = totalPages - 1;
    pageController.jumpToPage(currentIndex);
    notifyListeners();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}