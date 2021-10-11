

class ClearBlocState {
  ClearBlocState();
  factory ClearBlocState.loading() = ClearBlocLoading;
  factory ClearBlocState.loaded() = ClearBlocLoaded;
  factory ClearBlocState.error() = ClearBlocError;
  factory ClearBlocState.response(String responseText) = ClearBlocResponse;
}

class ClearBlocLoading extends ClearBlocState{}

class ClearBlocLoaded extends ClearBlocState{}

class ClearBlocError extends ClearBlocState{}

class ClearBlocResponse extends ClearBlocState{
  final String responseText;
  ClearBlocResponse(this.responseText);
}