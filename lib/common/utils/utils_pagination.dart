import 'package:delivery_practice01/common/provider/provider_pagination.dart';
import 'package:flutter/material.dart';

class UtilsPagination {
  static void paginate({
    required ScrollController scrollController,
    required ProviderPagination providerPagination,
  }) {
    if (scrollController.offset > scrollController.position.maxScrollExtent - 300) {
      providerPagination.paginate(fetchMore: true);
    }
  }
}
