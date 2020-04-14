open Jest
open Node

let () =
  describe "Expect" (fun () ->
      let open Expect in
      testPromise "toBe" (fun () ->
          ChildProcess.exec "echo hey" (ChildProcess.Options.make ())
          |> Promise.map (function
               | Ok { ChildProcess.exitCode = _; stdout; stderr = _ } ->
                 expect stdout |> toContainString "hey"
               | Error _ -> fail "exec should have succeeded")))
