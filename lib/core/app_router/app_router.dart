import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic_layer/home_bloc/home_cubit.dart';
import '../../data_layer/repository/home_repo/home_repo.dart';
import '../../data_layer/services/home_services/home_services.dart';

import '../../presentation_layer/layout/home_layout/home_layout.dart';
import '../../presentation_layer/splash/splash_view.dart';

class AppRouter {
  late HomeBaseRepository homeBaseRepository;
  late HomeCubit homeCubit;

  AppRouter() {
    homeBaseRepository = HomeBaseRepository(homeServices: HomeServices());
    homeCubit = HomeCubit(homeBaseRepository: homeBaseRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashView(),
        );
      case 'homelayout':
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (BuildContext context) =>
                    HomeCubit(homeBaseRepository: homeBaseRepository)
                      ..getPopularMovie()
                      ..getNewReleaseMovie()
                      ..getRecommendedModel(),
                child: const HomeLayout()));
    }
  }
}
