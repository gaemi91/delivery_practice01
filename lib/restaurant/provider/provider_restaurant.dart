import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination_more.dart';
import 'package:delivery_practice01/restaurant/model/model_restaurant.dart';
import 'package:delivery_practice01/restaurant/repository/repository_restaurant.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class StateNotifierRestaurant extends StateNotifier<CursorPaginationBase> {
  final RepositoryRestaurant repositoryRestaurant;

  StateNotifierRestaurant({required this.repositoryRestaurant}) : super(CursorPaginationLoading()) {
    paginate();
  }

  Future<void> paginate({
    int countFetch = 20,
    bool fetchMore = false,
    bool forceRefetch = false,
  }) async {
    try {
      // 1) CursorPagination - 정상적으로 데이터가 있는 상태
      // 2) CursorPaginationLoading - 데이터가 로딩중인 상태(현재 캐시가 없음)
      // 3) CursorPaginationError - 에러가 있는 상태
      // 4) CursorPaginationRefresh - 첫번째 페이지부터 다시 데이터를 가져올 때
      // 5) CursorPaginationFetchMore - 추가 데이터를 paginate 해오라는 요청을 받았을 때

      //바로 반환하는 상황
      // 1) hasMore가 false일 때
      if (state is CursorPagination && !forceRefetch) {
        final pState = state as CursorPagination;

        if (!pState.meta.hasMore) {
          return;
        }
      }
      // 2) 로딩중 일 때
      final isLoading = state is CursorPaginationLoading;
      final isFetchMore = state is CursorPaginationFetchMore;
      final isRefresh = state is CursorPaginationRefresh;

      if (fetchMore && (isLoading || isFetchMore || isRefresh)) {
        return;
      }

      CursorPaginationMore cursorPaginationMore = CursorPaginationMore(count: countFetch);

      //데이터를 추가로 더 가져오는 상황
      if (fetchMore) {
        final pState = state as CursorPagination;

        state = CursorPaginationFetchMore(meta: pState.meta, data: pState.data);

        cursorPaginationMore = cursorPaginationMore.copyWith(after: pState.data.last.id);
      }
      //데이터를 처음부터 가져오는 상황
      else {
        // 데이터가 있는 상황이라면 기존 데이터를 보존한 채로 fetch
        if (state is CursorPagination && !forceRefetch) {
          final pState = state as CursorPagination;

          state = CursorPaginationRefresh(meta: pState.meta, data: pState.data);
        }
        // 나머지 상황
        else {
          state = CursorPaginationLoading();
        }
      }

      final resp = await repositoryRestaurant.paginate(cursorPaginationMore: cursorPaginationMore);

      if (state is CursorPaginationFetchMore) {
        final pState = state as CursorPaginationFetchMore;

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
