import { Injectable } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }

  getLabInfo(): { AMBIENTE: string | null; API_KEY: string | null; build: string } {
    return {
      AMBIENTE: process.env.AMBIENTE ?? null,
      API_KEY: process.env.API_KEY ?? null,
      build: "jenkin"
    };
  }
}
