defmodule KindleClippings do
  defstruct [book: nil, author: nil, created: nil, body: nil]

  def main([]) do
    clippings = KindleClippings.Parser.parse(File.read!("test/fixtures/clippings.txt"))

    for clipping <- clippings do
      IO.puts clipping.book
    end
  end
end
