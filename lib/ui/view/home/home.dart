import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shoe_ecommerce_mobile/repository/product_repo.dart';
import 'package:shoe_ecommerce_mobile/ui/view/home/home_vm.dart';
import 'package:shoe_ecommerce_mobile/ui/widgets/text_widget.dart';
import 'package:stacked/stacked.dart';
import 'widgets/shoe_list_view.dart';

class HomePage extends StatelessWidget {
  ProductRepository product = ProductRepository();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ViewModelBuilder.reactive(
        viewModelBuilder: () => HomeViewModel(),
        builder: (context, model, _) {
          return Scaffold(
            backgroundColor: const Color(0xfffffdf6),
            body: SafeArea(
              child: Center(
                child: Column(children: [
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  SizedBox(
                      height: size.height * 0.05,
                      width: size.width * 0.2,
                      child: SvgPicture.asset("assets/svg/nike.svg")),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TextWidget(
                            title: "Men's Running           Shoe",
                            fontWeight: FontWeight.w700,
                            textColor: Colors.black,
                            textAlign: TextAlign.left,
                            fontSize: 35,
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 10.0, bottom: (size.height * 0.12)),
                            child: Container(
                              height: size.height * 0.009,
                              width: size.width * 0.2,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 5),
                    height: size.height * 0.5,
                    child: ShoeListView(size: size, model: model),
                  ),
                ]),
              ),
            ),
          );
        });
  }
}
