defmodule Push do

  def build_archive(treeish_value, path,directory) do
    System.cmd("git",
               ["archive", treeish_value, "-o",path],
               cd: directory)
  end

end
Push.build_archive("master","/Users/tim/code/mob_1/test.tar.gz",
                   "hanabi_umbrella")
