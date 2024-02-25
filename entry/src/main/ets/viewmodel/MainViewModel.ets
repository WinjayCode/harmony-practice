import { mainData } from '../model/DataModel';

export class MainViewModel {
  loadMainData(): string[] {
    return mainData;
  }
}