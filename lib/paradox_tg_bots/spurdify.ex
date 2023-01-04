defmodule ParadoxTgBots.Spurdify do
  @spurdify [
              {"p", "b"},
              {"sburdo", "spurdo"},
              {"sbarde", "spärde"},
              {"kek", "geg"},
              {"epic", "ebin"},
              {"right", "rite"},
              {"your", "ur"},
              {"god", "dog"},
              {"linux", "linugs"},
              {"fucking", "fuggen"},
              {"are", "r"},
              {"you", "u"},
              {"wh", "w"},
              {"th", "d"},
              {"af", "ab"},
              {"ap", "ab"},
              {"ca", "ga"},
              {"ck", "gg"},
              {"co", "go"},
              {"ev", "eb"},
              {"ex", "egz"},
              {"et", "ed"},
              {"iv", "ib"},
              {"it", "id"},
              {"ke", "ge"},
              {"nt", "nd"},
              {"op", "ob"},
              {"ot", "od"},
              {"po", "bo"},
              {"pe", "be"},
              {"pi", "bi"},
              {"up", "ub"},
              {"va", "ba"},
              {"ck", "gg"},
              {"cr", "gr"},
              {"kn", "gn"},
              {"lt", "ld"},
              {"mm", "m"},
              {"nt", "dn"},
              {"pr", "br"},
              {"ts", "dz"},
              {"tr", "dr"},
              {"bs", "bz"},
              {"ds", "dz"},
              {"es", "es"},
              {"fs", "fz"},
              {"gs", "gz"},
              {"is", "iz"},
              {"as", "az"},
              {"ls", "lz"},
              {"ms", "mz"},
              {"ns", "nz"},
              {"rs", "rz"},
              {"ss", "sz"},
              {"ts", "tz"},
              {"us", "uz"},
              {"ws", "wz"},
              {"ys", "yz"},
              {"alk", "olk"},
              {"ing", "ign"},
              {"ic", "ig"},
              {"ng", "nk"},
              {"gg", "gb"}
            ]
            |> Enum.map(fn {src, dest} -> {Regex.compile!(src, "i"), dest} end)

  def spurdify(text) do
    text
    |> String.downcase()
    |> then(
      &Enum.reduce(@spurdify, &1, fn {regex, replacement}, acc ->
        String.replace(acc, regex, replacement)
      end)
    )
    |> then(&Regex.replace(~r(\.+), &1, fn -> stupid_face(":") end, global: true))
    |> then(&Regex.replace(~r(,+), &1, fn -> stupid_face("x") end, global: true))
  end

  defp stupid_face(leading, rand_max \\ 5) do
    # 2 is for space + character, so lower bound should be > 2
    padding = :rand.uniform(rand_max) + 2
    String.pad_trailing(" " <> leading, padding, "D")
  end
end
