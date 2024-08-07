import 'package:flutter/material.dart';
import 'package:github_repositories/arguments_model/repository_detail_arguments.dart';
import 'package:github_repositories/base/arguments/base_arguments.dart';
import 'package:github_repositories/base/coordinator/base_coordinator.dart';
import 'package:github_repositories/database/app_database.dart';
import 'package:github_repositories/database/local_service.dart';
import 'package:github_repositories/repository/repository.dart';
import 'package:github_repositories/screen/repositories/actions/repositories_action.dart';
import 'package:github_repositories/screen/repositories/bloc/repositories_bloc.dart';
import 'package:github_repositories/screen/repositories/repositories_screen.dart';
import 'package:github_repositories/screen/repositories/state/repositories_state.dart';
import 'package:github_repositories/screen/repositories/use_cases/fetch_repositories_use_case.dart';
import 'package:github_repositories/screen/repositories/view_model/repositories_view_model.dart';
import 'package:github_repositories/screen/repositories_detail/actions/repositories_detail_action.dart';
import 'package:github_repositories/screen/repositories_detail/coordinator/repository_detail_coordinator.dart';

import '../../../remote/api_service.dart';

final class RepositoriesCoordinator implements BaseCoordinator {
  final BuildContext context;
  final RepositoriesAction action;
  final BaseArguments? arguments;

  RepositoriesCoordinator(
      {required this.context, required this.action, required this.arguments});

  @override
  Widget start() {
    final ApiService apiService = ApiServiceImpl();
    final LocalService localService = LocalService();
    final repository = RepositoryServiceImpl(
        apiService: apiService, localService: localService);

    final fetchRepositoriesUseCase =
        FetchRepositoriesUseCase(repository: repository);

    final bloc =
        RepositoriesBloc(fetchRepositoriesUseCase: fetchRepositoriesUseCase);
    final viewModel = RepositoriesViewModel(
        bloc: bloc, useCase: fetchRepositoriesUseCase, inputData: arguments);

    viewModel.bloc.stream.listen((state) {
      if (state is DisplayRepositoryDetailState) {
        showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {

              RepositoryDetailsArguments arguments = RepositoryDetailsArguments(
                  index: state.index, repository: state.repository);

              return RepositoryDetailCoordinator(
                      context: context,
                      action: FetchCommitAction(
                          index: state.index, repository: state.repository),
                      arguments: arguments)
                  .start();
            });
      }
    });

    if (action is FetchRepositoriesAction) {
      viewModel.fetchRepositories(action);
    }

    return RepositoriesScreen(
        viewModel: viewModel,
        onRepositoryItemTap: (
            {required int index, required RepositoryData repository}) {
          viewModel.displayBottomSheet(index: index, repository: repository);
        });
  }
}
