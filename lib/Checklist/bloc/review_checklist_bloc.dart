import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:emp_app/Checklist/data/checklist_repository.dart';
import 'package:emp_app/Checklist/models/review_checklist_model.dart';
import 'package:emp_app/Settings/Picklist/models/picklist_items_model.dart';
import 'package:equatable/equatable.dart';

part 'review_checklist_event.dart';
part 'review_checklist_state.dart';

class ReviewChecklistBloc
    extends Bloc<ReviewChecklistEvent, ReviewChecklistState> {
  ReviewChecklistBloc({required this.checklistRepository})
      : super(ReviewChecklistInitial());

  final ChecklistRepository checklistRepository;

  @override
  Stream<ReviewChecklistState> mapEventToState(
    ReviewChecklistEvent event,
  ) async* {
    if (event is ReviewChecklistListView) {
      yield* _mapTaskListToState(event);
    }
    if (event is LoadAddReviewModal) {
      final PicklistItemsModel responsePicklist =
          await checklistRepository.loadPickListData();
      yield LoadAddReviewModalSuccess(picklistData: responsePicklist.data);
    }
    if (event is AddReviewChecklist) {
      yield ReviewChecklistSuccess();
    }
  }

  Stream<ReviewChecklistState> _mapTaskListToState(
      ReviewChecklistListView event) async* {
    yield ReviewChecklistLoading();
    try {
      final ReviewChecklistData response =
          await this.checklistRepository.getListView();
      if (response != null) {
        yield ReviewChecklistLoaded(reviewChecklistList: response);
      } else {
        yield ReviewChecklistFailure(error: 'Something Went Wrong');
      }
    } catch (e) {
      yield ReviewChecklistFailure(error: e.toString());
    }
  }
}
