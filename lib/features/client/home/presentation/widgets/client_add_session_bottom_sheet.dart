import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/error_handling/failures.dart';
import 'package:flutter_projects/core/extensions/localization_helper.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/features/home/presentation/manager/provider/user_data_provider/user_data_provider.dart';
import 'package:flutter_projects/features/reusable_components/buttons/action_button.dart';
import 'package:flutter_projects/features/reusable_components/input_text_field.dart';
import 'package:flutter_projects/features/reusable_components/toasts/error_toast.dart';
import 'package:flutter_projects/features/reusable_components/toasts/success_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/shared/no_context_localization.dart';
import '../manager/client_add_session_provider/client_add_session_provider.dart';

class ClientAddSessionBottomSheet extends StatefulWidget {
  const ClientAddSessionBottomSheet({Key? key}) : super(key: key);

  @override
  State<ClientAddSessionBottomSheet> createState() => _ClientAddSessionBottomSheetState();
}

class _ClientAddSessionBottomSheetState extends State<ClientAddSessionBottomSheet> {
  final TextEditingController _sessionNameController = TextEditingController();
  final TextEditingController _sessionPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _sessionNameController.dispose();
    _sessionPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, size) {
        final double width = size.maxWidth;
        final double height = size.maxHeight;

        return Scaffold(
          resizeToAvoidBottomInset: true,

          body: Form(
            key: _formKey,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 14.w,
                  right: 14.w,
                ),
                child: SizedBox(
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _BuildTitle(context.localization.sessionName),

                         InputTextField(
                              validator: (sessionName) {
                                if(sessionName == null || sessionName.isEmpty) {
                                  return noContextLocalization().sessionNameIsEmptyError;
                                }else if(sessionName.length>=30) {
                                  return noContextLocalization().sessionNameLengthError(30);
                                }
                                return null;
                              },
                              controller: _sessionNameController,
                              textInputAction: TextInputAction.next,
                              borderRadius: 6.r,
                              width: width,
                            ),

                        _BuildTitle(context.localization.sessionPassword,),

                        InputTextField(
                          validator: (password) {
                            if(password == null || password.isEmpty) {
                              return noContextLocalization().sessionPasswordIsEmptyError;
                            }else if(password.length < 6) {
                              return noContextLocalization().sessionPasswordLengthError(6);
                            }

                            return null;
                          },
                          controller: _sessionPasswordController,
                          textInputAction: TextInputAction.next,
                          borderRadius: 6.r,
                          width: width,
                        ),

                        SizedBox(height: 20.h,),
                        Consumer(
                          builder: (context, ref, child) {
                            final clientAddSessionState = ref.watch(clientAddSessionProvider);

                            ref.listen(clientAddSessionProvider, (previous, current) {
                              if(current is ClientAddSessionError){
                                if(current.failure is! DataAlreadyExistFailure){
                                  showErrorToast(current.failure.message);
                                }
                              }else if (current is ClientAddSessionDone){
                                showSuccessToast("Session Added Successfully");//todo:localization
                              }
                            });

                            return ActionButton(
                                width: width,
                                height: height*0.142,
                                title: context.localization.addSession,
                                isLoading: clientAddSessionState is ClientAddSessionLoading,
                                onTap: () async{
                                  if(_formKey.currentState!.validate()){

                                    await ref.read(clientAddSessionProvider.notifier).addSession(
                                      sessionPassword: _sessionPasswordController.text.trim(),
                                      sessionName: _sessionNameController.text.trim(),
                                      clientId: ref.read(userDataProvider.notifier).userModel!.id!
                                    );

                                  }
                                }
                            );
                          },
                        ),

                        SizedBox(height: 14.h,),

                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),

        );
      },

    );
  }
}

class _BuildTitle extends StatelessWidget {
  final String title;
  const _BuildTitle(this.title,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: 20.w,
          bottom: 5.h
      ),
      child: Text(
        title,
        style: context.textTheme.titleMedium,
      ),
    );
  }
}

