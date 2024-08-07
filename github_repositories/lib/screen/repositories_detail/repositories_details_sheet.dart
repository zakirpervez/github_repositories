import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repositories/res/dimen_constant.dart';
import 'package:github_repositories/res/string_constant.dart';
import 'package:github_repositories/screen/app_widgets/custom_error.dart';
import 'package:github_repositories/screen/app_widgets/loader.dart';
import 'package:github_repositories/screen/repositories_detail/state/repository_detail_state.dart';
import 'package:github_repositories/screen/repositories_detail/view_model/repository_detail_view_model.dart';
import 'package:github_repositories/screen/repositories_detail/widgets/closeable_header.dart';
import 'package:github_repositories/screen/repositories_detail/widgets/commit_list_view.dart';
import 'package:github_repositories/wrappers/data_wrapper.dart';

import '../../res/color_constant.dart';
import '../app_widgets/horizontal_line.dart';
import '../app_widgets/semi_bold_title_text.dart';
import '../app_widgets/shadowed_banner_image.dart';
import 'bloc/repositories_detail_bloc.dart';

class RepositoriesDetailSheet extends StatelessWidget {
  final RepositoryDetailViewModel viewModel;

  const RepositoriesDetailSheet({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Dimen.dimen_16),
      child: Column(
        children: [
          _buildClosableHeader(viewModel: viewModel),
          const HorizontalLine(
            lineColor: ColorConstant.greyColor,
            lineIndent: Dimen.dimen_20,
            lineEndIndent: Dimen.dimen_20,
          ),
          const SizedBox(height: Dimen.dimen_16),
          ShadowedBannerImage(
              imageUrl: viewModel.repository.avatarUrl ?? StringConstant.empty),
          const SizedBox(height: Dimen.dimen_16),
          Padding(
            padding: const EdgeInsets.only(
                left: Dimen.dimen_16, right: Dimen.dimen_16),
            child: SemiBoldTitleText(
              titleText: viewModel.repository.description ?? StringConstant.empty,
              color: ColorConstant.shadyBlackColor,
              overflow: TextOverflow.ellipsis,
              fontSize: Dimen.dimen_20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(child: _buildCommitListView(viewModel: viewModel)),
          const SizedBox(height: Dimen.dimen_16),
        ],
      ),
    );
  }

  Widget _buildClosableHeader({required RepositoryDetailViewModel viewModel}) {
    return Padding(
      padding: const EdgeInsets.all(Dimen.dimen_16),
      child: CloseableHeader(
        title: viewModel.repository.name ?? StringConstant.empty,
        onCloseItemTap: () {
          viewModel.transferAndExit();
        },
      ),
    );
  }

  Widget _buildCommitListView({required RepositoryDetailViewModel viewModel}) {
    return BlocProvider(
      create: (context) => viewModel.bloc,
      child: BlocBuilder<RepositoryDetailBloc, RepositoryDetailState>(
        builder: (context, state) {
          if (state is FetchCommitState) {
            if (state.commits.status == Status.loading) {
              return const Loader();
            } else if (state.commits.status == Status.failure) {
              return CustomError(
                  errorMessage:
                      state.commits.errorMessage ?? StringConstant.errorUniversal);
            } else if (state.commits.status == Status.success) {
              viewModel.commitList = state.commits.data ?? [];
              return CommitListView(
                  displayAll: true, commitList: viewModel.commitList);
            }
          }
          return CustomError(errorMessage: StringConstant.errorUniversal);
        },
      ),
    );
  }
}
