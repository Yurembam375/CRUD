import 'package:frontend/data/repositories/user_repository.dart';
import 'package:frontend/logic/bloc/person_bloc_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Register Repository
  locator.registerLazySingleton<PersonRepository>(() => PersonRepository());

  // Register Bloc
  locator.registerFactory(() => PersonBloc(locator<PersonRepository>()));
}
