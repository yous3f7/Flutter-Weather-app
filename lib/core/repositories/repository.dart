import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:weather/core/daos/base_dao.dart';
import 'package:weather/core/errors/connection_error.dart';
import 'package:weather/core/models/BaseModel.dart';

import '../entities/base_entity.dart';
import '../errors/base_error.dart';
import '../results/result.dart';

abstract class Repository {
  Result<BaseError, Entity>
      execute<Model extends BaseModel<Entity>, Entity extends BaseEntity>({
    @required Either<BaseError, Model> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<BaseError, Model>).value.toEntity(),
      );
    } else {
      return Result(error: (remoteResult as Left<BaseError, Model>).value);
    }
  }

  Result<BaseError, T> executeForNoEntity<T>({
    @required Either<BaseError, T> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(data: (remoteResult as Right<BaseError, T>).value,);
    } else {
      return Result(error: (remoteResult as Left<BaseError, T>).value);
    }
  }

  Result<BaseError, List<Entity>> executeForList<
  Model extends BaseModel<Entity>, Entity extends BaseEntity>(
      {@required Either<BaseError, Entity> remoteResult}) {
    if (remoteResult.isRight()) {
      return Result(
        data: (remoteResult as Right<BaseError, List<Model>>)
            .value
            .map((model) => model.toEntity())
            .toList(),
      );
    } else {
      return Result(
        error: (remoteResult as Left<BaseError, List<Model>>).value,
      );
    }
  }

  Result<BaseError, Object> executeForNoData({
    @required Either<BaseError, Object> remoteResult,
  }) {
    if (remoteResult.isRight()) {
      return Result(data: (remoteResult as Right<BaseError, Object>).value);
    }
    else {
      return Result(error: (remoteResult as Left<BaseError, Object>).value);
    }
  }

  Future<Result<BaseError, Entity>> executeWithCacheRemoteFirst<
  Model extends BaseModel<Entity>,
  Entity extends BaseEntity,
  Dao extends BaseDao<Model>>({
    @required Either<BaseError, Model> remoteResult,
    @required Dao dao,
    Duration duration
  }) async {
    if (remoteResult.isRight()) {
      final models = (remoteResult as Right<BaseError, Model>).value;
      await dao.clear();
      await dao.add(models);
      Future<void>.delayed(duration??const Duration(days: 7),()=> dao.clear());
      final entities = models.toEntity();
      return Result(data: entities);
    } else {
      final error = (remoteResult as Left<BaseError, Model>).value;
      if (!(error is ConnectionError)) {
        await dao.clear();
        return Result(error: error);
      }
        final models = await dao.get(0);
        final entities = models.toEntity();//
        return Result(data: entities, error: error);
    }
  }


  Future<Result<BaseError, List<Entity>>> executeForListWithCacheRemoteFirst<
  Model extends BaseModel<Entity>,
  Entity extends BaseEntity,
  Dao extends BaseDao<Model>>({
    @required Either<BaseError, List<Model>> remoteResult,
    @required Dao dao,
  }) async {
    if (remoteResult.isRight()) {
      final models = (remoteResult as Right<BaseError, List<Model>>).value;
      await dao.clear();
      await dao.addAll(models);
      final entities = models.map((m) => m.toEntity()).toList();
      return Result(data: entities);
    } else {
      final error = (remoteResult as Left<BaseError, List<Model>>).value;
      if (!(error is ConnectionError)) {
        await dao.clear();
        return Result(error: error);
      }
      final models = await dao.getAll();
      if (models.isNotEmpty) {
        final entities = models.map((m) => m.toEntity()).toList();
        return Result(data: entities, error: error);
      }
      return Result(error: error);
    }
  }

  Future<Result<BaseError, List<Entity>>>
  executeForListWithCacheRemoteFirstSupportPagination<
  Model extends BaseModel<Entity>,
  Entity extends BaseEntity,
  Dao extends BaseDao<Model>>({
    @required Either<BaseError, List<Model>> remoteResult,
    @required Dao dao,
    @required int page,
  }) async {
    if (remoteResult.isRight()) {
      final models = (remoteResult as Right<BaseError, List<Model>>).value;
      if (page == 0) {
        await dao.clear();
      }
      await dao.addAll(models);
      final entities = models.map((m) => m.toEntity()).toList();
      return Result(data: entities);
    } else {
      final error = (remoteResult as Left<BaseError, List<Model>>).value;
      if (!(error is ConnectionError)) {
        await dao.clear();
        return Result(error: error);
      }
      final models = await dao.getAll();
      if (models.isNotEmpty) {
        final entities = models.map((m) => m.toEntity()).toList();
        return Result(data: entities, error: error);
      }
      return Result(error: error);
    }
  }

  Future<Result<BaseError, List<Entity>>> executeForListWithCacheLocalFirst<
  Model extends BaseModel<Entity>,
  Entity extends BaseEntity,
  Dao extends BaseDao>({
    @required
    Future<Either<BaseError, List<Model>>> Function() remoteResultExecutor,
    @required Dao dao,
  }) async {
    final models = await dao.getAll();
    if (models.isNotEmpty) {
      final entities = models.map((m) => m.toEntity()).toList();
      return Result(data: entities);
    }
    final remoteResult = await remoteResultExecutor();
    if (remoteResult.isRight()) {
      final models = (remoteResult as Right<BaseError, List<Model>>).value;
      final entities = models.map((m) => m.toEntity()).toList();
      return Result(data: entities);
    }
    final error = (remoteResult as Left<BaseError, List<Model>>).value;
    return Result(error: error);
  }

}
