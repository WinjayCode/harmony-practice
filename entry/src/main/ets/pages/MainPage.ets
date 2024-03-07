// pages存放UI界面相关代码文件，初始会生成一个Index页面。
import { MainViewModel } from '../viewmodel/MainViewModel';
import { ListItemComponent } from '../view/ListItemComponent';
import { TAG } from '../common/constants/Constants';
import { MainData } from '../viewmodel/MainData';

let mainModel: MainViewModel = new MainViewModel();

@Entry
@Component
struct MainPage {
  @State mainData: MainData[] = [];

  aboutToAppear() {
    console.log(TAG, 'aboutToAppear()');
    this.mainData = mainModel.loadMainData();
  }

  build() {
    Column() {
      List() {
        ForEach(this.mainData,
          (item: MainData) => {
            ListItem() {
              ListItemComponent({
                name: item.pageName,
                description: item.description,
                isInEntryModule: item.isInEntryModule
              })
            }
          }, (item: MainData) => item.pageName
        )
      }
      .width('100%')
      .height('100%')
      .divider({ strokeWidth: 1 })
    }
    .width('100%')
  }
}