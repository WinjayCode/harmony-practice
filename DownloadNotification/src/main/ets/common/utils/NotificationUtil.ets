/*
 * Copyright (c) 2023 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import wantAgent, { WantAgent } from '@ohos.app.ability.wantAgent';
import notification from '@ohos.notificationManager';
import CommonConstants from '../constants/CommonConstants';
import Logger from '../utils/Logger';

/**
 * Obtains the WantAgent of an application.
 *
 * @returns WantAgent of an application.
 */
export function createWantAgent(bundleName: string, abilityName: string): Promise<WantAgent> {
  let wantAgentInfo = {
    wants: [
      {
        bundleName: bundleName,
        abilityName: abilityName
      }
    ],
    operationType: wantAgent.OperationType.START_ABILITY,
    requestCode: 0,
    wantAgentFlags: [wantAgent.WantAgentFlags.CONSTANT_FLAG]
  } as wantAgent.WantAgentInfo;
  return wantAgent.getWantAgent(wantAgentInfo);
}

/**
 * Publish notification.
 *
 * @param progress Download progress
 * @param title Notification title.
 * @param wantAgentObj The want of application.
 */
export function publishNotification(progress: number, title: string, wantAgentObj: WantAgent) {
  let template: notification.NotificationTemplate = {
    name: 'downloadTemplate',
    data: {
      progressValue: progress,
      progressMaxValue: CommonConstants.PROGRESS_TOTAL,
      isProgressIndeterminate: false
    }
  };
  let notificationRequest: notification.NotificationRequest = {
    id: CommonConstants.NOTIFICATION_ID,
    slotType: notification.SlotType.CONTENT_INFORMATION,
    // Construct a progress bar template. The name field must be set to downloadTemplate.
    template: template,
    content: {
      contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
      normal: {
        title: `${title}：${CommonConstants.DOWNLOAD_FILE}`,
        text: '',
        additionalText: `${progress}%`
      }
    },
    wantAgent: wantAgentObj
  };
  notification.publish(notificationRequest).catch((err: Error) => {
    Logger.error(`[ANS] publish failed,message is ${err}`);
  });
}

/**
 * open notification permission
 */
export function openNotificationPermission() {
  notification.requestEnableNotification().then(() => {
    Logger.info('Enable notification success');
  }).catch((err) => {
    Logger.error('Enable notification failed because ' + JSON.stringify(err));
  });
}

/**
 * text notification
 */
export function publishTextNotification() {
  let notificationRequest: notification.NotificationRequest = { // 描述通知的请求
    id: CommonConstants.NOTIFICATION_ID, // 通知ID
    slotType: notification.SlotType.SERVICE_INFORMATION,
    content: { // 通知内容
      contentType: notification.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT, // 普通文本类型通知
      normal: { // 基本类型通知内容
        title: '普通文本类型通知-标题',
        text: '普通文本类型通知-内容详情',
        additionalText: '普通文本类型通知-附加内容', // 通知附加内容，是对通知内容的补充。
      }
    }
  }
  notification.publish(notificationRequest).then(() => { // 发布通知
    Logger.info('publish success');
  }).catch((err) => {
    Logger.error(`publish failed, dcode:${err.code}, message:${err.message}`);
  });
}