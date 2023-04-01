import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_projects/core/error_handling/failures.dart';
import 'package:flutter_projects/core/extensions/localization_helper.dart';
import 'package:flutter_projects/core/extensions/theme_helper.dart';
import 'package:flutter_projects/core/shared/enums/session_state_enum.dart';
import 'package:flutter_projects/core/shared/models/tracking_data_model.dart';
import 'package:flutter_projects/features/home/presentation/manager/provider/user_data_provider/user_data_provider.dart';
import 'package:flutter_projects/features/reusable_components/buttons/action_button.dart';
import 'package:flutter_projects/features/reusable_components/input_text_field.dart';
import 'package:flutter_projects/features/reusable_components/toasts/error_toast.dart';
import 'package:flutter_projects/features/reusable_components/toasts/success_toast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../../core/constants/app_icons.dart';
import '../../../../../core/shared/no_context_localization.dart';
import '../manager/tracker_add_session_provider/tracker_add_session_provider.dart';

class TrackerAddSessionBottomSheet extends StatefulWidget {
  const TrackerAddSessionBottomSheet({Key? key}) : super(key: key);

  @override
  State<TrackerAddSessionBottomSheet> createState() => _TrackerAddSessionBottomSheetState();
}

class _TrackerAddSessionBottomSheetState extends State<TrackerAddSessionBottomSheet> {
  final TextEditingController _sessionNameController = TextEditingController();
  final TextEditingController _sessionPasswordController = TextEditingController();
  final TextEditingController _intervalsController = TextEditingController(text: '2.0');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _sessionNameController.dispose();
    _sessionPasswordController.dispose();
    _intervalsController.dispose();
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
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: SizedBox(
                  width: width,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _BuildTitle(context.localization.sessionName),

                        Consumer(
                          builder: (context, ref, child) {
                            final TrackerAddSessionError? trackerAddSessionError = ref.watch(trackerAddSessionProvider.select(
                              (value) => (value is TrackerAddSessionError)?value:null
                            ));

                            if(trackerAddSessionError != null){
                              if(trackerAddSessionError.failure is DataAlreadyExistFailure) {
                                WidgetsBinding.instance.addPostFrameCallback((_) {
                                  _formKey.currentState!.validate();
                                  ref.read(trackerAddSessionProvider.notifier).refreshState();
                                });
                              }
                            }

                            return InputTextField(
                              validator: (sessionName) {
                                if(trackerAddSessionError != null){
                                  if(trackerAddSessionError.failure is DataAlreadyExistFailure){
                                    return trackerAddSessionError.failure.message;
                                  }
                                }

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
                            );
                          },

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

                        _BuildTitle(context.localization.intervals,),

                        SizedBox(
                          width: width*0.285,
                          height: height*0.14,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 9,
                                child: Consumer(
                                  builder: (context, ref, child) {
                                    ref.watch(_intervalsProvider);
                                    return InputTextField(
                                      isReadOnly: true,
                                      controller: _intervalsController,
                                      textInputAction: TextInputAction.done,
                                      borderRadius: 6.r,
                                      width: width*0.2,
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                ),
                              ),

                              SizedBox(width: 9.w,),

                              Expanded(
                                flex: 1,
                                child: IntervalIncDecControllers(
                                  intervalsController: _intervalsController,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 20.h,),
                        Consumer(
                          builder: (context, ref, child) {
                            final trackerAddSessionState = ref.watch(trackerAddSessionProvider);

                            ref.listen(trackerAddSessionProvider, (previous, current) {
                              if(current is TrackerAddSessionError){
                                if(current.failure is! DataAlreadyExistFailure){
                                  showErrorToast(current.failure.message);
                                }
                              }else if (current is TrackerAddSessionDone){
                                showSuccessToast("Session Added Successfully");//todo:localization
                              }
                            });

                            return ActionButton(
                                width: width,
                                height: height*0.118,
                                title: context.localization.addSession,
                                isLoading: trackerAddSessionState is TrackerAddSessionLoading,
                                onTap: () async{
                                  if(_formKey.currentState!.validate()){

                                    TrackingSessionModel trackingSessionModel = TrackingSessionModel(
                                        state: SessionState.disabled,
                                        sessionPassword: _sessionPasswordController.text.trim(),
                                        sessionName: _sessionNameController.text.trim(),
                                        interval: ref.read(_intervalsProvider),
                                        clientId: '',
                                        trackerId: ref.read(userDataProvider.notifier).userModel!.id!
                                    );

                                    await ref.read(trackerAddSessionProvider.notifier).addSession(trackingSessionModel);

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


final _intervalsProvider = StateProvider.autoDispose<double>((ref){
  return 2.0;
});


class IntervalIncDecControllers extends ConsumerStatefulWidget {
  final TextEditingController intervalsController;
  const IntervalIncDecControllers({Key? key, required this.intervalsController}) : super(key: key);

  @override
  ConsumerState createState() => _IntervalIncDecControllersState();
}

class _IntervalIncDecControllersState extends ConsumerState<IntervalIncDecControllers> {
  Timer? _timer;
  bool _longPressCanceled = false;

  void _increaseInterval() {
    final intervalValue = ref.read(_intervalsProvider.notifier);
    intervalValue.state++;
    widget.intervalsController.value = TextEditingValue(text: intervalValue.state.toString());
  }

  void _decreaseInterval() {
    final intervalValue = ref.read(_intervalsProvider.notifier);

    if(intervalValue.state > 1){
      intervalValue.state--;
      widget.intervalsController.value = TextEditingValue(text: intervalValue.state.toString());
    }
  }

  void _cancelLongPress() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _longPressCanceled = true;
  }

  @override
  void dispose() {
    _cancelLongPress();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: GestureDetector(
              onLongPress: () {
                _longPressCanceled = false;
                Future.delayed(const Duration(milliseconds: 250), () {
                  if (!_longPressCanceled) {
                    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
                      _increaseInterval();
                    });
                  }
                });
              },
              onLongPressEnd: (LongPressEndDetails longPressEndDetails) {
                _cancelLongPress();
              },
              onLongPressUp: () {
                _cancelLongPress();
              },
              onLongPressMoveUpdate: (LongPressMoveUpdateDetails longPressMoveUpdateDetails) {
                if (longPressMoveUpdateDetails.localOffsetFromOrigin.distance > 20) {
                  _cancelLongPress();
                }
              },

              onTap: (){
                _increaseInterval();
              },
              child: FittedBox(
                child: FaIcon(
                  AppIcons.arrowUpFa,
                  size: 18.r,
                ),
              ),
            ),
          ),

          Flexible(
            child: GestureDetector(
              onTap: (){
                _decreaseInterval();
              },
              onLongPress: () {
                _longPressCanceled = false;
                Future.delayed(const Duration(milliseconds: 250), () {
                  if (!_longPressCanceled) {
                    _timer = Timer.periodic(const Duration(milliseconds: 130), (timer) {
                      _decreaseInterval();
                    });
                  }
                });
              },
              onLongPressEnd: (LongPressEndDetails longPressEndDetails) {
                _cancelLongPress();
              },
              onLongPressUp: () {
                _cancelLongPress();
              },
              onLongPressMoveUpdate: (LongPressMoveUpdateDetails longPressMoveUpdateDetails) {
                if (longPressMoveUpdateDetails.localOffsetFromOrigin.distance > 20) {
                  _cancelLongPress();
                }
              },
              child: FittedBox(
                child: FaIcon(
                  AppIcons.arrowDownFa,
                  size: 18.r,
                ),
              ),
            ),
          ),

        ],
      ),
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

