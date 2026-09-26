import "dart:math";

import "package:cybersecurity_app/components/base_page.dart";
import "package:cybersecurity_app/components/custom_button.dart";
import "package:cybersecurity_app/components/custom_dialog.dart";
import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class RandomPage extends StatefulWidget {
  const RandomPage({super.key});
  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  double min = 1;
  double max = 100;
  int? generated;

  @override
  Widget build(BuildContext context) => BasePage(
    title: "Random Number Generator",
    dialog: const CustomDialog(
      title: "Pseudo Random Number Generator",
      body:
          "A PRNG produces a sequence that appears random from an initial seed. This demo is useful for understanding ranges and deterministic algorithms; it is not a replacement for a cryptographic random source.",
    ),
    child: Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Text(
            "Minimum Value: ${min.round()}",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(fontSize: 18, color: Colors.white),
          ),
          Slider(
            value: min,
            min: 0,
            max: 99,
            divisions: 99,
            activeColor: Colors.redAccent,
            onChanged:
                (value) => setState(() {
                  min = value;
                  if (max < min) max = min;
                }),
          ),
          Text(
            "Maximum Value: ${max.round()}",
            textAlign: TextAlign.center,
            style: GoogleFonts.nunito(fontSize: 18, color: Colors.white),
          ),
          Slider(
            value: max,
            min: 1,
            max: 100,
            divisions: 99,
            activeColor: Colors.redAccent,
            onChanged:
                (value) => setState(() {
                  max = value;
                  if (min > max) min = max;
                }),
          ),
          const SizedBox(height: 20),
          CustomButton(
            label: "Generate Random Number",
            onPress:
                () => setState(
                  () =>
                      generated =
                          Random.secure().nextInt(
                            max.round() - min.round() + 1,
                          ) +
                          min.round(),
                ),
          ),
          if (generated != null)
            Padding(
              padding: const EdgeInsets.only(top: 22),
              child: Text(
                "Generated Random Number: $generated",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                  color: Colors.greenAccent,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
        ],
      ),
    ),
  );
}
