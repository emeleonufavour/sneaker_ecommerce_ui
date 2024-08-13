import 'package:stacked/stacked_annotations.dart';

import '../service/product_service.dart';

@StackedApp(
    routes: [], dependencies: [LazySingleton(classType: ProductService)])
class AppSetup {}
