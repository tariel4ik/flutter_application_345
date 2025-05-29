import 'dart:async';

import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/exception_mapper.dart';
import '../../domain/entities/notification_entity.dart';
import '../../domain/entities/sensor_entity.dart';
import '../../domain/entities/sensor_value_entity.dart';
import '../../domain/repositories/sensor_repository.dart';
import '../api/sensor_api.dart';
import '../models/notification_model.dart';
import '../models/sensor_model.dart';


class SensorRepositoryImpl implements SensorRepository {
  final SensorApi api;

  SensorRepositoryImpl(this.api);

  @override
  Future<Either<Failure, List<SensorEntity>>> getSensors() async {
    try {
      final result = await api.getSensors();
      return right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(ExceptionMapper.from(e));
    } 
  }

  @override
  Future<Either<Failure, List<SensorValueEntity>>> getSensorValues({
    required int sensorId
  }) async {
    try {
      final result = await api.getSensorValues(sensorId);
      return right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(ExceptionMapper.from(e));
    }
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    DateTime? since,
  }) async {
    try {
      final result = await api.getNotifications(since: since);
      return right(result.map((e) => e.toEntity()).toList());
    } catch (e) {
      return left(ExceptionMapper.from(e));
    }
  }

  @override
  Stream<Either<Failure, List<NotificationEntity>>> watchNotifications() {
    return api.watchNotifications().transform(
      StreamTransformer<
        List<NotificationModel>,
        Either<Failure, List<NotificationEntity>>
      >.fromHandlers(
        handleData: (items, sink) {
          sink.add(right(items.map((e) => e.toEntity()).toList()));
        },
        handleError: (error, stack, sink) {
          final failure = ExceptionMapper.from(error);
          sink.add(left(failure));
        },
      ),
    );
  }
  
  @override
  Stream<Either<Failure, List<SensorEntity>>> watchSensors() {
    return api.watchSensors().transform(
      StreamTransformer<
        List<SensorModel>,
        Either<Failure, List<SensorEntity>>
      >.fromHandlers(
        handleData: (items, sink) {
          sink.add(right(items.map((e) => e.toEntity()).toList()));
        },
        handleError: (error, stack, sink) {
          final failure = ExceptionMapper.from(error);
          sink.add(left(failure));
        },
      ),
    );
  }
}
