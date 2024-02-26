export class MainData {
  pageName: string;
  isInEntryModule: boolean;

  constructor(pageName: string, isInEntryModule: boolean) {
    this.pageName = pageName;
    this.isInEntryModule = isInEntryModule;
  }
}