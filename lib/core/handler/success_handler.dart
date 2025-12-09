abstract class SuccessHandler<T> {
  final T data;

  SuccessHandler(this.data);
}

class SuccessHandlerImpl<T> extends SuccessHandler<T> {
  SuccessHandlerImpl(super.data);
}
