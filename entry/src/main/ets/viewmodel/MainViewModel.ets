import { mainData } from '../model/DataModel';
import { MainData } from './MainData';

export class MainViewModel {
  loadMainData(): MainData[] {
    return mainData;
  }
}