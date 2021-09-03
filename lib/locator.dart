import 'package:any_chat/services/django_service.dart';
import 'package:any_chat/viewmodels/chat_page_model.dart';
import 'package:any_chat/viewmodels/home_page_model.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setUpLocator() {
  locator.registerLazySingleton<DjangoService>(() => DjangoService());
  locator.registerLazySingleton<HomePageModel>(() => HomePageModel());
  locator.registerLazySingleton<ChatPageModel>(() => ChatPageModel());
}
