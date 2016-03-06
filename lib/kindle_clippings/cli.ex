defmodule KindleClippings.CLI do
  @moduledoc """
    CLI parsing and main entry point of the CLI tool
  """

  def main(args) do
    args |> parse_args |> do_process
  end

  def parse_args(args) do
    case OptionParser.parse(args) do
      {[input: input], _, _} -> [input, :stdout]
      {[output: output], _, _} -> [:stdin, output]
      {[input: input, output: output], _, _} -> [input, output]
      {[output: output, input: input], _, _} -> [input, output]
      {[], _, _} -> [:stdin, :stdout]
      _ -> :help
    end
  end

  defp do_process([input, output]) do
    clippings = input
      |> get_input()
      |> KindleClippings.Parser.parse()

    "templates/clippings.html.eex"
      |> EEx.eval_file([clippings: clippings])
      |> write_output(output)
  end
  defp do_process(:help) do
    IO.puts """
       Usage:
        ./kindle_clippings --input [input_file]

        Options:
        --help          Show this help message.
        --input [FILE]  use FILE as input file (mandatory)
        --output [FILE] use FILE as output file

        Description:
        Parses the Kindle clippings file and generates a nice looking HTML page from it.
        Default input and output are STDIN and STDOUT respectively.
      """
  end

  defp get_input(:stdin) do
    IO.read(:stdio, :all)
  end
  defp get_input(file) do
    File.read!(file)
  end

  defp write_output(content, :stdout) do
    IO.puts content
  end
  defp write_output(content, file) do
    File.write!(file, content)

    IO.puts "generated \"#{file}\""
  end
end
