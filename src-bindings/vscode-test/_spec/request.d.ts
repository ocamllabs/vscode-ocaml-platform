/// <reference types="node" />
import { IncomingMessage } from "http";
export declare function getStream(api: string): Promise<IncomingMessage>;
export declare function getJSON<T>(api: string): Promise<T>;
