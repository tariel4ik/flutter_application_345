import 'dart:async';

import 'package:flutter_application_345/features/sensors/domain/entities/notification_entity.dart';
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_entity.dart';
import 'package:flutter_application_345/features/sensors/domain/entities/sensor_value_entity.dart';
import 'package:flutter_application_345/features/sensors/domain/repositories/sensor_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/exception_mapper.dart';
import '../api/sensor_api.dart';
import '../models/notification_model.dart';

class SensorRepositoryImpl implements SensorRepository {
  final SensorApi api;

  SensorRepositoryImpl(this.api);

  @override
  Future<List<SensorEntity>> getSensors() async {
    final sensorModels = await api.getSensors();
    return sensorModels
        .map(
          (model) => model.toEntity()
        )
        .toList();
  }

  @override
  Future<List<SensorValueEntity>> getSensorValues(int sensorId) async {
    final valueModels = await api.getSensorValues(sensorId);
    return valueModels
        .map(
          (model) => model.toEntity()
        )
        .toList();
  }

  @override
  Future<Either<Failure, List<NotificationEntity>>> getNotifications({
    DateTime? since,
  }) async {
    try {
      final result = await api.fetchNotifications(since: since);
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


}
