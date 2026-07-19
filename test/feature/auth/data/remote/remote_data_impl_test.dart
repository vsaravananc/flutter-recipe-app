import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:recipe/core/services/beral_container.dart';
import 'package:recipe/feature/auth/data/data_sources/remote_data_source/remote_data_impl.dart';
import 'package:recipe/feature/auth/data/model/login_with_email_model.dart';

class MockFireBaseAuth extends Mock implements FirebaseAuth {}

class MockFireBaseFireStore extends Mock implements FirebaseFirestore {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

void main() {
  late MockFireBaseAuth mockFireBaseAuth;
  late MockFireBaseFireStore mockFireBaseFireStore;
  late MockGoogleSignIn mockGoogleSignIn;
  late LoginWithEmailModel login;
  late RemoteDataImpl testRemoteDataImp;

  setUp(() {
    mockFireBaseAuth = MockFireBaseAuth();
    mockFireBaseFireStore = MockFireBaseFireStore();
    mockGoogleSignIn = MockGoogleSignIn();
    testRemoteDataImp = RemoteDataImpl(
      firebaseAuth: mockFireBaseAuth,
      googleSignIn: mockGoogleSignIn,
      firebaseFirestore: mockFireBaseFireStore,
    );
    login = LoginWithEmailModel(email: 'dummy@gmail.com', password: "dummy");
  });

  Future<void> exceptFirebaseAuthFailure({
    required String key,
    required String matcher,
  }) async {
    when(
      () => mockFireBaseAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(FirebaseAuthException(code: key));
    final result = await testRemoteDataImp.loginWithEmail(login);

    verify(
      () => mockFireBaseAuth.signInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).called(1);
    expect(result.isLeft(), isTrue);
    expect(result.fold((f) => f.message, (_) => null), matcher);
  }

  group('Given a RemoteDataImpl', () {
    group('when called loginWithEmail', () {
      group('failure', () {
        group('FirebaseAuthException', () {
          test('when invalid email', () async {
            await exceptFirebaseAuthFailure(
              key: 'invalid-email',
              matcher:
                  'The email address you entered is not valid. Please check and try again.',
            );
          });
          test('when user disabled', () async {
            await exceptFirebaseAuthFailure(
              key: 'user-disabled',
              matcher:
                  'This account has been disabled. Please contact support.',
            );
          });
          test('when user not found', () async {
            await exceptFirebaseAuthFailure(
              key: 'user-not-found',
              matcher:
                  'No account found with this email. Please sign up first.',
            );
          });
          test('when wrong password', () async {
            await exceptFirebaseAuthFailure(
              key: 'wrong-password',
              matcher: 'Incorrect password. Please try again.',
            );
          });
          test('when user email already in use', () async {
            await exceptFirebaseAuthFailure(
              key: 'email-already-in-use',
              matcher:
                  'This email is already registered. Please use another email.',
            );
          });
          test('when Operation not allowed', () async {
            await exceptFirebaseAuthFailure(
              key: 'operation-not-allowed',
              matcher:
                  'Email/Password sign-in is not enabled. Please contact support.',
            );
          });
          test('when too many requests', () async {
            await exceptFirebaseAuthFailure(
              key: 'too-many-requests',
              matcher: 'Too many login attempts. Please try again later.',
            );
          });
          test('when network request failed', () async {
            await exceptFirebaseAuthFailure(
              key: 'network-request-failed',
              matcher:
                  'Network error. Check your internet connection and try again.',
            );
          });
          test('when weak password', () async {
            await exceptFirebaseAuthFailure(
              key: 'weak-password',
              matcher:
                  'The password is too weak. Please use a stronger password.',
            );
          });
          test('when requires recent login', () async {
            await exceptFirebaseAuthFailure(
              key: 'requires-recent-login',
              matcher: 'For security reasons, please log in again to continue.',
            );
          });
          test('when account exists with different credential', () async {
            await exceptFirebaseAuthFailure(
              key: 'account-exists-with-different-credential',
              matcher:
                  'An account already exists with a different sign-in method.',
            );
          });
          test('when invalid credential', () async {
            await exceptFirebaseAuthFailure(
              key: 'invalid-credential',
              matcher:
                  'The login credential has expired or is invalid. Please try again.',
            );
          });
          test('when something went wrong with firebase', () async {
            await exceptFirebaseAuthFailure(
              key: '',
              matcher: 'Something went wrong. Please try again later.',
            );
          });
        });

        group('catch', () async {
          when(
            () => mockFireBaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).thenThrow(Exception());
          final result = await testRemoteDataImp.loginWithEmail(login);

          verify(
            () => mockFireBaseAuth.signInWithEmailAndPassword(
              email: any(named: 'email'),
              password: any(named: 'password'),
            ),
          ).called(1);
          expect(result.isLeft(), isTrue);
          expect(
            result.fold((f) => f.message, (_) => null),
            'We’re unable to reach the server right now. Please check your connection or try again later.',
          );
        });
      });
      group('succes', () {});
    });

    group('when called loginWithGoogle', () {
      group('failure', () {});
      group('succes', () {});
    });

    group('when called logout', () {
      group('failure', () {});
      group('succes', () {});
    });

    group('when called registerWithEmail', () {
      group('failure', () {});
      group('succes', () {});
    });

    group('when called addUser', () {
      group('failure', () {});
      group('succes', () {});
    });

    group('when called getCurrentUser', () {
      group('failure', () {});
      group('succes', () {});
    });
  });
}
