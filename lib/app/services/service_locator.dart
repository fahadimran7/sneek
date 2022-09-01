import 'package:flutter_mvvm_project/app/services/products/product_service.dart';
import 'package:flutter_mvvm_project/app/services/users/user_service.dart';
import 'package:get_it/get_it.dart';

import 'auth/authentication_service.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerLazySingleton<AuthenticationService>(
    () => AuthenticationService(),
  );

  locator.registerLazySingleton<ProductService>(
    () => ProductService(),
  );

  locator.registerLazySingleton<UserService>(
    () => UserService(),
  );
}
