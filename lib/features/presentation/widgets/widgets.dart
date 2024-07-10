import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:gonana/consts.dart';
import 'package:get/get.dart' as getx;

class EnterText extends StatelessWidget {
  final String label;
  final String hint;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final TextInputType keyboardType;
  const EnterText({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                label,
                textAlign: TextAlign.left,
              ),
            )),
        TextField(
          onChanged: onChanged,
          controller: controller,
          keyboardType: keyboardType,
          autofocus: false,
          decoration: InputDecoration(
              border: const OutlineInputBorder(),
              focusedBorder:
                  OutlineInputBorder(borderSide: BorderSide(color: greenColor)),
              hintText: hint,
              hintStyle: const TextStyle(
                  color: Color(0xFF444444),
                  fontSize: 14,
                  fontWeight: FontWeight.w400)),
        ),
      ],
    );
  }
}

class EnterFormText extends StatelessWidget {
  final String label;
  final String hint;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  static String? defaultValidator(String? value) => null;
  final TextInputType keyboardType;
  const EnterFormText({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.onChanged,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveValidator = validator ?? defaultValidator;
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                label,
                textAlign: TextAlign.left,
              ),
            )),
        TextFormField(
          onChanged: onChanged,
          controller: controller,
          validator: effectiveValidator,
          keyboardType: keyboardType,
          autofocus: false,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hint,
            hintStyle: const TextStyle(
                color: Color(0xff444444),
                fontSize: 14,
                fontWeight: FontWeight.w400),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: greenColor)),
            errorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: redColor)),
            focusedErrorBorder:
                OutlineInputBorder(borderSide: BorderSide(color: greyColor)),
          ),
        ),
      ],
    );
  }
}

//Large Text Field
class EnterLargeText extends StatelessWidget {
  final String label;
  final String hint;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  static String? defaultValidator(String? value) => null;
  const EnterLargeText(
      {super.key,
      required this.label,
      required this.hint,
      required this.controller,
      this.onChanged,
      this.validator});

  @override
  Widget build(BuildContext context) {
    final effectiveValidator = validator ?? defaultValidator;
    return Container(
      // height: 200,
      child: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Text(
                  label,
                  textAlign: TextAlign.left,
                ),
              )),
          TextFormField(
            controller: controller,
            validator: effectiveValidator,
            onChanged: onChanged,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: greenColor)),
                hintText: hint,
                hintStyle: const TextStyle(
                    color: Color(0xff444444),
                    fontSize: 14,
                    fontWeight: FontWeight.w400)),
          ),
        ],
      ),
    );
  }
}

//Succesfully verfied pop up
class SuccesfulVerfication extends StatelessWidget {
  final String message;
  final VoidCallback onTap;
  const SuccesfulVerfication(
      {super.key, required this.message, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 198,
      width: 278,
      child: Column(children: [
        const Icon(Icons.check_circle_outline),
        Text(message),
        ShortGradientButton(title: 'Proceed', onPressed: onTap)
      ]),
    );
  }
}

//ClickHere Button without gradient
class ShortFlatButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const ShortFlatButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            minimumSize: const Size(185, 60),
            backgroundColor: const Color(0xff29844B)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(width: 10.0),
            const Icon(
              Icons.arrow_forward,
              color: Colors.white,
            ),
          ],
        ));
  }
}

//ClickHere Button White short
class ShortBorderButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget icon;
  const ShortBorderButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          side: const BorderSide(
            color: Color(0xff29844B),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(15, 60),
          backgroundColor: Colors.transparent),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: const TextStyle(color: Color(0xff29844B))),
          const SizedBox(width: 10.0),
          icon,
        ],
      ),
    );
  }
}

//Black Border Button
class BlackBorderButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const BlackBorderButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          elevation: 0,
          side: const BorderSide(
            color: Color(0xff000000),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(93, 33),
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent),
      child: Text(
        title,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

//ClickHere button with gradient
class ShortGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const ShortGradientButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 140,
      decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xff29844B), Color(0xff072C27)]),
          borderRadius: BorderRadius.circular(5)),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            minimumSize: const Size(185, 60),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                  child: Text(
                title,
                style: TextStyle(color: Colors.white),
              )),
              const SizedBox(width: 10.0),
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
            ],
          )),
    );
  }
}

class TinyButton extends StatelessWidget {
  final String title;
  final Color textColor;
  final VoidCallback onPressed;
  bool isLoading = false;
  bool borderColor = false;
  TinyButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.borderColor,
      required this.isLoading,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: borderColor ? Colors.redAccent : Color(0xff29844B)),
            borderRadius: BorderRadius.circular(15),
            color: borderColor ? Colors.transparent : Color(0xff29844B)),
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  title,
                  style: TextStyle(color: textColor),
                ),
        )),
      ),
    );
  }
}

//Long Border Buttton
class LongBorderButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const LongBorderButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xff29844B),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(342, 60),
          backgroundColor: const Color(0xFFFFFFFF)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 10.0),
          const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

//Login button with gradient
class LongGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final bool isLoading;
  const LongGradientButton(
      {super.key,
      required this.title,
      required this.onPressed,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: const LinearGradient(
            colors: [Color(0xff29844B), Color(0xff072C27)]),
      ),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: TextStyle(color: Colors.white),
                    ),
                    const SizedBox(width: 10.0),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                )),
    );
  }
}

class DialogGradientButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Gradient? color;
  final bool? isLoading;
  const DialogGradientButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.color,
    this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: color ??
              const LinearGradient(
                  colors: [Color(0xff29844B), Color(0xff072C27)])),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: isLoading ?? false
              ? const CircularProgressIndicator(color: Colors.white)
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                        child: Text(
                      title,
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    )),
                    const SizedBox(width: 10.0),
                    Flexible(
                        child: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    )),
                  ],
                )),
    );
  }
}

class DialogWhiteButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const DialogWhiteButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      // width: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
          border: Border.all(color: Color(0xff29844B))),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(color: Color(0xff29844B)),
              ),
              const SizedBox(width: 10.0),
              const Icon(
                Icons.arrow_forward,
                color: Color(0xff29844B),
              ),
            ],
          )),
    );
  }
}

class LongTransparentButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Icon? icon;
  const LongTransparentButton(
      {super.key, required this.title, required this.onPressed, this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 360,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: const Color(0xffFFFFFF))),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(width: 10.0),
              const Icon(Icons.arrow_forward, color: Colors.white),
            ],
          )),
    );
  }
}

//ClickHere Button long
class LongFlatButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  const LongFlatButton(
      {super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          side: const BorderSide(
            color: Color(0xff29844B),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          minimumSize: const Size(342, 60),
          backgroundColor: const Color(0xff29844B)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 10.0),
          const Icon(
            Icons.arrow_forward,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

//Toggle Switches
class CustomSwitch extends StatefulWidget {
  final VoidCallback onChanged;
  const CustomSwitch({super.key, required this.onChanged});

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      activeColor: const Color(0xffD9D9D9),
      activeTrackColor: const Color(0xff29844B),
      inactiveTrackColor: const Color(0xffD9D9D9),
      inactiveThumbColor: const Color(0xffffffff),
      value: _switchValue,
      onChanged: (value) {
        setState(() {
          _switchValue = value;
        });
      },
    );
  }
}

//Bottom Navigation
class BottomNavBarMarket extends StatelessWidget {
  const BottomNavBarMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 410,
      child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [Icon(Icons.shopping_bag_outlined), Text('Market')],
            ),
            Column(
              children: [Icon(Icons.account_balance_wallet), Text('Wallet')],
            ),
            Column(
              children: [Icon(Icons.book), Text('Feeds')],
            ),
            Column(
              children: [Icon(Icons.notifications), Text('Notifications')],
            ),
            Column(
              children: [Icon(Icons.settings), Text('Settings')],
            )
          ]),
    );
  }
}

//Bottom Navigation
class BottomNavBarAdd extends StatelessWidget {
  const BottomNavBarAdd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 410,
      child: Row(children: [
        const Column(
          children: [Icon(Icons.shopping_bag_outlined), Text('Market')],
        ),
        const Column(
          children: [Icon(Icons.account_balance_wallet), Text('Wallet')],
        ),
        Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: const Color(0xff29844B),
                borderRadius: BorderRadius.circular(5)),
            child: Center(
                child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ))),
        const Column(
          children: [Icon(Icons.notifications), Text('Notifications')],
        ),
        const Column(
          children: [Icon(Icons.settings), Text('Settings')],
        )
      ]),
    );
  }
}

Future<bool?> showNotif(String message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xffFFC500),
    textColor: const Color(0xff166922),
    fontSize: 14,
  );
}

Future<bool?> showfalseNotif(String message) {
  return Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: const Color(0xffFFEBEB),
    textColor: const Color(0xffD71B1B),
    fontSize: 14,
  );
}

class ErrorSnackbar {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: redColor,
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }
}

class SuccessSnackbar {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: greenColor,
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }
}

// successSnackBar({required String message}) {
//   getx.Get.showSnackbar(
//     getx.GetSnackBar(
//       message: message,
//       backgroundColor: greenColor,
//       padding: EdgeInsets.all(25),
//       margin: EdgeInsets.all(8),
//     ),
//   );
// }

class WarningSnackbar {
  static void show(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: yellowColor,
        padding: const EdgeInsets.all(25),
        margin: EdgeInsets.all(8),
        behavior: SnackBarBehavior.floating,
        content: Text(text),
      ),
    );
  }
}
