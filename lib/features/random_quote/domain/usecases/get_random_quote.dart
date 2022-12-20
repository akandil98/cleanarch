import 'package:cleanarch/core/usecases/usecase.dart';
import 'package:cleanarch/features/random_quote/domain/entities/quote.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../repositories/quote_repository.dart';

class GetRandomQuote implements UseCase<Quote, NoParams> {
  final QuoteRepository quoteRepository;

  GetRandomQuote({required this.quoteRepository});
  @override
  Future<Either<Failure, Quote>> call(NoParams params) =>
      quoteRepository.getRandomQuote();
}

// incase we have params we pass it instead of noparams

// class GetLogin implements UseCase<Quote, LoginParams> {
//   final LoginRepository loginRepository;
//   @override
//   Future<Either<Failure, Quote>> call(LoginParams params) {
//     return loginRepository.get(params.email);
//   }
// }

// class LoginParams extends Equatable {
//   final String email;
//   final String password;

//   const LoginParams({
//     required this.email,
//     required this.password,
//   });
//   @override
//   List<Object?> get props => [email, password];
// }
