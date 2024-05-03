import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/provider/employee_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/my_cache_network_image.dart';
import '../../../../components/my_custom_footer.dart';
import '../../../../components/my_scaffold.dart';
import '../../../../data/model/selected_item_model.dart';
import '../../../../styles/my_text.dart';
import '../../../../utils/my_navigator.dart';

class SelectEmployeePage extends StatelessWidget {
  final String? departmentId;

  const SelectEmployeePage({Key? key, this.departmentId}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => EmployeeProvider()..initData(departmentId: departmentId),
      child: Body(departmentId: departmentId));
}

class Body extends StatefulWidget {
  final String? departmentId;

  const Body({Key? key, this.departmentId}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final controller = TextEditingController();
  String query = '';
  List<SelectedItemModel> items = [];

  @override
  void dispose() {
    query = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeProvider>(builder: (context, state, _) {
      return MyScaffold(
          title: AppLocalizations.of(context)?.employee,
          leadType: AppBarBackType.back,
          body: SmartRefresher(
              controller: state.refreshController,
              enablePullUp: true,
              enablePullDown: false,
              scrollDirection: Axis.vertical,
              footer: const MyCustomFooter(),
              onLoading: () => state.item.length < state.limit
                  ? null
                  : state.loadMoreData(
                      query: query, departmentId: widget.departmentId),
              //onLoading: () => state.loadMoreData(query: query, departmentId: widget.departmentId),
              child: CustomScrollView(slivers: [
                SliverToBoxAdapter(child: Container(height: 20)),

                /// entrance title

                SliverToBoxAdapter(
                    child: BuildSearchField(
                        controller: controller,
                        onSubmitted: (value) {
                          query = value;
                          state.initData(
                              query: value, departmentId: widget.departmentId);
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
                                (context, index) => widgetItem(
                                    context, state.employeeList[index]),
                                childCount: state.employeeList.length)))
              ])));
    });
  }

  Widget widgetItem(BuildContext context, SelectedItemModel data) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.1 + 20,
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(15)),
        child: InkWell(
            onTap: () => Nav.pop(data: data),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(children: [
              /// image
              Expanded(
                  flex: 2,
                  child: CircleAvatar(
                      radius: 53,
                      backgroundColor: Colors.white10,
                      child: CircleAvatar(
                          radius: 50,
                          child: ClipOval(
                            child: MyCachedNetworkImage(
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                                imageUrl: data.image ?? ''),
                          )))),
              Container(width: 5),

              /// info
              Expanded(
                  flex: 5,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(data.name ?? '',
                          style: MyText.body1(context)
                              ?.copyWith(color: Colors.white))))
            ])));
  }
}
