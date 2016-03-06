defmodule KindleClippings.CLITest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  test "parse_args returns stdin and stdout if no args were given" do
    assert [:stdin, :stdout] == KindleClippings.CLI.parse_args([])
  end

  test "parse_args returns input file name if given" do
    assert ["/tmp/foo.bar", :stdout] == KindleClippings.CLI.parse_args(["--input", "/tmp/foo.bar"])
  end

  test "parse_args returns output file name if given" do
    assert [:stdin, "/tmp/foo.bar"] == KindleClippings.CLI.parse_args(["--output", "/tmp/foo.bar"])
  end

  test "parse_args returns input and output file name if given" do
    assert ["/tmp/in", "/tmp/out"] == KindleClippings.CLI.parse_args(["--output", "/tmp/out", "--input", "/tmp/in"])
  end

  test "parse_args returns help if unknown switch was used" do
    assert :help == KindleClippings.CLI.parse_args(["--foobar"])
  end

  test "parse_args returns help if --help was used" do
    assert :help == KindleClippings.CLI.parse_args(["--help"])
  end

  test "--help prints a help statement" do
    assert capture_io(fn ->
        KindleClippings.CLI.main(["--help"])
      end)
      |> String.starts_with?(" Usage:")
  end

  test "can process a file and export the result" do
    output_file = System.tmp_dir!() <> "/kindle-clippings-output.html"
    output = capture_io(fn ->
      KindleClippings.CLI.main([
        "--input", "test/fixtures/clippings.txt",
        "--output", output_file
      ])
    end)

    assert String.starts_with?(File.read!(output_file), "<!DOCTYPE html>")
    assert String.ends_with?(output, "kindle-clippings-output.html\"\n")

    File.rm!(output_file)
  end

  test "can process STDIN and write to STDOUT" do
    content = File.read!("test/fixtures/clippings.txt")
    output = capture_io([input: content, capture_prompt: false], fn ->
      KindleClippings.CLI.main([])
    end)

    assert String.starts_with?(output, "<!DOCTYPE html>")
  end
end
