import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/localization_helper.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../reusable_components/buttons/action_button.dart';
import '../../../reusable_components/toasts/error_toast.dart';
import '../manager/check_email_verification_provider/check_email_verification_provider.dart';
import '../manager/send_email_verification_provider/send_email_verification_provider.dart';
import '../widgets/back_arrow.dart';

class EmailVerificationPage extends ConsumerStatefulWidget {
  const EmailVerificationPage({Key? key}) : super(key: key);

  @override
  ConsumerState<EmailVerificationPage> createState() => _EmailVerificationCheckPageState();
}

class _EmailVerificationCheckPageState extends ConsumerState<EmailVerificationPage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(sendEmailVerificationProvider.notifier).sendEmailVerification();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const BackArrow(),

              SizedBox(height: 90.h,),

              Consumer(
                builder: (context, ref, child) {
                  final sendVerificationEmailState = ref.watch(sendEmailVerificationProvider);
                  log(sendVerificationEmailState.toString());

                  ref.listen(sendEmailVerificationProvider, (previous, current) {
                    if(current is SendEmailVerificationError){
                      showErrorToast(current.message);
                    }
                  });

                  if(sendVerificationEmailState is SendEmailVerificationLoading){
                    return const _BuildSendEmailVerificationLoading();
                  }

                  log(sendVerificationEmailState.toString());
                  return Column(
                    children: [
                      _BuildMailBoxSVG(),

                      SizedBox(height: 32.h,),
                      _BuildCheckYourEmailText(),

                      SizedBox(height: 25.h,),
                      _BuildCheckValidationButton()
                    ],
                  );
                },
              )

            ],
          ),
        ),
      ),
    );
  }
}

class _BuildSendEmailVerificationLoading extends StatelessWidget {
  const _BuildSendEmailVerificationLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          Expanded(
            child: Text(
              context.localization.sendingVerificationEmail,
              style: context.textTheme.titleMedium,
            ),
          ),

          Center(
            child: SizedBox(
                width:22.w,
                height:22.h,
                child: CircularProgressIndicator(color: context.theme.primaryColor,strokeWidth: 3.w,)
            ),
          )
        ],
      ),
    );
  }
}

class _BuildCheckValidationButton extends ConsumerWidget {
  const _BuildCheckValidationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkEmailVerificationState = ref.watch(checkEmailVerificationProvider);

    ref.listen(checkEmailVerificationProvider, (previous, current) {
      if(current is CheckEmailVerificationError){
        Fluttertoast.showToast(msg: current.message);
      }else if(current is CheckEmailVerifiedSuccessfully){
        Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute, (route) => false);
      }
    });

    return ActionButton(
        title: context.localization.done,
        isLoading: checkEmailVerificationState is CheckEmailVerificationLoading,
        onTap: ()async{
          await ref.read(checkEmailVerificationProvider.notifier).isEmailVerified();
        }
    );
  }
}

class _BuildMailBoxSVG extends StatelessWidget {
  const _BuildMailBoxSVG({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages.mailBox,
      width: 0.3.sw,
      height: 0.2.sh,
    );
  }
}

class _BuildCheckYourEmailText extends StatelessWidget {
  const _BuildCheckYourEmailText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        context.localization.verifyEmailMessage,
        style: context.textTheme.titleLarge,textAlign: TextAlign.center,
      ),
    );
  }
}
