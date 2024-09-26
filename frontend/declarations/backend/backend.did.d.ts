import type { Principal } from '@dfinity/principal';
import type { ActorMethod } from '@dfinity/agent';
import type { IDL } from '@dfinity/candid';

export interface _SERVICE {
  'addMessage' : ActorMethod<[string, string], undefined>,
  'autoMode' : ActorMethod<[string, bigint, string], Array<string>>,
  'callAnthropicAPI' : ActorMethod<[string, Array<[string, string]>], string>,
  'createOrUpdateFile' : ActorMethod<[string, string], undefined>,
  'executeCode' : ActorMethod<[string], string>,
  'getConversationHistory' : ActorMethod<[], Array<[string, string]>>,
  'listFiles' : ActorMethod<[], Array<[string, string]>>,
  'readFile' : ActorMethod<[string], [] | [string]>,
  'resetConversation' : ActorMethod<[], undefined>,
}
export declare const idlFactory: IDL.InterfaceFactory;
export declare const init: (args: { IDL: typeof IDL }) => IDL.Type[];
