type command =
  | Run
  | Attack of string

exception Invalid_input

let input (st : State.t) =
  let k = Graphics.read_key () in
  match k with
  | '1' -> Attack Character.attack (State.current_character st) 1
  | '2' -> Attack Character.attack (State.current_character st) 2
  | '3' -> Attack Character.attack (State.current_character st) 3
  | '4' -> Attack Character.attack (State.current_character st) 4
  | 'r' -> Run
  | _ -> raise Invalid_input