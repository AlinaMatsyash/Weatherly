import 'package:equatable/equatable.dart';

class PrecipitationSummary extends Equatable {
  const PrecipitationSummary({
    required this.startMessage,
    required this.totalAmount,
    required this.intervals,
    required this.hourlyBars,
    this.startsAt,
  });

  final DateTime? startsAt;
  final String startMessage;
  final double totalAmount;
  final List<PrecipitationInterval> intervals;
  final List<PrecipitationBar> hourlyBars;

  @override
  List<Object?> get props => [
    startsAt,
    startMessage,
    totalAmount,
    intervals,
    hourlyBars,
  ];
}

class PrecipitationInterval extends Equatable {
  const PrecipitationInterval({
    required this.start,
    required this.end,
    required this.intensityLabel,
    required this.amount,
  });

  final DateTime start;
  final DateTime end;
  final String intensityLabel;
  final double amount;

  @override
  List<Object?> get props => [start, end, intensityLabel, amount];
}

class PrecipitationBar extends Equatable {
  const PrecipitationBar({
    required this.time,
    required this.amount,
    required this.probability,
  });

  final DateTime time;
  final double amount;
  final int probability;

  @override
  List<Object?> get props => [time, amount, probability];
}
