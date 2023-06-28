import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../shared/web_libs/htlm_functions.dart';
import 'c_icon_button.dart';

class Contacts extends StatelessWidget {
  const Contacts({super.key});

  void copyToClipboard(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(duration: Duration(milliseconds: 500), content: Text('Copiado para o clipboard !')));
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Focus(
        descendantsAreFocusable: false,
        canRequestFocus: false,
        child: Wrap(
          children: [
            CIconButton(
                onPressed: () {
                  openNewTab('https://www.linkedin.com/in/victor-carvalho-capanema-437387126/');
                },
                icon: Image.asset('images/linkedin.png'),
                tooltipText: 'Linkedin: Victor Carvalho Capanema'),
            CIconButton(
                onPressed: () {
                  openNewTab('https://github.com/victorcapanema/psiprontu');
                },
                icon: Image.asset('images/github.png'),
                tooltipText: 'GitHub: victorcapanema'),
            CIconButton(
                onPressed: () async {
                  await Clipboard.setData(const ClipboardData(text: 'carvalho.capanema@gmail.com'));
                  if (context.mounted) {
                    copyToClipboard(context);
                  }
                },
                icon: Image.asset('images/gmail.png'),
                tooltipText: 'E-mail: carvalho.capanema@gmail.com'),
            CIconButton(
                onPressed: () async {
                  await Clipboard.setData(const ClipboardData(text: '31997446813'));
                  if (context.mounted) {
                    copyToClipboard(context);
                  }
                  openNewTab('https://api.whatsapp.com/send/?phone=5531997446813&text=Ol%C3%A1');
                },
                icon: Image.asset('images/whatsapp.png'),
                tooltipText: 'Whatsapp: (31) 99744-6813'),
            CIconButton(
              icon: Image.asset('images/license.png'),
              size: 40,
              padding: EdgeInsets.zero,
              onPressed: () {
                openNewTab('https://creativecommons.org/licenses/by-nc-nd/4.0/');
              },
              tooltipText: 'Licença',
            ),
          ],
        ),
      ),
    );
  }
}
