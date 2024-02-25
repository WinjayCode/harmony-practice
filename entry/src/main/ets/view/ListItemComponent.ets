import router from '@ohos.router';
import { TAG } from '../common/constants/Constants';
import AppContext from '@ohos.app.ability.common';


@Component
export struct ListItemComponent {
  name?: string

  build() {
    Row() {
      Text(this.name)
        .width('100%')
        .fontColor(Color.Black)
        .fontSize(20)
        .padding(10)
    }
    .onClick(() => {
      // jumpSameAbility(this.name);
      jumpDifferentAbility(this.name);
    })
  }
}

function jumpSameAbility(pageName: string): void {
  router.pushUrl({
    url: `pages/${pageName}`
  }, router.RouterMode.Standard, (err) => {
    if (err) {
      console.error(TAG, `Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
      return;
    }
    console.info(TAG, 'Invoke pushUrl succeeded.');
  });
}

async function jumpDifferentAbility(pageName: string) {
  try {
    let want = {
      deviceId: '',
      bundleName: 'com.winjay.practice',
      moduleName: pageName,
      abilityName: 'EntryAbility'
    }
    let context = getContext(this) as AppContext.UIAbilityContext;
    await context.startAbility(want);
    console.info(TAG, 'jumpDifferentAbility succeed!');
  } catch (error) {
    console.info(TAG, 'jumpDifferentAbility error!');
  }
}