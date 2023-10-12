import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/core/utils/regx_validation.dart';
import 'package:gossip_grove/providers/signup_provider.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final signupProvider = Provider.of<SignupProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: getVerticalSize(380),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(LoginImages.background),
                      fit: BoxFit.fill)),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    left: getSize(30),
                    width: getHorizontalSize(80),
                    height: getVerticalSize(195),
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(LoginImages.light1))),
                    ),
                  ),
                  Positioned(
                    left: getSize(140),
                    width: getHorizontalSize(80),
                    height: getVerticalSize(145),
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(LoginImages.light2))),
                    ),
                  ),
                  Positioned(
                    right: getSize(40),
                    top: getSize(40),
                    width: getHorizontalSize(80),
                    height: getVerticalSize(145),
                    child: Container(
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(LoginImages.clock))),
                    ),
                  ),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: getSize(50)),
                      child: Center(
                        child: customTitleText(
                          text: "Signup",
                          color: WhiteColor.white,
                          fontSize: getFontSize(50),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(getSize(30)),
              child: Form(
                key: signupProvider.signupFormKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(getSize(5)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 20.0,
                                offset: Offset(0, 10))
                          ]),
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(getSize(8.0)),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100))),
                            child: TextFormField(
                              controller: signupProvider.usernameController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Username",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Provider Username';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(getSize(8.0)),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100))),
                            child: TextFormField(
                              controller: signupProvider.emailController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Email",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please provide an Email Address';
                                }
                                if (!emailValidator.hasMatch(value)) {
                                  return 'Enter Valid Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(getSize(8.0)),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100))),
                            child: TextFormField(
                              controller: signupProvider.phoneNumberController,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: "Phone Number",
                                hintStyle: TextStyle(color: Colors.grey[400]),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Provide Phone number';
                                }
                                if (!phoneValidator.hasMatch(value)) {
                                  return 'Enter Valid Password';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(getSize(8.0)),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade100))),
                            child: TextFormField(
                              controller: signupProvider.passwordController,
                              obscureText: signupProvider.obscureText,
                              decoration: InputDecoration(
                                  suffixIcon: GestureDetector(
                                    onTap: () =>
                                        signupProvider.obscureTextToggle(),
                                    child: Icon(
                                      signupProvider.obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                  hintText: "Password",
                                  hintStyle:
                                      TextStyle(color: Colors.grey[400])),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getVerticalSize(30),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (signupProvider.signupFormKey.currentState!
                            .validate()) {
                          signupProvider.onSignup(context: context);
                        }
                      },
                      child: Container(
                        height: getVerticalSize(50),
                        decoration: AppDecoration.containerBoxDecoration(),
                        child: Center(
                          child: signupProvider.isSignupPressed
                              ? customButtonLoadingAnimation(
                                  size: 30,
                                )
                              : customText(
                                  text: "Signup",
                                  color: WhiteColor.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: getFontSize(23),
                                ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getVerticalSize(30),
                    ),
                    Column(
                      children: [
                        customText(
                          text: "Already a User?",
                          fontSize: getFontSize(20),
                          fontWeight: FontWeight.w500,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.goNamed("login");
                          },
                          child: customText(
                              text: "Log in",
                              fontSize: getFontSize(20),
                              fontWeight: FontWeight.w500,
                              color: BlueColor.brightBlue),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
