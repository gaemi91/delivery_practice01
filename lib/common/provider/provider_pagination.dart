import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination_params.dart';
import 'package:delivery_practice01/common/model/model_with_id.dart';
import 'package:delivery_practice01/common/repository/repository_base_pagination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderPagination<T extends IModelWithId, U extends IRepositoryBasePagination<T>>
    extends StateNotifier<CursorPaginationBase> {
  final U repository;

  ProviderPagination({required this.repository}) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int fetchCount = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination<T>;

        if (!pState.meta.hasMore) {
          return;
        }
      }

      final isLoading = state is CursorPaginationLoading;
      final isRefresh = state is CursorPaginationRefresh<T>;
      final isFetchMore = state is CursorPaginationFetchMore<T>;

      if (fetchMore && (isLoading || isRefresh || isFetchMore)) {
        return;
      }

      CursorPaginationParams cursorPaginationParams = CursorPaginationParams(
        count: fetchCount,
      );

      //데이터를 추가로 더 가져와야 하는 상황
      if (fetchMore) {
        final pState = state as CursorPagination<T>;

        state = CursorPaginationFetchMore<T>(meta: pState.meta, data: pState.data);

        cursorPaginationParams = cursorPaginationParams.copyWith(after: pState.data.last.id);
      } else {
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination<T>;

          state = CursorPaginationRefresh<T>(meta: pState.meta, data: pState.data);
        } else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repository.paginate(
        cursorPaginationParams: cursorPaginationParams,
      );

      if (state is CursorPaginationFetchMore) {
        final pState = state as CursorPaginationFetchMore<T>;

        state = resp.copyWith(data: [
          ...pState.data,
          ...resp.data,
        ]);
      } else {
        state = resp;
      }
    } catch (e) {
      state = CursorPaginationError(message: '데이터를 가져오지 못했습니다.');
    }
  }
}
