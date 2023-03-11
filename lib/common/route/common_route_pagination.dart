import 'package:delivery_practice01/common/const/colors.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/model/model_with_id.dart';
import 'package:delivery_practice01/common/provider/provider_pagination.dart';
import 'package:delivery_practice01/common/utils/utils_pagination.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(BuildContext context, int index, T model);

class CommonRoutePagination<T extends IModelWithId> extends ConsumerStatefulWidget {
  final StateNotifierProvider<ProviderPagination, CursorPaginationBase> provider;
  final PaginationWidgetBuilder<T> paginationWidgetBuilder;

  const CommonRoutePagination({
    required this.provider,
    required this.paginationWidgetBuilder,
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<CommonRoutePagination> createState() => _CommonRoutePaginationState<T>();
}

class _CommonRoutePaginationState<T extends IModelWithId> extends ConsumerState<CommonRoutePagination> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollControllerListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollControllerListener);
    scrollController.dispose();

    super.dispose();
  }

  void scrollControllerListener() {
    UtilsPagination.paginate(
      scrollController: scrollController,
      providerPagination: ref.read(widget.provider.notifier),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);

    if (state is CursorPaginationLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is CursorPaginationError) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(state.message, textAlign: TextAlign.center),
          const SizedBox(height: 15.0),
          ElevatedButton(
            onPressed: () {
              ref.read(widget.provider.notifier).paginate(forceRefetch: true);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color_Main),
            child: const Text('다시시도'),
          )
        ],
      );
    }

    final cp = state as CursorPagination<T>;

    return ListView.separated(
        controller: scrollController,
        physics: const BouncingScrollPhysics(),
        itemCount: cp.data.length + 1,
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemBuilder: (context, index) {
          if (index == cp.data.length) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Center(
                  child: cp is CursorPaginationFetchMore
                      ? const CircularProgressIndicator()
                      : const Text('데이터가 더이상 없습니다.')),
            );
          }

          final model = cp.data[index];

          return widget.paginationWidgetBuilder(context, index, model);
        });
    ;
  }
}
