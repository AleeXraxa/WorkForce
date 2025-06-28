import 'package:workforce/Core/app_core.dart';
import 'package:workforce/Features/Admin/Controller/admin_controller.dart';
import 'package:workforce/shared/Widgets/drop_down.dart';

class AddUser extends StatefulWidget {
  const AddUser({super.key});

  @override
  State<AddUser> createState() => AddUserState();
}

class AddUserState extends State<AddUser> {
  final adminController = Get.find<AdminController>();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Text('Add New User'),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomField(
                          labelText: 'Username',
                          controller: adminController.usernameController,
                          validator: (val) => AppValidators.isRequired(val,
                              fieldName: "Username"),
                        ),
                        SizedBox(height: 0.01.sh),
                        CustomField(
                          labelText: 'First Name',
                          controller: adminController.firstNameController,
                          validator: (val) => AppValidators.isRequired(val,
                              fieldName: "First Name"),
                        ),
                        SizedBox(height: 0.01.sh),
                        CustomField(
                          labelText: 'Last Name',
                          controller: adminController.lastNameController,
                          validator: (val) => AppValidators.isRequired(val,
                              fieldName: "Last Name"),
                        ),
                        SizedBox(height: 0.01.sh),
                        Obx(() => CustomDropdownField<String>(
                              labelText: "Select Gender",
                              value:
                                  adminController.selectedGender.value.isEmpty
                                      ? null
                                      : adminController.selectedGender.value,
                              items: ["Male", "Female"]
                                  .map((gender) => DropdownMenuItem(
                                        value: gender,
                                        child: Text(gender),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) adminController.setGender(val);
                              },
                              prefix: FontAwesomeIcons.userTag,
                            )),
                        SizedBox(height: 0.01.sh),
                        CustomField(
                          labelText: 'Email',
                          controller: adminController.emailController,
                          validator: AppValidators.isEmail,
                        ),
                        SizedBox(height: 0.01.sh),
                        CustomField(
                          labelText: 'Mobile',
                          controller: adminController.mobileController,
                          validator: AppValidators.isPhone,
                        ),
                        SizedBox(height: 0.01.sh),
                        Obx(() => CustomDropdownField<String>(
                              labelText: "Select Role",
                              value: adminController.selectedRole.value.isEmpty
                                  ? null
                                  : adminController.selectedRole.value,
                              items: ["Admin", "Employee", "Client"]
                                  .map((role) => DropdownMenuItem(
                                        value: role,
                                        child: Text(role),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) adminController.setRole(val);
                              },
                              prefix: FontAwesomeIcons.userTag,
                            )),
                        SizedBox(height: 0.01.sh),
                        CustomField(
                          labelText: 'Date of Birth',
                          controller: adminController.dobController,
                          validator: (val) => AppValidators.isRequired(val,
                              fieldName: "Date of Birth"),
                        ),
                        SizedBox(height: 0.01.sh),
                        PrimaryBtn(
                          btnText: 'Add New User',
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              adminController.addNewUser();
                            }
                          },
                          bgColor: Appcolors.primaryColor,
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
