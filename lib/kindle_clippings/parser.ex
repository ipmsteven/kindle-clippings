defmodule KindleClippings.Parser do
  def parse(content) do
    content
      |> String.split("\n")
      |> Enum.map(fn x -> String.replace(x, "\r", "") end)
      |> parse([])
  end

  defp parse([], parsed), do: Enum.reverse(parsed)
  defp parse([""], parsed), do: Enum.reverse(parsed) # trailing empty line
  defp parse(content_lines, parsed) do
    [book|tail] = content_lines
    [note|tail] = tail
    [body, tail] = parse_body(tail, [])

    [book, author] = parse_book(book)
    created = parse_clipping(note)
    clipping = %KindleClippings{book: book, author: author, created: created, body: body}

    parse(tail, [clipping|parsed])
  end

  defp parse_body(["=========="|tail], body) do
    [Enum.join(Enum.reverse(body), "\n"), tail]
  end
  defp parse_body([body_line|tail], body) do
    unless body_line == "" do
      parse_body(tail, [body_line|body])
    else
      parse_body(tail, body)
    end
  end

  defp parse_book(t) do
    [[_, book, author]] = Regex.scan(~r/(.*) \((.*)\)$/, t)
    [book, author]
  end

  defp parse_clipping(n) do
    [[_, created]] = Regex.scan(~r/\| Added on (.*)$/, n)
    created
  end
end
