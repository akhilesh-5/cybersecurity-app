import "dart:convert";

import "package:crypto/crypto.dart";
import "package:cybersecurity_app/components/base_page.dart";
import "package:cybersecurity_app/components/custom_button.dart";
import "package:cybersecurity_app/components/custom_dialog.dart";
import "package:cybersecurity_app/components/custom_text_field.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class HmacPage extends StatefulWidget {
  const HmacPage({super.key});
  @override
  State<HmacPage> createState() => _HmacPageState();
}

class _HmacPageState extends State<HmacPage> {
  final message = TextEditingController();
  final key = TextEditingController();
  final hmac = TextEditingController();
  final verify = TextEditingController();
  String? result;

  @override
  void dispose() {
    message.dispose();
    key.dispose();
    hmac.dispose();
    verify.dispose();
    super.dispose();
  }

  String calculate() =>
      Hmac(
        sha256,
        utf8.encode(key.text),
      ).convert(utf8.encode(message.text)).toString();

  @override
  Widget build(BuildContext context) => BasePage(
    title: "Message Authentication",
    dialog: const CustomDialog(
      title: "What is Message Authentication?",
      body:
          "A HMAC proves that a message was created by someone who knows the shared secret key and that it was not changed in transit.",
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CustomTextField(label: "Message", controller: message, isNum: false),
          CustomTextField(label: "Key", controller: key),
          CustomButton(
            label: "Generate HMAC",
            onPress:
                () => setState(() {
                  hmac.text = calculate();
                  result = null;
                }),
          ),
          const SizedBox(height: 20),
          CustomTextField(
            label: "HMAC",
            controller: hmac,
            readOnly: true,
            isNum: false,
          ),
          const Divider(color: Colors.white24, height: 35),
          CustomTextField(
            label: "HMAC to verify",
            controller: verify,
            isNum: false,
          ),
          CustomButton(
            label: "Verify",
            onPress:
                () => setState(() {
                  result =
                      verify.text.trim() == calculate()
                          ? "Message is authentic and unchanged."
                          : "Verification failed. The message or key may be incorrect.";
                }),
          ),
          if (result != null)
            Padding(
              padding: const EdgeInsets.only(top: 18),
              child: Text(
                result!,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color:
                      result!.startsWith("Message")
                          ? Colors.greenAccent
                          : Colors.redAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
