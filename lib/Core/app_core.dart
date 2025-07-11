// Model
export 'package:workforce/Features/Authentication/Model/user_model.dart';
export 'package:workforce/Features/Authentication/Model/otp_model.dart';

// View
export 'package:workforce/Features/Onboarding/View/splash.dart';
export 'package:workforce/Features/Authentication/View/welcome.dart';
export 'package:workforce/Features/Onboarding/View/onboarding.dart';
export 'package:workforce/Features/Authentication/View/login.dart';
export 'package:workforce/Features/Authentication/View/sign_up.dart';
export 'package:workforce/Features/Authentication/View/forgot_pass.dart';
export 'package:workforce/Features/Authentication/View/verification.dart';
export 'package:workforce/Features/Admin/View/admin_dashboard.dart';

// Controller
export 'package:workforce/Features/Onboarding/Controller/controller.dart';
export 'package:workforce/shared/Controllers/pass_controller.dart';
export 'package:workforce/Features/Authentication/Controller/auth_controller.dart';
export 'package:workforce/Features/Authentication/Controller/otp_controller.dart';

// Service
export 'package:workforce/Features/Authentication/Service/auth_service.dart';
export 'package:workforce/Features/Authentication/Service/email_service.dart';
export 'package:workforce/Features/Authentication/Service/otp_service.dart';

// Component
export 'package:workforce/Features/Onboarding/component/onboarding_widget.dart';

// Custom Widget
export 'package:workforce/shared/Widgets/secondary_btn.dart';
export 'package:workforce/shared/Widgets/navigation_btn.dart';
export 'package:workforce/shared/Widgets/social_btn.dart';
export 'package:workforce/shared/Widgets/primary_btn.dart';
export 'package:workforce/shared/Widgets/textfield.dart';
export 'package:workforce/shared/Widgets/dialogs/success_dialog.dart';

// Utils
export 'package:workforce/shared/utils/app_text_styles.dart';
export 'package:workforce/shared/utils/app_colors.dart';
export 'package:workforce/shared/utils/firebase_error.dart';
export 'package:workforce/shared/Bindings/initial_binding.dart';
export 'package:workforce/shared/utils/app_validators.dart';
export 'package:workforce/Features/Authentication/Controller/otp_utils.dart';

// Core Libraries
export 'package:firebase_core/firebase_core.dart';
export 'package:flutter/material.dart';
export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:get/get.dart';
export 'package:workforce/firebase_options.dart';
export 'package:lottie/lottie.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';
export 'package:smooth_page_indicator/smooth_page_indicator.dart';
export 'package:firebase_auth/firebase_auth.dart';
export 'package:pin_code_fields/pin_code_fields.dart';
export 'package:cloud_firestore/cloud_firestore.dart';
