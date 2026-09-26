import "dart:math";

import "package:cybersecurity_app/components/base_page.dart";
import "package:cybersecurity_app/components/custom_button.dart";
import "package:cybersecurity_app/components/custom_dialog.dart";
import "package:cybersecurity_app/components/custom_text_field.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});
  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  final password = TextEditingController();
  final generated = TextEditingController();
  bool upper = true;
  bool lower = true;
  bool numbers = true;
  bool symbols = true;
  double length = 12;
  String? feedback;

  @override
  void dispose() {
    password.dispose();
    generated.dispose();
    super.dispose();
  }

  void generate() {
    var chars = "";
    if (upper) chars += "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    if (lower) chars += "abcdefghijklmnopqrstuvwxyz";
    if (numbers) chars += "0123456789";
    if (symbols) {
      chars += r"!@#$%^&*()-_=+";
    }
    if (chars.isEmpty) return;
    final random = Random.secure();
    generated.text =
        List.generate(
          length.round(),
          (_) => chars[random.nextInt(chars.length)],
        ).join();
    setState(() {});
  }

  void checkStrength() {
    final value = password.text;
    final missing = <String>[];
    if (!RegExp(r"[A-Z]").hasMatch(value)) missing.add("Upper Case");
    if (!RegExp(r"[a-z]").hasMatch(value)) missing.add("Lower Case");
    if (!RegExp(r"\d").hasMatch(value)) missing.add("Numbers");
    if (!RegExp(r"[^A-Za-z0-9]").hasMatch(value)) {
      missing.add("Special Characters");
    }
    setState(() {
      feedback =
          missing.isEmpty && value.length >= 12
              ? "Strong password"
              : "Does not contain ${missing.isEmpty ? "at least 12 characters" : missing.join(", ")}";
    });
  }

  @override
  Widget build(BuildContext context) => BasePage(
    title: "Password Utilities",
    dialog: const CustomDialog(
      title: "Password Security",
      body:
          "Use long, unique passwords and enable multi-factor authentication. The generator creates a demo password locally; never reuse generated examples in real accounts.",
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _heading("Password Generator"),
          _switchRow(
            "Include Upper Case",
            upper,
            (value) => setState(() => upper = value),
          ),
          _switchRow(
            "Include Lower Case",
            lower,
            (value) => setState(() => lower = value),
          ),
          _switchRow(
            "Include Numbers",
            numbers,
            (value) => setState(() => numbers = value),
          ),
          _switchRow(
            "Include Special Characters",
            symbols,
            (value) => setState(() => symbols = value),
          ),
          Text(
            "Length: ${length.round()}",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(color: Colors.white, fontSize: 17),
          ),
          Slider(
            value: length,
            min: 6,
            max: 32,
            divisions: 26,
            activeColor: Colors.redAccent,
            onChanged: (value) => setState(() => length = value),
          ),
          CustomButton(label: "Generate Password", onPress: generate),
          const SizedBox(height: 10),
          CustomTextField(
            label: "Generated Password",
            controller: generated,
            readOnly: true,
            isNum: false,
          ),
          const Divider(color: Colors.white24, height: 35),
          _heading("Password Strength Tester"),
          CustomTextField(
            label: "Password",
            controller: password,
            isNum: false,
          ),
          CustomButton(label: "Check Strength", onPress: checkStrength),
          if (feedback != null)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                feedback!,
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color:
                      feedback == "Strong password"
                          ? Colors.greenAccent
                          : Colors.redAccent,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    ),
  );

  Widget _heading(String value) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Text(
      value,
      style: GoogleFonts.nunito(
        color: Colors.white,
        fontSize: 23,
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    ),
  );

  Widget _switchRow(String label, bool value, ValueChanged<bool> onChanged) =>
      SwitchListTile(
        title: Text(label, style: GoogleFonts.nunito(color: Colors.white)),
        value: value,
        activeThumbColor: Colors.redAccent,
        onChanged: onChanged,
      );
}
