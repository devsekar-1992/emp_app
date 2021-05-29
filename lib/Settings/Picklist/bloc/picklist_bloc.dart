import 'package:emp_app/Settings/Picklist/bloc/picklist_event.dart';
import 'package:emp_app/Settings/Picklist/bloc/picklist_state.dart';
import 'package:emp_app/Settings/Picklist/data/picklist_repository.dart';
import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PicklistBloc extends Bloc<PicklistEvent, PicklistState> {
  final PicklistRepository picklistRepository;

  PicklistBloc({required this.picklistRepository}) : super(PicklistInitial());

  @override
  Stream<PicklistState> mapEventToState(PicklistEvent event) async* {
    yield PicklistInitial();
    try {
      print(event);
      if (event is PickListItems) {
        yield* _mapTaskListToState(event);
      }
    } catch (e) {}
  }

  Stream<PicklistState> _mapTaskListToState(PicklistEvent event) async* {
    yield PicklistLoading();
    try {
      final PicklistItemsModel response =
          await this.picklistRepository.getDropdownItems();
      // ignore: unnecessary_null_comparison
      if (response != null) {
        yield PicklistSuccess(picklistModels: response);
      } else {
        yield PicklistFailure(error: 'Something Went Wrong');
      }
    } catch (e) {
      yield PicklistFailure(error: e.toString());
    }
  }
}
