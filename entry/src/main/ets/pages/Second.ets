import router from '@ohos.router';

@Entry
@Component
struct Second {
  @State message: string = 'Second Page'
  @State src: string = (router.getParams() as Record<string, string>)['src'];

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
        Button("Back")
          .onClick(() => {
            // router.showAlertBeforeBackPage({
            //   message: 'You want back?'
            // })

            // router.back();

            router.back({
              url: './Index',
              params: {
                src: 'Second页面传来的数据'
              }
            })
          })
      }
      .width('100%')
    }
    .height('100%')
  }
}