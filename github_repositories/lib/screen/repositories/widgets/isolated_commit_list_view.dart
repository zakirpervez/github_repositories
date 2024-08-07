import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repositories/base/view_model/isolated_coomit_view_model.dart';
import 'package:github_repositories/database/local_service.dart';
import 'package:github_repositories/remote/api_service.dart';
import 'package:github_repositories/repository/repository.dart';
import 'package:github_repositories/screen/app_widgets/loader.dart';
import 'package:github_repositories/screen/repositories/bloc/isolated_commit_bloc.dart';
import 'package:github_repositories/screen/repositories/state/repositories_state.dart';
import 'package:github_repositories/screen/repositories/use_cases/fetch_isolated_commit_use_case.dart';

import '../../../database/app_database.dart';
import '../../../res/dimen_constant.dart';
import '../../../res/string_constant.dart';
import '../../../wrappers/data_wrapper.dart';
import '../../../wrappers/isolate_service_wrapper.dart';

class IsolatedCommitListView extends StatelessWidget {
  final int index;
  final RepositoryData repository;
  final bool displayCommitFlag;

  const IsolatedCommitListView(
      {super.key,
      required this.index,
      required this.repository,
      required this.displayCommitFlag});

  @override
  Widget build(BuildContext context) {
    return displayCommitFlag
        ? _buildCommitListView(index: index, repository: repository)
        : const SizedBox.shrink();
  }

  Widget _buildCommitListView(
      {required int index, required RepositoryData repository}) {
    IsolatedCommitViewModel viewModel = _buildIsoCommitViewModel();
    viewModel.index = index;
    viewModel.repository = repository;
    viewModel.fetchCommitInIsolates();
    return BlocProvider(
      create: (context) => viewModel.bloc,
      child: BlocBuilder<IsolatedCommitBloc, BaseFetchIsolatedCommitState>(
        builder: (context, state) {
          if (state is FetchIsolatedCommitState) {
            if (state.commitDataWrapper.status == Status.loading) {
              return const Loader();
            } else if (state.commitDataWrapper.status == Status.success) {
              List<CommitData> commitList = state.commitDataWrapper.data ?? [];
              var displayableCommits =
                  commitList.take(Dimen.magicThree).toList();
              return displayableCommits.isEmpty?
              const SizedBox.shrink() :
              IntrinsicHeight(
                child: SizedBox(
                  width: double.infinity,
                  height: Dimen.magic200.toDouble(),
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: displayableCommits.length,
                    itemBuilder: (context, index) {
                      String titleText =
                          displayableCommits[index].message ?? StringConstant.empty;
                      return ListTile(
                        title: Text(titleText, maxLines: Dimen.magicOne, overflow: TextOverflow.ellipsis,),
                      );
                    },
                  ),
                ),
              );
            }
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  IsolatedCommitViewModel _buildIsoCommitViewModel() {
    IsolateServiceWrapper isolateServiceWrapper =
        IsolateServiceWrapper.buildIsolateService(
            serviceType: IsolateServiceType.commit);
    ApiService apiService = ApiServiceImpl();
    LocalService localService = LocalService();
    RepositoryService repositoryService = RepositoryServiceImpl(
        apiService: apiService,
        localService: localService,
        isolateServiceWrapper: isolateServiceWrapper);
    FetchIsolatedCommitUseCase useCase =
        FetchIsolatedCommitUseCase(repositoryService: repositoryService);
    IsolatedCommitBloc bloc =
        IsolatedCommitBloc(fetchIsolatedCommitUseCase: useCase);
    return IsolatedCommitViewModel(
        bloc: bloc, useCase: useCase, arguments: null);
  }
}
