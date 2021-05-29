import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:equatable/equatable.dart';

abstract class PicklistState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PicklistInitial extends PicklistState {}

class PicklistLoading extends PicklistState {}

class PicklistSuccess extends PicklistState {
  late final PicklistItemsModel picklistModels;
  PicklistSuccess({required this.picklistModels});

  @override
  List<Object> get props => [picklistModels];
}

class PicklistFailure extends PicklistState {
  final String error;
  PicklistFailure({required this.error});
}
