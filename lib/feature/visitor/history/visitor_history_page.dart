import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/components/my_scaffold.dart';
import 'package:igt_e_pass_app/feature/visitor/history/providers/history_provider.dart';
import 'package:provider/provider.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/components/my_custom_footer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../styles/my_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'component/widget_item_history.dart';

class VisitorHistoryPage extends StatelessWidget {
  const VisitorHistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => HistoryProvider(), child: const Body());
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final controller = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) => Consumer<HistoryProvider>(
      builder: (context, state, _) => MyScaffold(
          title: AppLocalizations.of(context)?.historyVisitor,
          leadType: AppBarBackType.back,
          body: SmartRefresher(
              controller: state.refreshController,
              enablePullUp: true,
              enablePullDown: false,
              scrollDirection: Axis.vertical,
              footer: const MyCustomFooter(),
              onLoading: () => state.loadMoreData(query: query),
              child: CustomScrollView(slivers: [
                SliverToBoxAdapter(child: Container(height: 20)),

                /// search
                SliverToBoxAdapter(
                    child: BuildSearchField(
                        controller: controller,
                        onSubmitted: (value) {
                          query = value;
                          state.initData(query: value);
                          state.refreshController.resetNoData();
                        })),

                /// list
                SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: state.isEmpty
                        ? SliverToBoxAdapter(
                            child: Center(
                                child: Text(
                                    AppLocalizations.of(context)!.no_data_found,
                                    style: MyText.title(context))))
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                                (context, index) => WidgetItemHistoryVisitor(
                                    data: state.list[index]),
                                childCount: state.list.length)))
              ]))));
}
