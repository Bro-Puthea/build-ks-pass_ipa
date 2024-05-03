import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/components/build_qr_image.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/pre_register_form_page.dart';
import 'package:igt_e_pass_app/feature/employee/pre_register/provider/pre_register_provider.dart';
import 'package:igt_e_pass_app/utils/general_utils.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../components/build_button.dart';
import '../../../components/my_scaffold.dart';
import '../../../styles/my_text.dart';
import '../../../utils/date_utils.dart';
import '../../../utils/my_navigator.dart';
import 'package:screenshot/screenshot.dart';
import '../visitor/component/widget_info_item.dart';

class PreRegisterPreviewPage extends StatelessWidget {
  final String id;

  const PreRegisterPreviewPage({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => PreRegisterProvider()..initPreviewData(id),
      child: Body(id: id));
}

class Body extends StatefulWidget {
  final String id;

  const Body({Key? key, required this.id}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScreenshotController controller = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Consumer<PreRegisterProvider>(builder: (context, state, _) {
      final time = state.registerModel.expectedTime;
      return Screenshot(
          controller: controller,
          child: MyScaffold(
              title: AppLocalizations.of(context)?.appointment_detail,
              actions: [
                TextButton(
                    onPressed: () => Nav.push(PreRegisterFormPage(
                        reApp: true,
                        data: state.registerModel,
                        selectedCard: state.selectedCard,
                        notify: state.notifyTo)),
                    child: Text(AppLocalizations.of(context)!.reApp,
                        style: MyText.button(context)
                            ?.copyWith(color: Colors.blueGrey)))
              ],
              body: CustomScrollView(
                  //physics: const BouncingScrollPhysics(),
                  slivers: [
                    SliverToBoxAdapter(child: Container(height: 20)),

                    /// avatar
                    const SliverToBoxAdapter(
                        child: Center(
                            child: CircleAvatar(
                                radius: 53,
                                backgroundColor: Colors.white10,
                                child: CircleAvatar(
                                    radius: 50,
                                    backgroundImage: AssetImage(
                                        "assets/icons/person.png"))))),

                    /// list info
                    SliverToBoxAdapter(child: Container(height: 20)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.supervised_user_circle_rounded,
                            title: AppLocalizations.of(context)!.name,
                            subtitle: state.registerModel.visitorName)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.phone_rounded,
                            title: AppLocalizations.of(context)!.phone,
                            subtitle: state.registerModel.phone)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.commute_rounded,
                            title: AppLocalizations.of(context)!.vehicle_no,
                            subtitle: state.registerModel.vehicleNumber)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.group_rounded,
                            title: AppLocalizations.of(context)!.department,
                            subtitle: state.registerModel.departmentName)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.person_rounded,
                            title: AppLocalizations.of(context)!.employee,
                            subtitle: state.registerModel.empName)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.data_object_rounded,
                            title: AppLocalizations.of(context)!.reason,
                            subtitle: state.registerModel.purpose)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.date_range_rounded,
                            title: AppLocalizations.of(context)!.excepted_date,
                            subtitle: DateUtil.formatDate(
                                state.registerModel.expectedDate ?? '', true))),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.access_time_outlined,
                            title: AppLocalizations.of(context)!.excepted_time,
                            subtitle:
                                time != null ? DateUtil.formatTime(time) : '')),

                    /*   SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.legend_toggle,
                            title: AppLocalizations.of(context)!.status,
                            subtitle: state.registerModel.status
                                .toString()
                                .toTitleCase())),*/

                    SliverToBoxAdapter(
                        child: BuildQRImage(
                            qr: state.registerModel.qrcodeImage ?? '',
                            controller: controller)),

                    SliverToBoxAdapter(child: Container(height: 20))
                  ]),
              bottomButton: Container(
                  padding: const EdgeInsets.all(20),
                  child: Row(children: [
                    FittedBox(
                        child: BuildCancelButton(
                            title: AppLocalizations.of(context)!.delete,
                            onTap: () => GeneralUtil.showAlertDialog(
                                onPositiveButton: () =>
                                    Provider.of<PreRegisterProvider>(context,
                                            listen: false)
                                        .deleteData(widget.id)
                                        .whenComplete(() {
                                      if (state.responseStatus.success ==
                                          'true') {
                                        GeneralUtil.showSnackBarMessage(
                                            isSuccess: true,
                                            message:
                                                state.responseStatus.message);
                                        Nav.pop();
                                      } else {
                                        GeneralUtil.showSnackBarMessage(
                                            isSuccess: false,
                                            message:
                                                state.responseStatus.message);
                                      }
                                    }),
                                subTittle: AppLocalizations.of(context)!
                                    .are_you_to_delete,
                                title: AppLocalizations.of(context)!.delete,
                                positiveButtonTitle:
                                    AppLocalizations.of(context)!.continued,
                                negativeButtonTitle:
                                    AppLocalizations.of(context)!.cancel))),
                    const SizedBox(width: 20),
                    FittedBox(
                        child: BuildCancelButton(
                            title: AppLocalizations.of(context)!.cancel,
                            color: Colors.amber,
                            onTap: () {
                              Provider.of<PreRegisterProvider>(context,
                                      listen: false)
                                  .cancel(widget.id)
                                  .whenComplete(() {
                                if (state.responseStatus.success == 'true') {
                                  GeneralUtil.showSnackBarMessage(
                                      isSuccess: true,
                                      message: state.responseStatus.message);
                                  Nav.pop();
                                } else {
                                  GeneralUtil.showSnackBarMessage(
                                      isSuccess: false,
                                      message: state.responseStatus.message);
                                }
                              });
                            })),
                    const SizedBox(width: 20),
                    Expanded(
                        child: BuildActiveButton(
                            title: AppLocalizations.of(context)!.edit,
                            onTap: () => Nav.push(PreRegisterFormPage(
                                    data: state.registerModel,
                                    selectedCard: state.selectedCard,
                                    notify: state.notifyTo))
                                .whenComplete(
                                    () => state.refreshPreviewData(widget.id))))
                  ]))));
    });
  }
}
