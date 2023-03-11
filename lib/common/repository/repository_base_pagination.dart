import 'package:delivery_practice01/common/model/model_cursor_pagination.dart';
import 'package:delivery_practice01/common/model/model_cursor_pagination_params.dart';
import 'package:delivery_practice01/common/model/model_with_id.dart';

abstract class IRepositoryBasePagination<T extends IModelWithId> {
  Future<CursorPagination<T>> paginate({
    CursorPaginationParams? cursorPaginationParams = const CursorPaginationParams(),
  });
}
