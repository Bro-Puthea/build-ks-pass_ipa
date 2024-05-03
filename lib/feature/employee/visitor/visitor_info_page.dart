import 'package:flutter/material.dart';
import 'package:igt_e_pass_app/components/my_cache_network_image.dart';
import 'package:igt_e_pass_app/data/model/vistor/vistors_model.dart';
import 'package:igt_e_pass_app/feature/employee/visitor/component/widget_info_item.dart';
import 'package:igt_e_pass_app/utils/date_utils.dart';
import 'package:igt_e_pass_app/utils/extension.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import '../../../components/build_button.dart';
import '../../../components/build_qr_image.dart';
import '../../../components/my_scaffold.dart';
import '../../../data/model/vistor/visitor_preview_model.dart';
import '../../../resource/constant.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../utils/general_utils.dart';
import '../../../utils/preference_helper.dart';
import '../../visitor/checkin/providers/checkin_provider.dart';
import 'provider/vistior_provider.dart';

class VisitorInfoPage extends StatelessWidget {
  final Visitors data;

  const VisitorInfoPage({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(providers: [
        ChangeNotifierProvider(
            create: (_) => VisitorProvider()..initDataPreview(data.id ?? '')),
        ChangeNotifierProvider(create: (_) => CheckinProvider()),
      ], child: Body(id: data.id ?? ''));
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
  Widget build(BuildContext context) =>
      Selector<VisitorProvider, VisitorsPreviewModel>(
          selector: (_, provider) => provider.data,
          builder: (context, state, _) => Screenshot(
              controller: controller,
              child: MyScaffold(
                  title: AppLocalizations.of(context)!.vistor_detail,
                  body: CustomScrollView(slivers: [
                    SliverToBoxAdapter(child: Container(height: 20)),

                    /// avatar
                    SliverToBoxAdapter(
                        child: Center(
                            child: CircleAvatar(
                                radius: 53,
                                backgroundColor: Colors.white10,
                                child: SizedBox.fromSize(
                                  size: const Size.fromRadius(50),
                                  child: ClipOval(
                                      //radius: 50,
                                      child: MyCachedNetworkImage(
                                          imageUrl: state.image ?? '')),
                                )))),

                    /// list info
                    SliverToBoxAdapter(child: Container(height: 20)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.supervised_user_circle_rounded,
                            title: AppLocalizations.of(context)!.name,
                            subtitle: state.visitorName)),
                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.phone_rounded,
                            title: AppLocalizations.of(context)!.phone,
                            subtitle: state.phone,
                            onTap: () => makeCall(state.phone ?? ''))),
                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.domain_rounded,
                            title: AppLocalizations.of(context)!.company,
                            subtitle: state.companyName)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.commute_rounded,
                            title: AppLocalizations.of(context)!.vehicle_number,
                            subtitle: state.vehicleNumber)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.group_rounded,
                            title: AppLocalizations.of(context)!.department,
                            subtitle: state.departmentName)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.person_rounded,
                            title: AppLocalizations.of(context)!.employee,
                            subtitle: state.empName)),

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.data_object_rounded,
                            title: AppLocalizations.of(context)!.reason,
                            subtitle: state.purpose)),

                    /*SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.date_range_rounded,
                            title: AppLocalizations.of(context)!.date,
                            subtitle: DateUtil.formatDate(
                                state.createdAt ?? '', false))),*/

                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.access_time_outlined,
                            title: AppLocalizations.of(context)!.checkin,
                            subtitle: DateUtil.formatDate(
                                state.checkIn ?? '', false))),
                    SliverToBoxAdapter(
                        child: WidgetInfoItem(
                            icon: Icons.access_time_outlined,
                            title: AppLocalizations.of(context)!.checkout,
                            subtitle: DateUtil.formatDate(
                                state.checkOut ?? '', false))),

                    PrefsHelper.getString(Const.groupName) == Const.security
                        ? SliverToBoxAdapter(
                            child: BuildQRImage(
                                qr: state.visitorCode ?? '',
                                controller: controller,
                                isCheckIn: false))
                        : const SliverToBoxAdapter()
                  ]),
                  bottomButton: state.checkIn == null
                      ? Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          child: BuildActiveButton(
                              title: AppLocalizations.of(context)!.allowIn,
                              onTap: allow))
                      : const SizedBox.shrink())));

  void allow() {
    final state = Provider.of<CheckinProvider>(context, listen: false);
    state.toAllowIn(widget.id).then((value) {
      if (state.resultResponse.success == "true") {
        GeneralUtil.showSnackBarMessage(
            isSuccess: true, message: state.resultResponse.message);
        Navigator.popUntil(context, (predicate) => predicate.isFirst);
      } else {
        GeneralUtil.showSnackBarMessage(isSuccess: false);
      }
    });
  }
}
