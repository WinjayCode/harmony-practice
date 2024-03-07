export class MainData {
  pageName: string;
  description: string;
  isInEntryModule: boolean;

  constructor(pageName: string, description: string, isInEntryModule: boolean) {
    this.pageName = pageName;
    this.description = description;
    this.isInEntryModule = isInEntryModule;
  }
}