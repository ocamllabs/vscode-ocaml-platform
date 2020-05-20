open Jest
open Node

let () =
  describe "Expect" (fun () ->
      let open Expect in
      testPromise "toBe" (fun () ->
          ChildProcess.exec "echo hey" (ChildProcess.Options.make ())
          |> Promise.map (function
               | { ChildProcess.exitCode = 0; stdout; stderr = _ } ->
                 expect stdout |> toContainString "hey"
               | _ -> fail "exec should have succeeded")))
