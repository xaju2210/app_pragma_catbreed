import 'package:app_pragma_prueba/config/constants/const_name_router.dart';
import 'package:app_pragma_prueba/entity/entity_cat.dart';
import 'package:app_pragma_prueba/screen/screen_detail.dart';
import 'package:app_pragma_prueba/screen/screen_list.dart';
import 'package:app_pragma_prueba/screen/screen_splash.dart';
import 'package:app_pragma_prueba/service/service_navigation.dart';
import 'package:go_router/go_router.dart';
//import 'package:fluro/fluro.dart';

// GoRouter configuration
final appRouter = GoRouter(
  initialLocation: ConstNameRouter.root,
  navigatorKey: ServiceNavigation.navigatorKey,
  routes: [
    GoRoute(
      path: ConstNameRouter.root,
      builder: (context, state) {
        return const ScreenSplash();
      },
    ),
    GoRoute(
      path: ConstNameRouter.list,
      builder: (context, state) {
        return const ScreenList();
      },
    ),
    GoRoute(
      path: ConstNameRouter.detail,
      builder: (context, state) {
        EntityCat? objCat =
            (state.extra is EntityCat) ? state.extra as EntityCat : null;

        return ScreenDetail(
          objCat: objCat,
        );
      },
    ),
  ],
);
