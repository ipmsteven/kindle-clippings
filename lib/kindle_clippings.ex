defmodule KindleClippings do
  @moduledoc """
    A module to parse Amazon Kindle MyClipping.txt files and generate
    beautiful HTML reports from it. It just shows how easy it is to parse
    structured text files in Elixir.
  """

  @doc """
  a struct for parsed clippings
  """
  defstruct [book: nil, author: nil, created: nil, body: nil]
end
