defmodule Push do

  #  build_archive |> send_archive

  def build_archive(treeish_value, directory) do
    System.cmd("git",
      ["archive", treeish_value],
      cd: directory)
      |> elem(0)
  end

  def send_archive(archive_data, destination_name, host) do
    :ssh.start
    {:ok, channel, _connection} = :ssh_sftp.start_channel(
      host,
      [user: 'ec2-user', silently_accept_hosts: true]
    )
    {:ok, file} = :ssh_sftp.open(channel, destination_name, [:write, :binary])
    :ok = :ssh_sftp.write(channel, file, archive_data)
    :ssh_sftp.close(channel, file)
    :ssh_sftp.stop_channel(channel)
  end

end

"master"
|> Push.build_archive("../hanabi_umbrella")
|> Push.send_archive('hanabi_umbrella.tar.gz', 'some_host')

