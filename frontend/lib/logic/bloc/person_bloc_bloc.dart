import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/data/repositories/user_repository.dart';
import 'package:frontend/logic/bloc/person_bloc_event.dart';
import 'package:frontend/logic/bloc/person_bloc_state.dart';


class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository repository;

  PersonBloc(this.repository) : super(PersonInitial()) {
    on<FetchPersons>((event, emit) async {
      emit(PersonLoading());
      try {
        final persons = await repository.fetchPersons();
        emit(PersonLoaded(persons));
      } catch (e) {
        emit(PersonError("Failed to fetch persons"));
      }
    });

    on<AddPerson>((event, emit) async {
      await repository.addPerson(event.data);
      add(FetchPersons());
    });

    on<UpdatePerson>((event, emit) async {
      await repository.updatePerson(event.id, event.data);
      add(FetchPersons());
    });

    on<DeletePerson>((event, emit) async {
      await repository.deletePerson(event.id);
      add(FetchPersons());
    });
  }
}
