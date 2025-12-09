import 'package:firebase_auth/firebase_auth.dart';
import 'package:recipe/core/api/repo/repo_client.dart';

class FirebaseClient extends RepoClient {
  final FirebaseAuth firebaseAuth;
  FirebaseClient({required this.firebaseAuth});
  @override
  Future<T> get<T>({required String endpoint}) {
    throw UnimplementedError();
  }

  @override
  Future<T> post<T, K>({required String endpoint, required K body}) {
    throw UnimplementedError();
  }
}
