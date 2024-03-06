import router from '@ohos.router';
import Logger from '../common/utils/Logger';
import { publishTextNotification } from '../common/utils/NotificationUtil';

@Entry
@Component
struct MainPage {
  build() {
    Column() {
      Button('普通文本类型通知')
        .fontSize(20)
        .margin({ top: 50 })
        .onClick(() => {
          this.textNotification();
        })
      Button('图片类型通知')
        .fontSize(20)
        .margin({ top: 50 })
      Button('进度类型通知')
        .fontSize(20)
        .margin({ top: 50 })
        .onClick(() => {
          router.pushUrl({
            url: 'pages/DownloadPage'
          }).catch((error: Error) => {
            Logger.error('DownloadPages push error' + JSON.stringify(error));
          });
        })
    }
    .width('100%')
    .margin({ top: 50 })
  }

  textNotification() {
    publishTextNotification();
  }
}