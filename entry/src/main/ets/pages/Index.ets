@Entry
@Component
struct Index {
  @State message: string = 'Hello World'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(30)
          .fontWeight(FontWeight.Bold)
          .fontColor(Color.Green)
      }
      .width('100%')
    }
    .height('100%')
  }
}