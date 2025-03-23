import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:l3_flutter_selise_blocksconstruct/core/errors/failures.dart';

typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef JSON = Map<String, dynamic>;
typedef QueryParams = Map<String, String>;
typedef RouteBuilder = Widget Function(BuildContext);
typedef ItemBuilder<T> = Widget Function(BuildContext, T);
