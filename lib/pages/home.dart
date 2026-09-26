import "package:cybersecurity_app/pages/encryption_page.dart";
import "package:cybersecurity_app/pages/hmac_page.dart";
import "package:cybersecurity_app/pages/miller_rabbin_page.dart";
import "package:cybersecurity_app/pages/password_page.dart";
import "package:cybersecurity_app/pages/prime_generator_page.dart";
import "package:cybersecurity_app/pages/random_page.dart";
import "package:cybersecurity_app/pages/tool_category_page.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 26, 18, 32),
        children: [
          Text(
            "Welcome to CyberSec",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          _categoryCard(
            context,
            title: "Interactive\nCryptography Tools",
            icon: Icons.lock_outline,
            tools: [
              ToolOption(
                title: "Text Encryption/\nDecryption",
                icon: Icons.lock,
                page: const EncryptionPage(),
              ),
              ToolOption(
                title: "Message\nAuthentication",
                icon: Icons.verified_user,
                page: const HmacPage(),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _categoryCard(
            context,
            title: "Number Theory &\nKey Generation",
            icon: Icons.calculate_outlined,
            tools: [
              ToolOption(
                title: "Miller Rabbin\nTest",
                icon: Icons.calculate,
                page: const MillerRabbinPage(),
              ),
              ToolOption(
                title: "Generate Prime\nNumber",
                icon: Icons.numbers,
                page: const PrimeGeneratorPage(),
              ),
              ToolOption(
                title: "Pseudo Random\nNumber",
                icon: Icons.shuffle,
                page: const RandomPage(),
              ),
            ],
          ),
          const SizedBox(height: 18),
          _categoryCard(
            context,
            title: "Password Security\nToolkit",
            icon: Icons.password,
            tools: [
              ToolOption(
                title: "Password Generator\n& Strength",
                icon: Icons.password,
                page: const PasswordPage(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _categoryCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required List<ToolOption> tools,
  }) {
    return Material(
      color: Colors.red.shade700,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.of(context).push(
            CupertinoPageRoute(
              builder:
                  (_) => ToolCategoryPage(
                    title: title.replaceAll("\n", " "),
                    icon: icon,
                    tools: tools,
                  ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Row(
            children: [
              Icon(icon, color: Colors.white, size: 34),
              const SizedBox(width: 18),
              Expanded(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, color: Colors.white70),
            ],
          ),
        ),
      ),
    );
  }
}
