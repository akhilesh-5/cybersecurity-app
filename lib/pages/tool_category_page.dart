import "package:cybersecurity_app/components/base_page.dart";
import "package:cybersecurity_app/components/custom_dialog.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class ToolOption {
  const ToolOption({
    required this.title,
    required this.icon,
    required this.page,
  });

  final String title;
  final IconData icon;
  final Widget page;
}

class ToolCategoryPage extends StatelessWidget {
  const ToolCategoryPage({
    required this.title,
    required this.icon,
    required this.tools,
    super.key,
  });

  final String title;
  final IconData icon;
  final List<ToolOption> tools;

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: title,
      dialog: CustomDialog(
        title: title,
        body: "Choose a tool below to explore this CyberSec learning category.",
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: ListView(
          padding: const EdgeInsets.fromLTRB(18, 24, 18, 30),
          children: [
            Icon(icon, color: Colors.redAccent, size: 58),
            const SizedBox(height: 12),
            Text(
              "Choose a tool",
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 22),
            Wrap(
              spacing: 14,
              runSpacing: 14,
              alignment: WrapAlignment.center,
              children:
                  tools
                      .map(
                        (tool) => SizedBox(
                          width:
                              MediaQuery.of(context).size.width > 520
                                  ? 210
                                  : 145,
                          height: 130,
                          child: Material(
                            color: Colors.red.shade700,
                            borderRadius: BorderRadius.circular(9),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(9),
                              onTap:
                                  () => Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (_) => tool.page,
                                    ),
                                  ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    tool.icon,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    tool.title,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.nunito(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
