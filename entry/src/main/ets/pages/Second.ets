import router from '@ohos.router';

@Entry
@Component
struct Second {
  @State message: string = 'Second Page'
  @State src: string = '';

  aboutToAppear() {
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
        Button("Back")
          .onClick(() => {
            router.showAlertBeforeBackPage({
              message: 'You want back?'
            })

            // router.back();

            router.back({
              url: 'pages/Index',
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