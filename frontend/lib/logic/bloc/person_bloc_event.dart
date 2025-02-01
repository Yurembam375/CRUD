abstract class PersonEvent {}

class FetchPersons extends PersonEvent {}

class AddPerson extends PersonEvent {
  final Map<String, dynamic> data;
  AddPerson(this.data);
}

class UpdatePerson extends PersonEvent {
  final int id;
  final Map<String, dynamic> data;
  UpdatePerson(this.id, this.data);
}

class DeletePerson extends PersonEvent {
  final int id;
  DeletePerson(this.id);
}
