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
    as _i9;
import '../../features/kanban_board/data/repositories/task_repository_impl.dart'
    as _i11;
import '../../features/kanban_board/domain/repositories/task_repository.dart'
    as _i10;
import '../../features/kanban_board/domain/use_cases/add_task.dart' as _i13;
import '../../features/kanban_board/domain/use_cases/get_tasks.dart' as _i14;
import '../../features/kanban_board/domain/use_cases/update_task.dart' as _i12;
import '../../features/kanban_board/presentation/manager/add_task/add_task_cubit.dart'
    as _i17;
import '../../features/kanban_board/presentation/manager/get_task/get_task_cubit.dart'
    as _i16;
import '../../features/kanban_board/presentation/manager/task_manager/task_manager_cubit.dart'
    as _i3;
import '../../features/kanban_board/presentation/manager/task_timer/task_timer_cubit.dart'
    as _i8;
import '../../features/kanban_board/presentation/manager/update_task/update_task_cubit.dart'
    as _i15;
import '../cache_service/cache_manager.dart' as _i6;
import '../cache_service/cache_manager_impl.dart' as _i7;
import '../navigation/navigator_service.dart' as _i5;
import '../network/network_service.dart' as _i4;

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
    gh.factory<_i3.TaskManagerCubit>(() => _i3.TaskManagerCubit());
    gh.singleton<_i4.NetworkService>(() => _i4.NetworkService());
    gh.singleton<_i5.AppRouter>(() => _i5.AppRouter());
    gh.lazySingleton<_i6.CacheManager>(() => _i7.CacheManagerImpl());
    gh.factory<_i8.TaskTimerCubit>(
        () => _i8.TaskTimerCubit(gh<_i6.CacheManager>()));
    gh.lazySingleton<_i9.TaskRemoteDataSource>(
        () => _i9.TaskRemoteDataSourceImpl(gh<_i4.NetworkService>()));
    gh.lazySingleton<_i10.TaskRepository>(
        () => _i11.TaskRepositoryImpl(gh<_i9.TaskRemoteDataSource>()));
    gh.factory<_i12.UpdateTask>(
        () => _i12.UpdateTask(gh<_i10.TaskRepository>()));
    gh.factory<_i13.AddTask>(() => _i13.AddTask(gh<_i10.TaskRepository>()));
    gh.factory<_i14.GetTasks>(() => _i14.GetTasks(gh<_i10.TaskRepository>()));
    gh.factory<_i15.UpdateTaskCubit>(
        () => _i15.UpdateTaskCubit(usecase: gh<_i12.UpdateTask>()));
    gh.factory<_i16.GetTaskCubit>(
        () => _i16.GetTaskCubit(useCase: gh<_i14.GetTasks>()));
    gh.factory<_i17.AddTaskCubit>(
        () => _i17.AddTaskCubit(usecase: gh<_i13.AddTask>()));
    return this;
  }
}
