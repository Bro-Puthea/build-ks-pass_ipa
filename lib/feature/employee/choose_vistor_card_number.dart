import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/data/model/selected_item_model.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/provider/card_no_provider.dart';
import 'package:igt_e_pass_app/styles/colors.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/my_scaffold.dart';
import '../../../../styles/my_text.dart';
import '../../../components/my_custom_footer.dart';
import '../../../utils/my_navigator.dart';
import '../../components/entry_field.dart';
import '../../utils/general_utils.dart';

class ChooseVisitorCardNumberPage extends StatelessWidget {
  final int count;

  const ChooseVisitorCardNumberPage({Key? key, this.count = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => CardNoProvider(), child: Body(count: count));
}

class Body extends StatefulWidget {
  final int count;

  const Body({Key? key, required this.count}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final controller = TextEditingController();
  final List<SelectedItemModel> _selectedItems = [];
  String query = '';
  int limit = 0;

  @override
  void dispose() {
    query = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CardNoProvider>(builder: (context, state, _) {
      return MyScaffold(
          title: AppLocalizations.of(context)!.card_no,
          leadType: AppBarBackType.back,
          body: SmartRefresher(
              controller: state.refreshController,
              enablePullUp: true,
              enablePullDown: false,
              scrollDirection: Axis.vertical,
              footer: const MyCustomFooter(),
              onLoading: () => state.item.length < state.limit
                  ? null
                  : state.loadMoreData(query: query),
              child: CustomScrollView(slivers: [
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
                                    widgetItem(context, state.item[index]),
                                childCount: state.item.length)))
              ])),
          bottomButton: Container(
              padding: const EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () => Nav.pop(),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            side: const BorderSide(
                                width: 2.0, color: Colors.red)),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(AppLocalizations.of(context)!.cancel,
                                style: MyText.button(context)
                                    ?.copyWith(color: Colors.red)))),
                    ElevatedButton(
                        onPressed: () => _submit(),
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(AppLocalizations.of(context)!.submit,
                                style: MyText.button(context)!.copyWith())))
                  ])));
    });
  }

  Widget widgetItem(BuildContext context, SelectedItemModel data) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.1 + 10,
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(15)),
        child: Row(children: [
          Container(width: 5),
          Expanded(
              flex: 5,
              child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Theme(
                            data:
                                ThemeData(unselectedWidgetColor: Colors.white),
                            child: CheckboxListTile(
                                value: _selectedItems.contains(data),
                                title: Text(
                                    "${AppLocalizations.of(context)!.card_number}: ${data.name}",
                                    style: MyText.body1(context)
                                        ?.copyWith(color: Colors.white)),
                                controlAffinity:
                                    ListTileControlAffinity.trailing,
                                onChanged: (isChecked) =>
                                    _itemChange(data, isChecked ?? false)))
                      ])))
        ]));
  }

  void _itemChange(SelectedItemModel itemValue, bool isSelected) {
    if (isSelected) {
      if (limit != widget.count) {
        _selectedItems.add(itemValue);
        limit++;
      } else {
        final cardNo = AppLocalizations.of(context)!.card_no.toLowerCase();
        final reach = AppLocalizations.of(context)!.reachLimit;

        GeneralUtil.showToast('$reach ${widget.count} $cardNo');
      }
    } else {
      _selectedItems.remove(itemValue);
      limit--;
    }
    setState(() {});
  }

  void _submit() => Navigator.pop(context, _selectedItems);
}
