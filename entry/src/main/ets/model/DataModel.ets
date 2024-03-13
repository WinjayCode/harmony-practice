import { MainData } from '../viewmodel/MainData';

export { mainData }

const mainData: MainData[] = [
  new MainData('Hello', '', true),
  new MainData('PageRouter', 'UIAbility内页面间的跳转', false),
  new MainData('RankingDemo', 'ArkTS基础知识', false),
  new MainData('ToDoList', 'ArkTS开发实践', false),
  new MainData('ArkTSComponents', '常用组件与布局', false),
  new MainData('TargetManagement', '管理组件状态', false),
  new MainData('SimpleVideo', 'Video组件的使用', false),
  new MainData('MultipleDialog', '多种样式的弹窗', false),
  new MainData('AnimateRefresh', '属性动画', false),
  new MainData('WebComponent', 'Web组件的使用', false),
  new MainData('NewsDataArkTS', 'Http数据请求', false),
  new MainData('SetAppFontSize', '数据管理', false),
  new MainData('Notification', '通知', false),
  new MainData('AlarmClock', '提醒', false),
  new MainData('ThirdPartyLibrary', '三方库的使用', false),
  new MainData('NativeTemplateDemo', 'Native开发', false),
]