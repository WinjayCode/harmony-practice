// pages存放UI界面相关代码文件，初始会生成一个Index页面。
@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Green)
        Button("Test Button")
      }
      .width('100%')
    }
    .height('100%')
  }
}