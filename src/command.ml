type command =
  | Run
  | Attack of int

exception Invalid_input

let input (bat : Battle.t) =
  let k = Graphics.read_key () in
  match k with
  | '1' -> Attack 1
  | 'r' -> Run
  | _ -> raise Invalid_input