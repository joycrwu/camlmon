open Character
open Graphics
open Hatchery
open Raylib

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
  | '1' -> Roll
  | '2' -> Skip
  | _ -> Invalid
