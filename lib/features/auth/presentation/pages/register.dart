import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/extensions/localization_helper.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/features/auth/presentation/manager/user_type_provider/user_type_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/error_handling/validation.dart';
import '../../../reusable_components/buttons/double_back_to_exit.dart';
import '../../../reusable_components/toasts/error_toast.dart';
import '../manager/register_provider/register_provider.dart';
import '../manager/social_login_provider/social_login_provider.dart';
import '../widgets/or_divider.dart';
import '../widgets/social_buttons.dart';
import '../../../reusable_components/buttons/action_button.dart';
import '../../../reusable_components/input_text_field.dart';
import '../widgets/user_type_switcher.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({Key? key,}) : super(key: key);

  @override
  ConsumerState createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Validation _validation = Validation();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();


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
                      SizedBox(height: 60.h,),

                      const _BuildLogo(),
                      SizedBox(height: 5.h,),

                      const _BuildTitle(),

                      SizedBox(height: 40.h,),
                      const UserTypeSwitcher(),

                      SizedBox(height: 20.h,),
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
                          return _validation.passwordValidator(password);
                        },
                        controller: passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        isObscure: true,
                      ),

                      SizedBox(height:35.h,),
                      Consumer(
                        builder: (context, ref, child) {
                          final registerState = ref.watch(registerProvider);

                          ref.listen(registerProvider, (previous, current) {
                            if(current is RegisterSuccess){
                              Navigator.pushNamed(context, AppRoutes.emailVerificationRoute);
                            }else if(current is RegisterError){
                              showErrorToast(current.message);
                            }
                          });

                          return ActionButton(
                            title: context.localization.register,
                            isLoading: registerState is RegisterLoading,

                            onTap: () async{
                              if(_formKey.currentState!.validate()){
                              await ref.read(registerProvider.notifier).register(
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
                      _BuildAlreadyHaveAnAccount(),

                      SizedBox(height:28.h,),

                      OrDivider(),

                      SizedBox(height:20.h,),
                      SocialButtons(
                        googleOnTap: () async{
                          await ref.read(socialLoginProvider.notifier).registerWithGoogle(ref.read(userTypeProvider));
                        },
                      ),

                      SizedBox(height:20.h,),

                    ],
                  ),
                ),
              ),
            ),
          ),
        )
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

class _BuildAlreadyHaveAnAccount extends StatelessWidget {
  const _BuildAlreadyHaveAnAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(-0.48,0),
      child: RichText(
        text:TextSpan(
            text: context.localization.alreadyHaveAnAccount,
            style: context.textTheme.titleMedium,
            children: [
              TextSpan(
                  text: context.localization.login,
                  style: context.textTheme.titleMedium!.copyWith(decoration: TextDecoration.underline),
                  recognizer: TapGestureRecognizer()..onTap = (){
                    Navigator.of(context).pushReplacementNamed(AppRoutes.loginRoute);
                  }
              )
            ]
        ),

      ),
    );
  }
}
