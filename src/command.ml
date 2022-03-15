open Character

type command =
  | Run
  | Attack of int

exception Invalid_input

let input (bat : Battle.t) (character : Character.t) (move : int) =
  let k = Graphics.read_key () in
  match k with
  | '1' -> Attack (Character.get_action_effect character 0)
  | '2' -> Attack (Character.get_action_effect character 1)
  | '3' -> Attack (Character.get_action_effect character 2)
  | 'r' -> Run
  | _ -> raise Invalid_input