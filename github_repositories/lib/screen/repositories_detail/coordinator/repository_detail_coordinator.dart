import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:github_repositories/base/arguments/base_arguments.dart';
import 'package:github_repositories/base/coordinator/base_coordinator.dart';
import 'package:github_repositories/database/local_service.dart';
import 'package:github_repositories/res/string_constant.dart';
import 'package:github_repositories/screen/repositories_detail/bloc/repositories_detail_bloc.dart';
import 'package:github_repositories/screen/repositories_detail/state/repository_detail_state.dart';
import 'package:github_repositories/screen/repositories_detail/use_cases/repository_detail_use_case.dart';
import 'package:github_repositories/screen/repositories_detail/view_model/repository_detail_view_model.dart';

import '../../../remote/api_service.dart';
import '../../../repository/repository.dart';
import '../../../res/dimen_constant.dart';
import '../actions/repositories_detail_action.dart';
import '../repositories_details_sheet.dart';

final class RepositoryDetailCoordinator extends BaseCoordinator {
  final BuildContext context;
  final RepositoryDetailAction action;
  final BaseArguments arguments;

  late MethodChannel methodChannel;

  RepositoryDetailCoordinator(
      {required this.context, required this.action, required this.arguments});

  @override
  Widget start() {
    methodChannel = const MethodChannel(StringConstant.appMethodChanel);
    final ApiService apiService = ApiServiceImpl();
    final LocalService localService = LocalService();
    final repositoryService = RepositoryServiceImpl(
        apiService: apiService, localService: localService);

    final fetchCommitUseCase =
        FetchCommitUseCase(repositoryService: repositoryService);

    final bloc = RepositoryDetailBloc(fetchCommitUseCase: fetchCommitUseCase);

    final viewModel = RepositoryDetailViewModel(
        bloc: bloc, useCase: fetchCommitUseCase, arguments: arguments);

    viewModel.bloc.stream.listen((state) {
      if (state is CloseItemTapState) {
        final preparedJson = viewModel.prepareDataForTransfer();
        _transferDataAndExit(preparedJson);
      }
    });

    if (action is FetchCommitAction) {
      viewModel.fetchCommits();
    }

    return RepositoriesDetailSheet(viewModel: viewModel);
  }

  Future<void> _transferDataAndExit(String repositoryJson) async {
    try {
      await methodChannel.invokeMethod(
          StringConstant.transferDataMethodName, repositoryJson);
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(Dimen.magicZero);
      }
    } on PlatformException catch (e) {
      e.stacktrace;
    }
  }
}
