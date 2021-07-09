part of 'review_checklist_bloc.dart';

abstract class ReviewChecklistState extends Equatable {
  const ReviewChecklistState();

  @override
  List<Object> get props => [];
}

class ReviewChecklistInitial extends ReviewChecklistState {}

class ReviewChecklistLoading extends ReviewChecklistState {}

class ReviewChecklistLoaded extends ReviewChecklistState {
  late final ReviewChecklistData reviewChecklistList;

  ReviewChecklistLoaded({required this.reviewChecklistList});
}

class ReviewChecklistFailure extends ReviewChecklistState {
  late final error;
  ReviewChecklistFailure({required this.error});
}

class LoadAddReviewModalSuccess extends ReviewChecklistState {
  final PicklistData picklistData;
  LoadAddReviewModalSuccess({required this.picklistData});
}

class ReviewChecklistSuccess extends ReviewChecklistState {}
