abstract class TermsAndConditonsState {}
class TermsAndConditonsInitial extends TermsAndConditonsState{}
class TermsAndConditonsLoading extends TermsAndConditonsState{}
class TermsAndConditonsLoaded extends TermsAndConditonsState{
  final String ? terms;
  TermsAndConditonsLoaded(this.terms);

}
class TermsAndConditonsError extends TermsAndConditonsState{}