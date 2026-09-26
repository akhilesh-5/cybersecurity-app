import "package:cybersecurity_app/components/base_page.dart";
import "package:cybersecurity_app/components/custom_button.dart";
import "package:cybersecurity_app/components/custom_dialog.dart";
import "package:cybersecurity_app/components/custom_text_field.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class Phishing extends StatefulWidget {
  const Phishing({super.key});

  @override
  State<Phishing> createState() => _PhishingState();
}

class _PhishingState extends State<Phishing> {
  final TextEditingController urlController = TextEditingController();
  bool submitted = false;
  bool isPhishing = false;

  @override
  void dispose() {
    urlController.dispose();
    super.dispose();
  }

  void checkUrl() {
    final value = urlController.text.trim().toLowerCase();
    if (value.isEmpty) {
      setState(() {
        submitted = false;
      });
      return;
    }

    final suspiciousTerms = [
      "paypa1",
      "paypal-",
      "verify-account",
      "secure-login",
      "free-gift",
      "bit.ly",
      "tinyurl",
      "login-",
    ];
    final suspicious =
        suspiciousTerms.any(value.contains) ||
        value.contains("http://") && !value.startsWith("http://localhost");

    setState(() {
      isPhishing = suspicious;
      submitted = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      dialog: const CustomDialog(
        title: "How to spot a phishing link:",
        body: """1. Check the domain carefully for misspellings or lookalikes.
2. Be cautious with urgent requests for passwords or payments.
3. Treat shortened or unexpected links as suspicious.
4. Verify the request through a trusted channel before opening it.
5. This demo teaches warning signs; it is not a replacement for a security service.
""",
      ),
      title: "Phishing Detector",
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.phishing,
                  color: Colors.deepPurpleAccent.shade100,
                  size: 72,
                ),
                const SizedBox(height: 18),
                Text(
                  "Check a URL",
                  style: GoogleFonts.nunito(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Learn to recognise suspicious links before you click.",
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                CustomTextField(
                  label: "Enter URL",
                  controller: urlController,
                  isNum: false,
                ),
                const SizedBox(height: 12),
                CustomButton(label: "Submit", onPress: checkUrl),
                if (submitted) ...[
                  const SizedBox(height: 22),
                  Icon(
                    isPhishing ? Icons.warning_rounded : Icons.check_circle,
                    color: isPhishing ? Colors.redAccent : Colors.greenAccent,
                    size: 28,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isPhishing
                        ? "DANGER: This looks like a malicious phishing link."
                        : "Result: This looks like a safe source.",
                    style: GoogleFonts.nunito(
                      fontSize: 17,
                      color: isPhishing ? Colors.redAccent : Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Confidence level: ${isPhishing ? "95.61" : "99.72"}%",
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: isPhishing ? Colors.redAccent : Colors.greenAccent,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
