import 'package:flutter/material.dart';
import 'package:bip39/bip39.dart' as bip39;

import 'package:kira_auth/utils/colors.dart';
import 'package:kira_auth/utils/strings.dart';
import 'package:kira_auth/widgets/appbar_wrapper.dart';
import 'package:kira_auth/widgets/custom_button.dart';
import 'package:kira_auth/widgets/app_text_field.dart';

class SeedBackupScreen extends StatefulWidget {
  final String encryptedSeed;

  SeedBackupScreen({this.encryptedSeed}) : super();

  @override
  _SeedBackupScreenState createState() => _SeedBackupScreenState();
}

class _SeedBackupScreenState extends State<SeedBackupScreen> {
  String _mnemonic;
  bool _showMnemonic;
  List<String> wordList;

  FocusNode seedPhraseNode;
  TextEditingController seedPhraseController;

  // print(NanoSeeds.generateSeed());

  @override
  void initState() {
    super.initState();
    this._showMnemonic = true;
    this._mnemonic = bip39.generateMnemonic();
    this.wordList = _mnemonic.split(' ');

    this.seedPhraseNode = FocusNode();
    this.seedPhraseController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: AppbarWrapper(
            childWidget: Container(
          padding: const EdgeInsets.all(30.0),
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              addHeadText(),
              addSeedPhrase(),
              addMnemonic(),
              addCreateNewAccount(),
              addGoBackButton(),
            ],
          )),
        )));
  }

  Widget addHeadText() {
    return Container(
        margin: EdgeInsets.only(bottom: 50),
        child: Text(
          Strings.seedPhrase,
          style: TextStyle(color: KiraColors.kPrimaryColor, fontSize: 30),
        ));
  }

  Widget addMnemonic() {}

  Widget addSeedPhrase() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  decoration: BoxDecoration(
                      border:
                          Border.all(width: 2, color: KiraColors.kPrimaryColor),
                      color: KiraColors.kPrimaryLightColor,
                      borderRadius: BorderRadius.circular(25)),
                  child: AppTextField(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    focusNode: seedPhraseNode,
                    controller: seedPhraseController..text = _mnemonic,
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    autocorrect: false,
                    onChanged: (String newText) {},
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20.0,
                        color: KiraColors.kBrownColor,
                        fontFamily: 'NunitoSans'),
                  ),
                )
              ],
            ),
          ],
        ));
  }

  Widget addCreateNewAccount() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.22,
        margin: EdgeInsets.only(bottom: 30),
        child: CustomButton(
          key: Key('create_account'),
          text: Strings.createAccount,
          height: 44.0,
          onPressed: () async {
            print("Create New Account");
          },
          backgroundColor: KiraColors.kPrimaryColor,
        ));
  }

  Widget addGoBackButton() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.22,
        margin: EdgeInsets.only(bottom: 30),
        child: CustomButton(
          key: Key('go_back'),
          text: Strings.back,
          height: 44.0,
          onPressed: () {
            Navigator.of(context).pop();
          },
          backgroundColor: KiraColors.kPrimaryColor,
        ));
  }
}
