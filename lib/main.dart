import 'package:curt_task/core/utililes/app_theme.dart';
import 'package:curt_task/feature/Auth/data/data_source/data_source.dart';
import 'package:curt_task/feature/Auth/data/repository/auth_repo.dart';
import 'package:curt_task/feature/Auth/domain/use_case/log_in_use_case.dart';
import 'package:curt_task/feature/Auth/domain/use_case/sign_up_use_case.dart';
import 'package:curt_task/feature/Auth/presentation/controller/auth_cubit.dart';
import 'package:curt_task/feature/Auth/presentation/screen/log_in.dart';
import 'package:curt_task/feature/Auth/presentation/screen/sign_up.dart';
import 'package:curt_task/feature/inventory/presentation/screen/inventory.dart';
import 'package:curt_task/feature/welcome/presentation/screen/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  // ServiceLocator.init();
  runApp(MyApp(

  ));
}

class MyApp extends StatelessWidget {

  MyApp();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(LogInUseCase(AuthRepository(LocalAuthDataSource
      ())), SignUpUseCase(AuthRepository(LocalAuthDataSource
      ()))),
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.light,
        debugShowCheckedModeBanner: false,

        home:Welcome(),
        routes: {
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/inventory': (context) => Inventory(),

        },
      ),
    );
  }
}
