open Jest;

[@bs.val] external __dirname: string = "__dirname";
let (<<) = (f, g, x) => f(g(x));

let projPath = Filename.dirname(__dirname);
describe("Esy.status", () => {
  Expect.(
    testPromise(
      "Checking if running esy status in __dirname works: " ++ projPath, () => {
      Js.Promise.(
        Esy.status(projPath)
        |> then_(
             resolve
             << (
               fun
               | Error(_) => fail("Esy.getStatus should not have failed")
               | Ok((status: Esy.status)) => {
                   expect(status.isProject) |> toBe(true);
                 }
             ),
           )
      )
    })
  )
});
