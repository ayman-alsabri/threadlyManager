import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:statistics_maneger/auth_screen/providers/auth.dart';
import 'package:statistics_maneger/main_screen/providers/work_data.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});
  static const route = 'auth/screen';

  @override
  State<AuthScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthScreen> with TickerProviderStateMixin {
  var _isLogin = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _autovalidateMode = AutovalidateMode.disabled;
  var _isLoading = false;

  final Map<String, String?> _userData = {
    'name': null,
    'shopName': null,
    'password': null
  };

  late final AnimationController _controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 200));
  late final Animation<double> _opacity = Tween<double>(begin: 1, end: 0)
      .animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  final _passwordController = TextEditingController();

  late final imageColor =
      theme.brightness == Brightness.light ? 'black' : 'white';
  late final theme = WorkData.currenTheme;
  final int delayMilliseconds = 500;
  late final _auth = Provider.of<Auth>(context, listen: false);

  void _toggleLoginSignup() async {
    await _controller.forward();
    setState(() {
      _isLogin = !_isLogin;
    });
    await _controller.reverse();
  }

  Future<void> _submit() async {
      String message = 'an error occured';
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      FocusManager.instance.primaryFocus?.unfocus();
      _passwordController.clear();

      try {
        if (!_isLogin) {
          setState(() {
            _isLoading = true;
          });
            await _auth.signup(_userData);
          
        }
        if (_isLogin) {
          setState(() {
            _isLoading = true;
          });
          await _auth.login(_userData);
        }
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'email-already-in-use':
            message = 'name is already in use';
            break;
          case 'credential-already-in-use':
            message = 'name is already in use';
            break;
          case 'account-exists-with-different-credential':
            message = 'name is already in use';
            break;
          case 'invalid-credential':
            message = 'invalid name or password';
            break;
          case 'invalid-email':
            message = 'name or id is badly formmated,please rewrite it correctly';
            break;
          default:
            'an error occured';
        }
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.tr)));
      } catch (er) {
        message = er.toString().replaceAll('Exception: ', '');
        if (!mounted) return;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message.tr)));
      }
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      return;
    }
    _autovalidateMode = AutovalidateMode.always;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Animate(
        autoPlay: true,
        child: Container(
          constraints: BoxConstraints(maxHeight: size.height),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: <Color>[
                ...theme.brightness == Brightness.light
                    ? [theme.colorScheme.onPrimary, theme.colorScheme.tertiary]
                    : [
                        theme.colorScheme.onSecondary,
                        theme.colorScheme.tertiary
                      ]
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: size.height * 0.07),
              FadeTransition(
                opacity: _opacity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                  child: SizedBox(
                    width: size.height * 0.1,
                    child: FittedBox(
                      alignment: AlignmentDirectional.centerStart,
                      fit: BoxFit.scaleDown,
                      child: Text(
                        textAlign: TextAlign.start,
                        _isLogin ? 'login'.tr : 'signup'.tr,
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSecondary),
                      ),
                    ),
                  ),
                ).animate(
                  delay: Duration(milliseconds: delayMilliseconds + 100),
                  effects: [
                    const FadeEffect(),
                    const MoveEffect(begin: Offset(-50, 0)),
                  ],
                ),
              ),
              FadeTransition(
                opacity: _opacity,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.07),
                  child: Text(
                    textAlign: TextAlign.start,
                    _isLogin ? 'welcome back'.tr : 'welcome'.tr,
                    style: TextStyle(
                        fontSize: 23, color: theme.colorScheme.onSecondary),
                  ),
                ).animate(
                  delay: Duration(milliseconds: delayMilliseconds + 400),
                  effects: [
                    const FadeEffect(),
                    const MoveEffect(begin: Offset(-50, 0)),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/images/stitches-$imageColor.png'),
                            fit: BoxFit.fill),
                        color: theme.scaffoldBackgroundColor.withOpacity(0.8),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50)),
                      ),
                      margin: EdgeInsets.only(left: size.width * 0.12),
                      padding: const EdgeInsets.only(left: 10, top: 10),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: FadeTransition(
                          opacity: _opacity,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      minHeight: size.height * 0.2),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20)),
                                    color: theme.scaffoldBackgroundColor,
                                    boxShadow: [
                                      BoxShadow(
                                          color: theme.colorScheme.primary
                                              .withOpacity(0.3),
                                          blurRadius: 10,
                                          offset: const Offset(0, 10)),
                                      BoxShadow(
                                        color: theme.colorScheme.tertiary
                                            .withOpacity(0.3),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                  margin: EdgeInsets.only(
                                      left: size.width * 0.08,
                                      right: size.width * 0.08,
                                      top: size.width * 0.08),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 6),
                                  child: Form(
                                    key: _formKey,
                                    autovalidateMode: _autovalidateMode,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      // mainAxisAlignment:
                                      //     MainAxisAlignment.spaceAround,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: TextFormField(
                                            key: UniqueKey(),
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              hintText: 'name'.tr,
                                              hintStyle: TextStyle(
                                                  color: theme.disabledColor),
                                            ),
                                            keyboardType: TextInputType.name,
                                            textInputAction:
                                                TextInputAction.next,
                                            textCapitalization:
                                                TextCapitalization.words,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please write your name'
                                                    .tr;
                                              }
                                              if (value.length < 2) {
                                                return 'please write your full name'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            onSaved: (newValue) {
                                              _userData['name'] = newValue!
                                                  .trim()
                                                  .replaceAll(' ', '_');
                                            },
                                          ),
                                        ),
                                        if (!_isLogin)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: TextFormField(
                                              key: UniqueKey(),
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                hintText: 'shop name'.tr,
                                                hintStyle: TextStyle(
                                                    color: theme.disabledColor),
                                              ),
                                              keyboardType:
                                                  TextInputType.number,
                                              textInputAction:
                                                  TextInputAction.next,
                                              textCapitalization:
                                                  TextCapitalization.none,
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'please write the shop name'
                                                      .tr;
                                                }
                                                if (value.length < 3) {
                                                  return 'shop name is short'
                                                      .tr;
                                                }
                                                return null;
                                              },
                                              onSaved: (newValue) {
                                                _userData['shopName'] =
                                                    newValue!
                                                        .trim()
                                                        .replaceAll(' ', '_');
                                              },
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 4),
                                          child: TextFormField(
                                            key: UniqueKey(),
                                            controller: _passwordController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          30)),
                                              hintText: 'password'.tr,
                                              hintStyle: TextStyle(
                                                  color: theme.disabledColor),
                                            ),
                                            keyboardType: TextInputType.text,
                                            textInputAction: _isLogin
                                                ? TextInputAction.done
                                                : TextInputAction.next,
                                            onEditingComplete:
                                                _isLogin ? _submit : null,
                                            obscureText: true,
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'please write a password'
                                                    .tr;
                                              }
                                              if (value.length < 8) {
                                                return 'please write a longer password'
                                                    .tr;
                                              }
                                              return null;
                                            },
                                            onSaved: (newValue) {
                                              _userData['password'] =
                                                  newValue!.trim();
                                            },
                                          ),
                                        ),
                                        if (!_isLogin)
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4),
                                            child: TextFormField(
                                              key: UniqueKey(),
                                              decoration: InputDecoration(
                                                  border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30)),
                                                  hintText:
                                                      'confirm password'.tr,
                                                  hintStyle: TextStyle(
                                                      color:
                                                          theme.disabledColor)),
                                              keyboardType: TextInputType.text,
                                              textInputAction:
                                                  TextInputAction.done,
                                              obscureText: true,
                                              onTapOutside: (event) {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              onEditingComplete: _submit,
                                              validator: (value) {
                                                if (value! !=
                                                    _passwordController.text) {
                                                  return 'password doesn\'t match'
                                                      .tr;
                                                }

                                                return null;
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ).animate(
                                  delay: Duration(
                                      milliseconds: delayMilliseconds + 300),
                                  effects: [
                                    const FadeEffect(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextButton(
                                  onPressed: _toggleLoginSignup,
                                  child: Text(_isLogin
                                      ? 'create an account'.tr
                                      : 'already have an account'.tr),
                                ).animate(
                                  delay: Duration(
                                      milliseconds: delayMilliseconds + 400),
                                  effects: [
                                    const FadeEffect(),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                _isLoading
                                    ? const CircularProgressIndicator()
                                    : ElevatedButton(
                                        onPressed: _submit,
                                        style: ButtonStyle(
                                            fixedSize: MaterialStatePropertyAll(
                                                Size(size.width * 0.5,
                                                    double.minPositive)),
                                            backgroundColor:
                                                MaterialStatePropertyAll(
                                                    theme.colorScheme.primary),
                                            foregroundColor:
                                                MaterialStatePropertyAll(theme
                                                    .colorScheme.onPrimary)),
                                        child: Text(_isLogin
                                            ? 'login'.tr
                                            : 'signup'.tr),
                                      ).animate(
                                        delay: Duration(
                                            milliseconds:
                                                delayMilliseconds + 500),
                                        effects: [
                                          const FadeEffect(),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      height: size.height * 0.07,
                      top: -(size.height * 0.07),
                      right: 0,
                      child: Image.asset(
                        'assets/images/niddle-$imageColor.png',
                      ),
                    ).animate(
                      delay: Duration(milliseconds: delayMilliseconds + 500),
                      effects: [
                        FadeEffect(
                            duration: Duration(
                                milliseconds: delayMilliseconds + 1000)),
                        MoveEffect(
                            begin: Offset(-size.width, 0),
                            duration: Duration(
                                milliseconds: delayMilliseconds + 1000))
                      ],
                    ),
                    Positioned(
                      width: size.width * 0.24,
                      bottom: size.height * 0.1,
                      left: 0,
                      child: Image.asset(
                        'assets/images/scissors-$imageColor.png',
                      ),
                    ).animate(
                      delay: Duration(milliseconds: delayMilliseconds + 500),
                      effects: [
                        MoveEffect(
                            begin: Offset(0, size.height),
                            duration:
                                Duration(milliseconds: delayMilliseconds + 800))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
