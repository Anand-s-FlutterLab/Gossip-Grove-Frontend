import 'package:gossip_grove/core/app_export.dart';
import 'package:gossip_grove/core/utils/regx_validation.dart';
import 'package:gossip_grove/providers/chat_provider.dart';
import 'package:gossip_grove/providers/login_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    final chatProvider = Provider.of<ChatProvider>(context);
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
                      )),
                  Positioned(
                    child: Container(
                      margin: EdgeInsets.only(top: getSize(50)),
                      child: Center(
                        child: customTitleText(
                          text: "Login",
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
                key: loginProvider.loginFormKey,
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
                              controller: loginProvider.emailController,
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
                            child: TextFormField(
                              controller: loginProvider.passwordController,
                              obscureText: loginProvider.obscureText,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () => loginProvider.obscureTextToggle(),
                                  child: Icon(
                                    loginProvider.obscureText
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: GrayColor.gray,
                                  ),
                                ),
                                border: InputBorder.none,
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please provide Password';
                                }
                                if (!passwordValidator.hasMatch(value)) {
                                  return 'Enter Valid Password';
                                }
                                return null;
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getVerticalSize(30),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (loginProvider.loginFormKey.currentState!
                            .validate()) {
                          loginProvider.onLogin(context: context);
                        }
                      },
                      child: Container(
                        height: getVerticalSize(50),
                        decoration: AppDecoration.containerBoxDecoration(),
                        child: Center(
                          child: loginProvider.isLoginPressed
                              ? customButtonLoadingAnimation(
                                  size: 50,
                                )
                              : customText(
                                  text: "Login",
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
                          text: "Doesn't have an account yet?",
                          fontSize: getFontSize(20),
                          fontWeight: FontWeight.w500,
                        ),
                        GestureDetector(
                          onTap: () {
                            context.goNamed("signup");
                          },
                          child: customText(
                              text: "Create Account",
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
