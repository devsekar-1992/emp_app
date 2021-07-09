part of 'review_checklist_bloc.dart';

abstract class ReviewChecklistEvent extends Equatable {
  const ReviewChecklistEvent();

  @override
  List<Object> get props => [];
}

class ReviewChecklistListView extends ReviewChecklistEvent {
  ReviewChecklistListView();
}

class LoadAddReviewModal extends ReviewChecklistEvent {}

class AddReviewChecklist extends ReviewChecklistEvent {}
