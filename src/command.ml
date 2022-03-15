type command =
  | Run
  | Attack of string

exception Invalid_input

let input (bat : Battle.t) =
  let k = Graphics.read_key () in
  match k with
  | '1' -> Attack "test"
  | 'r' -> Run
  | _ -> raise Invalid_input