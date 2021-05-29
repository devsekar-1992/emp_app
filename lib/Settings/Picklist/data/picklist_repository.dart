import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:emp_app/Tasks/models/task_detail_model.dart';
import 'package:emp_app/services/Picklist/PicklistApi.dart';

class PicklistRepository {
  late final PicklistApiRequest picklistApiRequest;
  PicklistRepository({required this.picklistApiRequest});

  Future<PicklistItemsModel> getDropdownItems() =>
      picklistApiRequest.getPicklistItems();
}
