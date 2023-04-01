import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/constants/app_images.dart';
import 'package:flutter_projects/core/constants/app_routes.dart';
import 'package:flutter_projects/core/extensions/localization_helper.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/features/auth/presentation/manager/user_type_provider/user_type_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/error_handling/validation.dart';
import '../../../reusable_components/buttons/action_button.dart';
import '../../../reusable_components/buttons/double_back_to_exit.dart';
import '../../../reusable_components/toasts/error_toast.dart';
import '../../../reusable_components/input_text_field.dart';
import '../manager/login_provider/login_provider.dart';
import '../manager/social_login_provider/social_login_provider.dart';
import '../widgets/or_divider.dart';
import '../widgets/social_buttons.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({Key? key,}) : super(key: key);

  @override
  ConsumerState createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();
  final Validation _validation = Validation();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToExit(
        child: Form(
          key: _formKey,
          child: SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 95.h,),

                    const _BuildLogo(),
                    SizedBox(height: 5.h,),

                    const _BuildTitle(),

                    SizedBox(height: 30.h,),
                    InputTextField(
                      hint: context.localization.email,
                      validator: (email){
                        return _validation.emailValidator(email);
                      },
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                    ),

                    SizedBox(height: 15.h,),
                    InputTextField(
                      hint: context.localization.password,
                      validator: (password){
                        return _validation.isPasswordEmpty(password);
                      },
                      controller: passwordController,
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      isObscure: true,
                    ),

                    SizedBox(height: 6.h,),
                    const _BuildForgotPassword(),

                    SizedBox(height:30.h,),

                    Consumer(
                      builder: (context, ref, child) {
                        final loginState = ref.watch(loginProvider);

                        ref.listen(loginProvider, (previous, current) {
                          if(current is LoginSuccess){
                            if(current.isEmailVerified){
                              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.homeRoute, (route) => false);
                            }else{
                              Navigator.pushNamed(context, AppRoutes.emailVerificationRoute);
                            }
                          }else if(current is LoginError){
                            showErrorToast(current.message);
                          }
                        });


                        return ActionButton(
                          title: context.localization.login,
                          isLoading: loginState is LoginLoading,
                          onTap: () async{
                            if(_formKey.currentState!.validate()){
                              await ref.read(loginProvider.notifier).login(
                                  emailController.text.trim(),
                                  passwordController.text.trim(),
                                  ref.read(userTypeProvider)
                              );
                            }
                          },
                        );
                      },
                    ),

                    SizedBox(height:12.h,),
                    const _BuildDoNotHaveAnAccount(),

                    SizedBox(height:28.h,),
                    const OrDivider(),

                    SizedBox(height:20.h,),
                    SocialButtons(
                      googleOnTap: () async{
                        await ref.read(socialLoginProvider.notifier).loginWithGoogle();
                      },
                    ),

                    SizedBox(height:20.h,),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildLogo extends StatelessWidget {
  const _BuildLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppImages.appLogo,
      width:0.5.sw,
      height: 60.h,
      fit: BoxFit.contain,
    );
  }
}

class _BuildTitle extends StatelessWidget {
  const _BuildTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.6.sw,
      height: 60.h,
      child: FittedBox(
        child: Text(
            'Live Tracking',
            style: context.textTheme.displayMedium
        ),
      ),
    );
  }
}

class _BuildForgotPassword extends StatelessWidget {
  const _BuildForgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, AppRoutes.resetPasswordRoute);
      },
      child: Align(
        alignment: AlignmentDirectional.topEnd,

        child: Padding(
          padding: EdgeInsetsDirectional.only(
              end: 20.w
          ),
          child: Text(
            context.localization.forgotPassword.replaceAll('\n', ' '),
            style: context.textTheme.titleSmall!.copyWith(
                decoration: TextDecoration.underline
            ),),
        ),
      ),
    );
  }
}

class _BuildDoNotHaveAnAccount extends StatelessWidget {
  const _BuildDoNotHaveAnAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: EdgeInsetsDirectional.only(start: 20.w),
        child: RichText(
          text:TextSpan(
              text: context.localization.doNotHaveAnAccount + ' ',
              style: context.textTheme.titleMedium,
              children: [
                TextSpan(
                    text: context.localization.register,
                    style: context.textTheme.titleMedium!.copyWith(
                        decoration: TextDecoration.underline
                    ),
                    recognizer: TapGestureRecognizer()..onTap = (){
                      Navigator.of(context).pushReplacementNamed(AppRoutes.registerRoute);
                    }
                )
              ]
          ),
        ),
      ),
    );
  }
}