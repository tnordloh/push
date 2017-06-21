defmodule Push do

  #  build_archive |> send_archive

  def build_archive(treeish_value, directory) do
    System.cmd("git",
               ["archive", treeish_value],
               into: IO.binstream(:stdio, :line),
               cd: directory)
  end


  def send_archive({io_stream, 0}) do
    file = File.stream!("testing.tar.gz")

    io_stream
    |> Stream.into(file)
    |> Stream.run
  end
  def send_archive({_io_stream, _}) do
    IO.puts "THIS IS BAD"
  end

end

"master"
|> Push.build_archive("hanabi_umbrella")
|> Push.send_archive
