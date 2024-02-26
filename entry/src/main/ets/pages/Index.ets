// pages存放UI界面相关代码文件，初始会生成一个Index页面。
import router from '@ohos.router';
import { TAG } from '../common/constants/Constants';

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