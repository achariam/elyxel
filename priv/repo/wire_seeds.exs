wires = [
  %{
    title: "How to make an efficient payment system in Erlang",
    link: "https://joearms.github.io/2016/08/08/Draft-Payment-System-in-Erlang.html",
    context: "Thinking about solving hard problems in this way might have some merit.",
    pluses: 121,
    minuses: 29,
    user: Elyxel.User |> Elyxel.Repo.get!(1)
  },
  %{
    title: "Playing with syntax",
    link: "http://stevelosh.com/blog/2016/08/playing-with-syntax/",
    context: "Some thought provoking discussion on modern programming syntax.",
    pluses: 24,
    minuses: 2,
    user: Elyxel.User |> Elyxel.Repo.get!(1)
  },
  %{
    title: "Kicksat",
    link: "https://github.com/kicksat",
    context: "A tiny open source spacecraft project.",
    pluses: 54,
    minuses: 7,
    user: Elyxel.User |> Elyxel.Repo.get!(1)
  }
]

for wire <- wires do
  Map.merge(%Elyxel.Wire{}, wire) |> Elyxel.Repo.insert!
end