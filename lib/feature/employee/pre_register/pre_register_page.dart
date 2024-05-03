import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/components/entry_field.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/data/model/pre_register/pre_register_model.dart';
import 'package:igt_e_pass_app/data/model/pre_register/view_pre_register_model.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/pre_register_form_page.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/pre_register_info_page.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/provider/pre_register_provider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../components/my_scaffold.dart';
import '../../../../styles/my_text.dart';
import '../../../components/my_custom_footer.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/my_navigator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PreRegisterPage extends StatelessWidget {
  final bool isButtonBack;

  const PreRegisterPage({Key? key, required this.isButtonBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => PreRegisterProvider(),
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
  void dispose() {
    query = '';
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreRegisterProvider>(builder: (context, state, _) {
      return MyScaffold(
          title: AppLocalizations.of(context)?.appointment,
          centerTitle: !widget.isButtonBack,
          leadType:
              widget.isButtonBack ? AppBarBackType.back : AppBarBackType.none,
          floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () =>
                  Nav.push(PreRegisterFormPage(data: AppointmentInfoModel()))
                      .then((value) => state.refreshData())),
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
                                    widgetItem(context, state.list[index]),
                                childCount: state.list.length)))
              ])));
    });
  }

  Widget widgetItem(BuildContext context, PreRegisters data) {
    final state = Provider.of<PreRegisterProvider>(context);

    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height * 0.1 + 20,
        decoration: BoxDecoration(
            color: Colors.white10, borderRadius: BorderRadius.circular(15)),
        child: InkWell(
            onTap: () => Nav.push(PreRegisterPreviewPage(id: data.id ?? ''))
                    .whenComplete(() {
                  state.initData(query: query);
                }),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Row(children: [
              /// image
              const Expanded(
                  flex: 2,
                  child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white10,
                      child: CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              AssetImage("assets/icons/person.png")))),
              Container(width: 5),

              /// info
              Expanded(
                  flex: 5,
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data.visitorName ?? 'N/A',
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: MyText.body2(context)!.copyWith(
                                    color: Colors.white,
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Text(
                                '${AppLocalizations.of(context)?.excepted_date}: ${DateUtil.formatDate(data.expectedDate ?? '', true)}',
                                style: MyText.caption(context)!.copyWith(
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400)),
                            Container(height: 5),
                            Text(
                                '${AppLocalizations.of(context)?.excepted_time}: ${data.expectedTime != null ? DateUtil.formatTime(data.expectedTime ?? '00:00') : ''}',
                                style: MyText.caption(context)!.copyWith(
                                    letterSpacing: 0.5,
                                    fontWeight: FontWeight.w400))
                          ])))
            ])));
  }
}
