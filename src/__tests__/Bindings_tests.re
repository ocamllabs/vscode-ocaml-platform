open Jest;

describe("Expect", () => {
  Expect.(
    testPromise("toBe", () => {
      Js.Promise.(
        Bindings.ChildProcess.exec(
          "echo hey",
          Bindings.ChildProcess.Options.make(),
        )
        |> then_(
             fun
             | Ok((_exitCode, stdout, _)) => {
                 expect(stdout) |> toContainString("hey") |> resolve;
               }
             | Error(_) => fail("exec should have succeeded") |> resolve,
           )
      )
    })
  )
});
