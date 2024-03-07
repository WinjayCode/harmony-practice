import router from '@ohos.router';
import { TAG } from '../common/constants/Constants';
import AppContext from '@ohos.app.ability.common';

@Component
export struct ListItemComponent {
  name?: string
  description?: string
  isInEntryModule: boolean

  build() {
    Row() {
      Text(this.name)
        .fontColor(Color.Black)
        .fontSize(20)
        .padding(10)
      Text(this.description)
        .fontColor(Color.Black)
        .fontSize(16)
        .padding(10)
        .opacity(0.6)
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .onClick(() => {
      console.debug(TAG, `isInEntryModule=${this.isInEntryModule}`);
      if (this.isInEntryModule) {
        jumpPage(this.name);
      } else {
        jumpDifferentAbility(this.name);
      }
    })
  }
}

function jumpPage(pageName: string): void {
  console.debug(TAG, `jumpPage():pageName=${pageName}`);
  router.pushUrl({
    url: `pages/${pageName}`
  }, router.RouterMode.Standard, (err) => {
    if (err) {
      console.error(TAG, `start page failed, code is ${err.code}, message is ${err.message}`);
      return;
    }
    console.info(TAG, 'start page succeeded.');
  });
}

async function jumpDifferentAbility(pageName: string) {
  console.debug(TAG, `jumpDifferentAbility():pageName=${pageName}`);
  try {
    let want = {
      deviceId: '',
      bundleName: 'com.winjay.practice',
      moduleName: pageName,
      abilityName: `${pageName}Ability`
    }
    let context = getContext(this) as AppContext.UIAbilityContext;
    await context.startAbility(want);
    console.info(TAG, 'start ability succeed!');
  } catch (error) {
    console.error(TAG, `start ability failed with ${error.code}`);
  }
}