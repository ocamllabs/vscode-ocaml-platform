open Jest

let () =
  describe "Expect" (fun () ->
      let open Expect in
      testPromise "toBe" (fun () ->
          Bindings.ChildProcess.exec "echo hey"
            (Bindings.ChildProcess.Options.make ())
          |> Promise.map (function
               | Ok (_exitCode, stdout, _) ->
                 expect stdout |> toContainString "hey"
               | Error _ -> fail "exec should have succeeded")))
