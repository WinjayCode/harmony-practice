import router from '@ohos.router';
import Logger from '../common/utils/Logger';
import {
  createWantAgent,
  publishTextNotification,
  publishPictureNotification,
  addActionButtons,
  openNotificationPermission,
  cancel
} from '../common/utils/NotificationUtil';
import wantAgent, { WantAgent } from '@ohos.app.ability.wantAgent';
import common from '@ohos.app.ability.common';

@Entry
@Component
struct MainPage {
  private wantAgentObj: WantAgent = new Object();
  private context = getContext(this) as common.UIAbilityContext;

  aboutToAppear() {
    openNotificationPermission();
    let bundleName = this.context.abilityInfo.bundleName;
    let abilityName = this.context.abilityInfo.name;
    createWantAgent(bundleName, abilityName).then(want => {
      this.wantAgentObj = want;
    }).catch((err: Error) => {
      Logger.error(`getWantAgent fail, err: ${JSON.stringify(err)}`);
    });
  }

  build() {
    Column() {
      Button('普通文本类型通知')
        .fontSize(20)
        .margin({ top: 50 })
        .onClick(() => {
          publishTextNotification();
        })
      Button('图片类型通知')
        .fontSize(20)
        .margin({ top: 50 })
        .onClick(() => {
          publishPictureNotification();
        })
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
      Button('添加操作按钮')
        .fontSize(20)
        .margin({ top: 50 })
        .onClick(() => {
          addActionButtons(this.wantAgentObj);
        })
      Button('移除通知')
        .fontSize(20)
        .margin({ top: 50 })
        .onClick(() => {
          cancel();
        })
    }
    .width('100%')
    .margin({ top: 50 })
  }
}