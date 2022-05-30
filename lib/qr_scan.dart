import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_qr_code/app_barcode_scanner_widget.dart';
import 'package:flutter_web_qr_code/qr_content.dart';

const String password = 'password123';

final qrContentsProvider = StateProvider<QRContent>((ref) {
  return qrContentList[0];
});

final isScanedProvider = StateProvider<bool>((ref) {
  return false;
});

class QRScanPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isScaned = ref.watch(isScanedProvider.state).state;
    final QRContent qrContents = ref.watch(qrContentsProvider.state).state;
    final Size size = MediaQuery.of(context).size;
    double shortestSide = size.shortestSide;

    return Scaffold(
      appBar: AppBar(title: const Text('QRコード読み取り')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                ref.read(isScanedProvider.state).state =
                    false; //flagをfalseにして、読み取ったときの処理がストップしないようにする
              },
              child: const Text('読み取り開始')),
          !isScaned
              ? Padding(
                  padding: EdgeInsets.all(shortestSide * 0.05),
                  child: SizedBox(
                    width: shortestSide * 0.6,
                    height: shortestSide * 0.6,
                    child: BarcodeScannerWidget(
                      (String code) async {
                        if (isScaned) {
                          //ストップを掛けなければ永遠にカメラが止まらず、スキャンしてしまう。
                          //1度スキャンしたらflagをtrueにしてflagがtrueの場合は処理をストップする
                          return;
                        }
                        ref.read(isScanedProvider.state).state = true;
                        List<String> contents = code.split('-');
                        int qrId = int.parse(
                            contents[1]); //qrコードに埋め込まれたid(urlに設定したid)を取得
                        ref.read(qrContentsProvider.state).state = qrContentList[
                            qrId]; //取得したidのqrContentをqrContentListから取得してqrContentsProviderに渡す

                        if (contents.length <= 2 || contents[2] != password) {
                          //パスワードや、urlのバリデーションを設定することで、
                          //別のQRコードを読み取ったときにエラーページに行くようにする
                          await Navigator.of(context)
                              .pushNamed('/error', arguments: '無効なQRコードです');
                        }
                        await Navigator.of(context).pushNamed('/qr_detail');
                      },
                    ),
                  ),
                )
              : const Text('読み取り開始ボタンをクリックしてください')
        ],
      ),
    );
  }
}
