import 'package:flutter/material.dart';

abstract final class PageTransitions {
  // 1. FADE - Most common, smooth and elegant
  static Widget fadeTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(
      opacity: CurveTween(curve: Curves.easeInOut).animate(animation),
      child: child,
    );
  }

  // 2. SLIDE FROM RIGHT - Standard navigation feel (like iOS)
  static Widget slideFromRight(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(CurveTween(curve: Curves.easeInOut).animate(animation)),
      child: child,
    );
  }

  // 3. SLIDE FROM LEFT - Back navigation or drawer
  static Widget slideFromLeft(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset.zero,
      ).animate(CurveTween(curve: Curves.easeInOut).animate(animation)),
      child: child,
    );
  }

  // 4. SLIDE FROM BOTTOM - Modal/bottom sheet style
  static Widget slideFromBottom(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(CurveTween(curve: Curves.easeOut).animate(animation)),
      child: child,
    );
  }

  // 5. SCALE - Material Design standard
  static Widget scale(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurveTween(curve: Curves.fastOutSlowIn).animate(animation)),
      child: child,
    );
  }

  // 6. ROTATION - Creative but professional
  static Widget rotation(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return RotationTransition(
      turns: Tween<double>(
        begin: -0.1,
        end: 0,
      ).animate(CurveTween(curve: Curves.easeOutBack).animate(animation)),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  // 7. SLIDE + FADE - iOS style, very popular
  static Widget slideAndFade(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.3, 0),
        end: Offset.zero,
      ).animate(CurveTween(curve: Curves.easeOut).animate(animation)),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  // 8. ZOOM - Material Design hero-like
  static Widget zoom(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(
        begin: 0.8,
        end: 1,
      ).animate(CurveTween(curve: Curves.easeOut).animate(animation)),
      child: FadeTransition(opacity: animation, child: child),
    );
  }

  // 9. NO TRANSITION - Instant navigation
  static Widget noTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return child;
  }
}
