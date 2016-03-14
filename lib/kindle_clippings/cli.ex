defmodule KindleClippings.CLI do
  @moduledoc """
    CLI parsing and main entry point of the CLI tool
  """

  def main(args) do
    args |> parse_args |> do_process
  end

  def parse_args(args) do
    case OptionParser.parse(args, strict: [input: :string, output: :string, help: :boolean]) do
       {opts, [], []} -> opts |> parse_opts
       _ -> :help
    end
  end

  defp parse_opts(opts) do
    cond do
      Keyword.has_key?(opts, :help) -> :help
      Keyword.has_key?(opts, :input) && Keyword.has_key?(opts, :output) -> [opts[:input], opts[:output]]
      Keyword.has_key?(opts, :input) -> [opts[:input], :stdout]
      Keyword.has_key?(opts, :output) -> [:stdin, opts[:output]]
      true -> [:stdin, :stdout]
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
        --help          Show this help message
        --input [FILE]  Use FILE as input file (default is STDIN)
        --output [FILE] Use FILE as output file (default is STDOUT)

        Description:
        Parses the Kindle clippings file and generates a nice looking HTML page from it.
        Default input and output are STDIN and STDOUT respectively.
      """
  end

  defp get_input(:stdin), do: IO.read(:stdio, :all)
  defp get_input(file), do: File.read!(file)

  defp write_output(content, :stdout), do: IO.puts content
  defp write_output(content, file) do
    File.write!(file, content)

    IO.puts "generated \"#{file}\""
  end
end
