import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:igt_e_pass_app/components/build_button.dart';
import 'package:igt_e_pass_app/components/my_app_bar.dart';
import 'package:igt_e_pass_app/components/my_cache_network_image.dart';
import 'package:igt_e_pass_app/feature/employee/profile/provider/profile_provider.dart';
import 'package:igt_e_pass_app/utils/validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../components/entry_field.dart';
import '../../../components/my_scaffold.dart';
import '../../../data/model/user_login_model.dart';
import '../../../resource/constant.dart';
import '../../../styles/my_text.dart';
import '../../../utils/general_utils.dart';
import '../../../utils/my_navigator.dart';
import '../../../utils/storage_utils.dart';

class UpdateProfilePage extends StatelessWidget {
  const UpdateProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (_) => ProfileProvider(), child: const Body());
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  File? imageFile;
  User userData = User();

  final TextEditingController _fistNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();

  @override
  void initState() {
    getUserInfo().then((value) {
      _fistNameController.text = value.firstName ?? '';
      _lastNameController.text = value.lastName ?? '';
      _phoneController.text = value.phone ?? '';
      _emailController.text = value.email ?? '';
      _addressController.text = value.address ?? '';
      _userNameController.text = value.username ?? '';
      userData = value;
      setState(() {});
    });
    super.initState();
  }

  Future<XFile?> _pickImage() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  @override
  Widget build(BuildContext context) {
    final plsInput = AppLocalizations.of(context)?.pls_input;
    final enter = AppLocalizations.of(context)?.enter;
    final firstName = AppLocalizations.of(context)?.first_name;
    final lastName = AppLocalizations.of(context)?.last_name;
    final email = AppLocalizations.of(context)?.email;
    final phone = AppLocalizations.of(context)?.phone;
    final address = AppLocalizations.of(context)?.address;

    return Consumer<ProfileProvider>(
        builder: (context, state, _) => MyScaffold(
            title:
                '${AppLocalizations.of(context)!.update} ${AppLocalizations.of(context)!.my_profile}',
            centerTitle: true,
            leadType: AppBarBackType.back,
            body: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(child: Container(height: 20)),

                  /// avatar
                  SliverToBoxAdapter(
                      child: Center(
                          child: Column(children: [
                    Stack(children: [
                      CircleAvatar(
                          radius: 53,
                          backgroundColor: Colors.white10,
                          child: imageFile != null
                              ? CircleAvatar(
                                  radius: 50,
                                  backgroundImage:
                                      Image.file(imageFile!, fit: BoxFit.cover)
                                          .image)
                              : ClipOval(
                                  child: SizedBox.fromSize(
                                      size: const Size.fromRadius(50),
                                      child: MyCachedNetworkImage(
                                          imageUrl:
                                              state.userData.imageUrl ?? '')))),
                      Positioned(
                          bottom: 1,
                          right: 1,
                          child: GestureDetector(
                              onTap: () async {
                                await _pickImage().then((pickedFile) async {
                                  if (pickedFile == null) return;
                                  setState(() {});
                                  imageFile = File(pickedFile.path);
                                  state
                                      .updateProfilePic(
                                          filePath: pickedFile.path)
                                      .whenComplete(() {
                                    if (state.responeState.status ==
                                        "success") {
                                      GeneralUtil.showSnackBarMessage(
                                          isSuccess: true,
                                          context: context,
                                          message: "update successful");
                                      state.getProfilePreview();
                                    } else {
                                      GeneralUtil.showSnackBarMessage(
                                          isSuccess: false,
                                          context: context,
                                          message:
                                              (state.responeState.message ??
                                                  ''));
                                    }
                                  });
                                });
                              },
                              child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 3, color: Colors.white),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(50)),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(2, 4),
                                            blurRadius: 3,
                                            color:
                                                Colors.black.withOpacity(0.3))
                                      ]),
                                  child: const Icon(Icons.add_a_photo,
                                      color: Colors.black))))
                    ]),
                    const SizedBox(height: 10),
                    Text("${userData.firstName} ${userData.lastName}",
                        style: MyText.title(context))
                  ]))),

                  /// list info
                  SliverToBoxAdapter(child: Container(height: 20)),

                  SliverToBoxAdapter(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Form(
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                const SizedBox(height: 5),
                                EntryField(
                                    controller: _fistNameController,
                                    label: firstName,
                                    hint: "$enter ${firstName?.toLowerCase()}",
                                    validator: (v) => kNullInputValidator(v,
                                        "$plsInput ${firstName?.toLowerCase()}")),
                                const SizedBox(height: 5),
                                EntryField(
                                    controller: _lastNameController,
                                    label: lastName,
                                    hint: "$enter ${lastName?.toLowerCase()}",
                                    validator: (v) => kNullInputValidator(v,
                                        "$plsInput ${lastName?.toLowerCase()}")),
                                const SizedBox(height: 5),
                                EntryField(
                                    keyboardType: TextInputType.phone,
                                    controller: _phoneController,
                                    label: phone,
                                    hint: "$enter ${phone?.toLowerCase()}",
                                    validator: Validator.validatePhoneNumber),
                                const SizedBox(height: 5),
                                EntryField(
                                    keyboardType: TextInputType.emailAddress,
                                    controller: _emailController,
                                    label: email,
                                    hint: "$enter ${email?.toLowerCase()}"),
                                const SizedBox(height: 5),
                                EntryField(
                                    controller: _addressController,
                                    keyboardType: TextInputType.multiline,
                                    label: address,
                                    hint: "$enter ${address?.toLowerCase()}",
                                    validator: (v) => kNullInputValidator(v,
                                        "$plsInput ${address?.toLowerCase()}"),
                                    maxLines: null,
                                    minLines: 8),
                              ])))),

                  SliverToBoxAdapter(child: Container(height: 20))
                ]),
            bottomButton: Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const BuildCancelButton(),
                      BuildActiveButton(
                          title: AppLocalizations.of(context)!.update,
                          onTap: () => state.updateProfile({
                                Const.firstName: _fistNameController.text,
                                Const.lastName: _lastNameController.text,
                                Const.phone: _phoneController.text,
                                Const.email: _emailController.text,
                                Const.address: _addressController.text
                              }).whenComplete(() {
                                if (state.responeState.status == "success") {
                                  GeneralUtil.showSnackBarMessage(
                                      isSuccess: true,
                                      context: context,
                                      message: state.responeState.message);
                                  setUserInfo(User(
                                      firstName: _fistNameController.text,
                                      lastName: _lastNameController.text,
                                      phone: _phoneController.text,
                                      address: _addressController.text,
                                      email: _emailController.text,
                                      id: userData.id));
                                  Nav.pop();
                                } else {
                                  GeneralUtil.showSnackBarMessage(
                                      isSuccess: false,
                                      context: context,
                                      message: (state.responeState.message));
                                }
                              }))
                    ]))));
  }
}
