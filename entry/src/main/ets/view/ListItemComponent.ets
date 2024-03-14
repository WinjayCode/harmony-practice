import router from '@ohos.router';
import { TAG } from '../common/constants/Constants';
import common from '@ohos.app.ability.common';

@Component
export struct ListItemComponent {
  name?: string
  description?: string
  isInEntryModule: boolean
  private context = getContext(this) as common.UIAbilityContext;

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
        this.jumpPage(this.name);
      } else {
        this.jumpDifferentAbility(this.name);
      }
    })
  }

  jumpPage(pageName: string): void {
    console.debug(TAG, `jumpPage():pageName=${pageName}`);
    router.pushUrl({
      url: `pages/${pageName}`
    }, router.RouterMode.Standard, (err) => {
      if (err) {
        console.error(TAG, `start page failed, code is ${err.code}, message is ${err.message}`);
        return;
      }
      console.debug(TAG, 'start page succeeded.');
    });
  }

  async jumpDifferentAbility(pageName: string) {
    console.debug(TAG, `jumpDifferentAbility():pageName=${pageName}`);
    try {
      let want = {
        deviceId: '',
        // bundleName: this.context.abilityInfo.bundleName,
        bundleName: this.context.applicationInfo.name,
        // moduleName: pageName,
        abilityName: `${pageName}Ability`
      }
      await this.context.startAbility(want);
      console.debug(TAG, 'start ability succeed!');
    } catch (error) {
      console.error(TAG, `start ability failed with: ${error}`);
    }
  }
}

