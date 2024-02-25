import { MainViewModel } from '../viewmodel/MainViewModel';
import { ListItemComponent } from '../view/ListItemComponent';
import { TAG } from '../common/constants/Constants';

let mainModel: MainViewModel = new MainViewModel();

@Entry
@Component
struct MainPage {
  @State mainData: string[] = [];

  aboutToAppear() {
    console.log(TAG, 'aboutToAppear()');
    this.mainData = mainModel.loadMainData();
  }

  build() {
    Column() {
      List() {
        ForEach(this.mainData,
          (item: string) => {
            ListItem() {
              ListItemComponent({ name: item })
            }
          }, (item: string) => item
        )
      }
      .width('100%')
      .height('100%')
      .divider({ strokeWidth: 1 })
    }
    .width('100%')
  }
}