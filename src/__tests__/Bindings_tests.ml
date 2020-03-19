open Jest

let () =
  describe "Expect" (fun () ->
      let open Expect in
      testPromise "toBe" (fun () ->
          let open Js.Promise in
          Bindings.ChildProcess.exec "echo hey"
            (Bindings.ChildProcess.Options.make ())
          |> then_ (function
               | Ok (_exitCode, stdout, _) ->
                 expect stdout |> toContainString "hey" |> resolve
               | Error _ -> fail "exec should have succeeded" |> resolve)))
