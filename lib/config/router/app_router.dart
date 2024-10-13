import 'package:go_router/go_router.dart';
import 'package:juego_pares/presentation/screens/screens.dart';
// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: '/',
  routes: [

    GoRoute(
      path: '/',
      name: HomeScreen.name,
      builder: (context, state) => const HomeScreen(),
    ),


    GoRoute(
      path: '/easy',
      name: EasyScreen.name,
      builder: (context, state) => const EasyScreen(),
    ),


    GoRoute(
      path: '/normal',
      name: NormalScreen.name,
      builder: (context, state) => const NormalScreen(),
    ),


    GoRoute(
      path: '/hard',
      name: HardScreen.name,
      builder: (context, state) => const HardScreen(),
    ),

    // GoRoute(
    //   path: '/cards',
    //   name: CardsScreen.name,
    //   builder: (context, state) => const CardsScreen(),
    // ),


    // GoRoute(
    //   path: '/theme-changer',
    //   name: ThemeChangerScreen.name,
    //   builder: (context, state) => const ThemeChangerScreen(),
    // ),
  ],
);