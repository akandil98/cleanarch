import 'dart:convert';
import 'package:cleanarch/core/api/end_points.dart';
import 'package:cleanarch/core/error/exceptions.dart';
import 'package:cleanarch/core/utils/app_strings.dart';
import 'package:cleanarch/features/random_quote/data/models/quote_model.dart';
import 'package:http/http.dart' as http;

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  http.Client client;

  RandomQuoteRemoteDataSourceImpl({required this.client});
  @override
  Future<QuoteModel> getRandomQuote() async {
    final randomQuoteUrl = Uri.parse(EndPoints.randomQuote);
    final response = await client.get(
      randomQuoteUrl,
      headers: {
        AppStrings.contentType: AppStrings.applicationJson,
      },
    );
    if (response.statusCode == 200) {
      return QuoteModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }
}
