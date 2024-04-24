import { AppRegistry, Platform } from 'react-native';
import App from './src/App';
import AppAndroid from './src/Android/App';
import { name as appName } from './app.json';

AppRegistry.registerComponent(appName, () => Platform.os === 'ios' ? App : AppAndroid);
