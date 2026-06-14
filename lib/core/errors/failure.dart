import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class LocationFailure extends Failure {
  const LocationFailure(super.message);
}

class ApiFailure extends Failure {
  const ApiFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class UnknownFailure extends Failure {
  const UnknownFailure(super.message);
}

class WeatherException implements Exception {
  const WeatherException(this.failure);

  final Failure failure;

  @override
  String toString() => failure.message;
}
