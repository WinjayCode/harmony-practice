import router from '@ohos.router';
import { TAG } from '../common/constants/Constants';
import AppContext from '@ohos.app.ability.common';

@Entry
@Component
struct Index {
  @State message: string = 'Index Page'
  @State src: string = ''

  onPageShow() {
    const params = router.getParams();
    if (params != null && params.hasOwnProperty('src')) {
      this.src = params['src'];
    }
  }

  onBackPress() {
    let handler = getContext(this) as AppContext.UIAbilityContext;
    handler.terminateSelf();
    return true;
  }

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Green)
        Text(this.src)
          .fontSize(20)
          .opacity(0.6)
        Button("Next")
          .onClick(() => {
            router.pushUrl({
              url: 'pages/Second',
              params: {
                src: 'Index页面传来的数据'
              }
            }, router.RouterMode.Standard)
              .catch((error: Error) => {
                console.error(TAG, 'IndexPage push error' + JSON.stringify(error));
              });
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}