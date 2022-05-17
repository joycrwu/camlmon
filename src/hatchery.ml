open Graphics
open Raylib
open Yojson.Basic.Util
open Character

type t = {
  normal_char_pool : Character.t list;
  rare_char_pool : Character.t list;
  ssr_char_pool : Character.t list;
  output_characters : Character.t list;
}

let new_hatchery () =
  {
    normal_char_pool = [];
    rare_char_pool = [];
    ssr_char_pool = [];
    output_characters = [];
  }

let add_char_to_pool (hat : t) (ch : Character.t) =
  match get_rarity ch with
  | 1 -> { hat with normal_char_pool = ch :: hat.normal_char_pool }
  | 2 -> { hat with rare_char_pool = ch :: hat.rare_char_pool }
  | 3 -> { hat with ssr_char_pool = ch :: hat.ssr_char_pool }
  | _ -> failwith "Rarity unaccepted"

let get_normal_char_pool hat = hat.normal_char_pool
let get_rare_char_pool hat = hat.rare_char_pool
let get_ssr_char_pool hat = hat.ssr_char_pool
let get_output_characters hat = hat.output_characters

let gacha hat =
  let ran_num = Random.int 100 in
  let num_normchars = List.length hat.normal_char_pool in
  let num_rarechars = List.length hat.rare_char_pool in
  let num_ssrchars = List.length hat.ssr_char_pool in
  let array_normchars = Array.of_list hat.normal_char_pool in
  let array_rarechars = Array.of_list hat.rare_char_pool in
  let array_ssrchars = Array.of_list hat.ssr_char_pool in
  match ran_num > 10 with
  | true ->
      let char_ran_num = Random.int 100 in
      let new_char_ran_num = char_ran_num mod num_normchars in
      Array.get array_normchars new_char_ran_num
  | false -> (
      match ran_num < 5 with
      | false ->
          let char_ran_num = Random.int 100 in
          let new_char_ran_num = char_ran_num mod num_rarechars in
          Array.get array_rarechars new_char_ran_num
      | true ->
          let char_ran_num = Random.int 100 in
          let new_char_ran_num = char_ran_num mod num_ssrchars in
          Array.get array_ssrchars new_char_ran_num)

let character_outputs (ch : Character.t) (hat : t) =
  { hat with output_characters = ch :: hat.output_characters }
