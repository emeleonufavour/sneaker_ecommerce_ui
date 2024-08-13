import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shoe_ecommerce_mobile/ui/view/onboarding/onboarding_vm.dart';
import 'package:stacked/stacked.dart';

import '../../../helpers/page_route.dart';
import '../../widgets/page_view.dart';
import '../home/home.dart';
import 'page.dart';
import 'widget/onboarding_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return ViewModelBuilder.nonReactive(
        viewModelBuilder: () => OnboardingViewModel(),
        onViewModelReady: (model) => model.getAllShoes(),
        builder: (context, model, _) {
          return Scaffold(
            body: ConcentricPageView(
              colors: pages.map((p) => p.bgColor).toList(),
              radius: screenWidth * 0.1,
              curve: Curves.ease,
              nextButtonBuilder: (context) => Padding(
                padding: const EdgeInsets.only(left: 3), // visual center
                child: Icon(
                  Icons.navigate_next,
                  size: screenWidth * 0.08,
                ),
              ),
              itemBuilder: (index) {
                final page = pages[index % pages.length];
                return SafeArea(
                  child: OnboardingPage(page: page),
                );
              },
              onFinish: () {
                log("finished");
                Navigator.push(context, ConcentricPageRoute(builder: (ctx) {
                  return HomePage();
                }));
              },
            ),
          );
        });
  }
}
