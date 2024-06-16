// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../../features/kanban_board/data/data_sources/task_data_resource.dart'
    as _i5;
import '../../features/kanban_board/data/repositories/task_repository_impl.dart'
    as _i7;
import '../../features/kanban_board/domain/repositories/task_repository.dart'
    as _i6;
import '../../features/kanban_board/domain/use_cases/get_tasks.dart' as _i8;
import '../../features/kanban_board/presentation/manager/get_task/get_task_cubit.dart'
    as _i9;
import '../navigation/navigator_service.dart' as _i4;
import '../network/network_service.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.NetworkService>(() => _i3.NetworkService());
    gh.singleton<_i4.AppRouter>(() => _i4.AppRouter());
    gh.lazySingleton<_i5.TaskRemoteDataSource>(
        () => _i5.TaskRemoteDataSourceImpl(gh<_i3.NetworkService>()));
    gh.lazySingleton<_i6.TaskRepository>(
        () => _i7.TaskRepositoryImpl(gh<_i5.TaskRemoteDataSource>()));
    gh.factory<_i8.GetTasks>(() => _i8.GetTasks(gh<_i6.TaskRepository>()));
    gh.factory<_i9.GetTaskCubit>(
        () => _i9.GetTaskCubit(useCase: gh<_i8.GetTasks>()));
    return this;
  }
}
