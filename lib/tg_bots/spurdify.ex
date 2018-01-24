defmodule TgBots.Spurdify do
  @spurdify  %{
  "kek"     => "geg",
  "epic"    => "ebin",
  "right"   => "rite",
  "your"    => "ur",
  "god"     => "dog",
  "linux"   => "linugs",
  "you"     => "u",
  "wh"      => "w",
  "th"      => "d",
  "af"      => "ab",
  "ap"      => "ab",
  "ca"      => "ga",
  "ck"      => "gg",
  "co"      => "go",
  "ev"      => "eb",
  "ex"      => "egz",
  "et"      => "ed",
  "iv"      => "ib",
  "it"      => "id",
  "ke"      => "ge",
  "nt"      => "nd",
  "op"      => "ob",
  "ot"      => "od",
  "po"      => "bo",
  "pe"      => "be",
  "pi"      => "bi",
  "up"      => "ub",
  "va"      => "ba",
  "ck"      => "gg",
  "cr"      => "gr",
  "kn"      => "gn",
  "lt"      => "ld",
  "mm"      => "m",
  "nt"      => "dn",
  "pr"      => "br",
  "ts"      => "dz",
  "tr"      => "dr",
  "bs"      => "bz",
  "ds"      => "dz",
  "es"      => "es",
  "fs"      => "fz",
  "gs"      => "gz",
  "is"      => "iz",
  "as"      => "az",
  "ls"      => "lz",
  "ms"      => "mz",
  "ns"      => "nz",
  "rs"      => "rz",
  "ss"      => "sz",
  "ts"      => "tz",
  "us"      => "uz",
  "ws"      => "wz",
  "ys"      => "yz",
  "alk"     => "olk",
  "ing"     => "ign",
  "ic"      => "ig",
  "ng"      => "nk"
  }

  def spurdify(text) do
    text
    |> (&Enum.reduce(@spurdify, &1, fn ({k, v}, acc) ->
      regex = Regex.compile!(k, "i")
       acc = String.replace(acc, regex, v)
    end)).()
    |> String.replace(".", stupid_face(":"))
    |> String.replace(",", stupid_face("x"))
  end

  defp stupid_face(leading, rand_max \\ 5) do
    # 2 is because space + character = 2, so lower bound should always be > 2
    padding = :rand.uniform(rand_max) + 2
    String.pad_trailing(" " <> leading, padding, "D")
  end
end
