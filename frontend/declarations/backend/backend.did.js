export const idlFactory = ({ IDL }) => {
  return IDL.Service({
    'addMessage' : IDL.Func([IDL.Text, IDL.Text], [], []),
    'generateResponse' : IDL.Func([IDL.Text], [IDL.Text], []),
    'getMessages' : IDL.Func([], [IDL.Vec(IDL.Text)], ['query']),
  });
};
export const init = ({ IDL }) => { return []; };
