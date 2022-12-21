import 'package:bloc/bloc.dart';
import 'package:cleanarch/core/error/failures.dart';
import 'package:cleanarch/core/usecases/usecase.dart';
import 'package:cleanarch/core/utils/app_strings.dart';
import 'package:cleanarch/features/random_quote/domain/usecases/get_random_quote.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/quote.dart';

part 'random_quote_state.dart';

class RandomQuoteCubit extends Cubit<RandomQuoteState> {
  final GetRandomQuote getRandomQuoteUseCase;
  RandomQuoteCubit({required this.getRandomQuoteUseCase})
      : super(RandomQuoteInitial());

  Future<void> getRandomQuote() async {
    Either<Failure, Quote> response = await getRandomQuoteUseCase(NoParams());
    emit(
      response.fold(
        (failure) => RandomQuoteError(msg: _mapFailureToMsg(failure)),
        (quote) => RandomQuoteLoaded(quote: quote),
      ),
    );
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;

      default:
        return AppStrings.unexpectedError;
    }
  }
}
