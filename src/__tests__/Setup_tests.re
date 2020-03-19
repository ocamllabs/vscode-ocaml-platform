open Jest;

describe("Setup.Bsb.checkBucklescriptCompat", () => {
  Expect.(
    {
      test(
        "must return Ok() for a valid package.json with compatible bs-platform",
        () => {
        switch (
          {| { "dependencies": { "bs-platform": "7.x.x" } } |}
          |> Json.parseOrRaise
          |> CheckBucklescriptCompat.run
        ) {
        | Ok () => pass
        | Error(msg) => fail(msg)
        }
      });
      test(
        "must return Error(\"Bucklescript <6 not supported\") for a valid package.json with incompatible bs-platform",
        () => {
        switch (
          {| { "dependencies": { "bs-platform": "5.x.x" } } |}
          |> Json.parseOrRaise
          |> CheckBucklescriptCompat.run
        ) {
        | Error(e) => expect(e) |> toBe("Bucklescript <6 not supported")
        | Ok () => fail("should not have returned Ok")
        }
      });
      test("must return Error() for a package.json with no bs-platform", () => {
        switch (
          {| { "dependencies": { "react": "*" } } |}
          |> Json.parseOrRaise
          |> CheckBucklescriptCompat.run
        ) {
        | Ok () => fail("should not have returned Ok()")
        | Error(e) =>
          expect(e)
          |> toBe(
               "'bs-platform' was expected in the 'dependencies' section of the \
       manifest file, but was not found!",
             )
        }
      });
    }
  )
});
