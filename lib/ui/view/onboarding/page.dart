import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../model/page_data.dart';

final pages = [
  PageData(
      icon: Icons.lock,
      title: "Find Your Perfect Pair with Ease!",
      bgColor: const Color(0xFF0043D0),
      textColor: Colors.white,
      lottie: Lottie.asset("assets/lotties/shoe2.json",
          animate: true, repeat: true)),
  PageData(
      icon: Icons.format_size,
      title: "Exclusive Styles, Just for You!",
      textColor: Colors.white,
      bgColor: const Color(0xFFFFA500),
      lottie: Lottie.asset("assets/lotties/shoe5.json",
          animate: true, repeat: true)),
  PageData(
      icon: Icons.hdr_weak,
      title: "Let's get started",
      textColor: const Color(0xFF0043D0),
      bgColor: const Color(0xFFFFFFFF),
      lottie: Lottie.asset("assets/lotties/shoe4.json",
          animate: true, repeat: true)),
];
