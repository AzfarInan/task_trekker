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
    as _i6;
import '../../features/kanban_board/data/repositories/task_repository_impl.dart'
    as _i8;
import '../../features/kanban_board/domain/repositories/task_repository.dart'
    as _i7;
import '../../features/kanban_board/domain/use_cases/add_task.dart' as _i9;
import '../../features/kanban_board/domain/use_cases/get_tasks.dart' as _i10;
import '../../features/kanban_board/domain/use_cases/update_task.dart' as _i11;
import '../../features/kanban_board/presentation/manager/add_task/add_task_cubit.dart'
    as _i14;
import '../../features/kanban_board/presentation/manager/get_task/get_task_cubit.dart'
    as _i13;
import '../../features/kanban_board/presentation/manager/task_manager/task_manager_cubit.dart'
    as _i3;
import '../../features/kanban_board/presentation/manager/update_task/update_task_cubit.dart'
    as _i12;
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
    gh.lazySingleton<_i6.TaskRemoteDataSource>(
        () => _i6.TaskRemoteDataSourceImpl(gh<_i4.NetworkService>()));
    gh.lazySingleton<_i7.TaskRepository>(
        () => _i8.TaskRepositoryImpl(gh<_i6.TaskRemoteDataSource>()));
    gh.factory<_i9.AddTask>(() => _i9.AddTask(gh<_i7.TaskRepository>()));
    gh.factory<_i10.GetTasks>(() => _i10.GetTasks(gh<_i7.TaskRepository>()));
    gh.factory<_i11.UpdateTask>(
        () => _i11.UpdateTask(gh<_i7.TaskRepository>()));
    gh.factory<_i12.UpdateTaskCubit>(
        () => _i12.UpdateTaskCubit(usecase: gh<_i11.UpdateTask>()));
    gh.factory<_i13.GetTaskCubit>(
        () => _i13.GetTaskCubit(useCase: gh<_i10.GetTasks>()));
    gh.factory<_i14.AddTaskCubit>(
        () => _i14.AddTaskCubit(usecase: gh<_i9.AddTask>()));
    return this;
  }
}
