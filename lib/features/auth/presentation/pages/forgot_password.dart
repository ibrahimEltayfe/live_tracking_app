import 'package:flutter_projects/core/extensions/localization_helper.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/error_handling/validation.dart';
import '../../../reusable_components/buttons/action_button.dart';
import '../../../reusable_components/toasts/error_toast.dart';
import '../../../reusable_components/input_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../manager/reset_password_provider/reset_password_provider.dart';
import '../widgets/back_arrow.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({
    Key? key,
  }) : super(key: key);

  @override
  State createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final Validation _validation = Validation();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: BackArrow(),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Consumer(
              builder: (context,ref,_) {
                final resetPasswordLinkSentState = ref.watch(resetPasswordProvider.select(
                   (state) => state is ResetPasswordLinkSent)
                );

                if(resetPasswordLinkSentState){
                  return Center(
                    child: Text(
                      context.localization.resetPasswordLinkSent,
                      style: context.textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                  );
                }

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25.h,),
                    const _BuildTitle(),

                    SizedBox(height: 70.h,),
                    SvgPicture.asset(AppImages.forgotPassword,width: 0.4.sw,height: 180.h,),
                    InputTextField(
                        hint: context.localization.enterYourEmail,
                        controller: _emailController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.emailAddress,
                        borderRadius: 10.r,
                        validator: (email) {
                          return _validation.emailValidator(email);
                        },
                    ),

                    const SizedBox(height: 20,),
                    Consumer(
                      builder: (context, WidgetRef ref,_) {
                        final resetPasswordState = ref.watch(resetPasswordProvider);

                        ref.listen(resetPasswordProvider, (previous, current) {
                          if(current is ResetPasswordError){
                            showErrorToast(current.message);
                          }
                        });

                        return ActionButton(
                            height: 52.h,
                            isLoading: resetPasswordState is ResetPasswordLoading,
                            title: context.localization.resetPassword,
                            onTap: (){
                              if(_formKey.currentState!.validate()){
                                ref.read(resetPasswordProvider.notifier).resetPassword(
                                  _emailController.text.trim()
                                );
                              }
                            }
                        );
                      }
                    )

                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 14.w),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Text(
              context.localization.forgotPassword,
              style: context.textTheme.displayLarge,
            )
          ],
        ),
      ),
    );
  }
}

