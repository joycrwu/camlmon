open Character
open Graphics
open Hatchery
open Raylib
open Team

exception Invalid_input

type map_command =
  | Up
  | Down
  | Left
  | Right
  | Battle
  | Exit
  | Invalid_input

let map_input k =
  match k with
  | Key.W -> Up
  | Key.S -> Down
  | Key.A -> Left
  | Key.D -> Right
  | Key.B -> Battle
  | Key.Q -> Exit
  | _ -> Invalid_input

type battle_command =
  | Attack of int
  | Run
  | Exit
  | Invalid_input

let battle_input (bat : Battle.t) (character : Character.t) k =
  match k with
  | Key.One -> Attack (Character.get_action_effect character 0)
  | Key.Two -> Attack (Character.get_action_effect character 1)
  | Key.Three -> Attack (Character.get_action_effect character 2)
  | Key.R -> Run
  | Key.Q -> Exit
  | _ -> Invalid_input

type hatchery_command =
  | Roll
  | Skip
  | Invalid

let hatchery_input k =
  match k with
  | Key.One -> Roll
  | Key.Two -> Skip
  | _ -> Invalid

type team_command =
  | Add of int
  | Remove of int
  | Unavailable

let team_add_char k =
  match k with
  | Key.Zero -> Add 0
  | Key.One -> Add 1
  | Key.Two -> Add 2
  | Key.Three -> Add 3
  | Key.Four -> Add 4
  | Key.Five -> Add 5
  | Key.Six -> Add 6
  | Key.Seven -> Add 7
  | Key.Eight -> Add 8
  | Key.Nine -> Add 9
  | _ -> Unavailable

let team_remove_char k =
  match k with
  | Key.Zero -> Remove 0
  | Key.One -> Remove 1
  | Key.Two -> Remove 2
  | Key.Three -> Remove 3
  | Key.Four -> Remove 4
  | Key.Five -> Remove 5
  | Key.Six -> Remove 6
  | Key.Seven -> Remove 7
  | Key.Eight -> Remove 8
  | Key.Nine -> Remove 9
  | _ -> Unavailable

let team_add_remove k c =
  match k with
  | Key.A -> team_add_char c
  | Key.R -> team_remove_char c
  | _ -> Unavailable
