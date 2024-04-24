import type { TurboModule } from 'react-native';
import { TurboModuleRegistry } from 'react-native';

export interface Spec extends TurboModule {
  multiply(a: number, b: number): Promise<number>;
  // discovery(connType: number): Promise<string>;
  // connect(connType: number, address: string): Promise<boolean>;
  // printBitmap(base64: string): void;
  // openCashBox(): void;
  // printerStatus(): Promise<number>;
  // isConnect(): Promise<boolean>;
  // setIp(ipAddress: String): Promise<boolean>;
}

export default TurboModuleRegistry.getEnforcing<Spec>('Xprinter');
