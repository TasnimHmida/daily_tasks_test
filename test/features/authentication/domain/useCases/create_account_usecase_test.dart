import 'package:daily_tasks_test/features/authentication/domain/use_cases/register_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late RegisterUseCase createAccountUseCase;
  const registerParams = {
    'email': 'hiba@gmail.com',
    'password': 'Test123*',
    'username': 'hiba'
  };

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    createAccountUseCase = RegisterUseCase(repository: mockAuthRepository);
  });

  test("should get createAccount from the repository", () async {
    /// arrange
    when(mockAuthRepository.register(
      userName: registerParams['username'],
      password: registerParams['password'],
      email: registerParams['email'],
    )).thenAnswer((dataJson) async => const Right(unit));

    /// act
    final result = await createAccountUseCase.call(
      userName: registerParams['username'] ?? '',
      password: registerParams['password'] ?? '',
      email: registerParams['email'] ?? '',
    );

    /// assert
    expect(result, equals(const Right(unit)));
  });
}
