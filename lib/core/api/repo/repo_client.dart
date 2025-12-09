
abstract class RepoClient extends RepoMethod {}

abstract class RepoMethod {
  Future<T> get<T>({required String endpoint});
  Future<T> post<T, K>({required String endpoint, required K body});
}
