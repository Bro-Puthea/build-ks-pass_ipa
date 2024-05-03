import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/components/my_custom_footer.dart';
import 'package:igt_e_pass_app/feature/employee/home/component/widget_item_visitor.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../components/my_scaffold.dart';
import '../../../styles/my_text.dart';
import 'provider/vistior_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllVisitorsPage extends StatelessWidget {
  final bool isButtonBack;

  const AllVisitorsPage({Key? key, required this.isButtonBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => VisitorProvider(),
      child: Body(isButtonBack: isButtonBack));
}

class Body extends StatefulWidget {
  final bool isButtonBack;

  const Body({Key? key, required this.isButtonBack}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final controller = TextEditingController();
  String query = '';

  @override
  Widget build(BuildContext context) {
    final titleBar =
        "${AppLocalizations.of(context)?.vistors} ${AppLocalizations.of(context)?.e_pass}";

    return Consumer<VisitorProvider>(builder: (context, state, _) {
      return MyScaffold(
          title: titleBar,
          centerTitle: !widget.isButtonBack,
          leadType:
              widget.isButtonBack ? AppBarBackType.back : AppBarBackType.none,
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
                                (context, index) =>
                                    WidgetItemVisitor(data: state.list[index]),
                                childCount: state.list.length)))
              ])));
    });
  }
}
