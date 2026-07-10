sealed class FailerHandler {
  final String message;
  FailerHandler(this.message);
}

class ServerFailure extends FailerHandler {
  ServerFailure(super.message);
}

class CacheFailure extends FailerHandler {
  CacheFailure(super.message);
}

class NetworkFailure extends FailerHandler {
  NetworkFailure(super.message);
}

class FireBaseFailure extends FailerHandler {
  FireBaseFailure(super.message);
}

class TypeErrorFailer extends FailerHandler {
  TypeErrorFailer(super.message);
}

class NotValideCodeFailer extends FailerHandler {
  NotValideCodeFailer(super.message);
}

class LocalDataBaseFailure extends FailerHandler {
  LocalDataBaseFailure(super.message);
}

class UnexpectedFailure extends FailerHandler {
  UnexpectedFailure(super.message);
}

class UnKnownFailure extends FailerHandler{
  UnKnownFailure(super.message);
}