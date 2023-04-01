# Live Tracking App
Its an app to track devices, you can make sessions so the client join your session and start tracking him.

<h2>Tracking Preview</h2>
Used fake gps app to simulate device movement.

<p><video src='https://user-images.githubusercontent.com/40795940/229274091-ce87e36a-ad55-410b-9bd9-e64bad9ea1c1.mp4'></p>

<h2>UI</h2>
<p float="left">
  <img src="https://user-images.githubusercontent.com/40795940/229274573-7dcabe66-effd-41a2-a613-b052d6cab936.png" width="300" >
  <img src="https://user-images.githubusercontent.com/40795940/229274583-b808015a-2343-4239-a1f0-615b61e4d3d2.png" width="300">
  <img src="https://user-images.githubusercontent.com/40795940/229274574-62b68dfe-6570-407e-aafd-1ac0cd0eb5c4.png" width="300" >
</p>

<h2>Client</h2>
<p float="left">
  <img src="https://user-images.githubusercontent.com/40795940/229274577-2a3d5b80-2c49-44c6-b313-c8e24267b12b.png" width="300"> 
  <img src="https://user-images.githubusercontent.com/40795940/229274579-5b5aaa6b-e6aa-4700-8111-bd04206b9440.png" width="300">
  <img src="https://user-images.githubusercontent.com/40795940/229274580-305b9519-ccf7-48de-b8b5-78b571c7df7d.png" width="300" >
</p>

<h2>File Structure</h2>
<pre>
├── config
│   ├── app_routers.dart
│   ├── app_themes.dart
│   ├── initialize_app_services.dart
│   ├── providers.dart
│   └── type_def.dart
├── core
│   ├── constants
│   │   ├── app_colors.dart
│   │   ├── app_fonts.dart
│   │   ├── app_icons.dart
│   │   ├── app_images.dart
│   │   ├── app_lottie.dart
│   │   ├── app_routes.dart
│   │   ├── app_styles.dart
│   │   └── end_points.dart
│   ├── error_handling
│   │   ├── dio_errors.dart
│   │   ├── exceptions.dart
│   │   ├── failures.dart
│   │   ├── fb_auth_errors.dart
│   │   ├── geo_action_type.dart
│   │   └── validation.dart
│   ├── extensions
│   │   ├── localization_helper.dart
│   │   ├── mediaquery_size.dart
│   │   └── theme_helper.dart
│   ├── shared
│   │   ├── enums
│   │   │   ├── app_languages.dart
│   │   │   ├── session_state_enum.dart
│   │   │   ├── user_state.dart
│   │   │   └── user_type.dart
│   │   ├── models
│   │   │   ├── client_location_model.dart
│   │   │   ├── drawer_model.dart
│   │   │   ├── tracking_data_model.dart
│   │   │   └── user_model.dart
│   │   ├── providers
│   │   │   ├── drawer_items_provider
│   │   │   │   └── drawer_items_provider.dart
│   │   │   └── language_provider
│   │   │       ├── language_provider.dart
│   │   │       └── language_state.dart
│   │   └── no_context_localization.dart
│   └── utils
│       ├── connectivity_watcher.dart
│       ├── crypto_service.dart
│       ├── geo_service.dart
│       ├── network_checker.dart
│       ├── real_time_manager.dart
│       └── shared_pref_helper.dart
├── features
│   ├── auth
│   │   ├── data
│   │   │   ├── data_sources
│   │   │   │   ├── auth_remote.dart
│   │   │   │   ├── email_verification_remote.dart
│   │   │   │   └── reset_password_remote.dart
│   │   │   ├── models
│   │   │   └── repositories
│   │   │       ├── auth_repository.dart
│   │   │       ├── email_verification_repo.dart
│   │   │       └── reset_password_repo.dart
│   │   └── presentation
│   │       ├── manager
│   │       │   ├── check_email_verification_provider
│   │       │   │   ├── check_email_verification_provider.dart
│   │       │   │   └── check_email_verification_state.dart
│   │       │   ├── login_provider
│   │       │   │   ├── login_provider.dart
│   │       │   │   └── login_state.dart
│   │       │   ├── register_provider
│   │       │   │   ├── register_provider.dart
│   │       │   │   └── register_state.dart
│   │       │   ├── reset_password_provider
│   │       │   │   ├── reset_password_provider.dart
│   │       │   │   └── reset_password_state.dart
│   │       │   ├── send_email_verification_provider
│   │       │   │   ├── send_email_verification_provider.dart
│   │       │   │   └── send_email_verification_state.dart
│   │       │   ├── social_login_provider
│   │       │   │   ├── social_login_provider.dart
│   │       │   │   └── social_login_state.dart
│   │       │   └── user_type_provider
│   │       │       └── user_type_provider.dart
│   │       ├── pages
│   │       │   ├── decide_page.dart
│   │       │   ├── email_verification_check_page.dart
│   │       │   ├── forgot_password.dart
│   │       │   ├── login.dart
│   │       │   ├── register.dart
│   │       │   └── social_register_page.dart
│   │       └── widgets
│   │           ├── back_arrow.dart
│   │           ├── or_divider.dart
│   │           ├── social_buttons.dart
│   │           └── user_type_switcher.dart
│   ├── client
│   │   └── home
│   │       ├── data
│   │       │   ├── data_sources
│   │       │   │   ├── client_tracking_sessions_remote.dart
│   │       │   │   ├── tracker_data_remote.dart
│   │       │   │   └── update_location_remote.dart
│   │       │   ├── models
│   │       │   │   └── location_updater_model.dart
│   │       │   └── repositories
│   │       │       ├── client_tracking_sessions_repo.dart
│   │       │       ├── tracker_data_repo.dart
│   │       │       └── update_location_repo.dart
│   │       └── presentation
│   │           ├── manager
│   │           │   ├── client_add_session_provider
│   │           │   │   ├── client_add_session_provider.dart
│   │           │   │   └── client_add_session_state.dart
│   │           │   ├── client_tracking_sessions_provider
│   │           │   │   ├── client_tracking_sessions_provider.dart
│   │           │   │   └── client_tracking_sessions_state.dart
│   │           │   ├── location_updater_provider
│   │           │   │   └── location_updater_provider.dart
│   │           │   └── trackers_data_provider
│   │           │       └── trackers_data_provider.dart
│   │           ├── pages
│   │           │   └── client_home_page.dart
│   │           └── widgets
│   │               ├── client_add_session_bottom_sheet.dart
│   │               └── client_session_widget.dart
│   ├── home
│   │   ├── data
│   │   │   ├── data_sources
│   │   │   │   └── user_data_remote.dart
│   │   │   ├── models
│   │   │   └── repositories
│   │   │       └── user_data_repo.dart
│   │   └── presentation
│   │       ├── manager
│   │       │   └── provider
│   │       │       └── user_data_provider
│   │       │           ├── user_data_provider.dart
│   │       │           └── user_data_state.dart
│   │       ├── pages
│   │       │   └── home.dart
│   │       └── widgets
│   ├── map
│   │   ├── data
│   │   │   ├── data_sources
│   │   │   │   └── client_location_remote.dart
│   │   │   ├── models
│   │   │   └── repositories
│   │   │       └── client_location_repo.dart
│   │   └── presentation
│   │       ├── pages
│   │       │   └── map_page.dart
│   │       ├── provider
│   │       │   ├── client_location_provider
│   │       │   │   └── client_location_provider.dart
│   │       │   └── map_provider
│   │       │       ├── map_provider.dart
│   │       │       └── map_state.dart
│   │       └── widgets
│   ├── profile
│   │   ├── data
│   │   │   ├── data_sources
│   │   │   │   └── profile_user_remote.dart
│   │   │   ├── models
│   │   │   └── repositories
│   │   │       └── profile_user_repo.dart
│   │   └── presentation
│   │       ├── manager
│   │       │   ├── profile_user_provider.dart
│   │       │   └── profile_user_state.dart
│   │       ├── pages
│   │       │   └── profile_page.dart
│   │       └── widgets
│   ├── reusable_components
│   │   ├── buttons
│   │   │   ├── action_button.dart
│   │   │   ├── back_button_shadow_box.dart
│   │   │   └── double_back_to_exit.dart
│   │   ├── dialogs
│   │   │   ├── show_location_permission_dialog.dart
│   │   │   └── show_session_details_dialog.dart
│   │   ├── drawer
│   │   │   ├── drawer.dart
│   │   │   └── drawer_icon.dart
│   │   ├── toasts
│   │   │   ├── error_toast.dart
│   │   │   └── success_toast.dart
│   │   ├── input_text_field.dart
│   │   ├── phoneix.dart
│   │   ├── shimmer_loading_effect.dart
│   │   ├── status_snackbar.dart
│   │   └── user_network_imagee.dart
│   └── tracker
│       └── home
│           ├── data
│           │   ├── data_sources
│           │   │   ├── client_data_remote.dart
│           │   │   └── tracker_tracking_sessions_remote.dart
│           │   ├── models
│           │   │   └── quote_model.dart
│           │   └── repositories
│           │       ├── client_data_repo.dart
│           │       └── tracker_tracking_sessions_repo.dart
│           └── presentation
│               ├── manager
│               │   ├── client_data_provider
│               │   │   └── client_data_provider.dart
│               │   ├── tracker_add_session_provider
│               │   │   ├── tracker_add_session_provider.dart
│               │   │   └── tracker_add_session_state.dart
│               │   ├── tracker_session_actions_provider
│               │   │   ├── actions_waiting_list_provider.dart
│               │   │   ├── tracker_session_actions_provider.dart
│               │   │   └── tracker_session_actions_state.dart
│               │   └── tracker_tracking_sessions_provider
│               │       ├── tracker_tracking_sessions_provider.dart
│               │       └── tracker_tracking_sessions_state.dart
│               ├── pages
│               │   └── tracker_home_page.dart
│               └── widgets
│                   ├── session_details_widget.dart
│                   ├── tracker_add_session_bottom_sheet.dart
│                   ├── tracker_disabled_session_widget.dart
│                   └── tracker_enabled_session_widget.dart
├── l10n
│   ├── app_ar.arb
│   ├── app_en.arb
│   ├── app_localizations.dart
│   ├── app_localizations_ar.dart
│   └── app_localizations_en.dart
├── firebase_options.dart
└── main.dart
</pre>

