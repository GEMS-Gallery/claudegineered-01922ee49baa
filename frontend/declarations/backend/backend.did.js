export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'addMessage' : IDL.Func([IDL.Text, IDL.Text], [], []),
    'autoMode' : IDL.Func([IDL.Nat, IDL.Text], [IDL.Vec(IDL.Text)], []),
    'createOrUpdateFile' : IDL.Func([IDL.Text, IDL.Text], [], []),
    'executeCode' : IDL.Func([IDL.Text], [IDL.Text], []),
    'getConversationHistory' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Text, IDL.Text))],
        ['query'],
      ),
    'listFiles' : IDL.Func(
        [],
        [IDL.Vec(IDL.Tuple(IDL.Text, IDL.Text))],
        ['query'],
      ),
    'readFile' : IDL.Func([IDL.Text], [IDL.Opt(IDL.Text)], ['query']),
    'resetConversation' : IDL.Func([], [], []),
  });
};
export const init = ({ IDL }) => { return []; };
