# CyberSec

CyberSec is a Flutter application for learning cryptography and practical cybersecurity concepts through interactive tools. It combines a red-and-black educational UI with demonstrations of encryption, authentication, number theory, password security, and phishing awareness.

## Features

### Interactive Cryptography Tools

- **Text Encryption/Decryption:** Demonstrates AES-CBC encryption and decryption. A SHA-256-derived demonstration key is used, and the IV is packaged with the ciphertext as Base64.
- **Message Authentication:** Generates and verifies HMAC-SHA256 values to demonstrate integrity and shared-key authentication.

### Number Theory and Key Generation

- **Miller-Rabin Test:** Probabilistically tests whether an integer is prime using modular exponentiation and repeated witnesses.
- **Large Prime Generation:** Creates random odd candidates with a requested bit length and repeats the Miller-Rabin test until a candidate passes.
- **Pseudo-Random Number:** Generates a value inside a user-selected range and explains PRNG concepts.

### Password Security Toolkit

- **Password Generator:** Generates a local password from selected uppercase, lowercase, numeric, and special-character sets.
- **Password Strength Tester:** Checks length and character-class coverage and explains missing properties.

### Phishing Awareness

- **Phishing Detector:** A local educational screen that checks URL patterns such as lookalike names, suspicious login/verification tokens, URL shorteners, and plain HTTP.
- **Browser Extension Artifact:** `chrome_phishing_extension.crx` is included as a packaged extension artifact from the broader project.

The project presentation also documents a companion intelligent phishing architecture using:

- Character TF-IDF n-grams with Logistic Regression, Random Forest, SVM, and stacking.
- A fine-tuned `bert-base-uncased` model.
- WHOISJSON metadata such as registrar, domain age, and SSL validity.
- A hosted inference API consumed by a Chrome extension.

The current Flutter phishing page is a local rule-based educational demonstration; the training pipeline, model weights, and inference service are not part of this repository checkout.

## Running the app

Prerequisites:

- Flutter 3.47 or compatible stable Flutter
- Dart 3.7 or compatible Dart
- Chrome, Windows, Android, or another Flutter-supported target

From the repository root:

```powershell
flutter pub get
flutter run -d chrome
```

Other useful commands:

```powershell
flutter devices
flutter run -d windows
flutter analyze
flutter test
flutter build web
```

The web build is generated under `build/web`.

## Source layout

```text
lib/
  main.dart                         App theme and bottom navigation
  components/                       Shared page, dialog, button, and field widgets
  functions/                        Encryption, primality, and prime-generation logic
  pages/
    home.dart                       Three clickable tool categories
    tool_category_page.dart         Category-level tool grids
    encryption_page.dart            AES demonstration
    hmac_page.dart                  HMAC generation and verification
    miller_rabbin_page.dart         Primality-test UI
    prime_generator_page.dart       Large-prime UI
    random_page.dart                Random-number UI
    password_page.dart              Generator and strength tester
    phishing.dart                   Phishing-awareness UI
    about.dart                      Project overview
```

## Security note

These tools are educational demonstrations. They should not be used as a replacement for reviewed cryptographic systems or production phishing protection. Production work would require authenticated encryption, secure key management, password-specific hashing such as Argon2id or bcrypt, model monitoring, API security, and independent security review.

## Interview preparation

See [`INTERVIEW_PREPARATION.md`](INTERVIEW_PREPARATION.md) for:

- Complete project architecture and demo flow.
- Tool-by-tool implementation explanations.
- Laravel InkSpire preparation.
- ML/DL phishing architecture from the project presentation.
- Likely interview questions and technically accurate answers.

## License

This project is licensed under the MIT License. See [LICENSE](LICENSE).
