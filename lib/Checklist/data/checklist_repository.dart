import 'package:emp_app/Checklist/models/review_checklist_model.dart';
import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:emp_app/services/Checklist/Checklist.dart';

class ChecklistRepository {
  late final ChecklistRequest checklistRequest;

  ChecklistRepository({required this.checklistRequest});

  Future<ReviewChecklistData> getListView() =>
      checklistRequest.getReviewChecklistList();
  Future<PicklistItemsModel> loadPickListData() =>
      checklistRequest.getPicklistList();
}
